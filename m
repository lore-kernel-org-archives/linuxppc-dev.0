Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EFFC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Oct 2021 07:39:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9AB60FD9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Oct 2021 07:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA9AB60FD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HYQcL363kz3cVP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Oct 2021 18:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HYQRF6py4z3cPj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Oct 2021 18:31:37 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HYQPd3jrjz9sT9;
 Tue, 19 Oct 2021 09:30:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AKGJQN7DE-Yn; Tue, 19 Oct 2021 09:30:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HYQP819njz9sTD;
 Tue, 19 Oct 2021 09:29:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E4838B775;
 Tue, 19 Oct 2021 09:29:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2jZeURx9P_0S; Tue, 19 Oct 2021 09:29:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.71])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A9398B77B;
 Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19J7Tf013188478
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 Oct 2021 09:29:41 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19J7Tfse3188477;
 Tue, 19 Oct 2021 09:29:41 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 20/22] powerpc/kuap: Wire-up KUAP on 85xx in 32 bits mode.
Date: Tue, 19 Oct 2021 09:29:31 +0200
Message-Id: <f8696f8980ca1532ada3a2f0e0a03e756269c7fe.1634627931.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634627931.git.christophe.leroy@csgroup.eu>
References: <cover.1634627931.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634628571; l=1685; s=20211009;
 h=from:subject:message-id; bh=J1J7ZXwdkDiJFq4NXO9q71rKXXtH/9QJY9ZvF65BJWk=;
 b=B/Bh6yAQXN/30bptJ7jGyC9m5IYMJp1NcMzPlDArAV0riesyc2CZXp81bmsWEKPESey5jc6RLfI0
 k+ZXEpRzC7U8iX1VtKwxKdcdNDlD075NmECom6xYOzzKIU4qQ2MW
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

This adds KUAP support to 85xx in 32 bits mode.
This is done by reading the content of SPRN_MAS1 and checking
the TID at the time user pgtable is loaded.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_fsl_booke.S   | 12 ++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 4622b50a5208..ac2b4dcf5fd3 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -462,6 +462,12 @@ END_BTB_FLUSH_SECTION
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
+#ifdef CONFIG_PPC_KUAP
+	mfspr	r12, SPRN_MAS1
+	rlwinm.	r12,r12,0,0x3fff0000
+	beq	2f			/* KUAP fault */
+#endif
+
 4:
 	/* Mask of required permission bits. Note that while we
 	 * do copy ESR:ST to _PAGE_RW position as trying to write
@@ -571,6 +577,12 @@ END_BTB_FLUSH_SECTION
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
+#ifdef CONFIG_PPC_KUAP
+	mfspr	r12, SPRN_MAS1
+	rlwinm.	r12,r12,0,0x3fff0000
+	beq	2f			/* KUAP fault */
+#endif
+
 	/* Make up the required permissions for user code */
 #ifdef CONFIG_PTE_64BIT
 	li	r13,_PAGE_PRESENT | _PAGE_BAP_UX
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 3ea415bcf9b8..611d6efc047b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -37,6 +37,7 @@ config PPC_BOOK3S_32
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
+	select PPC_HAVE_KUAP
 
 config PPC_8xx
 	bool "Freescale 8xx"
-- 
2.31.1

