Content-Type: text/plain;
  charset="us-ascii"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: why isync in atomic icc and return and atomic dec and return for CONFIG_SMP 
Date: Tue, 23 Jul 2002 17:25:30 -0400
MIME-Version: 1.0
Message-Id: <200207231725.30067.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Can anyone tell me the reason why we need to use an isync in the
atomic_add_return and atomic_sub_return (see kernel source in
asm/atomic.h) only for SMP machiens and only when a value is returned?

My understanding of an "isync" is that it forces all instruction issued
previous to the isync to be completed before any new instructions can be
fetched on that cpu (not on all cpus?).

Why is this needed only for SMP machines?

Why is it only needed when a value is actually returned (there are no isync
instructions on the non-returning versions)?

Can someone explain exactly what the isync does for us here?


#ifdef CONFIG_SMP
#define SMP_ISYNC       "\n\tisync"
#else
#define SMP_ISYNC
#endif

static __inline__ int atomic_add_return(int a, atomic_t *v)
{
        int t;

        __asm__ __volatile__(
"1:     lwarx   %0,0,%2         # atomic_add_return\n\
        add     %0,%1,%0\n\
        stwcx.  %0,0,%2\n\
        bne-    1b"
        SMP_ISYNC
        : "=&r" (t)
        : "r" (a), "r" (&v->counter)
        : "cc", "memory");

        return t;
}


static __inline__ int atomic_sub_return(int a, atomic_t *v)
{
        int t;

        __asm__ __volatile__(
"1:     lwarx   %0,0,%2         # atomic_sub_return\n\
        subf    %0,%1,%0\n\
        stwcx.  %0,0,%2\n\
        bne-    1b"
        SMP_ISYNC
        : "=&r" (t)
        : "r" (a), "r" (&v->counter)
        : "cc", "memory");

        return t;
}


Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
