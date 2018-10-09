Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF3C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:37:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD5D21479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIPTZV00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD5D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V0F85Zd0zDrPw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:37:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="tIPTZV00";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+39c443e67938b060f200+5525+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="tIPTZV00"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TygM6DZGzF37v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rhvZ9hpGPuuxCEIVPRN0AfR1n9umfTu+Rj50rDnMvn0=; b=tIPTZV00fcQtIlC3PL5dfu7G1m
 s5PDg5sM2GO4v6FDj1h95I9EvzJjKhy78N1Yhl963NGJ4q8l7M87quNsuK6TAcgA0FnZkGF7L6M3R
 sCXfhaSIG9gmRbeTC/mrYMcjNtOU4MquxVUF8qEcF7ld+tvHiWlAt9EXHLeCdfpKQHo9oI1uQk7sW
 1QwOxcMBAVRSMC8O5QBWT9AMk5Dow2eUCHWUHIlPtgFmKULPrfJzl8dIGklp5FLEcm9HmMcOp8vFM
 foaJpKDlE/sSsnoiUr0dtaoS8rtZpJeSOljP95oiUU5jlbFYNSjqQFIZTYuFsR56h+0aGs1p+g0Fp
 Fa6712tg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1Y-0001VV-M9; Tue, 09 Oct 2018 13:26:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 26/33] powerpc/fsl_pci: simplify fsl_pci_dma_set_mask
Date: Tue,  9 Oct 2018 15:24:53 +0200
Message-Id: <20181009132500.17643-27-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

swiotlb will only bounce buffer the effectice dma address for the device
is smaller than the actual DMA range.  Instead of flipping between the
swiotlb and nommu ops for FSL SOCs that have the second outbound window
just don't set the bus dma_mask in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/fsl_pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index f136567a5ed5..296ffabc9386 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -143,7 +143,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 * mapping that allows addressing any RAM address from across PCI.
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
-		set_dma_ops(dev, &dma_nommu_ops);
+		dev->bus_dma_mask = 0;
 		set_dma_offset(dev, pci64_dma_offset);
 	}
 
@@ -403,10 +403,6 @@ static void setup_pci_atmu(struct pci_controller *hose)
 				out_be32(&pci->piw[win_idx].piwar,  piwar);
 			}
 
-			/*
-			 * install our own dma_set_mask handler to fixup dma_ops
-			 * and dma_offset
-			 */
 			ppc_md.dma_set_mask = fsl_pci_dma_set_mask;
 
 			pr_info("%pOF: Setup 64-bit PCI DMA window\n", hose->dn);
-- 
2.19.0

