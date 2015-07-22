Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDA0B1A1D44
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 02:18:12 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>, <igal.liberman@freescale.com>,
 <ppc@mindchasers.com>, <joe@perches.com>, <pebolle@tiscali.nl>,
 <joakim.tjernlund@transmode.se>, Madalin Bucur <madalin.bucur@freescale.com>
Subject: [PATCH 03/10] dpaa_eth: add configurable bpool thresholds
Date: Wed, 22 Jul 2015 19:16:39 +0300
Message-ID: <1437581806-17420-3-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1437581806-17420-2-git-send-email-madalin.bucur@freescale.com>
References: <1437581806-17420-1-git-send-email-madalin.bucur@freescale.com>
 <1437581806-17420-2-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow the user to tweak the refill threshold and the total number
of buffers in the buffer pool. The provided values are for one CPU.

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 drivers/net/ethernet/freescale/dpaa/Kconfig       | 18 ++++++++++++++++++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c    |  2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h    |  3 ---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth_sg.c |  6 +++---
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig b/drivers/net/ethernet/freescale/dpaa/Kconfig
index 1f3a203..9e6a39f 100644
--- a/drivers/net/ethernet/freescale/dpaa/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
@@ -11,6 +11,24 @@ menuconfig FSL_DPAA_ETH
 
 if FSL_DPAA_ETH
 
+config FSL_DPAA_ETH_MAX_BUF_COUNT
+	int "Maximum number of buffers in private bpool"
+	range 64 2048
+	default "128"
+	---help---
+	  The maximum number of buffers to be by default allocated in the DPAA-Ethernet private port's
+	  buffer pool. One needn't normally modify this, as it has probably been tuned for performance
+	  already. This cannot be lower than DPAA_ETH_REFILL_THRESHOLD.
+
+config FSL_DPAA_ETH_REFILL_THRESHOLD
+	int "Private bpool refill threshold"
+	range 32 FSL_DPAA_ETH_MAX_BUF_COUNT
+	default "80"
+	---help---
+	  The DPAA-Ethernet driver will start replenishing buffer pools whose count
+	  falls below this threshold. This must be related to DPAA_ETH_MAX_BUF_COUNT. One needn't normally
+	  modify this value unless one has very specific performance reasons.
+
 config FSL_DPAA_CS_THRESHOLD_1G
 	hex "Egress congestion threshold on 1G ports"
 	range 0x1000 0x10000000
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 500d0e3..fc2071e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -475,7 +475,7 @@ dpa_priv_bp_probe(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 
 	dpa_bp->percpu_count = devm_alloc_percpu(dev, *dpa_bp->percpu_count);
-	dpa_bp->target_count = FSL_DPAA_ETH_MAX_BUF_COUNT;
+	dpa_bp->target_count = CONFIG_FSL_DPAA_ETH_MAX_BUF_COUNT;
 
 	dpa_bp->seed_cb = dpa_bp_priv_seed;
 	dpa_bp->free_buf_cb = _dpa_bp_free_pf;
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
index 08c1b01..fc6c5dc 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
@@ -126,9 +126,6 @@ struct dpa_buffer_layout_s {
 
 #define DPAA_ETH_RX_QUEUES	128
 
-#define FSL_DPAA_ETH_MAX_BUF_COUNT	128
-#define FSL_DPAA_ETH_REFILL_THRESHOLD	80
-
 /* More detailed FQ types - used for fine-grained WQ assignments */
 enum dpa_fq_type {
 	FQ_TYPE_RX_DEFAULT = 1, /* Rx Default FQs */
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sg.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sg.c
index b865d2a..d781219 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sg.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sg.c
@@ -151,7 +151,7 @@ int dpaa_eth_refill_bpools(struct dpa_bp *dpa_bp, int *countptr)
 	int count = *countptr;
 	int new_bufs;
 
-	if (unlikely(count < FSL_DPAA_ETH_REFILL_THRESHOLD)) {
+	if (unlikely(count < CONFIG_FSL_DPAA_ETH_REFILL_THRESHOLD)) {
 		do {
 			new_bufs = _dpa_bp_add_8_bufs(dpa_bp);
 			if (unlikely(!new_bufs)) {
@@ -162,10 +162,10 @@ int dpaa_eth_refill_bpools(struct dpa_bp *dpa_bp, int *countptr)
 				break;
 			}
 			count += new_bufs;
-		} while (count < FSL_DPAA_ETH_MAX_BUF_COUNT);
+		} while (count < CONFIG_FSL_DPAA_ETH_MAX_BUF_COUNT);
 
 		*countptr = count;
-		if (unlikely(count < FSL_DPAA_ETH_MAX_BUF_COUNT))
+		if (unlikely(count < CONFIG_FSL_DPAA_ETH_MAX_BUF_COUNT))
 			return -ENOMEM;
 	}
 
-- 
1.7.11.7
