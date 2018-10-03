Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39CCC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:56:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C50220644
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Xo2Q5JSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C50220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QQGd1GZXzF38q
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:56:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="Xo2Q5JSE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=mhairgrove@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="Xo2Q5JSE"; 
 dkim-atps=neutral
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QQ9S5xTnzF37w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 04:51:56 +1000 (AEST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5bb50fc70000>; Wed, 03 Oct 2018 11:51:51 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 03 Oct 2018 11:51:53 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 03 Oct 2018 11:51:53 -0700
Received: from localhost.localdomain (10.110.48.80) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 18:51:52 +0000
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 2/3] powerpc/powernv/npu: Use size-based ATSD invalidates
Date: Wed, 3 Oct 2018 11:51:33 -0700
Message-ID: <1538592694-18739-3-git-send-email-mhairgrove@nvidia.com>
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
 t=1538592711; bh=Sj4dABW1Dx4ooVnph1LJ6efBbzrBHSN/d9n6uMt6kiY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 X-Originating-IP:X-ClientProxiedBy:Content-Type;
 b=Xo2Q5JSEHrdx7NzCJzUrj48LUlCoy9xK+5NQjl3PMeGO5Hu3JW141RX7XM8XUjbvF
 6mgNClTFial8+hNnUHuykr5SR+MOu1GFhmNLvP8BEwxNrCKDl0/V3s6pHc5eT0DFor
 qioTYN/2QFLRMwJiiV/zvoVzHfsZLqU83x4eAJOhO1a75GQcZI8rzxJzwZ+T9OX08Y
 dmEAnQKC+d/Im/+ErAuoZ5aBK4ipkEEZ1SrjJsLcPMag55NusjeWP/W+EJ6ZprhzPV
 9BfDy9T0n0G24VBxLWWhjwcimzhhSLOoqD+x41HiZo7gfdNCPAbZ0ELooZUUj+oejQ
 pz/eNSR4rMuAw==
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

Prior to this change only two types of ATSDs were issued to the NPU:
invalidates targeting a single page and invalidates targeting the whole
address space. The crossover point happened at the configurable
atsd_threshold which defaulted to 2M. Invalidates that size or smaller
would issue per-page invalidates for the whole range.

The NPU supports more invalidation sizes however: 64K, 2M, 1G, and all.
These invalidates target addresses aligned to their size. 2M is a common
invalidation size for GPU-enabled applications because that is a GPU
page size, so reducing the number of invalidates by 32x in that case is a
clear improvement.

ATSD latency is high in general so now we always issue a single invalidate
rather than multiple. This will over-invalidate in some cases, but for any
invalidation size over 2M it matches or improves the prior behavior.
There's also an improvement for single-page invalidates since the prior
version issued two invalidates for that case instead of one.

With this change all issued ATSDs now perform a flush, so the flush
parameter has been removed from all the helpers.

To show the benefit here are some performance numbers from a
microbenchmark which creates a 1G allocation then uses mprotect with
PROT_NONE to trigger invalidates in strides across the allocation.

One NPU (1 GPU):

         mprotect rate (GB/s)
Stride   Before      After      Speedup
64K         5.3        5.6           5%
1M         39.3       57.4          46%
2M         49.7       82.6          66%
4M        286.6      285.7           0%

Two NPUs (6 GPUs):

         mprotect rate (GB/s)
Stride   Before      After      Speedup
64K         6.5        7.4          13%
1M         33.4       67.9         103%
2M         38.7       93.1         141%
4M        356.7      354.6          -1%

Anything over 2M is roughly the same as before since both cases issue a
single ATSD.

Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c |  103 ++++++++++++++++--------------
 1 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index c8f438a..e4c0fab 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/iommu.h>
 #include <linux/debugfs.h>
+#include <linux/sizes.h>
 
 #include <asm/debugfs.h>
 #include <asm/tlb.h>
@@ -458,8 +459,7 @@ static void put_mmio_atsd_reg(struct npu *npu, int reg)
 #define XTS_ATSD_AVA    1
 #define XTS_ATSD_STAT   2
 
-static unsigned long get_atsd_launch_val(unsigned long pid, unsigned long psize,
-					bool flush)
+static unsigned long get_atsd_launch_val(unsigned long pid, unsigned long psize)
 {
 	unsigned long launch = 0;
 
@@ -477,8 +477,7 @@ static unsigned long get_atsd_launch_val(unsigned long pid, unsigned long psize,
 	/* PID */
 	launch |= pid << PPC_BITLSHIFT(38);
 
-	/* No flush */
-	launch |= !flush << PPC_BITLSHIFT(39);
+	/* Leave "No flush" (bit 39) 0 so every ATSD performs a flush */
 
 	return launch;
 }
@@ -501,23 +500,22 @@ static void mmio_atsd_regs_write(struct mmio_atsd_reg
 }
 
 static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
-				unsigned long pid, bool flush)
+				unsigned long pid)
 {
-	unsigned long launch = get_atsd_launch_val(pid, MMU_PAGE_COUNT, flush);
+	unsigned long launch = get_atsd_launch_val(pid, MMU_PAGE_COUNT);
 
 	/* Invalidating the entire process doesn't use a va */
 	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
 }
 
