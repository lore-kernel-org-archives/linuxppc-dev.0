Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E661C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:52:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1682B2133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1682B2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449FsG43TJzDqTx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:52:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449FnK0qmBzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 01:49:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 449FnJ60KNz9s6w; Fri,  1 Mar 2019 01:49:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 449FnJ56hsz9s71; Fri,  1 Mar 2019 01:49:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 2/9] powerpc/powernv/idle: Restore AMR/UAMOR/AMOR after idle
Date: Fri,  1 Mar 2019 01:49:10 +1100
Message-Id: <20190228144917.16876-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228144917.16876-1-mpe@ellerman.id.au>
References: <20190228144917.16876-1-mpe@ellerman.id.au>
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
Cc: akshay.adiga@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In order to implement KUAP (Kernel Userspace Access Protection) on
Power9 we will be using the AMR, and therefore indirectly the
UAMOR/AMOR.

So save/restore these regs in the idle code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/idle_book3s.S | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

v4: New.

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 36178000a2f2..4a860d3b9229 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -170,8 +170,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	bne-	core_idle_lock_held
 	blr
 
-/* Reuse an unused pt_regs slot for IAMR */
+/* Reuse some unused pt_regs slots for AMR/IAMR/UAMOR/UAMOR */
+#define PNV_POWERSAVE_AMR	_TRAP
 #define PNV_POWERSAVE_IAMR	_DAR
+#define PNV_POWERSAVE_UAMOR	_DSISR
+#define PNV_POWERSAVE_AMOR	RESULT
 
 /*
  * Pass requested state in r3:
@@ -205,8 +208,16 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	SAVE_NVGPRS(r1)
 
 BEGIN_FTR_SECTION
+	mfspr	r4, SPRN_AMR
 	mfspr	r5, SPRN_IAMR
+	mfspr	r6, SPRN_UAMOR
+	std	r4, PNV_POWERSAVE_AMR(r1)
 	std	r5, PNV_POWERSAVE_IAMR(r1)
+	std	r6, PNV_POWERSAVE_UAMOR(r1)
+BEGIN_FTR_SECTION_NESTED(42)
+	mfspr	r7, SPRN_AMOR
+	std	r7, PNV_POWERSAVE_AMOR(r1)
+END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
 	mfcr	r5
@@ -935,12 +946,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_GPR(2, r1)
 
 BEGIN_FTR_SECTION
-	/* IAMR was saved in pnv_powersave_common() */
+	/* These regs were saved in pnv_powersave_common() */
+	ld	r4, PNV_POWERSAVE_AMR(r1)
 	ld	r5, PNV_POWERSAVE_IAMR(r1)
+	ld	r6, PNV_POWERSAVE_UAMOR(r1)
+	mtspr	SPRN_AMR, r4
 	mtspr	SPRN_IAMR, r5
+	mtspr	SPRN_UAMOR, r6
+BEGIN_FTR_SECTION_NESTED(42)
+	ld	r7, PNV_POWERSAVE_AMOR(r1)
+	mtspr	SPRN_AMOR, r7
+END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
 	/*
-	 * We don't need an isync here because the upcoming mtmsrd is
-	 * execution synchronizing.
+	 * We don't need an isync here after restoring IAMR because the upcoming
+	 * mtmsrd is execution synchronizing.
 	 */
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
-- 
2.20.1

