Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 4BFAADDEFA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 02:21:42 +1100 (EST)
Date: Thu, 11 Jan 2007 16:21:37 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Message-ID: <20070111152137.GG11226@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> This suffers from the same bug mpc83xx_restart has.  We can NOT do an  
> ioremap inside the restart function.  We may get called from  
> interrupt context on a panic and will not be able to do the ioremap 
> ().  The simplest thing is to do the mapping earlier in an init call  
> and save the pointer, its not perfect, but better.
> 

I'm beginning to hate this whole pseudo OF thing for embedded systems.
All we need to know is that we have a mpc52xx processor. Instead of
using this information directly we scatter it in many pieces, put a
dts file(-template) in the kernel, let the bootloader pass it back to
the kernel, evaluate it in an OF parser called from mpc52xx_setup_cpu()
and use it in mpc52xx_restart(). Quite a long way for one single SoC
register. Yes I know, I'm two years late for this rant...

BTW the watchdog timer is only implemented for gpt0. Is it guaranteed
that I get gpt0 with mpc52xx_find_and_map("mpc52xx-gpt")? As long as
all flat trees start with gpt0 I guess yes.

Anyway, how about this one?

Sascha


This patch adds restart support for mpx52xx systems.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/powerpc/platforms/52xx/lite5200.c       |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   20 ++++++++++++++++++++
 include/asm-powerpc/mpc52xx.h                |    2 ++
 3 files changed, 23 insertions(+)

Index: linux-2.6/arch/powerpc/platforms/52xx/lite5200.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/lite5200.c
+++ linux-2.6/arch/powerpc/platforms/52xx/lite5200.c
@@ -153,6 +153,7 @@ define_machine(lite52xx) {
 	.name 		= "lite52xx",
 	.probe 		= lite52xx_probe,
 	.setup_arch 	= lite52xx_setup_arch,
+	.restart	= mpc52xx_restart,
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
Index: linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -75,6 +75,23 @@ mpc52xx_find_ipb_freq(struct device_node
 }
 EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
 
+static struct __iomem mpc52xx_gpt *gpt = NULL;
+
+void
+mpc52xx_restart(char *cmd)
+{
+	local_irq_disable();
+
+	/* Turn on the watchdog and wait for it to expire. It effectively
+	  does a reset */
+	if (gpt) {
+		out_be32(&gpt->mode, 0x00000000);
+		out_be32(&gpt->count, 0x00010001);
+		out_be32(&gpt->mode, 0x00009004);
+	}
+
+	while (1);
+}
 
 void __init
 mpc52xx_setup_cpu(void)
@@ -82,6 +99,9 @@ mpc52xx_setup_cpu(void)
 	struct mpc52xx_cdm  __iomem *cdm;
 	struct mpc52xx_xlb  __iomem *xlb;
 
+	/* needed for mpc52xx_restart */
+	gpt = mpc52xx_find_and_map("mpc52xx-gpt");
+
 	/* Map zones */
 	cdm = mpc52xx_find_and_map("mpc52xx-cdm");
 	xlb = mpc52xx_find_and_map("mpc52xx-xlb");
Index: linux-2.6/include/asm-powerpc/mpc52xx.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/mpc52xx.h
+++ linux-2.6/include/asm-powerpc/mpc52xx.h
@@ -249,6 +249,8 @@ extern void mpc52xx_declare_of_platform_
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
 
+extern void mpc52xx_restart(char *cmd);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_POWERPC_MPC52xx_H__ */

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
