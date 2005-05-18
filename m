Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C6D4D679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 14:53:52 +1000 (EST)
Date: Tue, 17 May 2005 23:53:41 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505172352170.28134@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix platform device initialization of 8250 serial
 ports
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

(This fixes a bug and should go into 2.6.12 if possible.)

Initialization of 8250 serial ports that are platform devices require that
at empty entry exists in the array of plat_serial8250_port.  With out an
empty entry we can get some pretty random behavior.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>


---
commit 775d12402657efa10a3c76da6c764237afeca462
tree ab87cb0c7a06314683657598ac6f011a7cc38884
parent 995cccaa4c17395172a88369a7eda90ab98f9971
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 17 May 2005 23:51:13 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 17 May 2005 23:51:13 -0500

 ppc/syslib/mpc83xx_devices.c |    1 +
 ppc/syslib/mpc85xx_devices.c |    1 +
 2 files changed, 2 insertions(+)

Index: arch/ppc/syslib/mpc83xx_devices.c
===================================================================
--- afaee9b3b47f4d48902232740857f7b7d66e356f/arch/ppc/syslib/mpc83xx_devices.c  (mode:100644)
+++ ab87cb0c7a06314683657598ac6f011a7cc38884/arch/ppc/syslib/mpc83xx_devices.c  (mode:100644)
@@ -61,6 +61,7 @@
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 	},
+	{ },
 };
 
 struct platform_device ppc_sys_platform_devices[] = {
Index: arch/ppc/syslib/mpc85xx_devices.c
===================================================================
--- afaee9b3b47f4d48902232740857f7b7d66e356f/arch/ppc/syslib/mpc85xx_devices.c  (mode:100644)
+++ ab87cb0c7a06314683657598ac6f011a7cc38884/arch/ppc/syslib/mpc85xx_devices.c  (mode:100644)
@@ -61,6 +61,7 @@
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
 	},
+	{ },
 };
 
 struct platform_device ppc_sys_platform_devices[] = {
