Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A9C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 19:01:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C520213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 19:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RuYC/aqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C520213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QQN12kQmzF3C5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 05:01:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="RuYC/aqB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.65; helo=hqemgate16.nvidia.com;
 envelope-from=mhairgrove@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="RuYC/aqB"; 
 dkim-atps=neutral
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QQ9W1SKHzF37w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 04:51:58 +1000 (AEST)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5bb50fca0000>; Wed, 03 Oct 2018 11:51:55 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 03 Oct 2018 11:51:54 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 03 Oct 2018 11:51:54 -0700
Received: from localhost.localdomain (10.110.48.80) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 18:51:53 +0000
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 3/3] powerpc/powernv/npu: Remove atsd_threshold debugfs
 setting
Date: Wed, 3 Oct 2018 11:51:34 -0700
Message-ID: <1538592694-18739-4-git-send-email-mhairgrove@nvidia.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1538592694-18739-1-git-send-email-mhairgrove@nvidia.com>
References: <1538592694-18739-1-git-send-email-mhairgrove@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.110.48.80]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1538592715; bh=k5yTCe6xoKcbaQq+2qMW238Vb2vlK1rAbdTMlryXs54=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 X-Originating-IP:X-ClientProxiedBy:Content-Type;
 b=RuYC/aqB5BoZ+Xlo5jpZE8pTQfFmMfFjt6rHJmZ72B+99zG5vlFaUmGB7CsRaxkKI
 qZLh4yazWNJdG9dnahL3g9txXZ+rn0iPRZLqOZ0ktUsuOtwAwRDwIKFOcPXFQjdQyy
 5/j3B5MCKsZBk+7bTtrmCHExvEBBxjXPx8AyKIEtV6HNWDcgHk+CY6BrFl6UJ+xZez
 lToxfZXDLgdl9A0WiLMtAzk5KKBVrbLocPscgdJUUSYs+UAh+rX5XQdJ6ye5wfD10c
 aNli3a816z3YEsSCX5Kh/4Vz7z3YlMyhA23Ntug+k4ELTzoV/yYHj9Dc1BD5L+NGbE
 4yguct3pQQsMw==
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, Reza Arbab <arbab@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This threshold is no longer used now that all invalidates issue a single
ATSD to each active NPU.

Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index e4c0fab..6f60e09 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -17,7 +17,6 @@
 #include <linux/pci.h>
 #include <linux/memblock.h>
 #include <linux/iommu.h>
-#include <linux/debugfs.h>
 #include <linux/sizes.h>
 
 #include <asm/debugfs.h>
@@ -43,14 +42,6 @@
 static DEFINE_SPINLOCK(npu_context_lock);
 
 /*
- * When an address shootdown range exceeds this threshold we invalidate the
- * entire TLB on the GPU for the given PID rather than each specific address in
- * the range.
- */
-static uint64_t atsd_threshold = 2 * 1024 * 1024;
-static struct dentry *atsd_threshold_dentry;
-
-/*
  * Other types of TCE cache invalidation are not functional in the
  * hardware.
  */
@@ -966,11 +957,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	static int npu_index;
 	uint64_t rc = 0;
 
-	if (!atsd_threshold_dentry) {
-		atsd_threshold_dentry = debugfs_create_x64("atsd_threshold",
-				   0600, powerpc_debugfs_root, &atsd_threshold);
-	}
-
 	phb->npu.nmmu_flush =
 		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
 	for_each_child_of_node(phb->hose->dn, dn) {
-- 
1.7.2.5

