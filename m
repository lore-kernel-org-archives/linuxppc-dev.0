Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7CAC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:58:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B5C20644
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n1bdkk0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B5C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QQKJ3Kf4zF3BB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:58:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="n1bdkk0n";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=mhairgrove@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="n1bdkk0n"; 
 dkim-atps=neutral
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QQ9T5sqXzF37y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 04:51:57 +1000 (AEST)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5bb50faf0001>; Wed, 03 Oct 2018 11:51:27 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 03 Oct 2018 11:51:52 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 03 Oct 2018 11:51:52 -0700
Received: from localhost.localdomain (10.110.48.80) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 18:51:52 +0000
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 1/3] powerpc/powernv/npu: Reduce eieio usage when issuing
 ATSD invalidates
Date: Wed, 3 Oct 2018 11:51:32 -0700
Message-ID: <1538592694-18739-2-git-send-email-mhairgrove@nvidia.com>
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
 t=1538592687; bh=f6S8No1I0d8qHAbCAT1PoBbJKFQOePu8kIadRBZY/Yc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 X-Originating-IP:X-ClientProxiedBy:Content-Type;
 b=n1bdkk0n7ZWv6ERtfQUPrztVAhqSvCHdN75j/sHQEfLmH+dpbR/qJEOPy6LV/I8YV
 1lzr6QY4QtGX0XLT3SZZ6Su28SeRSEns9qRQY1ayR8amgChubQoejAAvjSHul+U0Uh
 DsyieB81/QhxuuxyyErHdn00eFUzLF/i2QaZnOAzwKpd+EOlafmIMpf5KyBkSZqFE5
 o7Hb4MVHr8bVSrYP9QJ3R29PgmJYu1fXj1s2XogAyJ3FFkshM2sHMlor8ujtNL/ET4
 rQnG3ej0lDi3xT0Aqfe/+B8vK+DaGwWCDYjTb5tx0dF3zm9afbLtYN0Il999i7z9fU
 +V7v6SUP94aCA==
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

There are two types of ATSDs issued to the NPU: invalidates targeting a
specific virtual address and invalidates targeting the whole address
space. In both cases prior to this change, the sequence was:

    for each NPU
        - Write the target address to the XTS_ATSD_AVA register
        - EIEIO
        - Write the launch value to issue the ATSD

First, a target address is not required when invalidating the whole
address space, so that write and the EIEIO have been removed. The AP
(size) field in the launch is not needed either.

Second, for per-address invalidates the above sequence is inefficient in
the common case of multiple NPUs because an EIEIO is issued per NPU. This
unnecessarily forces the launches of later ATSDs to be ordered with the
launches of earlier ones. The new sequence only issues a single EIEIO:

    for each NPU
        - Write the target address to the XTS_ATSD_AVA register
    EIEIO
    for each NPU
        - Write the launch value to issue the ATSD

Performance results were gathered using a microbenchmark which creates a
1G allocation then uses mprotect with PROT_NONE to trigger invalidates in
strides across the allocation.

With only a single NPU active (one GPU) the difference is in the noise for
both types of invalidates (+/-1%).

With two NPUs active (on a 6-GPU system) the effect is more noticeable:

         mprotect rate (GB/s)
Stride   Before      After      Speedup
64K         5.9        6.5          10%
1M         31.2       33.4           7%
2M         36.3       38.7           7%
4M        322.6      356.7          11%

Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c |   99 ++++++++++++++---------------
 1 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 8006c54..c8f438a 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -454,79 +454,76 @@ static void put_mmio_atsd_reg(struct npu *npu, int reg)
 }
 
 /* MMIO ATSD register offsets */
-#define XTS_ATSD_AVA  1
-#define XTS_ATSD_STAT 2
+#define XTS_ATSD_LAUNCH 0
+#define XTS_ATSD_AVA    1
+#define XTS_ATSD_STAT   2
 
-static void mmio_launch_invalidate(struct mmio_atsd_reg *mmio_atsd_reg,
-				unsigned long launch, unsigned long va)
+static unsigned long get_atsd_launch_val(unsigned long pid, unsigned long psize,
+					bool flush)
 {
-	struct npu *npu = mmio_atsd_reg->npu;
-	int reg = mmio_atsd_reg->reg;
+	unsigned long launch = 0;
 
-	__raw_writeq_be(va, npu->mmio_atsd_regs[reg] + XTS_ATSD_AVA);
-	eieio();
-	__raw_writeq_be(launch, npu->mmio_atsd_regs[reg]);
+	if (psize == MMU_PAGE_COUNT) {
+		/* IS set to invalidate entire matching PID */
+		launch |= PPC_BIT(12);
+	} else {
+		/* AP set to invalidate region of psize */
+		launch |= (u64)mmu_get_ap(psize) << PPC_BITLSHIFT(17);
+	}
+
+	/* PRS set to process-scoped */
+	launch |= PPC_BIT(13);
+
+	/* PID */
+	launch |= pid << PPC_BITLSHIFT(38);
+
+	/* No flush */
+	launch |= !flush << PPC_BITLSHIFT(39);
+
+	return launch;
 }
 
-static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
-				unsigned long pid, bool flush)
+static void mmio_atsd_regs_write(struct mmio_atsd_reg
+			mmio_atsd_reg[NV_MAX_NPUS], unsigned long offset,
+			unsigned long val)
 {
-	int i;
-	unsigned long launch;
+	struct npu *npu;
+	int i, reg;
 
 	for (i = 0; i <= max_npu2_index; i++) {
-		if (mmio_atsd_reg[i].reg < 0)
+		reg = mmio_atsd_reg[i].reg;
+		if (reg < 0)
 			continue;
 
-		/* IS set to invalidate matching PID */
-		launch = PPC_BIT(12);
-
-		/* PRS set to process-scoped */
-		launch |= PPC_BIT(13);
-
-		/* AP */
-		launch |= (u64)
-			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
-
-		/* PID */
-		launch |= pid << PPC_BITLSHIFT(38);
+		npu = mmio_atsd_reg[i].npu;
+		__raw_writeq_be(val, npu->mmio_atsd_regs[reg] + offset);
+	}
+}
 
-		/* No flush */
-		launch |= !flush << PPC_BITLSHIFT(39);
+static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
+				unsigned long pid, bool flush)
+{
+	unsigned long launch = get_atsd_launch_val(pid, MMU_PAGE_COUNT, flush);
 
-		/* Invalidating the entire process doesn't use a va */
-		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, 0);
-	}
+	/* Invalidating the entire process doesn't use a va */
+	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
 }
 
 static void mmio_invalidate_va(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
 			unsigned long va, unsigned long pid, bool flush)
 {
-	int i;
 	unsigned long launch;
 
-	for (i = 0; i <= max_npu2_index; i++) {
-		if (mmio_atsd_reg[i].reg < 0)
-			continue;
-
-		/* IS set to invalidate target VA */
-		launch = 0;
+	launch = get_atsd_launch_val(pid, mmu_virtual_psize, flush);
 
-		/* PRS set to process scoped */
-		launch |= PPC_BIT(13);
+	/* Write all VAs first */
+	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_AVA, va);
 
-		/* AP */
-		launch |= (u64)
-			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
-
-		/* PID */
-		launch |= pid << PPC_BITLSHIFT(38);
-
-		/* No flush */
-		launch |= !flush << PPC_BITLSHIFT(39);
+	/* Issue one barrier for all address writes */
+	eieio();
 
-		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, va);
-	}
+	/* Launch */
+	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
 }
 
 #define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
-- 
1.7.2.5

