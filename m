Return-Path: <SRS0=owsf=57=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F5C2BB1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 01:30:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A67320737
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 01:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="YbKFySl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A67320737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=d-silva.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4924Xv4C80zDqnG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 11:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=d-silva.org (client-ip=66.55.73.32;
 helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=d-silva.org
Authentication-Results: lists.ozlabs.org; dkim=pass (4096-bit key;
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256
 header.s=201810a header.b=YbKFySl0; dkim-atps=neutral
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com
 [66.55.73.32])
 by lists.ozlabs.org (Postfix) with ESMTP id 4924Q926vhzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2020 11:24:15 +1000 (AEST)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
 by ushosting.nmnhosting.com (Postfix) with ESMTPS id A3FA82DC671B;
 Wed, 15 Apr 2020 11:24:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
 s=201810a; t=1586913854;
 bh=+/Z7fqtYX8Nnp77mWTKUkbTOcmsYM+QdBA83YSGxNyo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YbKFySl0Lnh1JzBV+NZq3IlBQfsH+IZ4jOns/ERMHmdxjjacZVUwFbUfju9V24M7D
 HSdGuj2ESCw0YtxpqGq5ZmhSRhaOPb6NxxEYpbP244qgE0J08P1/R3/dk1q3EfmIbQ
 5xIx4kZzVRkMnRsX2FuKLm7+cSNDt1koBXlmJ7MGCtTMHNGSzs/1CceQuQHRKTDpL0
 kemJwwBl/QHnbFPTiC3ngoUsiBU29sKQ+cB9bE12yEoHomkoqm4dcCLEv77IWeQEcW
 /PnrlaMG24CZXQrUT0c1NMgbSjc3otnJCHZ0BHDlozLNt8x0ATH7t/v/XK2YMUaZqP
 GbntZefnPkiPSWYi0m4ltUYB7L6/m9pQtKRo6kznSsUpoXQpZW3pkZj36GNkOdvGoU
 zhlZ/7FNLRzSFMVbBppohkAB9VvH1oL3NHcqE8Ds/L5eeVPl4RCu6G+HYv3Iev1ZII
 jV8L1mkZ4An8kdmzYRV5Pyw/LTQYDYuaVv/pbJIa4VUeGIgoOmeufIwag7y9O2WrRw
 EYnJjkHRyUe2pTBatI2OtOU5rQkefDc5HhpOuCTMNdTL9GH5BKU1v3MxbD5daFxRGV
 0y82DPRPy0A2IiWDWOaTQd/Eec3YPenhsgGw1ZQzEwvGdxz18RrWO41SmR+G+e31ji
 LGlx4GcPw7UFkVr5cy3EuBeg=
Received: from localhost.lan ([10.0.1.179])
 by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 03F1O2Rv036615;
 Wed, 15 Apr 2020 11:24:09 +1000 (AEST)
 (envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH 1/2] ocxl: Remove unnecessary externs
Date: Wed, 15 Apr 2020 11:23:42 +1000
Message-Id: <20200415012343.919255-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415012343.919255-1-alastair@d-silva.org>
References: <20200415012343.919255-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mail2.nmnhosting.com [10.0.1.20]); Wed, 15 Apr 2020 11:24:09 +1000 (AEST)
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Function declarations don't need externs, remove the existing ones
so they are consistent with newer code

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h | 40 ++++++++++++++---------------
 include/misc/ocxl.h                 |  6 ++---
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 7de82647e761..ee79d2cd9fb6 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -9,28 +9,26 @@
 #define PNV_OCXL_TL_BITS_PER_RATE       4
 #define PNV_OCXL_TL_RATE_BUF_SIZE       ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
 
-extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
-			u16 *supported);
-extern int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count);
+int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled, u16 *supported);
+int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count);
 
-extern int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
+int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
 			char *rate_buf, int rate_buf_size);
-extern int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
-			uint64_t rate_buf_phys, int rate_buf_size);
-
-extern int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
-extern void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
-				void __iomem *tfc, void __iomem *pe_handle);
-extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
-				void __iomem **dar, void __iomem **tfc,
-				void __iomem **pe_handle);
-
-extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
-			void **platform_data);
-extern void pnv_ocxl_spa_release(void *platform_data);
-extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
-
-extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
-extern void pnv_ocxl_free_xive_irq(u32 irq);
+int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
+			 uint64_t rate_buf_phys, int rate_buf_size);
+
+int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
+void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
+			     void __iomem *tfc, void __iomem *pe_handle);
+int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
+			  void __iomem **dar, void __iomem **tfc,
+			  void __iomem **pe_handle);
+
+int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask, void **platform_data);
+void pnv_ocxl_spa_release(void *platform_data);
+int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
+
+int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
+void pnv_ocxl_free_xive_irq(u32 irq);
 
 #endif /* _ASM_PNV_OCXL_H */
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 06dd5839e438..0a762e387418 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -173,7 +173,7 @@ int ocxl_context_detach(struct ocxl_context *ctx);
  *
  * Returns 0 on success, negative on failure
  */
-extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
+int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
 
 /**
  * Frees an IRQ associated with an AFU context
@@ -182,7 +182,7 @@ extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
  *
  * Returns 0 on success, negative on failure
  */
-extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
+int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
 
 /**
  * Gets the address of the trigger page for an IRQ
@@ -193,7 +193,7 @@ extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
  *
  * returns the trigger page address, or 0 if the IRQ is not valid
  */
-extern u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
+u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
 
 /**
  * Provide a callback to be called when an IRQ is triggered
-- 
2.25.1

