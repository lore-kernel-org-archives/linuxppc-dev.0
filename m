Return-Path: <SRS0=+cnT=UT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A8C43613
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 05:38:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BF5208CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 05:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZeKXQJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BF5208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TrGP2xTJzDqnv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 15:38:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VZeKXQJz"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TqlK0w32zDqvr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 15:15:25 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id v9so902452pgr.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qJYd4Fzo01LZa1f6RLpal/VSttptbtaAkqirfv/VL9A=;
 b=VZeKXQJzxQ3aB/GHOIZUP3pIyXGMy/MIW//6XmfTvFyNY70TrBsCtAdl9NGUkl7D2I
 zwh0c6l/5aOF/BiDxoffE57GHnm5aLky8Iav5rEkFF+tqqs9C44zp9MYgDGxW5gV6p9M
 fj76xIP1b7Y/wtMG+BbzV7JyFX0HaSzwnyAckCrKhyq6PzM9f4LjOtjfXlLFQ0Oo/fpA
 zdcgw8GVjn0CPVjTz9RzxnDzH3/Z3SMV23+C8vm1BVbHAAS0xpMVFCOqm02V5Y46HtrC
 GjJrtz+lgwsC47r54RAQoQup8a7pfHKE17WO59CDC7jyujictBTedSo8UbV+rBGLu3vf
 wz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qJYd4Fzo01LZa1f6RLpal/VSttptbtaAkqirfv/VL9A=;
 b=R7O3e+3AvrZ7J0PxGz+Iw31RogsLpVSvXnwAAYUGqag1nM++iEvcyKUBTGJtp61gAY
 cSb0e2+NvNQDULUWdLdReg/KoZ43PwPkdd0xf3BpHj9OZ0Xd7stwNHLHOCLd4VPbDJZl
 xgN4mDx1H7fboUqBeydOE7ttPzpHS9RQAJASLbzcQe9jjfVsNhc59KhaC9gm9yVpDJWD
 ohuqYN0OBErLnW6VSC2q0m64eFUwkNQ1K8BGYOmshKRenGPEHs/DwP5oJjbBjR3s5QqQ
 awX4nz9UVjgEzyPr8pyQjdo/FiT4GChk37M/+TdsYBKzSQtXHAakKxsQdRE3kzF2MAnr
 A8rg==
X-Gm-Message-State: APjAAAXbrnh2luDVjXIZCTvQhhncE08I/s23C0HhdZpiOC+TmMREOOR1
 ruCVawT+kdheXkOqvSDZOO3aa4n7
X-Google-Smtp-Source: APXvYqwv5HIlfQc3S60VoFZ5s60E7nHbgfE873cnHrInJgs0NZsSiESgF3kFufGLSKuvc3zJ3Mz6sA==
X-Received: by 2002:a63:5152:: with SMTP id r18mr11217691pgl.324.1561007721904; 
 Wed, 19 Jun 2019 22:15:21 -0700 (PDT)
Received: from bobo.local0.net (193-116-72-140.tpgi.com.au. [193.116.72.140])
 by smtp.gmail.com with ESMTPSA id
 h12sm8235847pje.12.2019.06.19.22.15.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 22:15:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/52] powerpc/64s/exception: Move EXCEPTION_COMMON handler
 and return branches into callers
Date: Thu, 20 Jun 2019 15:14:18 +1000
Message-Id: <20190620051459.29573-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620051459.29573-1-npiggin@gmail.com>
References: <20190620051459.29573-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The aim is to reduce the amount of indirection it takes to get through
the exception handler macros, particularly where it provides little
code sharing.

No generated code change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 26 ++++++++++++------------
 arch/powerpc/kernel/exceptions-64s.S     | 21 +++++++++++--------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index f19c2391cc36..cc65e87cff2f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -658,31 +658,28 @@ BEGIN_FTR_SECTION				\
 	beql	ppc64_runlatch_on_trampoline;	\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
-#define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
+#define EXCEPTION_COMMON(area, trap, label, additions)		\
 	EXCEPTION_PROLOG_COMMON(trap, area);			\
 	/* Volatile regs are potentially clobbered here */	\
-	additions;						\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr;						\
-	b	ret
+	additions
 
 /*
  * Exception where stack is already set in r1, r1 is saved in r10, and it
  * continues rather than returns.
  */
-#define EXCEPTION_COMMON_NORET_STACK(area, trap, label, hdlr, additions) \
+#define EXCEPTION_COMMON_NORET_STACK(area, trap, label, additions) \
 	EXCEPTION_PROLOG_COMMON_1();				\
 	kuap_save_amr_and_lock r9, r10, cr1;			\
 	EXCEPTION_PROLOG_COMMON_2(area);			\
 	EXCEPTION_PROLOG_COMMON_3(trap);			\
 	/* Volatile regs are potentially clobbered here */	\
-	additions;						\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr
+	additions
 
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
-		ret_from_except, ADD_NVGPRS;ADD_RECONCILE)
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label, ADD_NVGPRS;ADD_RECONCILE); \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	bl	hdlr;						\
+	b	ret_from_except
 
 /*
  * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
@@ -690,8 +687,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
  * (finish nap and runlatch)
  */
 #define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
-		ret_from_except_lite, FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label,		\
+		FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON);		\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	bl	hdlr;						\
+	b	ret_from_except_lite
 
 /*
  * When the idle code in power4_idle puts the CPU into NAP mode,
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 02d974b71f44..87c4ebeb950c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -195,9 +195,10 @@ EXC_COMMON_BEGIN(system_reset_common)
 	mr	r10,r1
 	ld	r1,PACA_NMI_EMERG_SP(r13)
 	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100,
-			system_reset, system_reset_exception,
-			ADD_NVGPRS;ADD_RECONCILE_NMI)
+	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100, system_reset,
+					ADD_NVGPRS;ADD_RECONCILE_NMI)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	system_reset_exception
 
 	/* This (and MCE) can be simplified with mtmsrd L=1 */
 	/* Clear MSR_RI before setting SRR0 and SRR1. */
@@ -1171,8 +1172,11 @@ hmi_exception_after_realmode:
 	b	tramp_real_hmi_exception
 
 EXC_COMMON_BEGIN(hmi_exception_common)
-EXCEPTION_COMMON(PACA_EXGEN, 0xe60, hmi_exception_common, handle_hmi_exception,
-        ret_from_except, FINISH_NAP;ADD_NVGPRS;ADD_RECONCILE;RUNLATCH_ON)
+EXCEPTION_COMMON(PACA_EXGEN, 0xe60, hmi_exception_common,
+			FINISH_NAP;ADD_NVGPRS;ADD_RECONCILE;RUNLATCH_ON)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	handle_hmi_exception
+	b	ret_from_except
 
 EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0x20, IRQS_DISABLED)
 EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x20, 0xe80, IRQS_DISABLED)
@@ -1467,9 +1471,10 @@ EXC_COMMON_BEGIN(soft_nmi_common)
 	mr	r10,r1
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXGEN, 0x900,
-			system_reset, soft_nmi_interrupt,
-			ADD_NVGPRS;ADD_RECONCILE)
+	EXCEPTION_COMMON_NORET_STACK(PACA_EXGEN, 0x900, system_reset,
+					ADD_NVGPRS;ADD_RECONCILE)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	soft_nmi_interrupt
 	b	ret_from_except
 
 #else /* CONFIG_PPC_WATCHDOG */
-- 
2.20.1

