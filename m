Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1C861007D3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 13:56:32 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAI2p9RM023943
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:51:09 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAI2uPUF166224
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:56:25 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAI2uPlU021224
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:56:25 -0700
Message-ID: <4B036256.9060809@austin.ibm.com>
Date: Tue, 17 Nov 2009 20:56:22 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 3/4] Makefile and Kconfig updates for of_dynamci
References: <4B030FC2.9070401@austin.ibm.com>
In-Reply-To: <4B030FC2.9070401@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the Kconfig and Makefile files for drivers/of, powerpc and microblaze
to properly configure for CONFIG_OF_DYNAMIC to build the of_dynamic code.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: test-devicetree/arch/microblaze/Kconfig
===================================================================
--- test-devicetree.orig/arch/microblaze/Kconfig	2009-11-17 13:52:45.000000000 -0600
+++ test-devicetree/arch/microblaze/Kconfig	2009-11-17 14:01:06.000000000 -0600
@@ -111,6 +111,7 @@
 
 config OF
 	def_bool y
+	select OF_DYNAMIC
 
 config PROC_DEVICETREE
 	bool "Support for device tree in /proc"
Index: test-devicetree/arch/powerpc/Kconfig
===================================================================
--- test-devicetree.orig/arch/powerpc/Kconfig	2009-11-17 13:52:45.000000000 -0600
+++ test-devicetree/arch/powerpc/Kconfig	2009-11-17 14:01:06.000000000 -0600
@@ -163,6 +163,7 @@
 
 config OF
 	def_bool y
+	select OF_DYNAMIC
 
 config PPC_UDBG_16550
 	bool
Index: test-devicetree/drivers/of/Kconfig
===================================================================
--- test-devicetree.orig/drivers/of/Kconfig	2009-11-17 13:52:48.000000000 -0600
+++ test-devicetree/drivers/of/Kconfig	2009-11-17 14:01:06.000000000 -0600
@@ -1,3 +1,7 @@
+config OF_DYNAMIC
+	bool
+	depends on OF
+
 config OF_DEVICE
 	def_bool y
 	depends on OF && (SPARC || PPC_OF || MICROBLAZE)
Index: test-devicetree/drivers/of/Makefile
===================================================================
--- test-devicetree.orig/drivers/of/Makefile	2009-11-17 13:52:48.000000000 -0600
+++ test-devicetree/drivers/of/Makefile	2009-11-17 14:01:06.000000000 -0600
@@ -1,4 +1,5 @@
 obj-y = base.o
+obj-$(CONFIG_OF_DYNAMIC) += of_dynamic.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
