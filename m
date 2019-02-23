Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB430C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 03:17:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABA3206A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 03:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABA3206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445tfs4df1zDqXX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 14:17:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445tcn2PMGzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 14:15:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 445tcn0gqWz9s71; Sat, 23 Feb 2019 14:15:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445tcm4QVpz9s9L; Sat, 23 Feb 2019 14:15:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/kvm: Save and restore host AMR/IAMR/UAMOR
Date: Sat, 23 Feb 2019 14:15:12 +1100
Message-Id: <20190223031512.2972-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: paulus@samba.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When the hash MMU is active the AMR, IAMR and UAMOR are used for
pkeys. The AMR is directly writable by user space, and the UAMOR masks
those writes, meaning both registers are effectively user register
state. The IAMR is used to create an execute only key.

Also we must maintain the value of at least the AMR when running in
process context, so that any memory accesses done by the kernel on
behalf of the process are correctly controlled by the AMR.

Although we are correctly switching all registers when going into a
guest, on returning to the host we just write 0 into all regs, except
on Power9 where we restore the IAMR correctly.

This could be observed by a user process if it writes the AMR, then
runs a guest and we then return immediately to it without
rescheduling. Because we have written 0 to the AMR that would have the
effect of granting read/write permission to pages that the process was
trying to protect.

In addition, when using the Radix MMU, the AMR can prevent inadvertent
kernel access to userspace data, writing 0 to the AMR disables that
protection.

So save and restore AMR, IAMR and UAMOR.

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 26 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

v2: Restore AMR, UAMOR and IAMR.

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f24f6a2f8eb5..25043b50cb30 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -58,6 +58,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #define STACK_SLOT_DAWR		(SFS-56)
 #define STACK_SLOT_DAWRX	(SFS-64)
 #define STACK_SLOT_HFSCR	(SFS-72)
+#define STACK_SLOT_AMR		(SFS-80)
+#define STACK_SLOT_UAMOR	(SFS-88)
 /* the following is used by the P9 short path */
 #define STACK_SLOT_NVGPRS	(SFS-152)	/* 18 gprs */
 
@@ -726,11 +728,9 @@ BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_TIDR
 	mfspr	r6, SPRN_PSSCR
 	mfspr	r7, SPRN_PID
-	mfspr	r8, SPRN_IAMR
 	std	r5, STACK_SLOT_TID(r1)
 	std	r6, STACK_SLOT_PSSCR(r1)
 	std	r7, STACK_SLOT_PID(r1)
-	std	r8, STACK_SLOT_IAMR(r1)
 	mfspr	r5, SPRN_HFSCR
 	std	r5, STACK_SLOT_HFSCR(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
@@ -738,11 +738,18 @@ BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_CIABR
 	mfspr	r6, SPRN_DAWR
 	mfspr	r7, SPRN_DAWRX
+	mfspr	r8, SPRN_IAMR
 	std	r5, STACK_SLOT_CIABR(r1)
 	std	r6, STACK_SLOT_DAWR(r1)
 	std	r7, STACK_SLOT_DAWRX(r1)
+	std	r8, STACK_SLOT_IAMR(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
+	mfspr	r5, SPRN_AMR
+	std	r5, STACK_SLOT_AMR(r1)
+	mfspr	r6, SPRN_UAMOR
+	std	r6, STACK_SLOT_UAMOR(r1)
+
 BEGIN_FTR_SECTION
 	/* Set partition DABR */
 	/* Do this before re-enabling PMU to avoid P7 DABR corruption bug */
@@ -1631,22 +1638,25 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_PSPB, r0
 	mtspr	SPRN_WORT, r0
 BEGIN_FTR_SECTION
-	mtspr	SPRN_IAMR, r0
 	mtspr	SPRN_TCSCR, r0
 	/* Set MMCRS to 1<<31 to freeze and disable the SPMC counters */
 	li	r0, 1
 	sldi	r0, r0, 31
 	mtspr	SPRN_MMCRS, r0
 END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
-8:
 
-	/* Save and reset AMR and UAMOR before turning on the MMU */
+	/* Save and restore AMR, IAMR and UAMOR before turning on the MMU */
+	ld	r8, STACK_SLOT_IAMR(r1)
+	mtspr	SPRN_IAMR, r8
+
+8:	/* Power7 jumps back in here */
 	mfspr	r5,SPRN_AMR
 	mfspr	r6,SPRN_UAMOR
 	std	r5,VCPU_AMR(r9)
 	std	r6,VCPU_UAMOR(r9)
-	li	r6,0
-	mtspr	SPRN_AMR,r6
+	ld	r5,STACK_SLOT_AMR(r1)
+	ld	r6,STACK_SLOT_UAMOR(r1)
+	mtspr	SPRN_AMR, r5
 	mtspr	SPRN_UAMOR, r6
 
 	/* Switch DSCR back to host value */
@@ -1746,11 +1756,9 @@ BEGIN_FTR_SECTION
 	ld	r5, STACK_SLOT_TID(r1)
 	ld	r6, STACK_SLOT_PSSCR(r1)
 	ld	r7, STACK_SLOT_PID(r1)
-	ld	r8, STACK_SLOT_IAMR(r1)
 	mtspr	SPRN_TIDR, r5
 	mtspr	SPRN_PSSCR, r6
 	mtspr	SPRN_PID, r7
-	mtspr	SPRN_IAMR, r8
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 #ifdef CONFIG_PPC_RADIX_MMU
-- 
2.20.1

