Return-Path: <andid@gmx.net>
Received: from mncltd.com (p15112080.pureserver.info [217.160.169.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2919267A87
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Feb 2005 15:38:12 +1100 (EST)
Message-ID: <4206F0AD.1010203@gmx.net>
Date: Mon, 07 Feb 2005 05:38:05 +0100
From: Andre' Draszik <andid@gmx.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [PATCH][PPC32] ibmstb4 ocp fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

this one fixes the OCP device definition for STB04.
Please consider applying.

Signed-off-by: Andre' Draszik <andid@gmx.net>

diff -urN linuxppc-2.5.orig/arch/ppc/platforms/4xx/ibmstb4.c linuxppc-2.5/arch/ppc/platforms/4xx/ibmstb4.c
--- linuxppc-2.5.orig/arch/ppc/platforms/4xx/ibmstb4.c	2005-02-06 00:16:33.000000000 +0100
+++ linuxppc-2.5/arch/ppc/platforms/4xx/ibmstb4.c	2005-02-05 21:20:58.000000000 +0100
@@ -22,7 +22,7 @@
  };
  OCP_SYSFS_IIC_DATA()

-struct ocp_def core_ocp[] __initdata = {
+struct ocp_def core_ocp[] = {
  	{ .vendor	= OCP_VENDOR_IBM,
  	  .function	= OCP_FUNC_16550,
  	  .index	= 0,
@@ -46,6 +46,7 @@
  	},
  	{ .vendor	= OCP_VENDOR_IBM,
  	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
  	  .paddr	= IIC0_BASE,
  	  .irq		= IIC0_IRQ,
  	  .pm		= IBM_CPM_IIC0,
@@ -54,6 +55,7 @@
  	},
  	{ .vendor	= OCP_VENDOR_IBM,
  	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
  	  .paddr	= IIC1_BASE,
  	  .irq		= IIC1_IRQ,
  	  .pm		= IBM_CPM_IIC1,