-static void mmio_invalidate_va(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
-			unsigned long va, unsigned long pid, bool flush)
+static void mmio_invalidate_range(struct mmio_atsd_reg
+			mmio_atsd_reg[NV_MAX_NPUS], unsigned long pid,
+			unsigned long start, unsigned long psize)
 {
-	unsigned long launch;
-
-	launch = get_atsd_launch_val(pid, mmu_virtual_psize, flush);
+	unsigned long launch = get_atsd_launch_val(pid, psize);
 
 	/* Write all VAs first */
-	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_AVA, va);
+	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_AVA, start);
 
 	/* Issue one barrier for all address writes */
 	eieio();
@@ -609,14 +607,36 @@ static void release_atsd_reg(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
 }
 
 /*
- * Invalidate either a single address or an entire PID depending on
- * the value of va.
+ * Invalidate a virtual address range
  */
-static void mmio_invalidate(struct npu_context *npu_context, int va,
-			unsigned long address, bool flush)
+static void mmio_invalidate(struct npu_context *npu_context,
+			unsigned long start, unsigned long size)
 {
 	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
 	unsigned long pid = npu_context->mm->context.id;
+	unsigned long atsd_start = 0;
+	unsigned long end = start + size - 1;
+	int atsd_psize = MMU_PAGE_COUNT;
+
+	/*
+	 * Convert the input range into one of the supported sizes. If the range
+	 * doesn't fit, use the next larger supported size. Invalidation latency
+	 * is high, so over-invalidation is preferred to issuing multiple
+	 * invalidates.
+	 *
+	 * A 4K page size isn't supported by NPU/GPU ATS, so that case is
+	 * ignored.
+	 */
+	if (size == SZ_64K) {
+		atsd_start = start;
+		atsd_psize = MMU_PAGE_64K;
+	} else if (ALIGN_DOWN(start, SZ_2M) == ALIGN_DOWN(end, SZ_2M)) {
+		atsd_start = ALIGN_DOWN(start, SZ_2M);
+		atsd_psize = MMU_PAGE_2M;
+	} else if (ALIGN_DOWN(start, SZ_1G) == ALIGN_DOWN(end, SZ_1G)) {
+		atsd_start = ALIGN_DOWN(start, SZ_1G);
+		atsd_psize = MMU_PAGE_1G;
+	}
 
 	if (npu_context->nmmu_flush)
 		/*
@@ -631,23 +651,25 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 	 * an invalidate.
 	 */
 	acquire_atsd_reg(npu_context, mmio_atsd_reg);
-	if (va)
-		mmio_invalidate_va(mmio_atsd_reg, address, pid, flush);
+
+	if (atsd_psize == MMU_PAGE_COUNT)
+		mmio_invalidate_pid(mmio_atsd_reg, pid);
 	else
-		mmio_invalidate_pid(mmio_atsd_reg, pid, flush);
+		mmio_invalidate_range(mmio_atsd_reg, pid, atsd_start,
+					atsd_psize);
 
 	mmio_invalidate_wait(mmio_atsd_reg);
-	if (flush) {
-		/*
-		 * The GPU requires two flush ATSDs to ensure all entries have
-		 * been flushed. We use PID 0 as it will never be used for a
-		 * process on the GPU.
-		 */
-		mmio_invalidate_pid(mmio_atsd_reg, 0, true);
-		mmio_invalidate_wait(mmio_atsd_reg);
-		mmio_invalidate_pid(mmio_atsd_reg, 0, true);
-		mmio_invalidate_wait(mmio_atsd_reg);
-	}
+
+	/*
+	 * The GPU requires two flush ATSDs to ensure all entries have been
+	 * flushed. We use PID 0 as it will never be used for a process on the
+	 * GPU.
+	 */
+	mmio_invalidate_pid(mmio_atsd_reg, 0);
+	mmio_invalidate_wait(mmio_atsd_reg);
+	mmio_invalidate_pid(mmio_atsd_reg, 0);
+	mmio_invalidate_wait(mmio_atsd_reg);
+
 	release_atsd_reg(mmio_atsd_reg);
 }
 
@@ -664,7 +686,7 @@ static void pnv_npu2_mn_release(struct mmu_notifier *mn,
 	 * There should be no more translation requests for this PID, but we
 	 * need to ensure any entries for it are removed from the TLB.
 	 */
-	mmio_invalidate(npu_context, 0, 0, true);
+	mmio_invalidate(npu_context, 0, ~0UL);
 }
 
 static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
@@ -673,8 +695,7 @@ static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
 				pte_t pte)
 {
 	struct npu_context *npu_context = mn_to_npu_context(mn);
-
-	mmio_invalidate(npu_context, 1, address, true);
+	mmio_invalidate(npu_context, address, PAGE_SIZE);
 }
 
 static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
@@ -682,21 +703,7 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 					unsigned long start, unsigned long end)
 {
 	struct npu_context *npu_context = mn_to_npu_context(mn);
-	unsigned long address;
-
-	if (end - start > atsd_threshold) {
-		/*
-		 * Just invalidate the entire PID if the address range is too
-		 * large.
-		 */
-		mmio_invalidate(npu_context, 0, 0, true);
-	} else {
-		for (address = start; address < end; address += PAGE_SIZE)
-			mmio_invalidate(npu_context, 1, address, false);
-
-		/* Do the flush only on the final addess == end */
-		mmio_invalidate(npu_context, 1, address, true);
-	}
+	mmio_invalidate(npu_context, start, end - start);
 }
 
 static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
-- 
1.7.2.5

