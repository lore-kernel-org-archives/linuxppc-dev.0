Return-Path: <SRS0=kNGO=H7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 08:49:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AFD64DE0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 08:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AFD64DE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dpv7l63Lqz3f1V
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 19:49:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=O9MMPi8P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+bce9324c41c3486454c7+6399+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=O9MMPi8P; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dpv6m1nYWz3dD0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Mar 2021 19:48:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=E7hhcteK4GUQFY9xJ3UXZHBinl63OJRSjslBjH5SJ4o=; b=O9MMPi8P/b5H+w4VoMI8YihaaA
 BPVU5aXQqLQQj97pJgAx+OanvHJgHAHYqG4osgFX4FdkSeUoiQALMA1zpxM3LhNUWq3j7RlE2zhlk
 nXQdh9z5M0xgAycaeWyvFMu0U+yIpNcghIBVN+93bMa5oiFMW7ZrNJAMZy5s5wHwSaUHY3AQbHUV4
 EzSgaqp7xRzOBYqhRo+qswdIUSKXlm1J1ykAVaj1SYP5j2D+2STDtXcLCbdZly0NivQpFDcLiRa74
 OEGlXEz38hVpN6W99EJhHgrab4vvXFmNjp/2m1XhY13n93ZuU0UJFPJ+YZjk+7mdiNYaKVziqbUCz
 DqT4a2zA==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGeD0-00FUqj-3N; Mon, 01 Mar 2021 08:47:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 12/17] iommu: remove DOMAIN_ATTR_PAGING
Date: Mon,  1 Mar 2021 09:42:52 +0100
Message-Id: <20210301084257.945454-13-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301084257.945454-1-hch@lst.de>
References: <20210301084257.945454-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DOMAIN_ATTR_PAGING is never used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/iommu.c | 5 -----
 include/linux/iommu.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b212bf0261820b..9a4cda390993e6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2668,7 +2668,6 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
 	struct iommu_domain_geometry *geometry;
-	bool *paging;
 	int ret = 0;
 
 	switch (attr) {
@@ -2676,10 +2675,6 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 		geometry  = data;
 		*geometry = domain->geometry;
 
-		break;
-	case DOMAIN_ATTR_PAGING:
-		paging  = data;
-		*paging = (domain->pgsize_bitmap != 0UL);
 		break;
 	default:
 		if (!domain->ops->domain_get_attr)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 840864844027dc..180ff4bd7fa7ef 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -108,7 +108,6 @@ enum iommu_cap {
 
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
-	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_IO_PGTABLE_CFG,
-- 
2.29.2

