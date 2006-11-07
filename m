Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:38 +1100
Subject: [PATCH 8/31] powerpc: Make EMAC use generic DCR access methods
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072356.D50826811A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the EMAC driver use the new DCR access methods. It
doesn't yet uses dcr_map() and thus still only work with real DCRs.
This will be fixed in a later patch

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 drivers/net/ibm_emac/ibm_emac_mal.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_mal.h	2006-10-11 13:01:59.000000000 +1000
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h	2006-10-11 14:35:28.000000000 +1000
@@ -24,6 +24,7 @@
 #include <linux/netdevice.h>
 
 #include <asm/io.h>
+#include <asm/dcr.h>
 
 /*
  * These MAL "versions" probably aren't the real versions IBM uses for these 
@@ -191,6 +192,7 @@ struct mal_commac {
 
 struct ibm_ocp_mal {
 	int			dcrbase;
+	dcr_host_t		dcrhost;
 
 	struct list_head	poll_list;
 	struct net_device	poll_dev;
@@ -207,12 +209,12 @@ struct ibm_ocp_mal {
 
 static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
 {
-	return mfdcr(mal->dcrbase + reg);
+	return dcr_read(mal->dcrhost, mal->dcrbase + reg);
 }
 
 static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
 {
-	mtdcr(mal->dcrbase + reg, val);
+	dcr_write(mal->dcrhost, mal->dcrbase + reg, val);
 }
 
 /* Register MAL devices */
