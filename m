Return-Path: <SRS0=Ef5B=VC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF8C5B57D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 06:40:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1240E218A3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 06:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1240E218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45g4wS6hB2zDqdx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 16:40:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com; envelope-from=yanaijie@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
X-Greylist: delayed 933 seconds by postgrey-1.36 at bilbo;
 Fri, 05 Jul 2019 16:38:37 AEST
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45g4tP6LQTzDqcR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2019 16:38:36 +1000 (AEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 65C871494F392E6206F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2019 14:23:08 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 5 Jul 2019
 14:22:58 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3] powerpc: unify definition of M_IF_NEEDED
Date: Fri, 5 Jul 2019 14:39:53 +0800
Message-ID: <20190705063954.11674-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190705063954.11674-1-yanaijie@huawei.com>
References: <20190705063954.11674-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
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
Cc: Jason Yan <yanaijie@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

M_IF_NEEDED is defined too many times. Move it to a common place.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/powerpc/include/asm/nohash/mmu-book3e.h  | 10 ++++++++++
 arch/powerpc/kernel/exceptions-64e.S          | 10 ----------
 arch/powerpc/kernel/fsl_booke_entry_mapping.S | 10 ----------
 arch/powerpc/kernel/misc_64.S                 |  5 -----
 4 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
index 4c9777d256fb..0877362e48fa 100644
--- a/arch/powerpc/include/asm/nohash/mmu-book3e.h
+++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
@@ -221,6 +221,16 @@
 #define TLBILX_T_CLASS2			6
 #define TLBILX_T_CLASS3			7
 
+/*
+ * The mapping only needs to be cache-coherent on SMP, except on
+ * Freescale e500mc derivatives where it's also needed for coherent DMA.
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
+#define M_IF_NEEDED	MAS2_M
+#else
+#define M_IF_NEEDED	0
+#endif
+
 #ifndef __ASSEMBLY__
 #include <asm/bug.h>
 
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 1cfb3da4a84a..fd49ec07ce4a 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1342,16 +1342,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	sync
 	isync
 
-/*
- * The mapping only needs to be cache-coherent on SMP, except on
- * Freescale e500mc derivatives where it's also needed for coherent DMA.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
-
 /* 6. Setup KERNELBASE mapping in TLB[0]
  *
  * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index 235ae622e2ab..2b6c143d0d8b 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -153,16 +153,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbivax 0,r9
 	TLBSYNC
 
-/*
- * The mapping only needs to be cache-coherent on SMP, except on
- * Freescale e500mc derivatives where it's also needed for coherent DMA.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
-
 #if defined(ENTRY_MAPPING_BOOT_SETUP)
 
 /* 6. Setup KERNELBASE mapping in TLB1[0] */
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 1ad4089dd110..f1bd82ce62fa 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -484,11 +484,6 @@ kexec_create_tlb:
 	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */
 
 /* Set up a temp identity mapping v:0 to p:0 and return to it. */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
 	mtspr	SPRN_MAS0,r9
 
 	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
-- 
2.17.2

