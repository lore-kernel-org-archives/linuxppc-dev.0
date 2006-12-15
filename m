Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 17A5767BE8
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:42:40 +1100 (EST)
Date: Fri, 15 Dec 2006 15:42:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix iseries_veth init
Message-Id: <20061215154250.591da7b1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Only initialise iseries_veth on legacy iSeries.
Make the init and exit routines static.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/iseries_veth.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/net/iseries_veth.c b/drivers/net/iseries_veth.c
index d6f4f18..2194b56 100644
--- a/drivers/net/iseries_veth.c
+++ b/drivers/net/iseries_veth.c
@@ -73,7 +73,7 @@
 #include <asm/abs_addr.h>
 #include <asm/iseries/mf.h>
 #include <asm/uaccess.h>
-
+#include <asm/firmware.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_lp_event.h>
@@ -1668,7 +1668,7 @@ static struct vio_driver veth_driver = {
  * Module initialization/cleanup
  */
 
-void __exit veth_module_cleanup(void)
+static void __exit veth_module_cleanup(void)
 {
 	int i;
 	struct veth_lpar_connection *cnx;
@@ -1697,11 +1697,14 @@ void __exit veth_module_cleanup(void)
 }
 module_exit(veth_module_cleanup);
 
-int __init veth_module_init(void)
+static int __init veth_module_init(void)
 {
 	int i;
 	int rc;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	this_lp = HvLpConfig_getLpIndex_outline();
 
 	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i) {
-- 
1.4.4.2
