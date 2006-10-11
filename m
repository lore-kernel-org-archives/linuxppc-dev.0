Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D62AB67B6C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 21:03:45 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9BCO5iK002741
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 06:24:05 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9BB3fPQ011588
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 06:03:42 -0500 (CDT)
Message-ID: <452CCFB6.6060604@freescale.com>
Date: Wed, 11 Oct 2006 19:04:22 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] Fix MPC8360EMDS PB board support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC8360EMDS PB support is broken as some code was missing
in last submission.  This patch adds missing code and makes
MPC8360EMDS PB support working.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
As Kim's patch to add Kconfig file hasn't been merged, I
include the fix in this patch.

 arch/powerpc/platforms/83xx/Kconfig       |   13 +++++++++++++
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/mpc8360e_pb.c |   19 +++++++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 0975e94..7edb6b4 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -32,6 +32,13 @@ config MPC834x_ITX
 	  Be aware that PCI initialization is the bootloader's
 	  responsiblilty.
 
+config MPC8360E_PB
+	bool "Freescale MPC8360E PB"
+	select DEFAULT_UIMAGE
+	select QUICC_ENGINE
+	help
+	  This option enables support for the MPC836x EMDS Processor Board.
+
 endchoice
 
 config PPC_MPC832x
@@ -46,4 +53,10 @@ config MPC834x
 	select PPC_INDIRECT_PCI
 	default y if MPC834x_SYS || MPC834x_ITX
 
+config PPC_MPC836x
+	bool
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI
+	default y if MPC8360E_PB
+
 endmenu
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 9387a11..e60fd75 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -5,3 +5,4 @@ obj-y				:= misc.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
 obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
+obj-$(CONFIG_MPC8360E_PB)       += mpc8360e_pb.o
diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
index c019190..1a523c8 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
@@ -30,6 +30,7 @@ #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
 
+#include <asm/of_device.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
@@ -141,6 +142,24 @@ #else
 #endif
 }
 
+static int __init mpc8360_declare_of_platform_devices(void)
+{
+	struct device_node *np;
+
+	for (np = NULL; (np = of_find_compatible_node(np, "network",
+					"ucc_geth")) != NULL;) {
+		int ucc_num;
+		char bus_id[BUS_ID_SIZE];
+
+		ucc_num = *((uint *) get_property(np, "device-id", NULL)) - 1;
+		snprintf(bus_id, BUS_ID_SIZE, "ucc_geth.%u", ucc_num);
+		of_platform_device_create(np, bus_id, NULL);
+	}
+
+	return 0;
+}
+device_initcall(mpc8360_declare_of_platform_devices);
+
 void __init mpc8360_sys_init_IRQ(void)
 {
