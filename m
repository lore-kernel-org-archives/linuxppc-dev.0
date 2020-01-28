Return-Path: <SRS0=Ynhu=3R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF5BC32771
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jan 2020 00:21:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956A222527
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jan 2020 00:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="domCpCTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956A222527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4866k91ZkqzDqGN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jan 2020 11:21:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=domCpCTs; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4866gV4TclzDqCw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2020 11:19:34 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id t14so4371957plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2020 16:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3o9Ljrv2OFMBZ5wku5kz1JiDVYgrxI773FBvRA5QFhQ=;
 b=domCpCTs9Z4h0obKKlHsrz3e7GM2VXNR/DiPpfLhSgf0A8e8mK+w8GJkqlrydBihYy
 Gefip/MVhwwNe0VgB3aBwGIaXxok5btzUNlDzcvRUpNNIF5t35ObnQ8HR3FFye9gpcsJ
 zqh2EhQNlo3/yYBG31BEx/cZEXgFXszwoqcrxwJmHYsY4Q7d6Bc3QJUSk7JvQ4HnrVl/
 qDZvXxb8pI8ukl0/LCC0z5nlYdKC3PE6p1nedB03jxfkvtCfvKY9kBceXI3EexSWoYpW
 dIcqp/+//V/1v/9FXP/TGVcItznqgbmTssOZRM3O6XSiBJ5+Z14m7+mrjMxfpoZdPnG3
 5nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3o9Ljrv2OFMBZ5wku5kz1JiDVYgrxI773FBvRA5QFhQ=;
 b=i1tO0PvXqKVNQKOq3iHas5CZueg+zM4tn4KhZ5sR8cBkMF6H6RnRJ2Xy+HEDgMWryZ
 +dIWz6dm0U0lktES+aMqSeHp30kKKaaNlecaA2C+PoC6y9kZlqjJ7QzV/kKNOlsrxWh2
 pUn+TXmbdCsm7Nuvgz39RNg27la+AD/rLOKtyl48YyVXrxvKGL+Hjbb9nYg25EOR0hjJ
 lkxuaoWWaq2k3G1GSeL1E+Q+/F11S4oS/PdFy7iRM0+3OdjCVy2E+rnxtnFX86d7DmlX
 F3PO9glH1E/f1TwWSPDokhscr5TlUVVbYDMGVJ1CEFf/QbFXlBMxIYFzLwCsni140xm+
 ZgKA==
X-Gm-Message-State: APjAAAXZF2VV8kp98J/5L+pYpsTAL7NWdK3W+odaIz2EuzyafTm3iLo2
 v45Gph7OWRHrKCIarQPqNt23p6Mb
X-Google-Smtp-Source: APXvYqyPj5G3E/+clRgJ7vG72KIzBd8zrHb6V/rEzIvTbfgcUP4Db3JX+fCrdv0e/BrEZqYMLYHLag==
X-Received: by 2002:a17:90a:8a08:: with SMTP id
 w8mr1449486pjn.125.1580170771608; 
 Mon, 27 Jan 2020 16:19:31 -0800 (PST)
Received: from bobo.local0.net (203-219-188-70.tpgi.com.au. [203.219.188.70])
 by smtp.gmail.com with ESMTPSA id h3sm250385pjs.0.2020.01.27.16.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 16:19:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: system call implement the bulk of the logic in C
 fix 2 (tabort_syscall)
Date: Tue, 28 Jan 2020 10:18:54 +1000
Message-Id: <20200128001854.195896-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: Michal Suchanek <msuchanek@suse.de>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Another incremental patch which fixes silly tabort_syscall bug that
causes kernel crashes when making system calls in transactional state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S   | 9 +++------
 arch/powerpc/kernel/syscall_64.c | 4 ++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d0bb238805e6..94b3db203ec3 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -165,16 +165,13 @@ syscall_restore_regs:
 	b	.Lsyscall_restore_regs_cont
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-_GLOBAL(tabort_syscall)
+_GLOBAL(tabort_syscall) /* (unsigned long nip, unsigned long msr) */
 	/* Firstly we need to enable TM in the kernel */
 	mfmsr	r10
 	li	r9, 1
 	rldimi	r10, r9, MSR_TM_LG, 63-MSR_TM_LG
 	mtmsrd	r10, 0
 
-	ld	r11,_NIP(r13)
-	ld	r12,_MSR(r13)
-
 	/* tabort, this dooms the transaction, nothing else */
 	li	r9, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
 	TABORT(R9)
@@ -188,8 +185,8 @@ _GLOBAL(tabort_syscall)
 	li	r9, MSR_RI
 	andc	r10, r10, r9
 	mtmsrd	r10, 1
-	mtspr	SPRN_SRR0, r11
-	mtspr	SPRN_SRR1, r12
+	mtspr	SPRN_SRR0, r3
+	mtspr	SPRN_SRR1, r4
 	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 #endif
diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index cfe458adde07..69a4ef13973b 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -15,7 +15,7 @@
 #include <asm/time.h>
 #include <asm/unistd.h>
 
-extern void __noreturn tabort_syscall(void);
+extern void __noreturn tabort_syscall(unsigned long nip, unsigned long msr);
 
 typedef long (*syscall_fn)(long, long, long, long, long, long);
 
@@ -30,7 +30,7 @@ notrace long system_call_exception(long r3, long r4, long r5, long r6, long r7,
 
 	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
 	    unlikely(regs->msr & MSR_TS_T))
-		tabort_syscall();
+		tabort_syscall(regs->nip, regs->msr);
 
 	account_cpu_user_entry();
 
-- 
2.23.0

