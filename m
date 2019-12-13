Return-Path: <SRS0=Sd9m=2D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE06CC43603
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 08:52:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FD0206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 08:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FD0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Z4Dp4VmXzDrBG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 19:52:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 47Z44x700LzDqRY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 19:45:53 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A3666AE80803;
 Fri, 13 Dec 2019 03:44:44 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 3/3] powerpc/pseries/iommu: Do not use
 H_PUT_TCE_INDIRECT in secure VM
Date: Fri, 13 Dec 2019 19:45:37 +1100
Message-Id: <20191213084537.27306-4-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213084537.27306-1-aik@ozlabs.ru>
References: <20191213084537.27306-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

H_PUT_TCE_INDIRECT uses a 4K page with TCEs to allow handling up to 512
TCEs per hypercall. While it is a decent optimization, we rather share
less of secure VM memory so let's avoid sharing.

This only allows H_PUT_TCE_INDIRECT for normal (not secure) VMs.

This keeps using H_STUFF_TCE as it does not require sharing.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Possible alternatives are:

1. define FW_FEATURE_STUFFTCE (to allow H_STUFF_TCE) in addition to
FW_FEATURE_MULTITCE (make it only enable H_PUT_TCE_INDIRECT) and enable
only FW_FEATURE_STUFFTCE for SVM; pro = no SVM mention in iommu.c,
con = a FW feature bit with very limited use

2. disable FW_FEATURE_MULTITCE and loose H_STUFF_TCE which adds a delay
in booting process
---
 arch/powerpc/platforms/pseries/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f6e9b87c82fc..2334a67c7614 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -192,7 +192,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	int ret = 0;
 	unsigned long flags;
 
-	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE)) {
+	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE) ||
+			is_secure_guest()) {
 		return tce_build_pSeriesLP(tbl->it_index, tcenum,
 					   tbl->it_page_shift, npages, uaddr,
 		                           direction, attrs);
@@ -402,7 +403,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	u64 rc = 0;
 	long l, limit;
 
-	if (!firmware_has_feature(FW_FEATURE_MULTITCE)) {
+	if (!firmware_has_feature(FW_FEATURE_MULTITCE) ||
+			is_secure_guest()) {
 		unsigned long tceshift = be32_to_cpu(maprange->tce_shift);
 		unsigned long dmastart = (start_pfn << PAGE_SHIFT) +
 				be64_to_cpu(maprange->dma_base);
-- 
2.17.1

