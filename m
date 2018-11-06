Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED41C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:44:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543E520862
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543E520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8Pv1nkgzF39R
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 23:44:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8FY0k2vzDrP0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:37:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42q8FW0rJWz9sBN; Tue,  6 Nov 2018 23:37:19 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42q8FV3jyhz9s9J; Tue,  6 Nov 2018 23:37:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/mm/64s: Use PPC_SLBFEE macro
Date: Tue,  6 Nov 2018 23:37:08 +1100
Message-Id: <20181106123709.940-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181106123709.940-1-mpe@ellerman.id.au>
References: <20181106123709.940-1-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Old toolchains don't know about slbfee and break the build, eg:
  {standard input}:37: Error: Unrecognized opcode: `slbfee.'

Fix it by using the macro version. We need to add an underscore
version that takes raw register numbers from the inline asm, rather
than our Rx macros.

Fixes: e15a4fea4dee ("powerpc/64s/hash: Add some SLB debugging tests")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc-opcode.h | 2 ++
 arch/powerpc/mm/slb.c                 | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 6093bc8f74e5..a6e9e314c707 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -493,6 +493,8 @@
 					__PPC_RS(t) | __PPC_RA0(a) | __PPC_RB(b))
 #define PPC_SLBFEE_DOT(t, b)	stringify_in_c(.long PPC_INST_SLBFEE | \
 					__PPC_RT(t) | __PPC_RB(b))
+#define __PPC_SLBFEE_DOT(t, b)	stringify_in_c(.long PPC_INST_SLBFEE |	\
+					       ___PPC_RT(t) | ___PPC_RB(b))
 #define PPC_ICBT(c,a,b)		stringify_in_c(.long PPC_INST_ICBT | \
 				       __PPC_CT(c) | __PPC_RA0(a) | __PPC_RB(b))
 /* PASemi instructions */
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index f3e002ee457b..457fd29448b1 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -19,6 +19,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
+#include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
 #include <asm/smp.h>
@@ -65,7 +66,7 @@ static void assert_slb_presence(bool present, unsigned long ea)
 
 	WARN_ON_ONCE(mfmsr() & MSR_EE);
 
-	asm volatile("slbfee. %0, %1" : "=r"(tmp) : "r"(ea) : "cr0");
+	asm volatile(__PPC_SLBFEE_DOT(%0, %1) : "=r"(tmp) : "r"(ea) : "cr0");
 
 	WARN_ON(present == (tmp == 0));
 #endif
-- 
2.17.2

