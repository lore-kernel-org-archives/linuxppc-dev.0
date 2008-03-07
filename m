Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 59D5CDDF32
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 23:24:51 +1100 (EST)
Message-ID: <47D12F80.3000400@denx.de>
Date: Fri, 07 Mar 2008 13:05:20 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
Subject: Re: TQM5200 2.6-denx SM501 voyager enabling problem.
References: <BLU106-W20B00A907B0D9DAD5014E2CA1D0@phx.gbl>	<loom.20080228T145124-686@post.gmane.org>
	<BLU106-W293FED7524135F0A85B76BCA1B0@phx.gbl>
	<BLU106-W3191420D0642825B53DD08CA120@phx.gbl>
In-Reply-To: <BLU106-W3191420D0642825B53DD08CA120@phx.gbl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Pedro Luis D. L. wrote:

<snip>

> I tried to contact TQ but they seem not to be able to solve my
> problem. They suggested that the problem could be in the different
> endianness used by MPC5200 and SMI501. That problem seems to be
> corrected in the driver. Anyway, this endianness problem may come
> to light if I had any video output. It is possible to change the
> endianness of SM501 chip from the u-boot writing a register.
> I did it and it made no difference at all. The real problem is
> still that none device is initialized or detected even when the
> Framebuffer driver for SM501 and MFD Driver for SM501 are compiled
> with the kernel. I checked that platform driver for both are
> registered (using some printk output) but their probe functions
> are never invoked.
> 
> I thought that my problem could be that I don't have initialized
> the device within the platform file tqm5200.c. I added the following
> code (marked with +) to this file under arch/powerpc/platforms/52xx/tqm5200.c
> 
> +static struct resource sm501_resources[] = {
> +	[0]	= {
> +		.start	= 0xE3E00000,
> +		.end	= 0xE3DFFFFF,

This is wrong as '.end' resource should be greater than '.start'.
The value for '.end' seems to origin from the typo in TQ docs for
TQM5200. The proper value results from adding 2MB register space
of the SM501 to the IO base 0xe3e00000 and is 0xe3ffffff.
Furthermore you didn't define any framebuffer memory resource
which is strictly needed here for the framebuffer driver.

> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device sm501_device = {
> +	.name		= "sm501",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(sm501_resources),
> +	.resource	= sm501_resources,
> +};
> 
> static void __init tqm5200_setup_arch(void)
> {
> 	if (ppc_md.progress)
> 		ppc_md.progress("tqm5200_setup_arch()", 0);
> 
> 	/* Some mpc5200 & mpc5200b related configuration */
> 	mpc5200_setup_xlb_arbiter();
> 
> 	/* Map wdt for mpc52xx_restart() */
> 	mpc52xx_map_wdt();
> 
> #ifdef CONFIG_PCI
> 	np = of_find_node_by_type(NULL, "pci");
> 	if (np) {
> 		mpc52xx_add_bridge(np);
> 		of_node_put(np);
> 	}
> #endif
> +
> +	platform_device_register(&sm501_device);
> +
> }
> 
> I got this idea from the configuration files from other platforms,
> but I still need to find out how exactly "resources" must be defined.
> Anybody knows wheather am I pointing in the right direction and this
> makes any sense?

yes, the direction is right or this is at least a possible solution
among others provided that you do it correctly.
Calling "platform_device_register(...)" from "tqm5200_setup_arch()"
won't work, so move this call and the resource definitions to
sm501 platform driver. A really right direction would be adding
sm501 resource description to the device tree and adding appropriate
code to the sm501 platform driver, but it is more effort.

> As far as I understand now (and I may be terribly wrong), once
> that SM501 MFD and Framebuffer drivers are registered,  I need
> to tell the kernel where to find the device in the local bus.
> Is it right?

yes, try the patch below, and also ensure that
CONFIG_VT,
CONFIG_VT_CONSOLE,
CONFIG_FRAMEBUFFER_CONSOLE
are enabled in the kernel configuration.

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index afd8296..599ffe6 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -901,6 +901,9 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 
 	INIT_LIST_HEAD(&sm->devices);
 
+	/* switch to BE */
+	writel(0xffffffff, sm->regs + SM501_ENDIAN_CONTROL);
+
 	devid = readl(sm->regs + SM501_DEVICEID);
 
 	if ((devid & SM501_DEVICEID_IDMASK) != SM501_DEVICEID_SM501) {
@@ -1263,8 +1266,31 @@ static struct platform_driver sm501_plat_drv = {
 	.resume		= sm501_plat_resume,
 };
 
+/* define some sm501 resources on tqm5200 */
+#define SM501_FB_BASE	0xe0000000
+#define SM501_IO_BASE	0xe3e00000
+#define SM501_FB_END	((SM501_FB_BASE) + 0x7fffff)
+#define SM501_IO_END	((SM501_IO_BASE) + 0x1fffff)
+
+static struct resource sm501_device0_resources[] = {
+	[0] = {.start = SM501_FB_BASE, .end = SM501_FB_END, .flags = IORESOURCE_MEM,},
+	[1] = {.start = SM501_IO_BASE, .end = SM501_IO_END, .flags = IORESOURCE_MEM,},
+};
+
+static struct platform_device sm501_device0 = {
+	.name = "sm501",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(sm501_device0_resources),
+	.resource = sm501_device0_resources,
+};
+
+static struct platform_device *mfd_devices[] __initdata = {
+	&sm501_device0,
+};
+
 static int __init sm501_base_init(void)
 {
+	platform_add_devices(mfd_devices, ARRAY_SIZE(mfd_devices));
 	platform_driver_register(&sm501_plat_drv);
 	return pci_register_driver(&sm501_pci_drv);
 }

Best regards,
Anatolij

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
