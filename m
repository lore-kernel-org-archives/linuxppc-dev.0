Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: yellowdog-devel@lists.terrasoftsolutions.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: why isync in atomic icc and return and atomic dec and return for CONFIG_SMP
Date: Tue, 23 Jul 2002 18:15:05 -0400
References: <200207231725.30067.kevin.hendricks@sympatico.ca>
In-Reply-To: <200207231725.30067.kevin.hendricks@sympatico.ca>
MIME-Version: 1.0
Message-Id: <200207231815.05841.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

"PowerPC Microprocessor Family: The Programming Environments" manual
(MPRPPCFPE-01, MPCFPE/AD from IBM Microelectronics and Motorola -dated
1994) on page 8-104 says the following about "isync" and I am quoting:

This instruction waits for all previous instructions to complete and then
discards any prefetched instructions, causing subsequent instructions to
be fetched (or refetched) from memory and to execute in the context
established by the previous instructions.  This instruction has NO EFFECT
on other processors or their caches.

So why should we be using this only for SMP systems?  If we are using the
atomic operations to create our own locks then I understand why the isync
but then it should be there for both smp and non-smp systems shouldn't it?

I must be missing something here?

Kevin



On July 23, 2002 05:25, Kevin B. Hendricks wrote:
> Hi,
>
> Can anyone tell me the reason why we need to use an isync in the
> atomic_add_return and atomic_sub_return (see kernel source in
> asm/atomic.h) only for SMP machiens and only when a value is returned?
>
> My understanding of an "isync" is that it forces all instruction issued
> previous to the isync to be completed before any new instructions can be
> fetched on that cpu (not on all cpus?).
>
> Why is this needed only for SMP machines?
>
> Why is it only needed when a value is actually returned (there are no
> isync instructions on the non-returning versions)?
>
> Can someone explain exactly what the isync does for us here?
>
>
> #ifdef CONFIG_SMP
> #define SMP_ISYNC       "\n\tisync"
> #else
> #define SMP_ISYNC
> #endif
>
> static __inline__ int atomic_add_return(int a, atomic_t *v)
> {
>         int t;
>
>         __asm__ __volatile__(
> "1:     lwarx   %0,0,%2         # atomic_add_return\n\
>         add     %0,%1,%0\n\
>         stwcx.  %0,0,%2\n\
>         bne-    1b"
>         SMP_ISYNC
>
>         : "=&r" (t)
>         : "r" (a), "r" (&v->counter)
>         : "cc", "memory");
>
>         return t;
> }
>
>
> static __inline__ int atomic_sub_return(int a, atomic_t *v)
> {
>         int t;
>
>         __asm__ __volatile__(
> "1:     lwarx   %0,0,%2         # atomic_sub_return\n\
>         subf    %0,%1,%0\n\
>         stwcx.  %0,0,%2\n\
>         bne-    1b"
>         SMP_ISYNC
>
>         : "=&r" (t)
>         : "r" (a), "r" (&v->counter)
>         : "cc", "memory");
>
>         return t;
> }
>
>
> Thanks,
>
> Kevin
>
> _______________________________________________
> yellowdog-devel mailing list
> yellowdog-devel@lists.terrasoftsolutions.com
> http://lists.terrasoftsolutions.com/mailman/listinfo/yellowdog-devel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
