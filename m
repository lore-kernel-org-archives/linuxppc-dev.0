Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E39FD47536
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 06:27:53 +1100 (EST)
Date: Wed, 3 Dec 2008 22:27:52 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/83xx: Fix sparse warnings in mpc836x_mds.c
Message-ID: <20081203192752.GE13035@oksana.dev.rtsoft.ru>
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes following sparse warnings:

  CHECK   mpc836x_mds.c
mpc836x_mds.c:75:12: warning: Using plain integer as NULL pointer
mpc836x_mds.c:79:13: warning: incorrect type in assignment (different address spaces)
mpc836x_mds.c:79:13:    expected unsigned char [usertype] *static [toplevel] bcsr_regs
mpc836x_mds.c:79:13:    got void [noderef] <asn:2>*
mpc836x_mds.c:105:3: warning: incorrect type in argument 1 (different address spaces)
mpc836x_mds.c:105:3:    expected unsigned char volatile [noderef] [usertype] <asn:2>*addr
mpc836x_mds.c:105:3:    got unsigned char [usertype] *
mpc836x_mds.c:105:3: warning: incorrect type in argument 1 (different address spaces)
mpc836x_mds.c:105:3:    expected unsigned char const volatile [noderef] [usertype] <asn:2>*addr
mpc836x_mds.c:105:3:    got unsigned char [usertype] *
mpc836x_mds.c:107:3: warning: incorrect type in argument 1 (different address spaces)
mpc836x_mds.c:107:3:    expected unsigned char volatile [noderef] [usertype] <asn:2>*addr
mpc836x_mds.c:107:3:    got unsigned char [usertype] *
mpc836x_mds.c:107:3: warning: incorrect type in argument 1 (different address spaces)
mpc836x_mds.c:107:3:    expected unsigned char const volatile [noderef] [usertype] <asn:2>*addr
mpc836x_mds.c:107:3:    got unsigned char [usertype] *
mpc836x_mds.c:131:11: warning: incorrect type in argument 1 (different address spaces)
mpc836x_mds.c:131:11:    expected void volatile [noderef] <asn:2>*addr
mpc836x_mds.c:131:11:    got unsigned char [usertype] *static [toplevel] bcsr_regs

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index fbcca19..09e9d6f 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -18,6 +18,7 @@
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/reboot.h>
@@ -56,8 +57,6 @@
 #define DBG(fmt...)
 #endif
 
-static u8 *bcsr_regs = NULL;
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -66,13 +65,14 @@ static u8 *bcsr_regs = NULL;
 static void __init mpc836x_mds_setup_arch(void)
 {
 	struct device_node *np;
+	u8 __iomem *bcsr_regs = NULL;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc836x_mds_setup_arch()", 0);
 
 	/* Map BCSR area */
 	np = of_find_node_by_name(NULL, "bcsr");
-	if (np != 0) {
+	if (np) {
 		struct resource res;
 
 		of_address_to_resource(np, 0, &res);
-- 
1.5.6.5
