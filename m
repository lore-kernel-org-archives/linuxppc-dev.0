Date: Fri, 21 Sep 2001 14:36:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
Message-ID: <20010921143645.F20058@zax>
References: <20010917152316.O3851@zax> <3BA62583.55E48A97@mvista.com> <20010918102901.A1183@zax> <3BA7980B.EEBF1F5D@mvista.com> <20010919121954.D13693@zax> <3BA83D9D.87F9B1E1@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA83D9D.87F9B1E1@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 19, 2001 at 02:39:25AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > Ah, yes, I discovered ATOMIC_SYNC_FIX after I sent that,....
>
> I thought it was automatically enabled on the 405GP.....I guess not.
>
> > .....  That should certainly fix the atomic ops, however there
> > are quite a number of other places where the kernel uses stwcx., which
> > ATOMIX_SYNC_FIX doesn't fix
>
> I took a quick look at the original patch and saw that too, I just never
> got around to fixing the rest of it.  It solved the problem at the time,
> so it didn't seem urgent.  If you would like to finish it up, that would
> be great.

Try the below...

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in linux-bungo/arch/ppc/config.in
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/config.in	Wed Sep 19 13:35:58 2001
+++ linux-bungo/arch/ppc/config.in	Thu Sep 20 14:48:10 2001
@@ -199,10 +199,12 @@
     define_bool CONFIG_405GP y
     define_bool CONFIG_BIOS_FIXUP y
     define_bool CONFIG_TREEBOOT y
+    define_bool CONFIG_IBM405_ERR77 y
   fi
   if [ "$CONFIG_EP405" = "y" ]; then
     define_bool CONFIG_405GP y
     define_bool CONFIG_EMBEDDEDBOOT y
+    define_bool CONFIG_IBM405_ERR77 y
   fi
   if [ "$CONFIG_OAK" = "y" -o "$CONFIG_TIVO" = "y" ]; then
     define_bool CONFIG_403GCX y
@@ -210,7 +212,6 @@
   fi

   bool 'Blue Logic DMA' CONFIG_405_DMA
-  bool 'Workarounds for Atomic Operations' CONFIG_ATOMIC_SYNC_FIX

   define_bool CONFIG_IBM405_ERR51 y
   define_bool CONFIG_NOT_COHERENT_CACHE y
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/bitops.c linux-bungo/arch/ppc/kernel/bitops.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/bitops.c	Tue Jun  5 21:22:02 2001
+++ linux-bungo/arch/ppc/kernel/bitops.c	Thu Sep 20 15:54:46 2001
@@ -21,8 +21,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%3 \n\
-	or	%0,%0,%2 \n\
-	stwcx.	%0,0,%3 \n\
+	or	%0,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=m" (*p)
@@ -38,8 +39,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%3 \n\
-	andc	%0,%0,%2 \n\
-	stwcx.	%0,0,%3 \n\
+	andc	%0,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=m" (*p)
@@ -55,8 +57,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%3 \n\
-	xor	%0,%0,%2 \n\
-	stwcx.	%0,0,%3 \n\
+	xor	%0,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=m" (*p)
@@ -72,8 +75,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%4 \n\
-	or	%1,%0,%3 \n\
-	stwcx.	%1,0,%4 \n\
+	or	%1,%0,%3 \n"
+	PPC405_ERR77(0,%4)
+"	stwcx.	%1,0,%4 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=&r" (t), "=m" (*p)
@@ -91,8 +95,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%4 \n\
-	andc	%1,%0,%3 \n\
-	stwcx.	%1,0,%4 \n\
+	andc	%1,%0,%3 \n"
+	PPC405_ERR77(0,%4)
+"	stwcx.	%1,0,%4 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=&r" (t), "=m" (*p)
@@ -110,8 +115,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%4 \n\
-	xor	%1,%0,%3 \n\
-	stwcx.	%1,0,%4 \n\
+	xor	%1,%0,%3 \n"
+	PPC405_ERR77(0,%4)
+"	stwcx.	%1,0,%4 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=&r" (t), "=m" (*p)
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/entry.S linux-bungo/arch/ppc/kernel/entry.S
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/entry.S	Sat Sep  8 21:03:46 2001
+++ linux-bungo/arch/ppc/kernel/entry.S	Thu Sep 20 16:50:26 2001
@@ -321,6 +321,7 @@
 	SYNC			/* Some chip revs have problems here... */
 	mtmsr	r0		/* Update machine state */

