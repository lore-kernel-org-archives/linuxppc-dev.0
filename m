Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E2C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Oct 2021 07:37:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D96460FD9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Oct 2021 07:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D96460FD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HYQZK1lv0z3cbR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Oct 2021 18:37:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HYQQx31c1z3dcL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Oct 2021 18:31:21 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HYQPY2HVDz9sT5;
 Tue, 19 Oct 2021 09:30:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fv-MPlPslamJ; Tue, 19 Oct 2021 09:30:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HYQP80BFFz9sT6;
 Tue, 19 Oct 2021 09:29:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E55878B775;
 Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kVuUxg9R5CBz; Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.71])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 49C6E8B779;
 Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19J7Te4U3188470
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 Oct 2021 09:29:40 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19J7TeS93188469;
 Tue, 19 Oct 2021 09:29:40 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 18/22] powerpc/kuap: Wire-up KUAP on 44x
Date: Tue, 19 Oct 2021 09:29:29 +0200
Message-Id: <7d6c3f1978a26feada74b084f651e8cf1e3b3a47.1634627931.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634627931.git.christophe.leroy@csgroup.eu>
References: <cover.1634627931.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634628571; l=2044; s=20211009;
 h=from:subject:message-id; bh=qnWgsTBhp2/xbFG2w1Xw3W4LrJUJu4X5eUtc2j1aZqA=;
 b=ZSnO6WtCIUURl8ZRfSOeDtNBputZGtGCW2IibNcHOLAWZTEXzy8wzxjCGt3xkEi4Y+o/fKjn1+ig
 u6VFWJDZB+w0DtZ7YETJ5N04EOWc/1nkeweuYwj3KaYXrPalTY4B
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds KUAP support to 44x. This is done by checking
the content of SPRN_PID at the time it is read and written
into SPRN_MMUCR.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_44x.S         | 16 ++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 916f7e91c6de..b73a56466903 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -334,6 +334,10 @@ interrupt_base:
 	mfspr	r12,SPRN_MMUCR
 	mfspr   r13,SPRN_PID		/* Get PID */
 	rlwimi	r12,r13,0,24,31		/* Set TID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r13,0
+	beq	2f			/* KUAP Fault */
+#endif
 
 4:
 	mtspr	SPRN_MMUCR,r12
@@ -444,6 +448,10 @@ interrupt_base:
 	mfspr	r12,SPRN_MMUCR
 	mfspr   r13,SPRN_PID		/* Get PID */
 	rlwimi	r12,r13,0,24,31		/* Set TID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r13,0
+	beq	2f			/* KUAP Fault */
+#endif
 
 4:
 	mtspr	SPRN_MMUCR,r12
@@ -572,6 +580,10 @@ finish_tlb_load_44x:
 3:	mfspr	r11,SPRN_SPRG3
 	lwz	r11,PGDIR(r11)
 	mfspr   r12,SPRN_PID		/* Get PID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r12,0
+	beq	2f			/* KUAP Fault */
+#endif
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
 
 	/* Mask of required permission bits. Note that while we
@@ -669,6 +681,10 @@ finish_tlb_load_44x:
 3:	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 	mfspr   r12,SPRN_PID		/* Get PID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r12,0
+	beq	2f			/* KUAP Fault */
+#endif
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
 
 	/* Make up the required permissions */
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index fad34f28bd3a..e989eeca4c7e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -64,6 +64,7 @@ config 44x
 	select PHYS_64BIT
 	select PPC_HAVE_KUEP
 	select PPC_KUEP
+	select PPC_HAVE_KUAP
 
 endchoice
 
-- 
2.31.1

