Return-Path: <jyoung5@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CD28DDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 17:00:20 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m345wWLb015315
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 01:58:32 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m346018x104290
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 00:00:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34600q8021682
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 00:00:00 -0600
Subject: Re: [PATCH] Add idle wait support for 44x platforms
From: Jerone Young <jyoung5@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080403210027.05339204@zod.rchland.ibm.com>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<20080403210027.05339204@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 00:59:59 -0500
Message-Id: <1207288799.6971.11.camel@thinkpadL>
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

On Thu, 2008-04-03 at 21:00 -0500, Josh Boyer wrote:
> On Thu, 03 Apr 2008 17:43:02 -0500
> Jerone Young <jyoung5@us.ibm.com> wrote:
> 
> > # HG changeset patch
> > # User Jerone Young <jyoung5@us.ibm.com>
> > # Date 1207262487 18000
> > # Node ID 7226bef216680748a50327900572c2fbc3e762b0
> > # Parent  a5b2aebbc6ebd2439c655f1c047ed7e3c1991ec1
> 
> As a complete and unrelated side note to the actual patch, wtf is this
> hg stuff?  I can't really tell what tree you're even basing this off of.

hehe...I primary use hg as it's just much easier to deal with. Yes I do
go through the conversion. But it is worth it. The patches I send are in
git format.

> 
> > Add idle wait support for 44x platforms
> > 
> > This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.
> 
> This huge single line needs fixing in the next version of the patch.
> 
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
> 
> In addition to the comments Tony and Hollis made, I have a few of my
> own.
> 
> > Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
> > 
> > diff --git a/arch/powerpc/platforms/44x/44x.h b/arch/powerpc/platforms/44x/44x.h
> > --- a/arch/powerpc/platforms/44x/44x.h
> > +++ b/arch/powerpc/platforms/44x/44x.h
> > @@ -5,4 +5,6 @@ extern void as1_writeb(u8 data, volatile
> >  extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
> >  extern void ppc44x_reset_system(char *cmd);
> > 
> > +extern int ppc44x_idle_init(void);
> > +
> >  #endif /* __POWERPC_PLATFORMS_44X_44X_H */
> 
> The changes to this file aren't needed.  See below.
> 
> > diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
> > --- a/arch/powerpc/platforms/44x/Makefile
> > +++ b/arch/powerpc/platforms/44x/Makefile
> > @@ -1,4 +1,5 @@ obj-$(CONFIG_44x)	:= misc_44x.o
> >  obj-$(CONFIG_44x)	:= misc_44x.o
> > +obj-$(CONFIG_44x)	+= idle.o
> 
> Just add this target to the already existing obj-(CONFIG_44x)
> 
> >  obj-$(CONFIG_EBONY)	+= ebony.o
> >  obj-$(CONFIG_TAISHAN)	+= taishan.o
> >  obj-$(CONFIG_BAMBOO)	+= bamboo.o
> > diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
> > --- a/arch/powerpc/platforms/44x/bamboo.c
> > +++ b/arch/powerpc/platforms/44x/bamboo.c
> > @@ -61,3 +61,5 @@ define_machine(bamboo) {
> >  	.restart			= ppc44x_reset_system,
> >  	.calibrate_decr 	= generic_calibrate_decr,
> >  };
> > +
> > +machine_late_initcall(bamboo, ppc44x_idle_init);
> 
> Ugh.  Don't add an init call to every 4xx board like this.  It's not
> needed.  See below.
> 
> > diff --git a/arch/powerpc/platforms/44x/idle.c b/arch/powerpc/platforms/44x/idle.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/44x/idle.c
> 
> If you're ever going to extend bare metal support for this to 40x, then
> this is the wrong place for it.  It should reside in
> arch/powerpc/sysdev/ppc4xx_soc.c in that case.

So I did this at first after your suggestions but then I changed it
because:

- it depended on CONFIG_4xx_SOC .. which I could not figure out who
actually enabled this

- wanted to make a patch that could also go into earlier kernels 


> 
> > +
> > +#include <linux/of.h>
> > +#include <asm/machdep.h>
> > +
> > +static void ppc44x_idle(void);
> 
> This isn't needed.  Move the structures below the function.

This can be done
> 
> > +struct sleep_mode {
> > +	char *name;
> > +	void (*entry)(void);
> > +};
> > +
> > +static struct sleep_mode modes[] = {
> > +	{ .name = "spin", .entry = NULL },
> > +	{ .name = "wait", .entry = &ppc44x_idle },
> > +};
> 
> <snip>
> 
> > +int __init ppc44x_idle_init(void)
> > +{
> > +	if(of_find_node_by_path("/hypervisor") != NULL) {
> > +		/* if we find /hypervisor node is in device tree,
> > +		   set idle mode to wait */
> > +		current_mode = 1; /* wait mode */
> > +	}
> > +
> > +	ppc_md.power_save = modes[current_mode].entry;
> > +	return 0;
> 
> I liked Hollis' method of assignment here.
> 
> > +}
> 
> Add an arch_initcall(ppc44x_idle_init); here and dispense with
> changing every board .c file in the 44x directory.
ah didn't know about arch_initcall

> 
> josh
