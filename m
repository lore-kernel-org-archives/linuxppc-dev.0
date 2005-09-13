Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1126631205.11056.15.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 13 Sep 2005 12:06:46 -0500
Subject: Merge Question on asm-ppc*/rwsem.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul (or anyone, really),

I am not too familiar with some of the low-level machine
details that might (do!) influence some of the semaphore
implementations.  I was hoping I might get you to give
me a quick nudge in the right direction here.

Here is a brief example of the differences found in
the ppc and pp64 versions of asm-ppc*/rwsem.h:

    (ppc is -, and ppc64 is + here)

    @@ -69,9 +74,7 @@
      */
     static inline void __down_read(struct rw_semaphore *sem)
     {
    -       if (atomic_inc_return((atomic_t *)(&sem->count)) > 0)
    -               smp_wmb();
    -       else
    +       if (unlikely(atomic_inc_return((atomic_t *)(&sem->count)) <= 0))
                    rwsem_down_read_failed(sem);
     }

If we add likely() to the PPC version, and then invert it,
we can get effectively this:

    static inline void __down_read(struct rw_semaphore *sem)
    {
            if (unlikely(atomic_inc_return((atomic_t *)(&sem->count)) <= 0))
                    rwsem_down_read_failed(sem);
    #ifndef __powerpc64__
            else
                    smp_wmb();
    #endif
    }

Which begs the question, what is the "else smp_wmb();" clause
really doing for us in the ppc32 case, and can we either
get rid of it, or is it safe to add to the ppc64 case?

Thanks,
jdl
