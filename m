Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3e7d30667d5ac0b6aabc197fb5d500b9c6c82feb.1182493056.git.michael@ellerman.id.au>
In-Reply-To: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
References: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/5] Use dcr_host_t.base in ibm_emac_mal
Date: Fri, 22 Jun 2007 16:18:08 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This requires us to do a sort-of fake dcr_map(), so that base is set
properly. This will be fixed/removed when the device-tree-aware emac driver
is merged.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/net/ibm_emac/ibm_emac_mal.c |    5 ++++-
 drivers/net/ibm_emac/ibm_emac_mal.h |    5 ++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ibm_emac/ibm_emac_mal.c b/drivers/net/ibm_emac/ibm_emac_mal.c
index cabd984..b08da96 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.c
+++ b/drivers/net/ibm_emac/ibm_emac_mal.c
@@ -421,7 +421,10 @@ static int __init mal_probe(struct ocp_device *ocpdev)
 		       ocpdev->def->index);
 		return -ENOMEM;
 	}
-	mal->dcrbase = maldata->dcr_base;
+
+	/* XXX This only works for native dcr for now */
+	mal->dcrhost = dcr_map(NULL, maldata->dcr_base, 0);
+
 	mal->def = ocpdev->def;
 
 	INIT_LIST_HEAD(&mal->poll_list);
diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
index 64bc338..6b1fbeb 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.h
+++ b/drivers/net/ibm_emac/ibm_emac_mal.h
@@ -191,7 +191,6 @@ struct mal_commac {
 };
 
 struct ibm_ocp_mal {
-	int			dcrbase;
 	dcr_host_t		dcrhost;
 
 	struct list_head	poll_list;
@@ -209,12 +208,12 @@ struct ibm_ocp_mal {
 
 static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
 {
-	return dcr_read(mal->dcrhost, mal->dcrbase + reg);
+	return dcr_read(mal->dcrhost, mal->dcrhost.base + reg);
 }
 
 static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
 {
-	dcr_write(mal->dcrhost, mal->dcrbase + reg, val);
+	dcr_write(mal->dcrhost, mal->dcrhost.base + reg, val);
 }
 
 /* Register MAL devices */
-- 
1.5.1.3.g7a33b
