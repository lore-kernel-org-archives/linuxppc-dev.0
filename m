Return-Path: <SRS0=hK36=HL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 11:05:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFA964E30
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 11:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFA964E30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZg5p3vQFzDvVR
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 22:05:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZdbJ50YRzDqqk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2021 20:57:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DZdbD65Z5z9txgW;
 Tue,  9 Feb 2021 10:56:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id UaZ8rU5Z4NAB; Tue,  9 Feb 2021 10:56:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdbD5MRWz9txg8;
 Tue,  9 Feb 2021 10:56:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A1A858B7D6;
 Tue,  9 Feb 2021 10:56:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MBq71Stc_Rs1; Tue,  9 Feb 2021 10:56:57 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 58A7A8B7D4;
 Tue,  9 Feb 2021 10:56:57 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2526567342; Tue,  9 Feb 2021 09:56:57 +0000 (UTC)
Message-Id: <b4df2320aad07b2fe1ea8e10de9a4d5c0186974b.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 32/41] powerpc/32: Refactor saving of volatile
 registers in exception prologs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com
Date: Tue,  9 Feb 2021 09:56:57 +0000 (UTC)
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

Exception prologs all do the same at the end:
- Save trapno in stack
- Mark stack with exception marker
- Save r0
- Save r3 to r8

Refactor that into a COMMON_EXCEPTION_PROLOG_END macro.
At the same time use r1 instead of r11.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h    | 14 +++++++++-----
 arch/powerpc/kernel/head_40x.S   |  9 +--------
 arch/powerpc/kernel/head_booke.h | 26 +++++++++++++-------------
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 84e6251622e8..12c39178a1d2 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -104,14 +104,18 @@
 	li	r10, MSR_KERNEL		/* can take exceptions */
 	mtmsr	r10			/* (except for mach check in rtas) */
 #endif
-	stw	r0,GPR0(r11)
+	COMMON_EXCEPTION_PROLOG_END \trapno
+.endm
+
+.macro COMMON_EXCEPTION_PROLOG_END trapno
+	stw	r0,GPR0(r1)
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l
-	stw	r10,8(r11)
+	stw	r10,8(r1)
 	li	r10, \trapno
-	stw	r10,_TRAP(r11)
-	SAVE_4GPRS(3, r11)
-	SAVE_2GPRS(7, r11)
+	stw	r10,_TRAP(r1)
+	SAVE_4GPRS(3, r1)
+	SAVE_2GPRS(7, r1)
 _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 .endm
 
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 52b40bf529c6..e1360b88b6cb 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -157,14 +157,7 @@ _ENTRY(crit_esr)
 	mfspr	r12,SPRN_SRR2
 	mfspr	r9,SPRN_SRR3
 	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?)	   */
-	stw	r0,GPR0(r11)
-	lis	r10, STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l
-	stw	r10, 8(r11)
-	li	r10, \trapno + 2
-	stw	r10,_TRAP(r11)
-	SAVE_4GPRS(3, r11)
-	SAVE_2GPRS(7, r11)
+	COMMON_EXCEPTION_PROLOG_END \trapno + 2
 _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 .endm
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 7c8195ae95c4..7e47b5dfdd9c 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -78,14 +78,18 @@ END_BTB_FLUSH_SECTION
 	stw	r1, 0(r11);						     \
 	mr	r1, r11;						     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
-	stw	r0,GPR0(r11);						     \
-	lis	r10, STACK_FRAME_REGS_MARKER@ha;/* exception frame marker */ \
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
-	stw	r10, 8(r11);						     \
-	li	r10, trapno;						     \
-	stw	r10,_TRAP(r11);						     \
-	SAVE_4GPRS(3, r11);						     \
-	SAVE_2GPRS(7, r11)
+	COMMON_EXCEPTION_PROLOG_END trapno
+
+.macro COMMON_EXCEPTION_PROLOG_END trapno
+	stw	r0,GPR0(r1)
+	lis	r10, STACK_FRAME_REGS_MARKER@ha	/* exception frame marker */
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l
+	stw	r10, 8(r1)
+	li	r10, trapno
+	stw	r10,_TRAP(r1)
+	SAVE_4GPRS(3, r1)
+	SAVE_2GPRS(7, r1)
+.end
 
 .macro prepare_transfer_to_handler
 	bl	prepare_transfer_to_handler
@@ -231,11 +235,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	stw	r1,0(r11);						     \
 	mr	r1,r11;							     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
-	li	r10, trapno;						     \
-	stw	r10,_TRAP(r11);						     \
-	stw	r0,GPR0(r11);						     \
-	SAVE_4GPRS(3, r11);						     \
-	SAVE_2GPRS(7, r11)
+	COMMON_EXCEPTION_PROLOG_END trapno
 
 .macro SAVE_xSRR xSRR
 	mfspr	r0,SPRN_\xSRR\()0
-- 
2.25.0

