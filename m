Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D61BAB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 08:11:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3414DDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 08:11:17 +1000 (EST)
Subject: Re: [PATCH 11/20] powerpc: Move definitions of secondary CPU
	spinloop to header file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9D0737C4-EA82-41B8-B109-ED4FDB901C00@kernel.crashing.org>
References: <20090723055957.19D28DDD1B@ozlabs.org>
	<9D0737C4-EA82-41B8-B109-ED4FDB901C00@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 08:11:12 +1000
Message-Id: <1248387072.25467.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-23 at 09:51 -0500, Kumar Gala wrote:
> On Jul 23, 2009, at 12:59 AM, Benjamin Herrenschmidt wrote:
> 
> > Those definitions are currently declared extern in the .c file where
> > they are used, move them to a header file instead.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > --
> >
> > arch/powerpc/include/asm/smp.h |    5 +++++
> > arch/powerpc/kernel/setup_64.c |    3 ---
> > 2 files changed, 5 insertions(+), 3 deletions(-)
> 
> Can we not get rid of the externs in:
> 
> arch/powerpc/platforms/cell/smp.c:extern void  
> generic_secondary_smp_init(unsigned long);
> arch/powerpc/platforms/pseries/smp.c:extern void  
> generic_secondary_smp_init(unsigned long);
> 
> arch/powerpc/kernel/prom_init.c:extern unsigned long  
> __secondary_hold_spinloop;

Probably :-) I'll have a look.

Cheers,
Ben.

> - k
> 
> >
> >
> > --- linux-work.orig/arch/powerpc/include/asm/smp.h	2009-07-22  
> > 16:38:32.000000000 +1000
> > +++ linux-work/arch/powerpc/include/asm/smp.h	2009-07-22  
> > 16:46:59.000000000 +1000
> > @@ -148,6 +148,11 @@ extern struct smp_ops_t *smp_ops;
> > extern void arch_send_call_function_single_ipi(int cpu);
> > extern void arch_send_call_function_ipi(cpumask_t mask);
> >
> > +#ifdef CONFIG_PPC64
> > +extern void generic_secondary_smp_init(void);
> > +extern unsigned long __secondary_hold_spinloop;
> > +#endif /* CONFIG_PPC64 */
> > +
> > #endif /* __ASSEMBLY__ */
> >
> > #endif /* __KERNEL__ */
> > Index: linux-work/arch/powerpc/kernel/setup_64.c
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-07-22  
> > 16:38:12.000000000 +1000
> > +++ linux-work/arch/powerpc/kernel/setup_64.c	2009-07-22  
> > 16:46:59.000000000 +1000
> > @@ -230,9 +230,6 @@ void early_setup_secondary(void)
> > #endif /* CONFIG_SMP */
> >
> > #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
> > -extern unsigned long __secondary_hold_spinloop;
> > -extern void generic_secondary_smp_init(void);
> > -
> > void smp_release_cpus(void)
> > {
> > 	unsigned long *ptr;
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
