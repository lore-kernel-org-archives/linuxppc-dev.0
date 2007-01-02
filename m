Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3D83DDF57
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:32:08 +1100 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l02MVwVc002702
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 23:31:58 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/4] powerpc: 52xx,
	Don't use device_initcall to probe of_platform_bus
Date: Tue,  2 Jan 2007 23:29:53 +0100
Message-Id: <11677769982640-git-send-email-tnt@246tNt.com>
In-Reply-To: <116777699771-git-send-email-tnt@246tNt.com>
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using device_initcall makes it happen for every platform that
compiles this file in. This is really bad, for obvious reasons.

Instead, we use the .init field of the machine description. If
the platform needs the hook to do something specific it can provides
its own function and call mpc52xx_declare_of_platform_devices from
there. If not, the mpc52xx_declare_of_platform_devices function can
directly be used as the init hook.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/platforms/52xx/lite5200.c       |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    7 ++++---
 include/asm-powerpc/mpc52xx.h                |    1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index eaff71e..0f21bab 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -153,6 +153,7 @@ define_machine(lite52xx) {
 	.name 		= "lite52xx",
 	.probe 		= lite52xx_probe,
 	.setup_arch 	= lite52xx_setup_arch,
+	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
 	.show_cpuinfo	= lite52xx_show_cpuinfo,
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 8331ff4..cc40889 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -116,11 +116,12 @@ unmap_regs:
 	if (xlb) iounmap(xlb);
 }
 
-static int __init
+void __init
 mpc52xx_declare_of_platform_devices(void)
 {
 	/* Find every child of the SOC node and add it to of_platform */
-	return of_platform_bus_probe(NULL, NULL, NULL);
+	if (of_platform_bus_probe(NULL, NULL, NULL))
+		printk(KERN_ERR __FILE__ ": "
+			"Error while probing of_platform bus\n");
 }
 
-device_initcall(mpc52xx_declare_of_platform_devices);
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index 4a28a85..4560d72 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -244,6 +244,7 @@ #ifndef __ASSEMBLY__
 extern void __iomem * mpc52xx_find_and_map(const char *);
 extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
 extern void mpc52xx_setup_cpu(void);
+extern void mpc52xx_declare_of_platform_devices(void);
 
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
-- 
1.4.2
