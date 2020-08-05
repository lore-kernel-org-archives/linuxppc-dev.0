Return-Path: <SRS0=7j3x=BP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABEC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 03:09:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87312070A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 03:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsDrwsn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87312070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLxRV6cb0zDqZT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 13:09:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::843;
 helo=mail-qt1-x843.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tsDrwsn6; dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLxLw1N5nzDqRj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2020 13:05:12 +1000 (AEST)
Received: by mail-qt1-x843.google.com with SMTP id x12so24163176qtp.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2020 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KZZhp6G/Nvdr8CubS5lc2IdWicGU//2bZ5AuIAz3WYY=;
 b=tsDrwsn6dw9H9iUUR3XvrWEQiOYRfexsj6w/btAB7+ZzsHuM2fIRTkEUdV2w0KaSFC
 h+IX6i/BpNognd2NP9nnDY28By5W++Z9D1wKijXnSEaKeFvsTyoAQiSC0GISyOn6VkO6
 /izKrL2Lw4lhEwm6j0911VfV/BfOxL8Vu4qTPLxz8EnxznS8EDelcL5ChjBKc0CIhK6a
 50HRa/GfTvzfXdeWKBrxjr9rpKlMUeXzixQoKOKKe2vjT43XaBcKASUqXJsFWR23r4Uo
 c3RAWn0op7UzU+dPXtz4YMyCP/dtAAUsvsAZkbdQ36dh7Ap8Fj2FoLUVktHDcd6czgfh
 eN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KZZhp6G/Nvdr8CubS5lc2IdWicGU//2bZ5AuIAz3WYY=;
 b=sQ/GE+RK+ktUUPz6S5m+0h1mgSSTrgoBtGepQqYmoyA26i+QwaUIlWvgTenJqzeWV9
 6rnOTWtWAET+oHPK7beTCeyW+p7pQ4RKqs1o3JjajpYHPrcVov1f6WniKbBl012TB9Mj
 dMCalQPbswkPF0BBc7xarAMdekrXaRsK8p/mRh29BN0W3ZlBDVyE9SPN2D+5FYyWxsl2
 K+LZ1X88IJtTYX4idZ0s1RcElfqZqjmidBjz04YPndKmYaDue5sLAoPO6zn7AcEKogmx
 mxsMZuB5rxdPVnFJXKSYI0C5j1rrN8AjMvU+SODI9V1bIcRGL3aPanxvpdZf61ZWKSJ8
 VggA==
X-Gm-Message-State: AOAM530X3TZuu8KDz7dWp9bekIq5cuLqdUPJIoxc9YHYmNO1D3RaVhzi
 52QspL9tPA7KBOYFzpHyj/o=
X-Google-Smtp-Source: ABdhPJwEJlDXMiqIxjJ8NWBXOAzyEnPfjVEOVS1TpGiB9pkJhcOwymUcwPehjylHnqE+u6vPhAyQIA==
X-Received: by 2002:ac8:4643:: with SMTP id f3mr1275598qto.128.1596596709387; 
 Tue, 04 Aug 2020 20:05:09 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-154-168.dynamic.desktop.com.br.
 [179.125.154.168])
 by smtp.gmail.com with ESMTPSA id n4sm869946qtr.73.2020.08.04.20.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 20:05:08 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Leonardo Bras <leobras.c@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, Brian King <brking@linux.vnet.ibm.com>,
 Murilo Fossa Vicentini <muvic@linux.ibm.com>,
 David Dai <zdai@linux.vnet.ibm.com>
Subject: [PATCH v5 1/4] powerpc/pseries/iommu: Create defines for operations
 in ibm, ddw-applicable
Date: Wed,  5 Aug 2020 00:04:52 -0300
Message-Id: <20200805030455.123024-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200805030455.123024-1-leobras.c@gmail.com>
References: <20200805030455.123024-1-leobras.c@gmail.com>
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

Create defines to help handling ibm,ddw-applicable values, avoiding
confusion about the index of given operations.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Tested-by: David Dai <zdai@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 43 ++++++++++++++++----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6d47b4a3ce39..ac0d6376bdad 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -39,6 +39,14 @@
 
 #include "pseries.h"
 
+enum {
+	DDW_QUERY_PE_DMA_WIN  = 0,
+	DDW_CREATE_PE_DMA_WIN = 1,
+	DDW_REMOVE_PE_DMA_WIN = 2,
+
+	DDW_APPLICABLE_SIZE
+};
+
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
@@ -771,12 +779,12 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 {
 	struct dynamic_dma_window_prop *dwp;
 	struct property *win64;
-	u32 ddw_avail[3];
+	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	u64 liobn;
 	int ret = 0;
 
 	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
-					 &ddw_avail[0], 3);
+					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
 
 	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
 	if (!win64)
@@ -798,15 +806,15 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 		pr_debug("%pOF successfully cleared tces in window.\n",
 			 np);
 
-	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
+	ret = rtas_call(ddw_avail[DDW_REMOVE_PE_DMA_WIN], 1, 1, NULL, liobn);
 	if (ret)
 		pr_warn("%pOF: failed to remove direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np, ret, ddw_avail[2], liobn);
+			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 	else
 		pr_debug("%pOF: successfully removed direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np, ret, ddw_avail[2], liobn);
+			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 
 delprop:
 	if (remove_prop)
@@ -889,11 +897,11 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	buid = pdn->phb->buid;
 	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
 
-	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
-		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
+	ret = rtas_call(ddw_avail[DDW_QUERY_PE_DMA_WIN], 3, 5, (u32 *)query,
+			cfg_addr, BUID_HI(buid), BUID_LO(buid));
 	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
-		" returned %d\n", ddw_avail[0], cfg_addr, BUID_HI(buid),
-		BUID_LO(buid), ret);
+		" returned %d\n", ddw_avail[DDW_QUERY_PE_DMA_WIN], cfg_addr,
+		 BUID_HI(buid), BUID_LO(buid), ret);
 	return ret;
 }
 
@@ -920,15 +928,16 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 
 	do {
 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
-		ret = rtas_call(ddw_avail[1], 5, 4, (u32 *)create,
-				cfg_addr, BUID_HI(buid), BUID_LO(buid),
-				page_shift, window_shift);
+		ret = rtas_call(ddw_avail[DDW_CREATE_PE_DMA_WIN], 5, 4,
+				(u32 *)create, cfg_addr, BUID_HI(buid),
+				BUID_LO(buid), page_shift, window_shift);
 	} while (rtas_busy_delay(ret));
 	dev_info(&dev->dev,
 		"ibm,create-pe-dma-window(%x) %x %x %x %x %x returned %d "
-		"(liobn = 0x%x starting addr = %x %x)\n", ddw_avail[1],
-		 cfg_addr, BUID_HI(buid), BUID_LO(buid), page_shift,
-		 window_shift, ret, create->liobn, create->addr_hi, create->addr_lo);
+		"(liobn = 0x%x starting addr = %x %x)\n",
+		 ddw_avail[DDW_CREATE_PE_DMA_WIN], cfg_addr, BUID_HI(buid),
+		 BUID_LO(buid), page_shift, window_shift, ret, create->liobn,
+		 create->addr_hi, create->addr_lo);
 
 	return ret;
 }
@@ -996,7 +1005,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	int page_shift;
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
-	u32 ddw_avail[3];
+	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
 	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
@@ -1029,7 +1038,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * the property is actually in the parent, not the PE
 	 */
 	ret = of_property_read_u32_array(pdn, "ibm,ddw-applicable",
-					 &ddw_avail[0], 3);
+					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
 	if (ret)
 		goto out_failed;
 
-- 
2.25.4

