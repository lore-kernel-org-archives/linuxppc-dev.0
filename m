Date: Thu, 20 Jun 2002 15:46:01 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Samuel Rydh <samuel@ibrium.se>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sycall asm inline
In-Reply-To: <20020619033923.14394@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0206201520090.15378-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Jun 2002, Benjamin Herrenschmidt wrote:

> >I had a patch that did exactly this, but I don't know where it is anymore
> >(too many bk trees :-)) Anyway you don't want to see my inline version of
> >atomic_clear_mask which selected the best instruction (among rlwinm,
> >andi., andis., and andc) through a maze of macros and builtin_constant_p
> >(I did this for fun since atomic_clear_mask is almost never used).
>
> It's never used, but should probably be inlined anyway, I just found
> a driver that used it and we don't export it to modules...

Ok, you wanted it, you get it. I have finally found the atomic.h I used on
UP for kernel 2.4.0. It is missing a few SMP synchronization barriers and
the 405(?) braindeadness bugfixes (I'm still unable to understand how IBM
could let a proc with such a bug in the wild).

Comments ? If it's the last version I wrote (not sure, maybe I missed a
later version when searching this morning), it's been heavily stress
tested in userspace, but on UP only. I've not booted the kernel very often
(still using 2.2 for production).

Note that I suspect that the compiler version check can be removed,
everybody should be at 2.95 or later now. The change in letters for
immediate constraint was quite painful.

And yes, I know that a few more functions have been added since then, like
dec_if_positive. But there are other things I don't understand in the
current code, especially some memory barriers and clobbers for which I
can't find a good reason.

Note also that these are macros and not inline functions, but this was
written before there was correct constant propagation for optimization
of builtin_constant_p in inline function calls. I believe that this is
properly fixed in versions of GCC blessed to compile the kernel.

Now people who want to have fun may try to expand __mask_constant by hand
and later check the result with cc -E :-)

	Gabriel

==========================================================================
/*
 * PowerPC atomic operations
 */

#ifndef _ASM_PPC_ATOMIC_H_
#define _ASM_PPC_ATOMIC_H_

typedef struct { volatile int counter; } atomic_t;

#define ATOMIC_INIT(i)	{ (i) }

#define atomic_read(v)		((v)->counter)
#define atomic_set(v,i)		(((v)->counter) = (i))

/* The exact version number for which the 32 bit mask
 * constraint letter switched from "L" to "T" should be checked.
 * The #r in the constraints is a trick to keep gcc shut, don't tell
 * anybody in the gcc lists about it.
 */
#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >94)
#define __MASK32__ "T#r"
#define __SIGNED_HIGH_IMMEDIATE__ "L#r"
#else
#define __MASK32__ "L#r"
#define __SIGNED_HIGH_IMMEDIATE__ "J#r"
#endif

#define __atomic_op(addr, action, tmp, operand...) \
({int __tmp__; \
  asm volatile("\n\
1:	lwarx %0,0,%2\n\t"\
	action "\n\
	stwcx. %0,0,%2\n\
	bne-	1b" \
	: tmp (__tmp__), "+m" ((volatile atomic_t *)(addr)->counter) \
	: "r" (addr) , ##operand \
	: "cr0"); \
})

#define __atomic_op_return(addr, action, tmp, operand...) \
({int __tmp__; \
  asm volatile("\n\
1:	lwarx %0,0,%2\n\t"\
	action "\n\
	stwcx. %0,0,%2\n\
	bne-	1b" \
	: tmp (__tmp__), "+m" ((volatile atomic_t *)(addr)->counter) \
	: "r" (addr) , ##operand \
	: "cr0"); \
	__tmp__; \
})

/* Using "i#r" for high immediate constants avoids having to
 * use the exact constraint letter which has changed beween
 * gcc revisions.
 */
#define atomic_add(amount,addr) \
(__builtin_constant_p(amount) && (!((amount) & 0xffff)) ? \
 __atomic_op(addr, \
             "addis %0,%0,%v3 # atomic_add", "=&b", "i#r" (amount)): \
 __builtin_constant_p(amount) && ((unsigned)(amount)+0x8000 >= 0x10000) ? \
 __atomic_op(addr, \
             "addis %0,%0,%v3; addi %0,%0,%w3 # atomic_add", \
             "=&b", "i#r" (amount + ((amount&0x8000)<<1))) : \
 __atomic_op(addr, \
             "add%I3 %0,%0,%3 # atomic_add", "=&b", "Ir" (amount)))

