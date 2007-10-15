Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/5] Update ibm_newemac to use dcr_host_t.base
Date: Mon, 15 Oct 2007 19:34:34 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that dcr_host_t contains the base address, we can use that in the
ibm_newemac code, rather than storing it separately.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/net/ibm_newemac/mal.c |    9 +++++----
 drivers/net/ibm_newemac/mal.h |    5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ibm_newemac/mal.c b/drivers/net/ibm_newemac/mal.c
index 5885411..748a869 100644
--- a/drivers/net/ibm_newemac/mal.c
+++ b/drivers/net/ibm_newemac/mal.c
@@ -461,6 +461,7 @@ static int __devinit mal_probe(struct of_device *ofdev,
 	struct mal_instance *mal;
 	int err = 0, i, bd_size;
 	int index = mal_count++;
+	unsigned int dcr_base;
 	const u32 *prop;
 	u32 cfg;
 
@@ -497,14 +498,14 @@ static int __devinit mal_probe(struct of_device *ofdev,
 	}
 	mal->num_rx_chans = prop[0];
 
-	mal->dcr_base = dcr_resource_start(ofdev->node, 0);
-	if (mal->dcr_base == 0) {
+	dcr_base = dcr_resource_start(ofdev->node, 0);
+	if (dcr_base == 0) {
 		printk(KERN_ERR
 		       "mal%d: can't find DCR resource!\n", index);
 		err = -ENODEV;
 		goto fail;
 	}
-        mal->dcr_host = dcr_map(ofdev->node, mal->dcr_base, 0x100);
+	mal->dcr_host = dcr_map(ofdev->node, dcr_base, 0x100);
 	if (!DCR_MAP_OK(mal->dcr_host)) {
 		printk(KERN_ERR
 		       "mal%d: failed to map DCRs !\n", index);
@@ -626,7 +627,7 @@ static int __devinit mal_probe(struct of_device *ofdev,
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
  fail_unmap:
-	dcr_unmap(mal->dcr_host, mal->dcr_base, 0x100);
+	dcr_unmap(mal->dcr_host, dcr_base, 0x100);
  fail:
 	kfree(mal);
 
diff --git a/drivers/net/ibm_newemac/mal.h b/drivers/net/ibm_newemac/mal.h
index cb1a16d..6daa98e 100644
--- a/drivers/net/ibm_newemac/mal.h
+++ b/drivers/net/ibm_newemac/mal.h
@@ -185,7 +185,6 @@ struct mal_commac {
 
 struct mal_instance {
 	int			version;
-	int			dcr_base;
 	dcr_host_t		dcr_host;
 
 	int			num_tx_chans;	/* Number of TX channels */
@@ -213,12 +212,12 @@ struct mal_instance {
 
 static inline u32 get_mal_dcrn(struct mal_instance *mal, int reg)
 {
-	return dcr_read(mal->dcr_host, mal->dcr_base + reg);
+	return dcr_read(mal->dcr_host, mal->dcr_host.base + reg);
 }
 
 static inline void set_mal_dcrn(struct mal_instance *mal, int reg, u32 val)
 {
-	dcr_write(mal->dcr_host, mal->dcr_base + reg, val);
+	dcr_write(mal->dcr_host, mal->dcr_host.base + reg, val);
 }
 
 /* Register MAL devices */
-- 
1.5.1.3.g7a33b
