Message-ID: <027b01c0d728$9a702b80$4b00000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: <brian.kuschak@skystream.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: dcache BUG()
Date: Mon, 7 May 2001 12:04:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian,

I have also seen the dcache BUG, as well as bugs and warnings from other
parts of the kernel in the MontaVista 2.4.0 kernel.  They all seem to be
related to a inconsistency with reference counters, which led me to suspect
a problem with atomic instructions in our kernel.  I have replaced the
lwarx/stcrx pairs in include/asm-ppc/atomic.h with code that just turns off
and on interrupts, and that seemed to have made the error messages and BUGs
disappear.  Please try this patch and see if you still have the same
problems.  This is really just a work around for us until we find out what
is the real problem.

thanks,
Eli

diff -c -r1.1.1.2 atomic.h
*** atomic.h 2001/02/21 00:53:16 1.1.1.2
--- atomic.h 2001/05/07 18:35:10
***************
*** 5,10 ****
--- 5,25 ----
  #ifndef _ASM_PPC_ATOMIC_H_
  #define _ASM_PPC_ATOMIC_H_

+ struct int_control_struct
+ {
+         void (*int_cli)(void);
+         void (*int_sti)(void);
+         void (*int_restore_flags)(unsigned long);
+         void (*int_save_flags)(unsigned long *);
+         void (*int_set_lost)(unsigned long);
+ };
+
+ extern struct int_control_struct int_control;
+ #define __cli() int_control.int_cli()
+ #define __sti() int_control.int_sti()
+ #define __save_flags(flags) int_control.int_save_flags((unsigned long
*)&flags)
+ #define __restore_flags(flags) int_control.int_restore_flags((unsigned
long)flags)
+
  typedef struct { volatile int counter; } atomic_t;

  #define ATOMIC_INIT(i) { (i) }
***************
*** 17,80 ****

  static __inline__ int atomic_add_return(int a, atomic_t *v)
  {
!  int t;

!  __asm__ __volatile__("\n\
! 1: lwarx %0,0,%3\n\
!  add %0,%2,%0\n\
!  stwcx. %0,0,%3\n\
!  bne- 1b"
!  : "=&r" (t), "=m" (v->counter)
!  : "r" (a), "r" (v), "m" (v->counter)
!  : "cc");

   return t;
  }

  static __inline__ int atomic_sub_return(int a, atomic_t *v)
  {
!  int t;

!  __asm__ __volatile__("\n\
! 1: lwarx %0,0,%3\n\
!  subf %0,%2,%0\n\
!  stwcx. %0,0,%3\n\
!  bne- 1b"
!  : "=&r" (t), "=m" (v->counter)
!  : "r" (a), "r" (v), "m" (v->counter)
!  : "cc");

   return t;
  }

  static __inline__ int atomic_inc_return(atomic_t *v)
  {
!  int t;

!  __asm__ __volatile__("\n\
! 1: lwarx %0,0,%2\n\
!  addic %0,%0,1\n\
!  stwcx. %0,0,%2\n\
!  bne- 1b"
!  : "=&r" (t), "=m" (v->counter)
!  : "r" (v), "m" (v->counter)
!  : "cc");

   return t;
  }

  static __inline__ int atomic_dec_return(atomic_t *v)
  {
!  int t;

!  __asm__ __volatile__("\n\
! 1: lwarx %0,0,%2\n\
!  addic %0,%0,-1\n\
!  stwcx. %0,0,%2\n\
!  bne 1b"
!  : "=&r" (t), "=m" (v->counter)
!  : "r" (v), "m" (v->counter)
!  : "cc");

   return t;
  }
--- 32,91 ----

  static __inline__ int atomic_add_return(int a, atomic_t *v)
  {
!  int flags, t;
!
!  __save_flags(flags);__cli();

!  t = (v)->counter;
!  t = t + a;
!  (v)->counter = t;

+  __restore_flags(flags);
+
   return t;
  }

  static __inline__ int atomic_sub_return(int a, atomic_t *v)
  {
!  int flags, t;
!
!  __save_flags(flags);__cli();

!  t = (v)->counter;
!  t = t - a;
!  (v)->counter = t;

+  __restore_flags(flags);
+
   return t;
  }

  static __inline__ int atomic_inc_return(atomic_t *v)
  {
!  int flags, t;
!
!  __save_flags(flags);__cli();
!
!  t = (v)->counter;
!  t = t + 1;
!  (v)->counter = t;

!  __restore_flags(flags);

   return t;
  }

  static __inline__ int atomic_dec_return(atomic_t *v)
  {
!  int flags, t;
!
!  __save_flags(flags);__cli();
!
!  t = (v)->counter;
!  t = t - 1;
!  (v)->counter = t;

!  __restore_flags(flags);

   return t;
  }
diff -c -r1.1.1.2 hw_irq.h
*** hw_irq.h 2001/02/21 00:53:16 1.1.1.2
--- hw_irq.h 2001/05/07 18:35:27
***************
*** 7,12 ****
--- 7,13 ----
  #ifndef _PPC_HW_IRQ_H
  #define _PPC_HW_IRQ_H

+ #ifndef _ASM_PPC_ATOMIC_H_
  struct int_control_struct
  {
   void (*int_cli)(void);
***************
*** 15,20 ****
--- 16,23 ----
   void (*int_save_flags)(unsigned long *);
   void (*int_set_lost)(unsigned long);
  };
+ #endif
+
  extern struct int_control_struct int_control;
  extern unsigned long timer_interrupt_intercept;
  extern unsigned long do_IRQ_intercept;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
