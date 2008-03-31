Return-Path: <jyoung5@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C80BDE3B1
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 04:23:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2VINoJr027167
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 14:23:50 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2VINl6L125680
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 12:23:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2VINkOd032384
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 12:23:46 -0600
Subject: Re: [PATCH] Add idle power save for ppc 4xx
From: Jerone Young <jyoung5@us.ibm.com>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <1206983237.12155.60.camel@vader.jdub.homelinux.org>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 13:23:46 -0500
Message-Id: <1206987826.9165.15.camel@thinkpadL>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-03-31 at 12:07 -0500, Josh Boyer wrote:
> On Mon, 2008-03-31 at 08:12 -0500, Jerone Young wrote:
> > # HG changeset patch
> > # User Jerone Young <jyoung5@us.ibm.com>
> > # Date 1206969060 18000
> > # Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f
> > # Parent  1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc
> > Add idle power save for ppc 4xx
> > 
> > This patch sets the wait state MSR when power_save is called in cpu_idle loop for ppc4xx. This is mainly to help out virtualization solutions such as KVM. This way the virtualization soultions are able to tell if the guest kernel is idle.
> > 
> > I have tested this on hardware & KVM virtual guest.
> 
> I'm not overly thrilled with adding this to all of 4xx.  It doesn't
> actually save much power at all (1% on a project that actually measured
> it with an amp meter recently) and there's really no other benefit to
> doing it outside of the virtual guest case.
> 
> I'm assuming you pass a dtb to the virtual guest when you start it up.
> Could you define a property in the CPU node there that can be parsed to
> use the power_save function instead of always making it the default?
> 
> > Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
> > 
> > diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -39,6 +39,7 @@ obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsy
> >  obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
> >  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
> >  obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
> > +obj-$(CONFIG_4xx)		+= idle_4xx.o
> >  obj-$(CONFIG_TAU)		+= tau_6xx.o
> >  obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
> >  				   swsusp_$(CONFIG_WORD_SIZE).o
> > diff --git a/arch/powerpc/kernel/idle_4xx.c b/arch/powerpc/kernel/idle_4xx.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/arch/powerpc/kernel/idle_4xx.c
> 
> Can this be added to sysdev/ppc4xx_soc.c instead?

Probably. Though the other platforms have there power_save code in
idle_<platform>.S files, as they are in assembly.

Also I don't appear to have ppc4xx_soc.c in my source (using
2.6.25-rc6).

> 
> > +#include <asm/processor.h>
> > +#include <asm/machdep.h>
> > +
> > +void ppc4xx_idle()
> > +{
> > +	unsigned long msr_save;
> > +
> > +	/* set wait state MSR */
> > +	local_irq_enable();
> > +	msr_save = mfmsr();
> > +	mtmsr(msr_save|MSR_WE);
> > +	local_irq_disable();
> > +}
> 
> I agree with Hollis on both the MSR_WE|MSR_EE and removing the
> local_irq_disable changes.

You mention adding MSR_CE in a followup email. I'll add that to and
remove local_irq_disable.

> 
> > diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> > --- a/arch/powerpc/kernel/setup_32.c
> > +++ b/arch/powerpc/kernel/setup_32.c
> > @@ -132,6 +132,10 @@ void __init machine_init(unsigned long d
> >  	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
> >  	    cpu_has_feature(CPU_FTR_CAN_NAP))
> >  		ppc_md.power_save = ppc6xx_idle;
> > +#endif
> > +
> > +#ifdef CONFIG_4xx
> > +	ppc_md.power_save = ppc4xx_idle;
> >  #endif
> 
> I agree this belongs in platform setup code.  Finding the right spot for
> it might be a bit of a challenge.
> 
> josh
> 
