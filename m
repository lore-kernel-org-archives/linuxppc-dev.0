Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C4DCDDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 05:45:02 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.5.6)
	with ESMTP id md50000412108.msg
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 12:38:55 -0700
Subject: Porting RapidIO from ppc arch to powerpc arch in support of MPC8641D
From: Phil Terry <pterry@micromemory.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 22 May 2007 12:38:52 -0700
Message-Id: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Reply-To: pterry@micromemory.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys n Gals,

I'm new to this list so I hope this isn't the wrong place to be asking
these questions.

I'm using the MPC8641D in a Serial RapidIO backplane chassis design.

My last foray into kernel development (privately in an embedded company)
was back in 2.6.9 to 2.6.11 days for a MPC8540 so be gentle with me if
I've missed something in the intervening kernels. I've tried to catch up
as best I can with the archives.

So I thought it would be a simple task of taking Matt Porter's ppc rio
stuff and porting it to powerpc but then I discovered this dts/open
firmware thingy...

So I want to explain an overview of what I intend to do for this port
and if anyone can either tell me where its already been done (yippee),
tell me I'm on the right track (ok) or tell me I'm on the wrong track
(bad) that would be great.

So I'm taking the boot/dts/mpc8641_hpcn.dts and producing a new
mpc8641D_umem.dts with the following addition to the soc.

srio@c0000 {
                device_type = "srio";
                compatible = "86xx,85xx";
		reg = <c0000 20000>;
		law = <400000000 e00000000>;
		dbells = <0 ffff>;
		mboxs = <0 4>;
                interrupt-parent = <&mpic>;
                interrupts = <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
              };

where law is the 36-bit start/end address of the law for rapidio (yes I
do want to use 36-bit addressing as well but thats another story),
dbells is the range of doorbells to use and mboxs is the range of
mailboxes.

Then I can copy the old ppc/kernel/rio.c to powerpc/kernel/rio.c and
change...

void platform_rio_init(void)
{
	struct device_node *np;
	if ( (np = of_find_compatible_node(np, "srio", "86xx")) != NULL ) {
		mpc86xx_rio_setup(np);
	}
	else {
		printk(KERN_INFO "RIO: No platform_rio_init() present in dts\n");
	}
}

with mpc86xx_rio_setup being the old mpc85xx_rio_setup from
ppc/syslib/ppc85xx_rio.c modified to extract the laws, doorbell
resources, mailboxes etc, from the of_get_property instead of
hard-coding them.

/* void mpc86xx_rio_setup(int law_start, int law_size) */

void mpc86xx_rio_setup(struct device_node *np)
{
	...

	/*port->iores.start = law_start;*/
        port->iores.start = of_get_number(of_get_propert(np,"laws"));
	
	...
	/* mpc86xx_rio_doorbell_init(port); */
	mpc86xx_rio_doorbell_init(np,port);

}
etc, etc.

Then I should pass np into the various setup routines as above so that
they can find the interrupts, etc.

Is this the right kind of flavor or have I misunderstood how the dtb
stuff is supposed to integrate with the susbsys_initcall stuff. I'm
assuming we are supposed to do away with all the CONFIG_RAPIDIO,
CONFIG_MPCxyz etc so that the kernel is driven by the dtb?

Any pointers gratefully accepted.

Cheers
Phil

btw how to I get the dtc to accept 36-bit numbers as above for laws?
and am I allowed to invent properties like this or is there some keeper
of the property names who I should genuflect before?
