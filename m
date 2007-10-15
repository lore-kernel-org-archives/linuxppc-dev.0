Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <32ee558d2e9458d81a43d8962aabf7df60b79664.1192440801.git.michael@ellerman.id.au>
In-Reply-To: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
References: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/5] Use dcr_host_t.base in ibm_emac_mal
Date: Mon, 15 Oct 2007 19:34:35 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
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
index 4e49e8c..dcd8826 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.c
+++ b/drivers/net/ibm_emac/ibm_emac_mal.c
@@ -413,7 +413,10 @@ static int __init mal_probe(struct ocp_device *ocpdev)
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
index 8f54d62..aa76d3f 100644
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