#define atomic_add_return(amount,addr) \
(__builtin_constant_p(amount) && (!((amount) & 0xffff)) ? \
 __atomic_op_return(addr, \
                    "addis %0,%0,%v3 # atomic_add_return", \
                    "=&b", "i#r" (amount): \
 __builtin_constant_p(amount) && ((unsigned)(amount)+0x8000 >= 0x10000) ? \
 __atomic_op_return(addr, \
             "addis %0,%0,%v3; addi %0,%0,%w3 # atomic_add_return", \
             "=&b", "i#r" (amount + ((amount&0x8000)<<1))) : \
 __atomic_op_return(addr, \
             "add%I3 %0,%0,%3 # atomic_add_return", "=&b", "Ir" (amount)))

#define atomic_sub(amount,addr) \
(__builtin_constant_p(amount) && (!((amount) & 0xffff)) ? \
 __atomic_op(addr, \
             "addis %0,%0,%v3 # atomic_sub", "=&b", "i#r" (-amount)): \
 __builtin_constant_p(amount) && ((unsigned)(-(amount))+0x8000 >= 0x10000) ? \
 __atomic_op(addr, \
             "addis %0,%0,%v3; addi %0,%0,%w3 # atomic_sub", \
             "=&b", "i#r" (amount + ((amount&0x8000)<<1))) : \
 __atomic_op(addr, \
             "sub%I3 %0,%0,%3 # atomic_sub", "=&b", "Pr" (amount)))

#define atomic_inc(addr) \
        __atomic_op(addr, "addi %0,%0,1 # atomic_inc", "=&b")

#define atomic_inc_return(addr) \
        __atomic_op_return(addr, "addi %0,%0,1 # atomic_inc_return", "=&b")

#define atomic_dec(addr) \
        __atomic_op(addr, "addi %0,%0,-1 # atomic_dec", "=&b")

#define atomic_dec_return(addr) \
        __atomic_op_return(addr, "addi %0,%0,-1 # atomic_dec_return", "=&b")

#define atomic_dec_and_test(addr) \
        (!__atomic_op_return(addr, \
                             "addi %0,%0,-1 # atomic_dec_and_test", "=&b"))

#define atomic_set_mask(mask,addr) \
(__builtin_constant_p(mask) && (!((mask) & 0xffff)) ? \
 __atomic_op(addr, "oris %0,%0,%u3 # atomic_set_mask", \
             "=&r", "J#r" (mask)) : \
 __builtin_constant_p(mask) && ((mask)&0xffff0000U) ? \
 __atomic_op(addr, \
	     "oris %0,%0,%u3; ori %0,%0,%b3 # atomic_set_mask", \
             "=&r", "i#r" (mask)) : \
 __atomic_op(addr, \
	     "or%I3 %0,%0,%3 # atomic_set_mask", "=&r", "Kr"(mask)))

/* Clear mask is more complex than the others especially
 * if we want to make clever use of rlwinm.
 */
#define __mask_edges(x) (((x) ^ ((x)<<1)) & ~ 1U)
#define __mask_clear_lsb(x) (x &~ (x & -x))
#define __mask_constant(x) ((x)!=0 && \
__mask_clear_lsb(__mask_clear_lsb(__mask_edges(x))) == 0)

#define atomic_clear_mask(mask,addr)\
({if (__builtin_constant_p(mask)) {\
	if (__mask_constant(mask)) {\
		__atomic_op(addr,\
			    "rlwinm %0,%0,0,%m3,%M3 # atomic_clear_mask",\
			    "=&r", __MASK32__(~mask));\
	} else if (((mask) & 0xffff0000U) == 0xffff0000U) {\
		__atomic_op(addr,\
			    "andi. %0,%0,%3 # atomic_clear_mask",\
			    "=&r", "K#r" ((~mask)&0xffff));\
	} else if (((mask) & 0xffff) == 0xffff) {\
		__atomic_op(addr,\
			    "andis. %0,%0,%3 # atomic_clear_mask",\
			    "=&r", "J#r" (~mask));\
 	} else {\
		__atomic_op(addr,\
			    "andc %0,%0,%3 # atomic_clear_mask",\
			    "=&r", "r" (mask));\
	}\
} else {\
	__atomic_op(addr,\
		    "andc %0,%0,%3 # atomic_clear_mask",\
		    "=&r", "r" (mask));\
}})

#endif /* _ASM_PPC_ATOMIC_H_ */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
