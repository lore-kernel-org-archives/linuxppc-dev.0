Return-Path: <nfont@austin.ibm.com>
Message-ID: <4B06B0D5.8080909@austin.ibm.com>
Date: Fri, 20 Nov 2009 09:08:05 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 3/4 v2] Makefile and Kconfig updates
References: <4B06AF33.1000400@austin.ibm.com>
In-Reply-To: <4B06AF33.1000400@austin.ibm.com>
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

 arch/microblaze/Kconfig |    1 +
 arch/powerpc/Kconfig    |    1 +
 drivers/of/Kconfig      |    4 ++++
 drivers/of/Makefile     |    1 +
 4 files changed, 7 insertions(+)

Index: test-devicetree/arch/microblaze/Kconfig
===================================================================
--- test-devicetree.orig/arch/microblaze/Kconfig	2009-11-20 11:59:01.000000000 -0600
+++ test-devicetree/arch/microblaze/Kconfig	2009-11-20 12:35:41.000000000 -0600
@@ -112,6 +112,7 @@
 config OF
 	def_bool y
 	select OF_FLATTREE
+	select OF_DYNAMIC
 
 config PROC_DEVICETREE
 	bool "Support for device tree in /proc"
Index: test-devicetree/arch/powerpc/Kconfig
===================================================================
--- test-devicetree.orig/arch/powerpc/Kconfig	2009-11-20 11:59:01.000000000 -0600
+++ test-devicetree/arch/powerpc/Kconfig	2009-11-20 12:35:41.000000000 -0600
@@ -164,6 +164,7 @@
 config OF
 	def_bool y
 	select OF_FLATTREE
+	select OF_DYNAMIC
 
 config PPC_UDBG_16550
 	bool
Index: test-devicetree/drivers/of/Kconfig
===================================================================
--- test-devicetree.orig/drivers/of/Kconfig	2009-11-20 11:59:01.000000000 -0600
+++ test-devicetree/drivers/of/Kconfig	2009-11-20 12:35:41.000000000 -0600
@@ -2,6 +2,10 @@
 	bool
 	depends on OF
 
+config OF_DYNAMIC
+	bool
+	depends on OF
+
 config OF_DEVICE
 	def_bool y
 	depends on OF && (SPARC || PPC_OF || MICROBLAZE)
Index: test-devicetree/drivers/of/Makefile
===================================================================
--- test-devicetree.orig/drivers/of/Makefile	2009-11-20 11:59:01.000000000 -0600
+++ test-devicetree/drivers/of/Makefile	2009-11-20 12:35:41.000000000 -0600
@@ -1,5 +1,6 @@
 obj-y = base.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
+obj-$(CONFIG_OF_DYNAMIC) += of_dynamic.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
