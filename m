Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7081CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 10:16:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7771960F24
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7771960F24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJb4Z0tdlz2yNv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 20:15:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4HJb440fGxz2xsC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2021 20:15:30 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 0646CAE80062;
 Tue, 28 Sep 2021 06:15:23 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerps/pseries/dma: Add support for 2M IOMMU page size
Date: Tue, 28 Sep 2021 20:15:21 +1000
Message-Id: <20210928101521.3956331-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.30.2
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
Cc: Leonardo Bras <leobras.c@gmail.com>, Brian J King <bjking1@us.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Travis Pizel <verno@us.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@br.ibm.com>,
 Murilo Vicentini <muvic@br.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The upcoming PAPR spec adds a 2M page size, bit 23 right after the 16G page
size in the "ibm,query-pe-dma-window" call.

This adds support for the new page size. Since the new page size is out
of sorted order, this changes the loop to not assume that shift[] is
sorted.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This might not work if PHYP keeps rejecting new window requests for less
than 32768 TCEs. This is needed:
https://github.com/aik/linux/commit/8cc8fa5ba5b3b4a18efbc9d81d9e5b85ca7c8a95


---
 arch/powerpc/platforms/pseries/iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index c741689a5165..237bf405b0cb 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1159,14 +1159,15 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
 /* Return largest page shift based on "IO Page Sizes" output of ibm,query-pe-dma-window. */
 static int iommu_get_page_shift(u32 query_page_size)
 {
-	/* Supported IO page-sizes according to LoPAR */
+	/* Supported IO page-sizes according to LoPAR, note that 2M is out of order */
 	const int shift[] = {
 		__builtin_ctzll(SZ_4K),   __builtin_ctzll(SZ_64K), __builtin_ctzll(SZ_16M),
 		__builtin_ctzll(SZ_32M),  __builtin_ctzll(SZ_64M), __builtin_ctzll(SZ_128M),
-		__builtin_ctzll(SZ_256M), __builtin_ctzll(SZ_16G)
+		__builtin_ctzll(SZ_256M), __builtin_ctzll(SZ_16G), __builtin_ctzll(SZ_2M)
 	};
 
 	int i = ARRAY_SIZE(shift) - 1;
+	int ret = 0;
 
 	/*
 	 * On LoPAR, ibm,query-pe-dma-window outputs "IO Page Sizes" using a bit field:
@@ -1176,11 +1177,10 @@ static int iommu_get_page_shift(u32 query_page_size)
 	 */
 	for (; i >= 0 ; i--) {
 		if (query_page_size & (1 << i))
-			return shift[i];
+			ret = max(ret, shift[i]);
 	}
 
-	/* No valid page size found. */
-	return 0;
+	return ret;
 }
 
 static struct property *ddw_property_create(const char *propname, u32 liobn, u64 dma_addr,
-- 
2.30.2