+	PPC405_ERR77(0,r1)
 	stwcx.	r0,0,r1		/* to clear the reservation */

 	/* if returning to user mode, set new sprg2 and save kernel SP */
@@ -383,6 +384,7 @@
 	lwz	r4,GPR4(r1)
 	lwz	r1,GPR1(r1)
 	SYNC
+	PPC405_ERR77_SYNC
 	RFI


diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-bungo/arch/ppc/kernel/head_4xx.S
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Wed Sep 19 13:35:58 2001
+++ linux-bungo/arch/ppc/kernel/head_4xx.S	Thu Sep 20 17:00:28 2001
@@ -292,6 +295,7 @@
 	mfspr	r22, SPRG4
 	mfspr	r21, SPRG1
 	mfspr	r20, SPRG0
+	PPC405_ERR77_SYNC
 	rfi			/* Should sync shadow TLBs */

 2:
@@ -568,6 +572,7 @@
 	mfspr	r22, SPRG4
 	mfspr	r21, SPRG1
 	mfspr	r20, SPRG0
+	PPC405_ERR77_SYNC
 	rfi			/* Should sync shadow TLBs */

 2:
@@ -720,6 +725,7 @@
 	mfspr	r22, SPRG4
 	mfspr	r21, SPRG1
 	mfspr	r20, SPRG0
+	PPC405_ERR77_SYNC
 	rfi			/* Should sync shadow TLBs */

 /* This code finishes saving the registers to the exception frame
@@ -743,6 +749,8 @@
 	andi.	r24,r23,0x3f00		/* Get vector offset */
 	stw	r24,TRAP(r21)
 	li	r22,RESULT
+	/* No need to put an erratum #77 workaround here
+		because interrupts are currently disabled */
 	stwcx.	r22,r22,r21		/* Clear the reservation */
 	li	r22,0
 	stw	r22,RESULT(r21)
@@ -771,6 +779,8 @@
 	mtspr	SPRN_SRR1,r20		/* Set up the machine state register */
 	mtlr	r23			/* Set up the return pointer */
 	SYNC
+	/* We shouldn't need a 405 erratum #77 workaround here, because we're not
+	 * actually returning to the interrupted instruction yet. */
 	rfi

 	/* Critical exception jump path
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/idle.c linux-bungo/arch/ppc/kernel/idle.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/idle.c	Tue Sep 11 14:26:51 2001
+++ linux-bungo/arch/ppc/kernel/idle.c	Fri Sep 21 13:26:09 2001
@@ -134,6 +134,7 @@
 		register unsigned long tmp;
 		asm (	"101:lwarx  %1,0,%3\n"  /* reserve zero_cache */
 			"    lwz    %0,0(%1)\n" /* get next -- new zero_cache */
+			PPC405_ERR77(0,%3)
 			"    stwcx. %0,0,%3\n"  /* update zero_cache */
 			"    bne-   101b\n"     /* if lost reservation try again */
 			: "=&r" (tmp), "=&r" (page), "+m" (zero_cache)
@@ -233,6 +234,7 @@
 #ifdef CONFIG_SMP
 			"    sync\n"            /* let store settle */
 #endif
+			PPC405_ERR77(0,%2)
 			"    stwcx. %3,0,%2\n"  /* update zero_cache in mem */
 			"    bne-   101b\n"     /* if lost reservation try again */
 			: "=&r" (tmp), "+m" (zero_quicklist)
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/misc.S linux-bungo/arch/ppc/kernel/misc.S
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/misc.S	Sat Sep  8 21:03:46 2001
+++ linux-bungo/arch/ppc/kernel/misc.S	Thu Sep 20 16:59:31 2001
@@ -302,6 +302,7 @@
 10:	lwarx	r7,0,r9
 	cmpi	0,r7,0
 	bne-	10b
+	PPC405_ERR77(0,r9)
 	stwcx.	r8,0,r9
 	bne-	10b
 #endif /* CONFIG_SMP */
@@ -334,6 +335,7 @@
 10:	lwarx	r7,0,r9
 	cmpi	0,r7,0
 	bne-	10b
+	PPC405_ERR77(0,r9)
 	stwcx.	r8,0,r9
 	bne-	10b
 	eieio
@@ -616,6 +626,7 @@
 _GLOBAL(xchg_u32)
 	mr	r5,r3		/* Save pointer */
 10:	lwarx	r3,0,r5		/* Fetch old value & reserve */
+	PPC405_ERR77(0,r5)
 	stwcx.	r4,0,r5		/* Update with new value */
 	bne-	10b		/* Retry if "reservation" (i.e. lock) lost */
 	blr
