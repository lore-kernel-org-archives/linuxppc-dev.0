Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 61646DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 02:48:10 +1100 (EST)
Date: Fri, 5 Dec 2008 18:48:07 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Fix sparse warnings in board files
Message-ID: <20081205154807.GA23256@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes following sparse warnings:

  CHECK   83xx/usb.c
83xx/usb.c:205:5: warning: symbol 'mpc837x_usb_cfg' was not declared. Should it be static?
  CHECK   83xx/mpc831x_rdb.c
83xx/mpc831x_rdb.c:45:13: warning: symbol 'mpc831x_rdb_init_IRQ' was not declared. Should it be static?
  CHECK   83xx/mpc832x_rdb.c
83xx/mpc832x_rdb.c:133:13: warning: symbol 'mpc832x_rdb_init_IRQ' was not declared. Should it be static?
  CHECK   83xx/mpc832x_mds.c
83xx/mpc832x_mds.c:68:12: warning: Using plain integer as NULL pointer
83xx/mpc832x_mds.c:72:13: warning: incorrect type in assignment (different address spaces)
83xx/mpc832x_mds.c:72:13:    expected unsigned char [usertype] *static [toplevel] bcsr_regs
83xx/mpc832x_mds.c:72:13:    got void [noderef] <asn:2>*
83xx/mpc832x_mds.c:99:11: warning: incorrect type in argument 1 (different address spaces)
83xx/mpc832x_mds.c:99:11:    expected void volatile [noderef] <asn:2>*addr
83xx/mpc832x_mds.c:99:11:    got unsigned char [usertype] *static [toplevel] bcsr_regs

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Because of this noise it's quite hard to catch my own, newly
introduced warnings when working with these files.

 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    9 ++++-----
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 -
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    2 --
 arch/powerpc/platforms/83xx/mpc83xx.h     |    1 +
 6 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index a428f8d..5177bdd 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -42,7 +42,7 @@ static void __init mpc831x_rdb_setup_arch(void)
 	mpc831x_usb_cfg();
 }
 
-void __init mpc831x_rdb_init_IRQ(void)
+static void __init mpc831x_rdb_init_IRQ(void)
 {
 	struct device_node *np;
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index ec43477..ec0b401 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -49,8 +49,6 @@
 #define DBG(fmt...)
 #endif
 
-static u8 *bcsr_regs = NULL;
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -59,13 +57,14 @@ static u8 *bcsr_regs = NULL;
 static void __init mpc832x_sys_setup_arch(void)
 {
 	struct device_node *np;
+	u8 __iomem *bcsr_regs = NULL;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc832x_sys_setup_arch()", 0);
 
 	/* Map BCSR area */
 	np = of_find_node_by_name(NULL, "bcsr");
-	if (np != 0) {
+	if (np) {
 		struct resource res;
 
 		of_address_to_resource(np, 0, &res);
@@ -93,9 +92,9 @@ static void __init mpc832x_sys_setup_arch(void)
 			!= NULL){
 		/* Reset the Ethernet PHYs */
 #define BCSR8_FETH_RST 0x50
-		bcsr_regs[8] &= ~BCSR8_FETH_RST;
+		clrbits8(&bcsr_regs[8], BCSR8_FETH_RST);
 		udelay(1000);
-		bcsr_regs[8] |= BCSR8_FETH_RST;
+		setbits8(&bcsr_regs[8], BCSR8_FETH_RST);
 		iounmap(bcsr_regs);
 		of_node_put(np);
 	}
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 0300268..d8eb447 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -130,7 +130,7 @@ static int __init mpc832x_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc832x_rdb, mpc832x_declare_of_platform_devices);
 
-void __init mpc832x_rdb_init_IRQ(void)
+static void __init mpc832x_rdb_init_IRQ(void)
 {
 
 	struct device_node *np;
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 8bb13c8..530ef99 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -26,7 +26,6 @@
 #define BCSR12_USB_SER_MASK	0x8a
 #define BCSR12_USB_SER_PIN	0x80
 #define BCSR12_USB_SER_DEVICE	0x02
-extern int mpc837x_usb_cfg(void);
 
 static int mpc837xmds_usb_cfg(void)
 {
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index da030af..1d09654 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -21,8 +21,6 @@
 
 #include "mpc83xx.h"
 
-extern int mpc837x_usb_cfg(void);
-
 /* ************************************************************************
  *
  * Setup the architecture
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 2a7cbab..83cfe51 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -61,6 +61,7 @@
 
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
+extern int mpc837x_usb_cfg(void);
 extern int mpc834x_usb_cfg(void);
 extern int mpc831x_usb_cfg(void);
 
-- 
1.5.6.5
