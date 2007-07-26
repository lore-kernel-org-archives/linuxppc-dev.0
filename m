Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC0C7DDEF6
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 20:02:43 +1000 (EST)
Date: Thu, 26 Jul 2007 19:02:27 +0900 (JST)
Message-Id: <20070726.190227.1723211598.kouish@swc.toshiba.co.jp>
Subject: [PATCH 3/4] init markings for celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are some variables and functions that we should place in init
section. And this patch changes some '__devinit' to '__init', because
the device is platform device and not hot-pluggable.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/scc_epci.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c
@@ -283,7 +283,7 @@ struct pci_ops celleb_epci_ops = {
 };
 
 /* to be moved in FW */
-static int __devinit celleb_epci_init(struct pci_controller *hose)
+static int __init celleb_epci_init(struct pci_controller *hose)
 {
 	u32 val;
 	volatile void __iomem *reg, *epci_base;
@@ -403,7 +403,7 @@ static int __devinit celleb_epci_init(st
 	return 0;
 }
 
-int __devinit celleb_setup_epci(struct device_node *node,
+int __init celleb_setup_epci(struct device_node *node,
 				struct pci_controller *hose)
 {
 	struct resource r;
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/setup.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
@@ -73,7 +73,7 @@ static void celleb_show_cpuinfo(struct s
 	of_node_put(root);
 }
 
-static int celleb_machine_type_hack(char *ptr)
+static int __init celleb_machine_type_hack(char *ptr)
 {
 	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
 	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
@@ -135,7 +135,7 @@ static void celleb_kexec_cpu_down(int cr
 }
 #endif
 
-static struct of_device_id celleb_bus_ids[] = {
+static struct of_device_id celleb_bus_ids[] __initdata = {
 	{ .type = "scc", },
 	{ .type = "ioif", },	/* old style */
 	{},
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/scc_sio.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c
@@ -28,12 +28,12 @@
 
 /* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
     mmio=0xfff000-0x1000,0xff2000-0x1000 */
-static int txx9_serial_bitmap = 0;
+static int txx9_serial_bitmap __initdata = 0;
 
 static struct {
 	uint32_t offset;
 	uint32_t index;
-} txx9_scc_tab[3] = {
+} txx9_scc_tab[3] __initdata = {
 	{ 0x300, 0 },	/* 0xFFF300 */
 	{ 0x400, 0 },	/* 0xFFF400 */
 	{ 0x800, 1 }	/* 0xFF2800 */
@@ -79,7 +79,7 @@ static int __init txx9_serial_init(void)
 	return 0;
 }
 
-static int txx9_serial_config(char *ptr)
+static int __init txx9_serial_config(char *ptr)
 {
 	int	i;
 
