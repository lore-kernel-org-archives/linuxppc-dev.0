Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F56FECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:07:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8CD20869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8CD20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bxms5wQ1zDrPt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:07:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxVv3bvKzF3TT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxVq2Kwdz9ttFT;
 Fri, 19 Oct 2018 08:54:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id jzC2x4oMcXs1; Fri, 19 Oct 2018 08:54:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxVq1rBnz9ttFM;
 Fri, 19 Oct 2018 08:54:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7218C8B8DF;
 Fri, 19 Oct 2018 08:55:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id YYOXmQZDdf1L; Fri, 19 Oct 2018 08:55:00 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4995A8B75B;
 Fri, 19 Oct 2018 08:55:00 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 384D96F496; Fri, 19 Oct 2018 06:55:00 +0000 (UTC)
Message-Id: <f316a86ad5d06d16b250ccffa5d9fc5ea74a58d2.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 04/20] powerpc/mm: move platform specific mmu-xxx.h in
 platform directories
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:00 +0000 (UTC)
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

The purpose of this patch is to move platform specific
mmu-xxx.h files in platform directories like pte-xxx.h files.

In the meantime this patch creates common nohash and
nohash/32 + nohash/64 mmu.h files for future common parts.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h                     | 14 ++------------
 arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h |  0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h |  0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h |  0
 arch/powerpc/include/asm/nohash/32/mmu.h           | 19 +++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/mmu.h           |  8 ++++++++
 arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h |  0
 arch/powerpc/include/asm/nohash/mmu.h              | 11 +++++++++++
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |  2 +-
 arch/powerpc/kvm/e500.h                            |  2 +-
 10 files changed, 42 insertions(+), 14 deletions(-)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
 rename arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/mmu.h

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb20eb3b8fb0..2184021b0e1c 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -341,18 +341,8 @@ static inline void mmu_early_init_devtree(void) { }
 #if defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
-#elif defined(CONFIG_40x)
-/* 40x-style software loaded TLB */
-#  include <asm/mmu-40x.h>
-#elif defined(CONFIG_44x)
-/* 44x-style software loaded TLB */
-#  include <asm/mmu-44x.h>
-#elif defined(CONFIG_PPC_BOOK3E_MMU)
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#  include <asm/mmu-book3e.h>
-#elif defined (CONFIG_PPC_8xx)
-/* Motorola/Freescale 8xx software loaded TLB */
-#  include <asm/mmu-8xx.h>
+#elif defined(CONFIG_PPC_MMU_NOHASH)
+#include <asm/nohash/mmu.h>
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-40x.h
rename to arch/powerpc/include/asm/nohash/32/mmu-40x.h
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-44x.h
rename to arch/powerpc/include/asm/nohash/32/mmu-44x.h
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-8xx.h
rename to arch/powerpc/include/asm/nohash/32/mmu-8xx.h
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
new file mode 100644
index 000000000000..af0e8b54876a
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
+#define _ASM_POWERPC_NOHASH_32_MMU_H_
+
+#if defined(CONFIG_40x)
+/* 40x-style software loaded TLB */
+#include <asm/nohash/32/mmu-40x.h>
+#elif defined(CONFIG_44x)
+/* 44x-style software loaded TLB */
+#include <asm/nohash/32/mmu-44x.h>
+#elif defined(CONFIG_PPC_BOOK3E_MMU)
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+#elif defined (CONFIG_PPC_8xx)
+/* Motorola/Freescale 8xx software loaded TLB */
+#include <asm/nohash/32/mmu-8xx.h>
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
new file mode 100644
index 000000000000..87871d027b75
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
+#define _ASM_POWERPC_NOHASH_64_MMU_H_
+
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+
+#endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-book3e.h
rename to arch/powerpc/include/asm/nohash/mmu-book3e.h
diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
new file mode 100644
index 000000000000..a037cb1efb57
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/mmu.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_MMU_H_
+#define _ASM_POWERPC_NOHASH_MMU_H_
+
+#ifdef CONFIG_PPC64
+#include <asm/nohash/64/mmu.h>
+#else
+#include <asm/nohash/32/mmu.h>
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_MMU_H_ */
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 8d142e5d84cd..5fbc890d1094 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -17,7 +17,7 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/asm-offsets.h>
 #include <asm/mpc85xx.h>
 
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 94f04fcb373e..962ee90a0dfe 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -20,7 +20,7 @@
 #define KVM_E500_H
 
 #include <linux/kvm_host.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/tlb.h>
 #include <asm/cputhreads.h>
 
-- 
2.13.3

