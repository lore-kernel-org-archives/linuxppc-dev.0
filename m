Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA623B7D8A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 14:30:48 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5H4Ftlw008690
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 00:15:55 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5H4Uew4130400
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 00:30:44 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5H4Ue77022493
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 00:30:40 -0400
Date: Wed, 16 Jun 2010 21:30:39 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH RFC] ppc: fix default_machine_crash_shutdown #ifdef botch
Message-ID: <20100617043038.GA2651@linux.vnet.ibm.com>
References: <20100616004839.GA18110@linux.vnet.ibm.com>
	<6286.1276739813@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6286.1276739813@neuling.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 17, 2010 at 11:56:53AM +1000, Michael Neuling wrote:
> 
> 
> In message <20100616004839.GA18110@linux.vnet.ibm.com> you wrote:
> > crash_kexec_wait_realmode() is defined only if CONFIG_PPC_STD_MMU_64
> > and CONFIG_SMP, but is called if CONFIG_PPC_STD_MMU_64 even if !CONFIG_SMP.
> > Fix the conditional compilation around the invocation.
> > 
> > Untested, probably does not compile.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> This should be right since we don't need to wait for the other CPUs if
> there are no others... 
> 
> Compiles for me and even fixes the SMP=N case.  Thanks!

Glad it worked!  ;-)

							Thanx, Paul

> Acked-by: Michael Neuling <mikey@neuling.org>
> 
> > ---
> > 
> > diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> > index b46f2e0..29df48f 100644
> > --- a/arch/powerpc/kernel/crash.c
> > +++ b/arch/powerpc/kernel/crash.c
> > @@ -447,7 +447,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
> >  	crash_kexec_prepare_cpus(crashing_cpu);
> >  	cpu_set(crashing_cpu, cpus_in_crash);
> >  	crash_kexec_stop_spus();
> > -#ifdef CONFIG_PPC_STD_MMU_64
> > +#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
> >  	crash_kexec_wait_realmode(crashing_cpu);
> >  #endif
> >  	if (ppc_md.kexec_cpu_down)
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
