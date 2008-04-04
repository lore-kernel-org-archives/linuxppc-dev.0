Return-Path: <jyoung5@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14A6FDDEF5
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 02:42:47 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m34Fgh6I032439
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 11:42:43 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m34Fggku051344
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 09:42:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34FggTP032133
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 09:42:42 -0600
Subject: Re: [kvm-ppc-devel] [PATCH] [v2] Add idle wait support for 44x
	platforms
From: Jerone Young <jyoung5@us.ibm.com>
To: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
References: <afed3e5de82ab6c0ac8d.1207292794@thinkpadL>
	<835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 10:42:41 -0500
Message-Id: <1207323761.6634.6.camel@thinkpadL>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-04-04 at 08:36 -0400, Jimi Xenidis wrote:
> On Apr 4, 2008, at 3:06 AM, Jerone Young wrote:
> 
> > # HG changeset patch
> > # User Jerone Young <jyoung5@us.ibm.com>
> > # Date 1207292108 18000
> > # Node ID afed3e5de82ab6c0ac8d6ceeb0292b6c41ece1ed
> > # Parent  a5b2aebbc6ebd2439c655f1c047ed7e3c1991ec1
> > [v2] Add idle wait support for 44x platforms
> >
> > This patch adds the ability for the CPU to go into wait state while  
> > in cpu_idle loop. This helps virtulization solutions know when the  
> > guest Linux kernel is in an idle state. There are two ways to do it.
> >
> > 1) Command line
> > 	idle=spin <-- CPU will spin (this is the default)
> > 	idle=wait <-- set CPU into wait state when idle
> >
> > 2) The device tree will be checked for the "/hypervisor" node
> >    If this node is seen it will use "wait" for idle, so that
> >    the hypervisor can know when guest Linux kernel it is in
> >    an idle state.
> >
> > This patch, unlike the last, isolates the code to 44x platforms.
> >
> > Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
> >
> > diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/ 
> > platforms/44x/Makefile
> > --- a/arch/powerpc/platforms/44x/Makefile
> > +++ b/arch/powerpc/platforms/44x/Makefile
> > @@ -1,4 +1,4 @@ obj-$(CONFIG_44x)	:= misc_44x.o
> > -obj-$(CONFIG_44x)	:= misc_44x.o
> > +obj-$(CONFIG_44x)	:= misc_44x.o idle.o
> >  obj-$(CONFIG_EBONY)	+= ebony.o
> >  obj-$(CONFIG_TAISHAN)	+= taishan.o
> >  obj-$(CONFIG_BAMBOO)	+= bamboo.o
> > diff --git a/arch/powerpc/platforms/44x/idle.c b/arch/powerpc/ 
> > platforms/44x/idle.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/44x/idle.c
> > @@ -0,0 +1,84 @@
> > +/*
> > + * Copyright 2008 IBM Corp.
> > + *
> > + * Derived from pasemi/idle.c
> > + * 	by Olof Johansson <olof@lixom.net>
> > + *
> > + * Added by: Jerone Young <jyoung5@us.ibm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or  
> > modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA   
> > 02111-1307 USA
> > + *
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/kernel.h>
> > +#include <asm/machdep.h>
> > +
> > +static int current_mode = 0;
> 
> Doesn't matter if the 0 is functionally redundant or pleasing to your  
> eye, it is the "Linux way" to leave out the " = 0", so just do it  
> please.
> 
Ok this can be removed.

> > +
> > +struct sleep_mode {
> > +	char *name;
> > +	void (*entry)(void);
> > +};
> > +
> > +static void ppc44x_idle(void)
> Perhaps "ppc44x_wait" is more appropriate?
> > +{
> > +	unsigned long msr_save;
> > +
> > +	msr_save = mfmsr();
> > +	/* set wait state MSR */
> > +	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE);
> 
> Did we decide to drop MSR_DE?
Hollis argued it down on an earlier email on kvm-ppc-devel. Though I did
have it in one of the earlier patches.

> 
> > +	/* return to initial state */
> > +	mtmsr(msr_save);
> 
> It may be my paranoia but I'm pretty sure you need the isync() after  
> _both_ mtmsr()s
> Certainly can't hurt.

I could add this back. Though everyone had already agreed on it without
it. So figured it was safer to go witout it. But I can add it back.

> 
> > +}
> > +
> > +static struct sleep_mode modes[] = {
> > +	{ .name = "spin", .entry = NULL },
> > +	{ .name = "wait", .entry = &ppc44x_idle },
> > +};
> > +
> > +int __init ppc44x_idle_init(void)
> > +{
> > +	void *func = modes[current_mode].entry;
> > +	struct device_node *node;
> > +
> > +	node = of_find_node_by_path("/hypervisor");
> > +	if (node) {
> > +		/* if we find /hypervisor node is in device tree,
> > +		   set idle mode to wait */
> > +		func = &ppc44x_idle; /* wait */
> > +		of_node_put(node);
> > +	}
> > +
> > +	ppc_md.power_save = func;
> > +	return 0;
> > +}
> > +
> > +arch_initcall(ppc44x_idle_init);
> 
> IIRC, this would over-ride the idle_param() below, is that the  
> intended behavior?

Yes. At the moment if it detects a hypervisor in the kernel tree it
overrides what the command line says.

> 
> > +
> > +static int __init idle_param(char *p)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < sizeof(modes)/ARRAY_SIZE(modes); i++) {
> 
> It is supposed to be:
> 	for (i = 0; i < ARRAY_SIZE(modes); i++) {
> What you have will actually eval to 0 and would have never checked  
> anything :)

Ouch. My bad. Wasn't thinking when I added that.

> 
> > +		if (!strcmp(modes[i].name, p)) {
> > +			current_mode = i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +early_param("idle", idle_param);
> >
> > ---------------------------------------------------------------------- 
> > ---
> > Check out the new SourceForge.net Marketplace.
> > It's the best place to buy or sell services for
> > just about anything Open Source.
> > http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/ 
> > marketplace
> > _______________________________________________
> > kvm-ppc-devel mailing list
> > kvm-ppc-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/kvm-ppc-devel
> 