@@ -627,12 +638,14 @@
 _GLOBAL(atomic_clear_mask)
 10:	lwarx	r5,0,r4
 	andc	r5,r5,r3
+	PPC405_ERR77(0,r4)
 	stwcx.	r5,0,r4
 	bne-	10b
 	blr
 _GLOBAL(atomic_set_mask)
 10:	lwarx	r5,0,r4
 	or	r5,r5,r3
+	PPC405_ERR77(0,r4)
 	stwcx.	r5,0,r4
 	bne-	10b
 	blr
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc_asm.h linux-bungo/arch/ppc/kernel/ppc_asm.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc_asm.h	Wed Aug 29 08:57:34 2001
+++ linux-bungo/arch/ppc/kernel/ppc_asm.h	Fri Sep 21 12:38:13 2001
@@ -165,5 +165,14 @@
 #define HMT_LOW		/* nothing */
 #define HMT_MEDIUM	/* nothing */
 #define HMT_HIGH	/* nothing */
+
+#ifdef CONFIG_IBM405_ERR77
+#define PPC405_ERR77(ra,rb)	dcbt	ra, rb;
+#define	PPC405_ERR77_SYNC	sync;
+#else
+#define PPC405_ERR77(ra,rb)
+#define PPC405_ERR77_SYNC
+#endif
+
 #endif /* CONFIG_PPC_ISERIES */

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/semaphore.c linux-bungo/arch/ppc/kernel/semaphore.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/semaphore.c	Tue Jun  5 22:20:48 2001
+++ linux-bungo/arch/ppc/kernel/semaphore.c	Thu Sep 20 16:59:10 2001
@@ -39,6 +39,7 @@
 "	srawi	%1,%0,31\n"
 "	andc	%1,%0,%1\n"
 "	add	%1,%1,%4\n"
+	PPC405_ERR77(0,%3)
 "	stwcx.	%1,0,%3\n"
 "	bne	1b"
 	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/lib/locks.c linux-bungo/arch/ppc/lib/locks.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/lib/locks.c	Wed Aug 29 08:57:35 2001
