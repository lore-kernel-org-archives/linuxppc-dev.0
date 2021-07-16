Return-Path: <SRS0=FVZa=MI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE08DC07E95
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jul 2021 08:31:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A52613E3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jul 2021 08:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A52613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GR4Gf0N4qz3bht
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jul 2021 18:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=MKISFQEz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::735;
 helo=mail-qk1-x735.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=MKISFQEz; dkim-atps=neutral
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GR4BV10Kpz308m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jul 2021 18:28:18 +1000 (AEST)
Received: by mail-qk1-x735.google.com with SMTP id s6so7923446qkc.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jul 2021 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iXGgb/5Va0eqpRGTSVzjW8LDpHV/dLXtU//ErgInw+M=;
 b=MKISFQEzulngPloG/c1AkFIgXCAZxuKeEXjHi2jlqZUoA3XrTwiil4nya8QLpqNNqZ
 tJ5KQJA7qgN/ENmBMCHrk0j0+wKSz5uopBGjXmHl4HWx0v3MVcmo+ohsVbcuuDjoLDjE
 ok7uQXndColbCJNlYV76QLS6Y6Sy6zW21BNi/GbKNDUQcoUd+j2pikDx/Heec07H0Wv5
 RilMrCbS8Dr2DssaJDj+Qajm/33piDPSdBx4UTDLN329L3bC2JxNdxV/fNv2tbmFl/hF
 5SM4UYUqGjKaY6NZd6bGbid6Oq254vtdLOshCGS2Q7zO/+TGFYZ0NuWhSAeY4eWgbM/7
 pWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iXGgb/5Va0eqpRGTSVzjW8LDpHV/dLXtU//ErgInw+M=;
 b=r7jb0AtJemMXBz966r8IloByDSTxg9knxM67bWp/AIrovO2xu2S6jFQXh9IJxvRah6
 oGkdoklgTlA1FwlZFSWeaZQIpV5s7RfKgrufA982gD+PjWs8oDpTxG7+KqSpX2swPBrB
 x8Vc+kJsMpgb3cGYEDO7t38Xzpu2gwVL8OX0EY/80PT6wc1wqtInANnmEXHb5ZmbHcgt
 cjxBHkWDqW/qOa8mgVyatQedDGOwfuQP4/KBFBoI+PVveGqe7ZLejsPz3AXJ2wlxnKyq
 oTJuUcPjzno9zegisV4ArXllKCwOJfeHzmf7fJC/LR46stcv4pKwW5Hn4Npu4XqQ6VRL
 D+Hw==
X-Gm-Message-State: AOAM530etX6a2HSwmtxuZPchmyJLRmdkfsyeXO3On8YopND5QAc+MNrS
 vfHkF0owaN9GI8QUOnoNgGQ=
X-Google-Smtp-Source: ABdhPJwmLvmTbw6c+J0LkX71SrVmkzTc2XGeAjYD7caA5SiZG0Ttv/ab891S5JLeRlFZmD3/pQ5Eeg==
X-Received: by 2002:a37:2d04:: with SMTP id t4mr8839951qkh.160.1626424096100; 
 Fri, 16 Jul 2021 01:28:16 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
 by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jul 2021 01:28:15 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Leonardo Bras <leobras.c@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 kernel test robot <lkp@intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PATCH v5 08/11] powerpc/pseries/iommu: Update remove_dma_window() to
 accept property name
Date: Fri, 16 Jul 2021 05:27:53 -0300
Message-Id: <20210716082755.428187-9-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
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

Update remove_dma_window() so it can be used to remove DDW with a given
property name.

This enables the creation of new property names for DDW, so we can
have different usage for it, like indirect mapping.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 108c3dcca686..17c6f4706e76 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -830,31 +830,32 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
 			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 }
 
-static void remove_ddw(struct device_node *np, bool remove_prop)
+static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_name)
 {
 	struct property *win;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	int ret = 0;
 
+	win = of_find_property(np, win_name, NULL);
+	if (!win)
+		return -EINVAL;
+
 	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
 					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
 	if (ret)
-		return;
-
-	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
-	if (!win)
-		return;
+		return 0;
 
 	if (win->length >= sizeof(struct dynamic_dma_window_prop))
 		remove_dma_window(np, ddw_avail, win);
 
 	if (!remove_prop)
-		return;
+		return 0;
 
 	ret = of_remove_property(np, win);
 	if (ret)
 		pr_warn("%pOF: failed to remove direct window property: %d\n",
 			np, ret);
+	return 0;
 }
 
 static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
@@ -907,7 +908,7 @@ static int find_existing_ddw_windows(void)
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
 		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
 		if (!direct64 || len < sizeof(*direct64)) {
-			remove_ddw(pdn, true);
+			remove_ddw(pdn, true, DIRECT64_PROPNAME);
 			continue;
 		}
 
@@ -1382,7 +1383,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64);
 
 out_remove_win:
-	remove_ddw(pdn, true);
+	remove_ddw(pdn, true, DIRECT64_PROPNAME);
 
 out_failed:
 	if (default_win_removed)
@@ -1547,7 +1548,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		 * we have to remove the property when releasing
 		 * the device node.
 		 */
-		remove_ddw(np, false);
+		remove_ddw(np, false, DIRECT64_PROPNAME);
 		if (pci && pci->table_group)
 			iommu_pseries_free_group(pci->table_group,
 					np->full_name);
-- 
2.32.0

