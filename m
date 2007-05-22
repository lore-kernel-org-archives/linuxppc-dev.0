Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 2339CDDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 09:06:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 pterry@micromemory.com
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Date: Wed, 23 May 2007 01:05:52 +0200
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
In-Reply-To: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705230105.53013.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 22 May 2007, Phil Terry wrote:
> Guys n Gals,
> 
> I'm new to this list so I hope this isn't the wrong place to be asking
> these questions.

Hi Phil,

It's the right place, welcome here!

> So I want to explain an overview of what I intend to do for this port
> and if anyone can either tell me where its already been done (yippee),
> tell me I'm on the right track (ok) or tell me I'm on the wrong track
> (bad) that would be great.

I think you are on the right track. It depends a lot on what degree of
probing is possible on rapidio. For most of the bus types that we have
recently added, like plb5 or siliconbackplane, this would be "not at all",
but the code in drivers/rapidio suggests that this one is doing
it correctly and it allows you to probe every device on the bus as long
as you can find the bus controller.

> So I'm taking the boot/dts/mpc8641_hpcn.dts and producing a new
> mpc8641D_umem.dts with the following addition to the soc.
> 
> srio@c0000 {
>                 device_type = "srio";
>                 compatible = "86xx,85xx";
> 		reg = <c0000 20000>;
> 		law = <400000000 e00000000>;
> 		dbells = <0 ffff>;
> 		mboxs = <0 4>;
>                 interrupt-parent = <&mpic>;
>                 interrupts = <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
>               };
>
> where law is the 36-bit start/end address of the law for rapidio (yes I
> do want to use 36-bit addressing as well but thats another story),
> dbells is the range of doorbells to use and mboxs is the range of
> mailboxes.

This sounds like the "law" should actually be part of the reg property,
and both should be relative to the parent bus. The way you define
"reg" seems to be relative to some register area, which is not how
it's meant (depends on the parent of the srio device).

I would guess that the reg property should look more like

	reg = <0 abc0000 0 20000 /* regs_win */
	        4 0 0 400000	 /* maint_win */
		4 400000 0 10000 /* dbell_win */
		4 0 a 0>; /* all the law area */

If you want to describe the control registers being mapped at
0x000000000abc0000 and the law area at 0x0000000400000000, in the
global 36 bit address space, and the registers you want to
ioremap.

With this, your code can be simplified to
	regs_win = of_iomap(node, 0);
	maint_win = of_iomap(node, 1);
	dbell_wind = of_iomap(node, 2);

Since the law appears to define the address space for any
devices behind the rapidio bridge, it might also be an option
to define a "ranges" property that sets up a mapping between
addresses on the two sides of the bridge, like

     #address-cells <2>; /* 64 bit addresses behind the bridge */
     #size-cells <2>; /* 64 bit address length behind the bridge */
     ranges <0 0 4 0 a 0>; /* bus address 0 gets mapped to host
            address 400000000, length a00000000 */

This would be the only way if you wanted to describe rapidio
devices as child nodes, but if you don't do that, there may not
really be much value-add over simply defining a reg property.

What about the hdid? There is currently code that scans the kernel
command line for this, which would make it a candidate to get
written into the device tree by the boot wrapper instead.

> Then I can copy the old ppc/kernel/rio.c to powerpc/kernel/rio.c and
> change...
> 
> void platform_rio_init(void)
> {
> 	struct device_node *np;
> 	if ( (np = of_find_compatible_node(np, "srio", "86xx")) != NULL ) {
> 		mpc86xx_rio_setup(np);
> 	}
> 	else {
> 		printk(KERN_INFO "RIO: No platform_rio_init() present in dts\n");
> 	}
> }
> 
> with mpc86xx_rio_setup being the old mpc85xx_rio_setup from
> ppc/syslib/ppc85xx_rio.c modified to extract the laws, doorbell
> resources, mailboxes etc, from the of_get_property instead of
> hard-coding them.

There is no point in scanning all the device tree yourself for this,
just make sure you have the rapidio device in a place that gets
automatically scanned with of_platform_bus_probe at boot time,
and then register an of_platform_driver that matches your
compatible property.

The code from platform_rio_init then gets converted to the
->probe method of the of_platform_driver.
 
> /* void mpc86xx_rio_setup(int law_start, int law_size) */
> 
> void mpc86xx_rio_setup(struct device_node *np)
> {
> 	...
> 
> 	/*port->iores.start = law_start;*/
>         port->iores.start = of_get_number(of_get_propert(np,"laws"));

of_address_to_resource(np, 4, &port->iores);

> 	...
> 	/* mpc86xx_rio_doorbell_init(port); */
> 	mpc86xx_rio_doorbell_init(np,port);
> 
> }
> etc, etc.
> 
> Then I should pass np into the various setup routines as above so that
> they can find the interrupts, etc.
> 
> Is this the right kind of flavor or have I misunderstood how the dtb
> stuff is supposed to integrate with the susbsys_initcall stuff.

the thing you are missing is probably the of_platform_driver. Your
driver should have something like

static struct of_device_id mpc85xx_rio_ids[] = {
	{ .compatible = "fsl,8641d-rapidio", .data = RIO_8641 },
	{ .compatible = "fsl,8540-rapidio", .data = RIO_8540 },
	{ },
};
static struct of_platform_driver mpc85xx_rio_driver = {
	.name = "mpc85xx_rio",
	.match_table = &mpc85xx_rio_ids,
	.probe = mpc85xx_rio_probe,
};
static int __init mpc85xx_rio_init(void)
{
	return of_register_platform_driver(&mpc85xx_rio_driver);
}
subsys_initcall(mpc85xx_rio_init);

> I'm assuming we are supposed to do away with all the CONFIG_RAPIDIO,
> CONFIG_MPCxyz etc so that the kernel is driven by the dtb?

CONFIG_RAPIDIO is still needed to determine whether the code gets compiled
in, but you should make sure that there is no harm in enabling it
on a platform that doesn't actually have rapidio devices.

	Arnd <><