+++ linux-bungo/arch/ppc/lib/locks.c	Fri Sep 21 11:52:46 2001
@@ -35,8 +35,9 @@
 	__asm__ __volatile__ ("\n\
 1:	lwarx	%0,0,%1\n\
 	cmpwi	0,%0,0\n\
-	bne	2f\n\
-	stwcx.	%2,0,%1\n\
+	bne	2f\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%2,0,%1\n\
 	bne-	1b\n\
 	isync\n\
 2:"
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/atomic.h linux-bungo/include/asm-ppc/atomic.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/atomic.h	Wed Aug 29 08:57:35 2001
+++ linux-bungo/include/asm-ppc/atomic.h	Fri Sep 21 12:25:06 2001
@@ -23,32 +23,16 @@
 #define SMP_ISYNC
 #endif

-/* This was needed on the 4xx processors.  We don't know why, yet. -- Dan
-*/
-#ifdef CONFIG_ATOMIC_SYNC_FIX
-#define ATOMIC_SYNC "	sync\n"
+/* Erratum #77 on the 405 means we need a sync or dcbt before every stwcx.
+ * The old ATOMIC_SYNC_FIX covered some but not all of this. */
+
+#ifdef CONFIG_IBM405_ERR77
+#define PPC405_ERR77(ra,rb)	"dcbt " #ra "," #rb ";"
 #else
-#define ATOMIC_SYNC
+#define PPC405_ERR77(ra,rb)
 #endif

-#ifdef CONFIG_ATOMIC_SYNC_FIX
-static __inline__ void atomic_set(atomic_t *v, int a)
-{
-	int t;
-
-	__asm__ __volatile__("\n\
-1:	lwarx   %0,0,%3\n\
-	ori     %0,%2,0\n\
-	sync\n\
-	stwcx.  %0,0,%3\n\
-	bne-    1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (a), "r" (v), "m" (v->counter)
-	: "cc");
-}
-#else
 #define atomic_set(v,i)		(((v)->counter) = (i))
-#endif

 static __inline__ void atomic_add(int a, atomic_t *v)
 {
@@ -56,9 +40,9 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%3		# atomic_add\n\
-	add	%0,%2,%0\n"\
-	ATOMIC_SYNC\
-"	stwcx.	%0,0,%3\n\
+	add	%0,%2,%0\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne-	1b"
 	: "=&r" (t), "=m" (v->counter)
 	: "r" (a), "r" (&v->counter), "m" (v->counter)
@@ -71,9 +55,9 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%2		# atomic_add_return\n\
-	add	%0,%1,%0\n"\
-	ATOMIC_SYNC\
-"	stwcx.	%0,0,%2\n\
+	add	%0,%1,%0\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
 	bne-	1b"
 	SMP_ISYNC
 	: "=&r" (t)
@@ -89,9 +73,9 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%3		# atomic_sub\n\
-	subf	%0,%2,%0\n"\
-	ATOMIC_SYNC\
-"	stwcx.	%0,0,%3\n\
+	subf	%0,%2,%0\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne-	1b"
 	: "=&r" (t), "=m" (v->counter)
 	: "r" (a), "r" (&v->counter), "m" (v->counter)
@@ -104,9 +88,9 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%2		# atomic_sub_return\n\
-	subf	%0,%1,%0\n"\
-	ATOMIC_SYNC\
-"	stwcx.	%0,0,%2\n\
+	subf	%0,%1,%0\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
 	bne-	1b"
 	SMP_ISYNC
 	: "=&r" (t)
@@ -122,9 +106,9 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%2		# atomic_inc\n\
-	addic	%0,%0,1\n"\
-	ATOMIC_SYNC\
-"	stwcx.	%0,0,%2\n\
+	addic	%0,%0,1\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
 	bne-	1b"
 	: "=&r" (t), "=m" (v->counter)
 	: "r" (&v->counter), "m" (v->counter)
@@ -137,9 +121,9 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%1		# atomic_inc_return\n\
-	addic	%0,%0,1\n"\
-	ATOMIC_SYNC\
-"	stwcx.	%0,0,%1\n\
+	addic	%0,%0,1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1 \n\
 	bne-	1b"
 	SMP_ISYNC
 	: "=&r" (t)
@@ -155,8 +139,8 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%2		# atomic_dec\n\
-	addic	%0,%0,-1\n"\
-	ATOMIC_SYNC\
+	addic	%0,%0,-1\n"
+	PPC405_ERR77(0,%2)\
 "	stwcx.	%0,0,%2\n\
 	bne-	1b"
 	: "=&r" (t), "=m" (v->counter)
@@ -170,8 +154,8 @@

 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%1		# atomic_dec_return\n\
-	addic	%0,%0,-1\n"\
-	ATOMIC_SYNC\
+	addic	%0,%0,-1\n"
+	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
 	SMP_ISYNC
@@ -196,8 +180,8 @@
 	__asm__ __volatile__(
 "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
 	addic.	%0,%0,-1\n\
-	blt-	2f\n"\
-	ATOMIC_SYNC\
+	blt-	2f\n"
+	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
 	SMP_ISYNC
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/bitops.h linux-bungo/include/asm-ppc/bitops.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/bitops.h	Sat Jun  9 12:06:37 2001
+++ linux-bungo/include/asm-ppc/bitops.h	Fri Sep 21 12:26:51 2001
@@ -11,6 +11,7 @@

 #include <linux/config.h>
 #include <asm/byteorder.h>
+#include <asm/atomic.h>

 /*
  * The test_and_*_bit operations are taken to imply a memory barrier
@@ -36,8 +37,9 @@

 	__asm__ __volatile__("\n\
 1:	lwarx	%0,0,%3 \n\
-	or	%0,%0,%2 \n\
-	stwcx.	%0,0,%3 \n\
+	or	%0,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne-	1b"
 	: "=&r" (old), "=m" (*p)
 	: "r" (mask), "r" (p), "m" (*p)
@@ -69,8 +71,9 @@

 	__asm__ __volatile__("\n\
 1:	lwarx	%0,0,%3 \n\
-	andc	%0,%0,%2 \n\
-	stwcx.	%0,0,%3 \n\
+	andc	%0,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne-	1b"
 	: "=&r" (old), "=m" (*p)
 	: "r" (mask), "r" (p), "m" (*p)
@@ -96,8 +99,9 @@

 	__asm__ __volatile__("\n\
 1:	lwarx	%0,0,%3 \n\
-	xor	%0,%0,%2 \n\
-	stwcx.	%0,0,%3 \n\
+	xor	%0,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
 	bne-	1b"
 	: "=&r" (old), "=m" (*p)
 	: "r" (mask), "r" (p), "m" (*p)
@@ -126,8 +130,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%4 \n\
-	or	%1,%0,%3 \n\
-	stwcx.	%1,0,%4 \n\
+	or	%1,%0,%3 \n"
+	PPC405_ERR77(0,%4)
+"	stwcx.	%1,0,%4 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=&r" (t), "=m" (*p)
@@ -158,8 +163,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%4 \n\
-	andc	%1,%0,%3 \n\
-	stwcx.	%1,0,%4 \n\
+	andc	%1,%0,%3 \n"
+	PPC405_ERR77(0,%4)
+"	stwcx.	%1,0,%4 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=&r" (t), "=m" (*p)
@@ -190,8 +196,9 @@

 	__asm__ __volatile__(SMP_WMB "\n\
 1:	lwarx	%0,0,%4 \n\
-	xor	%1,%0,%3 \n\
-	stwcx.	%1,0,%4 \n\
+	xor	%1,%0,%3 \n"
+	PPC405_ERR77(0,%4)
+"	stwcx.	%1,0,%4 \n\
 	bne	1b"
 	SMP_MB
 	: "=&r" (old), "=&r" (t), "=m" (*p)
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h linux-bungo/include/asm-ppc/pgtable.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h	Tue Sep 18 11:25:44 2001
+++ linux-bungo/include/asm-ppc/pgtable.h	Fri Sep 21 12:30:01 2001
@@ -442,8 +440,9 @@
 	__asm__ __volatile__("\
 1:	lwarx	%0,0,%3\n\
 	andc	%1,%0,%4\n\
-	or	%1,%1,%5\n\
-	stwcx.	%1,0,%3\n\
+	or	%1,%1,%5\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%1,0,%3\n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" (clr), "r" (set), "m" (*p)
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/spinlock.h linux-bungo/include/asm-ppc/spinlock.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/spinlock.h	Wed Aug 29 08:57:36 2001
+++ linux-bungo/include/asm-ppc/spinlock.h	Fri Sep 21 12:25:06 2001
@@ -46,8 +46,9 @@
 	bne+	2b\n\
 1:	lwarx	%0,0,%1\n\
 	cmpwi	0,%0,0\n\
-	bne-	2b\n\
-	stwcx.	%2,0,%1\n\
+	bne-	2b\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%2,0,%1\n\
 	bne-	2b\n\
 	isync"
 	: "=&r"(tmp)
@@ -114,8 +115,9 @@
 	blt+		1b\n\
 2:	lwarx		%0,0,%1\n\
 	addic.		%0,%0,1\n\
-	ble-		1b\n\
-	stwcx.		%0,0,%1\n\
+	ble-		1b\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.		%0,0,%1\n\
 	bne-		2b\n\
 	isync"
 	: "=&r"(tmp)
@@ -130,8 +132,9 @@
 	__asm__ __volatile__(
 	"eieio				# read_unlock\n\
 1:	lwarx		%0,0,%1\n\
-	addic		%0,%0,-1\n\
-	stwcx.		%0,0,%1\n\
+	addic		%0,%0,-1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.		%0,0,%1\n\
 	bne-		1b"
 	: "=&r"(tmp)
 	: "r"(&rw->lock)
@@ -149,8 +152,9 @@
 	bne+		1b\n\
 2:	lwarx		%0,0,%1\n\
 	cmpwi		0,%0,0\n\
-	bne-		1b\n\
-	stwcx.		%2,0,%1\n\
+	bne-		1b\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.		%2,0,%1\n\
 	bne-		2b\n\
 	isync"
 	: "=&r"(tmp)
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/system.h linux-bungo/include/asm-ppc/system.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/system.h	Thu Sep 20 09:19:15 2001
+++ linux-bungo/include/asm-ppc/system.h	Fri Sep 21 12:25:06 2001
@@ -130,8 +130,9 @@
 	unsigned long prev;

 	__asm__ __volatile__ ("\n\
-1:	lwarx	%0,0,%2 \n\
-	stwcx.	%3,0,%2 \n\
+1:	lwarx	%0,0,%2 \n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%3,0,%2 \n\
 	bne-	1b"
 	: "=&r" (prev), "=m" (*(volatile unsigned long *)p)
 	: "r" (p), "r" (val), "m" (*(volatile unsigned long *)p)
@@ -181,8 +182,9 @@
 	__asm__ __volatile__ ("\n\
 1:	lwarx	%0,0,%2 \n\
 	cmpw	0,%0,%3 \n\
-	bne	2f \n\
-	stwcx.	%4,0,%2 \n\
+	bne	2f \n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%4,0,%2 \n\
 	bne-	1b\n"
 #ifdef CONFIG_SMP
 "	sync\n"


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
