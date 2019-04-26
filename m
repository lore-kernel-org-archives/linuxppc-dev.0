Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E1AC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 12:51:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FA1206C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 12:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qVyV35Rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FA1206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rDTQ6YJyzDqgZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 22:51:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+69eb5840461690eae8c6+5724+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="qVyV35Rq"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rDRB6gmPzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 22:49:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Su18TchpSoe/0NVour+JvUdeF4XIglM1Gp4Rp1+nQOc=; b=qVyV35RqHMrOL0VIl0MV8yg6eF
 6m62QR0pXqnMLqS3RRng7jaYESb+5VueRTHQ5uIt+xIanLEsJWJ3LUVLpnNWzrJl8OQagzarM+tMb
 8r1QQI52s4mqineb6/aFyIXZlJ2GzOXAVHehjaGBw9tllkthHn/DD2yn5nDN4G8KjXL9lP9zWPktk
 T88ve/oL5YC2vkFBKdJjhpnYw1vnE7s5G84xpbiur89yUXWhXYUYBLlqwiDIiJMH5ifXA4pP5bmsq
 xk+w/Kem68cqR37NKGE3AixOCZBdYs7wwkbUuXNoqE9ynKBaCtyRbQFVGjR8fJdyscGfeZGU76qkd
 JpgLStHQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hK0IY-0007Ze-UT; Fri, 26 Apr 2019 12:49:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/3] powerpc/powernv: remove pnv_pci_{enable,disable}_tunnel
Date: Fri, 26 Apr 2019 14:49:16 +0200
Message-Id: <20190426124917.23789-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426124917.23789-1-hch@lst.de>
References: <20190426124917.23789-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These have been unused ever since they've been added to the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/pnv-pci.h        |  2 -
 arch/powerpc/platforms/powernv/pci-ioda.c |  4 +-
 arch/powerpc/platforms/powernv/pci.c      | 48 -----------------------
 arch/powerpc/platforms/powernv/pci.h      |  1 -
 4 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 9fcb0bc462c6..a8bd0aeeee03 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -27,8 +27,6 @@ extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
 extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
 				   struct opal_msg *msg);
 
-extern int pnv_pci_enable_tunnel(struct pci_dev *dev, uint64_t *asnind);
-extern int pnv_pci_disable_tunnel(struct pci_dev *dev);
 extern int pnv_pci_set_tunnel_bar(struct pci_dev *dev, uint64_t addr,
 				  int enable);
 extern int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3ead4c237ed0..ed73ba8e44a6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -54,6 +54,8 @@
 static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU_NVLINK",
 					      "NPU_OCAPI" };
 
+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
+
 void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...)
 {
@@ -2359,7 +2361,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	return 0;
 }
 
-void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 {
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 8d28f2932c3b..2bac62a7123d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -868,54 +868,6 @@ struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pnv_pci_get_phb_node);
 
-int pnv_pci_enable_tunnel(struct pci_dev *dev, u64 *asnind)
-{
-	struct device_node *np;
-	const __be32 *prop;
-	struct pnv_ioda_pe *pe;
-	uint16_t window_id;
-	int rc;
-
-	if (!radix_enabled())
-		return -ENXIO;
-
-	if (!(np = pnv_pci_get_phb_node(dev)))
-		return -ENXIO;
-
-	prop = of_get_property(np, "ibm,phb-indications", NULL);
-	of_node_put(np);
-
-	if (!prop || !prop[1])
-		return -ENXIO;
-
-	*asnind = (u64)be32_to_cpu(prop[1]);
-	pe = pnv_ioda_get_pe(dev);
-	if (!pe)
-		return -ENODEV;
-
-	/* Increase real window size to accept as_notify messages. */
-	window_id = (pe->pe_number << 1 ) + 1;
-	rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id, pe->pe_number,
-					     window_id, pe->tce_bypass_base,
-					     (uint64_t)1 << 48);
-	return opal_error_code(rc);
-}
-EXPORT_SYMBOL_GPL(pnv_pci_enable_tunnel);
-
-int pnv_pci_disable_tunnel(struct pci_dev *dev)
-{
-	struct pnv_ioda_pe *pe;
-
-	pe = pnv_ioda_get_pe(dev);
-	if (!pe)
-		return -ENODEV;
-
-	/* Restore default real window size. */
-	pnv_pci_ioda2_set_bypass(pe, true);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pnv_pci_disable_tunnel);
-
 int pnv_pci_set_tunnel_bar(struct pci_dev *dev, u64 addr, int enable)
 {
 	__be64 val;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index fbec1c76d7a7..f0a6ff56e349 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -194,7 +194,6 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
 extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
-extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
 extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 		__u64 window_size, __u32 levels);
 extern int pnv_eeh_post_init(void);
-- 
2.20.1

