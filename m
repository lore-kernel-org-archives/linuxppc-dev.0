Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id F1A8267A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 10:10:22 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 30 Mar 2005 17:10:21 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050331001021.GB22041@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.10-rc2] ppc32: Call redwood5_platform_add_devices before
	driver init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Use arch_initcall to call redwood5_platform_add_devices, ensuring
that platform_add_devices is called before drivers are initialized.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
===================================================================
--- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/redwood5.c
+++ linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
@@ -48,6 +48,7 @@
 {
 	return platform_add_devices(redwood5_devs, ARRAY_SIZE(redwood5_devs));
 }
+arch_initcall(redwood5_platform_add_devices);
 
 void __init
 redwood5_setup_arch(void)
@@ -76,7 +77,6 @@
 
 	printk("\n");
 #endif
-	device_initcall(redwood5_platform_add_devices);
 }
 
 void __init
