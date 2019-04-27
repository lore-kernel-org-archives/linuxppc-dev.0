Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC055C43218
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 07:22:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F92C206A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 07:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F92C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rj760dRrzDqLM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 17:22:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rhsG5NDqzDqYJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 17:10:42 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DFEB1A00BD;
 Sat, 27 Apr 2019 09:10:39 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 679431A00A5;
 Sat, 27 Apr 2019 09:10:39 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net
 (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DBD32205ED;
 Sat, 27 Apr 2019 09:10:38 +0200 (CEST)
From: laurentiu.tudor@nxp.com
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
 camelia.groza@nxp.com, leoyang.li@nxp.com
Subject: [PATCH v2 7/9] dpaa_eth: fix iova handling for contiguous frames
Date: Sat, 27 Apr 2019 10:10:29 +0300
Message-Id: <20190427071031.6563-8-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The driver relies on the no longer valid assumption that dma addresses
(iovas) are identical to physical addressees and uses phys_to_virt() to
make iova -> vaddr conversions. Fix this by adding a function that does
proper iova -> phys conversions using the iommu api and update the code
to use it.
Also, a dma_unmap_single() call had to be moved further down the code
because iova -> vaddr conversions were required before the unmap.
For now only the contiguous frame case is handled and the SG case is
split in a following patch.
While at it, clean-up a redundant dpaa_bpid2pool() and pass the bp
as parameter.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 44 ++++++++++---------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index cdc7e6d83f77..f17edc80dc37 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -50,6 +50,7 @@
 #include <linux/highmem.h>
 #include <linux/percpu.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
 #include <linux/sort.h>
 #include <linux/phy_fixed.h>
 #include <soc/fsl/bman.h>
@@ -1595,6 +1596,17 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
 	return 0;
 }
 
+static phys_addr_t dpaa_iova_to_phys(struct device *dev, dma_addr_t addr)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain)
+		return iommu_iova_to_phys(domain, addr);
+	else
+		return addr;
+}
+
 /* Cleanup function for outgoing frame descriptors that were built on Tx path,
  * either contiguous frames or scatter/gather ones.
  * Skb freeing is not handled here.
@@ -1617,7 +1629,7 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
 	int nr_frags, i;
 	u64 ns;
 
-	skbh = (struct sk_buff **)phys_to_virt(addr);
+	skbh = (struct sk_buff **)phys_to_virt(dpaa_iova_to_phys(dev, addr));
 	skb = *skbh;
 
 	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
@@ -1687,25 +1699,21 @@ static u8 rx_csum_offload(const struct dpaa_priv *priv, const struct qm_fd *fd)
  * accommodate the shared info area of the skb.
  */
 static struct sk_buff *contig_fd_to_skb(const struct dpaa_priv *priv,
-					const struct qm_fd *fd)
+					const struct qm_fd *fd,
+					struct dpaa_bp *dpaa_bp,
+					void *vaddr)
 {
 	ssize_t fd_off = qm_fd_get_offset(fd);
-	dma_addr_t addr = qm_fd_addr(fd);
-	struct dpaa_bp *dpaa_bp;
 	struct sk_buff *skb;
-	void *vaddr;
 
-	vaddr = phys_to_virt(addr);
 	WARN_ON(!IS_ALIGNED((unsigned long)vaddr, SMP_CACHE_BYTES));
 
-	dpaa_bp = dpaa_bpid2pool(fd->bpid);
-	if (!dpaa_bp)
-		goto free_buffer;
-
 	skb = build_skb(vaddr, dpaa_bp->size +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
-	if (WARN_ONCE(!skb, "Build skb failure on Rx\n"))
-		goto free_buffer;
+	if (WARN_ONCE(!skb, "Build skb failure on Rx\n")) {
+		skb_free_frag(vaddr);
+		return NULL;
+	}
 	WARN_ON(fd_off != priv->rx_headroom);
 	skb_reserve(skb, fd_off);
 	skb_put(skb, qm_fd_get_length(fd));
@@ -1713,10 +1721,6 @@ static struct sk_buff *contig_fd_to_skb(const struct dpaa_priv *priv,
 	skb->ip_summed = rx_csum_offload(priv, fd);
 
 	return skb;
-
-free_buffer:
-	skb_free_frag(vaddr);
-	return NULL;
 }
 
 /* Build an skb with the data of the first S/G entry in the linear portion and
@@ -2309,12 +2313,12 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	if (!dpaa_bp)
 		return qman_cb_dqrr_consume;
 
-	dma_unmap_single(dpaa_bp->dev, addr, dpaa_bp->size, DMA_FROM_DEVICE);
-
 	/* prefetch the first 64 bytes of the frame or the SGT start */
-	vaddr = phys_to_virt(addr);
+	vaddr = phys_to_virt(dpaa_iova_to_phys(dpaa_bp->dev, addr));
 	prefetch(vaddr + qm_fd_get_offset(fd));
 
+	dma_unmap_single(dpaa_bp->dev, addr, dpaa_bp->size, DMA_FROM_DEVICE);
+
 	/* The only FD types that we may receive are contig and S/G */
 	WARN_ON((fd_format != qm_fd_contig) && (fd_format != qm_fd_sg));
 
@@ -2325,7 +2329,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	(*count_ptr)--;
 
 	if (likely(fd_format == qm_fd_contig))
-		skb = contig_fd_to_skb(priv, fd);
+		skb = contig_fd_to_skb(priv, fd, dpaa_bp, vaddr);
 	else
 		skb = sg_fd_to_skb(priv, fd);
 	if (!skb)
-- 
2.17.1

