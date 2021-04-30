Return-Path: <SRS0=0xlf=J3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F289C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 16:34:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1989760233
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 16:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1989760233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWydH5tz9z3cDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 May 2021 02:34:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=VqsDCv9Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f35;
 helo=mail-qv1-xf35.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VqsDCv9Y; dkim-atps=neutral
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWyZd0N68z30Bk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 May 2021 02:32:24 +1000 (AEST)
Received: by mail-qv1-xf35.google.com with SMTP id h3so33920576qve.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GRPlkzaGZyBbq6zUXKNQzaRwXQORgwIEp8JWTzfRhiI=;
 b=VqsDCv9YfIbPsC9jT7HcbKV5zeDxQFt3/bo2f01dptxmGI3qWa1kDAEP4LCb1Ns+xi
 Euem+se+3JMX9fTRbscu2LHEA27FkfOZ4+i5XzDa33y8jfPtUKRppZeQl4W0NbWJTy1D
 TQ+yhSAE5dCTiVOu49jUec8pSu6DuhEms7EZ24OHv8Sx3/avl588O8nMyqFl+p+Caes+
 A0FZ3zDEbFl0WNoTZB8/vSidEJFYAPZRYQuWW4P+HOg79fZ5D8cicNQ3tQlMBSGgEtO/
 FIREVX6/N+HqBzR+0IWa9y2IK5kc3QOwp8f6e0un25n/YjZRG8oJS3IJaDg9GHG27lJ/
 RskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GRPlkzaGZyBbq6zUXKNQzaRwXQORgwIEp8JWTzfRhiI=;
 b=k9HnSoatuw8GgJieyC4kQtCzWoQp+WCkRmOJGRJDJa+EKX65WnRZ+EYuc5TMDpXq2E
 Vd/kpK00Wr+JqoSIF/2Q+NHkvWudPqp+dUfg0aZfYYOQKJwKl1RAX6CRy2zQC+x7J8Ee
 TfxViXkJIrWfUXF1ClwLWlzdwD9L8COwsKYckboVr5Vc+KFi1/anyin+Bs8yWWNBqCpj
 MK+2MYZBGErKhrbthE8EfXvDMhp86eDDsU9/RIliAVm1zBnqngMBNEEzUJFhMnTzZTAb
 WGMug6c57H4vQl5ZDr5Wqq27s4QXFwchuugfmJUQ4Ye8as/P2B0o9Ccxp7gelj84LIBf
 owgw==
X-Gm-Message-State: AOAM533AUcOnuHPuq89qn/Np2mPBrCmbeU85PpnxbzCU+hiNo/lOlSoV
 j2ue7iJihZ3npSO2BEJvW7E=
X-Google-Smtp-Source: ABdhPJy4VNr27m78kDspds6MWHbaa9DtyRZF84u9qgtYB7+0TIc4X9cfxFd6T7ZrzX6NRrecrhkjnw==
X-Received: by 2002:a05:6214:a62:: with SMTP id
 ef2mr933705qvb.31.1619800342218; 
 Fri, 30 Apr 2021 09:32:22 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com
 ([2804:14c:482:7b04::1001])
 by smtp.gmail.com with ESMTPSA id p1sm2624334qtu.89.2021.04.30.09.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Apr 2021 09:32:21 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Leonardo Bras <leobras.c@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v4 05/11] powerpc/pseries/iommu: Allow DDW windows starting at
 0x00
Date: Fri, 30 Apr 2021 13:31:40 -0300
Message-Id: <20210430163145.146984-6-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430163145.146984-1-leobras.c@gmail.com>
References: <20210430163145.146984-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

enable_ddw() currently returns the address of the DMA window, which is
considered invalid if has the value 0x00.

Also, it only considers valid an address returned from find_existing_ddw
if it's not 0x00.

Changing this behavior makes sense, given the users of enable_ddw() only
need to know if direct mapping is possible. It can also allow a DMA window
starting at 0x00 to be used.

This will be helpful for using a DDW with indirect mapping, as the window
address will be different than 0x00, but it will not map the whole
partition.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 35 ++++++++++++--------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6f14894d2d04..955cf095416c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -849,25 +849,26 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 			np, ret);
 }
 
-static u64 find_existing_ddw(struct device_node *pdn, int *window_shift)
+static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
 {
 	struct direct_window *window;
 	const struct dynamic_dma_window_prop *direct64;
-	u64 dma_addr = 0;
+	bool found = false;
 
 	spin_lock(&direct_window_list_lock);
 	/* check if we already created a window and dupe that config if so */
 	list_for_each_entry(window, &direct_window_list, list) {
 		if (window->device == pdn) {
 			direct64 = window->prop;
-			dma_addr = be64_to_cpu(direct64->dma_base);
+			*dma_addr = be64_to_cpu(direct64->dma_base);
 			*window_shift = be32_to_cpu(direct64->window_shift);
+			found = true;
 			break;
 		}
 	}
 	spin_unlock(&direct_window_list_lock);
 
-	return dma_addr;
+	return found;
 }
 
 static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
@@ -1157,20 +1158,19 @@ static int iommu_get_page_shift(u32 query_page_size)
  * pdn: the parent pe node with the ibm,dma_window property
  * Future: also check if we can remap the base window for our base page size
  *
- * returns the dma offset for use by the direct mapped DMA code.
+ * returns true if can map all pages (direct mapping), false otherwise..
  */
-static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
+static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 {
 	int len = 0, ret;
 	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
-	u64 dma_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
-	struct property *win64;
+	struct property *win64 = NULL;
 	struct dynamic_dma_window_prop *ddwprop;
 	struct failed_ddw_pdn *fpdn;
 	bool default_win_removed = false;
@@ -1182,8 +1182,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	mutex_lock(&direct_window_init_mutex);
 
-	dma_addr = find_existing_ddw(pdn, &len);
-	if (dma_addr != 0)
+	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len))
 		goto out_unlock;
 
 	/*
@@ -1338,7 +1337,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dma_addr = be64_to_cpu(ddwprop->dma_base);
+	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
 	goto out_unlock;
 
 out_free_window:
@@ -1351,6 +1350,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64->name);
 	kfree(win64->value);
 	kfree(win64);
+	win64 = NULL;
 
 out_failed:
 	if (default_win_removed)
@@ -1370,10 +1370,10 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * as RAM, then we failed to create a window to cover persistent
 	 * memory and need to set the DMA limit.
 	 */
-	if (pmem_present && dma_addr && (len == max_ram_len))
-		dev->dev.bus_dma_limit = dma_addr + (1ULL << len);
+	if (pmem_present && win64 && (len == max_ram_len))
+		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + (1ULL << len);
 
-	return dma_addr;
+	return win64;
 }
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
@@ -1452,11 +1452,8 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 			break;
 	}
 
-	if (pdn && PCI_DN(pdn)) {
-		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
-		if (pdev->dev.archdata.dma_offset)
-			return true;
-	}
+	if (pdn && PCI_DN(pdn))
+		return enable_ddw(pdev, pdn);
 
 	return false;
 }
-- 
2.30.2

