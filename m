Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20103C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 02:46:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D0C2087D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 02:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh567oDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D0C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WXKQ28HbzF3Kn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 13:46:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hh567oDp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hh567oDp"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WXGp25xhzF36K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 13:44:17 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id f18-v6so5171904plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=6f+JvuOCz4n5ivoTRCN2AlCI+l7JSVlImLb6JJh3sNo=;
 b=Hh567oDpps+Oi10SxvpoY80pZbcDDo1moBJUFsLWThyE8xUyXbP0UlBIEhTqIH8z47
 YRPu16e2RpqYsVEN/Q1OXpGZ+hUTL0w1SQ3gtpMjwyZGPtso61+WdAEEDBQ1NiKJp99/
 gO7HiKhC8QR5vMyULjCjHfzaGHmCEDd11bkpBZDwnnX0vN9vS8YN/emjdPZaccX7UlKt
 6V8LvBOBP3eDYy/Kvf68F8UKNrqEBgmPejPS+OWrtm1R1GaBboTNBOO1hOgMl1ki5AYs
 TQXfDM0vfx+dNvEpMzBz4cqMYQBOhqm0qjYFbSn5e7tSnpjtDBj+UD+kr/VPeSA3JEWp
 IM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=6f+JvuOCz4n5ivoTRCN2AlCI+l7JSVlImLb6JJh3sNo=;
 b=bfRMeLrE330A7sklCLi89zlP0xbzClaRCl8twDilM94AcAAeGo6Gwx1ywAzJRHLt2q
 mPY/2JlojondUlaCG+fdIOYQznn5g4oVoShJZncnG+DFSrzXg2u9wpkTUyiBd94/ifO0
 UhPWnobS56uTXvJKHst4slvoFf6w7mTQ5x6DMXeqWbF2wRXKXKVsmkP2NA3pKEfAcO8Z
 Iz8N8Fn9LttLkdCuuTD6NBK1Uf/CJ6bJa5pMdcFcalwdIS+H2G1uqURvlr4nfFB/4SWX
 eIoOmVn4iEjHlkKBjBYUW1guHS8wYT16+GRUAA9fRhYLb3ssV1flGtAFvhFiWZ5ObMcV
 jmcQ==
X-Gm-Message-State: ABuFfog70uX2aqQW03plIw1thWgHIvtXfNaO1cbSwb09Ahm6ZCD7u0YN
 Ybv8/kATcmkcK5s8ot7C7X2qpnWA
X-Google-Smtp-Source: ACcGV61Nv85jaX6lTBNEt3wpag5vf/Sr8ZqZrhmANLMvKzVEjX1kaQRQwmHa5K/1JYbwZMeX8a8/wA==
X-Received: by 2002:a17:902:9b89:: with SMTP id
 y9-v6mr4010109plp.239.1539312255266; 
 Thu, 11 Oct 2018 19:44:15 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id s85-v6sm44485734pfi.15.2018.10.11.19.44.12
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Oct 2018 19:44:14 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Fri, 12 Oct 2018 13:14:08 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Use SWITCH_FRAME_SIZE for prom and rtas entry
Date: Fri, 12 Oct 2018 13:14:06 +1030
Message-Id: <20181012024406.20658-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 6c1719942e19 ("powerpc/of: Remove useless register save/restore
when calling OF back") removed the saving of srr0 and srr1 when calling
into OpenFirmware. Commit e31aa453bbc4 ("powerpc: Use LOAD_REG_IMMEDIATE
only for constants on 64-bit") did the same for rtas.

This means we don't need to save the extra stack space and can use
the common SWITCH_FRAME_SIZE.

There were already no users of _SRR0 and _SRR1 so we can remove them
too.

Link: https://github.com/linuxppc/linux/issues/83
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/kernel/asm-offsets.c |  9 ---------
 arch/powerpc/kernel/entry_64.S    | 10 +++++-----
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a6d70fd2e499..2eb4923f8468 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -280,11 +280,6 @@ int main(void)
 	/* Interrupt register frame */
 	DEFINE(INT_FRAME_SIZE, STACK_INT_FRAME_SIZE);
 	DEFINE(SWITCH_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
-#ifdef CONFIG_PPC64
-	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
-	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
-	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
-#endif /* CONFIG_PPC64 */
 	STACK_PT_REGS_OFFSET(GPR0, gpr[0]);
 	STACK_PT_REGS_OFFSET(GPR1, gpr[1]);
 	STACK_PT_REGS_OFFSET(GPR2, gpr[2]);
@@ -328,10 +323,6 @@ int main(void)
 	STACK_PT_REGS_OFFSET(_ESR, dsisr);
 #else /* CONFIG_PPC64 */
 	STACK_PT_REGS_OFFSET(SOFTE, softe);
-
-	/* These _only_ to be used with {PROM,RTAS}_FRAME_SIZE!!! */
-	DEFINE(_SRR0, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs));
-	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
 #endif /* CONFIG_PPC64 */
 
 #if defined(CONFIG_PPC32)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ed6f6c7f4264..7db00ee6be48 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1124,7 +1124,7 @@ _ASM_NOKPROBE_SYMBOL(fast_exception_return);
 _GLOBAL(enter_rtas)
 	mflr	r0
 	std	r0,16(r1)
-        stdu	r1,-RTAS_FRAME_SIZE(r1)	/* Save SP and create stack space. */
+        stdu	r1,-SWITCH_FRAME_SIZE(r1) /* Save SP and create stack space. */
 
 	/* Because RTAS is running in 32b mode, it clobbers the high order half
 	 * of all registers that it saves.  We therefore save those registers
@@ -1256,7 +1256,7 @@ rtas_restore_regs:
 	ld	r8,_DSISR(r1)
 	mtdsisr	r8
 
-        addi	r1,r1,RTAS_FRAME_SIZE	/* Unstack our frame */
+        addi	r1,r1,SWITCH_FRAME_SIZE	/* Unstack our frame */
 	ld	r0,16(r1)		/* get return address */
 
 	mtlr    r0
@@ -1267,7 +1267,7 @@ rtas_restore_regs:
 _GLOBAL(enter_prom)
 	mflr	r0
 	std	r0,16(r1)
-        stdu	r1,-PROM_FRAME_SIZE(r1)	/* Save SP and create stack space */
+        stdu	r1,-SWITCH_FRAME_SIZE(r1) /* Save SP and create stack space */
 
 	/* Because PROM is running in 32b mode, it clobbers the high order half
 	 * of all registers that it saves.  We therefore save those registers
@@ -1324,8 +1324,8 @@ _GLOBAL(enter_prom)
 	REST_10GPRS(22, r1)
 	ld	r4,_CCR(r1)
 	mtcr	r4
-	
-        addi	r1,r1,PROM_FRAME_SIZE
+
+        addi	r1,r1,SWITCH_FRAME_SIZE
 	ld	r0,16(r1)
 	mtlr    r0
         blr
-- 
2.17.1

