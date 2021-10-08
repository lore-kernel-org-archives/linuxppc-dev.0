Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD4C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 15:44:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B193060F6F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 15:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B193060F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQstd0PYrz3cGG
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 02:44:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQsqV0pX3z3c5Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Oct 2021 02:41:25 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HQsq316Fwz9sSk;
 Fri,  8 Oct 2021 17:41:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WlGDrbB7CtM2; Fri,  8 Oct 2021 17:41:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspx6S5Qz9sSm;
 Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BB3368B786;
 Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 3mWv1WIfLPql; Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E69078B798;
 Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198Feo4t1129692
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 8 Oct 2021 17:40:50 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198Feo2X1129691;
 Fri, 8 Oct 2021 17:40:50 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 13/16] powerpc/kuap: Wire-up KUAP on 40x
Date: Fri,  8 Oct 2021 17:40:41 +0200
Message-Id: <0c4b7e8738d023e4e9c8d3218f104b1e73c930f8.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633707305.git.christophe.leroy@csgroup.eu>
References: <cover.1633707305.git.christophe.leroy@csgroup.eu>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds KUAP support to 40x. This is done by checking
the content of SPRN_PID at the time user pgtable is loaded.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S         | 8 ++++++++
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 7d72ee5ab387..87d322dbed94 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -297,6 +297,10 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 3:
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
+#ifdef CONFIG_PPC_KUAP
+	rlwinm.	r9, r9, 0, 0xff
+	beq	5f			/* Kuap fault */
+#endif
 4:
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
@@ -377,6 +381,10 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 3:
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
+#ifdef CONFIG_PPC_KUAP
+	rlwinm.	r9, r9, 0, 0xff
+	beq	5f			/* Kuap fault */
+#endif
 4:
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 30091551ab24..d703fd8e2feb 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -53,6 +53,7 @@ config 40x
 	select PPC_UDBG_16550
 	select 4xx_SOC
 	select HAVE_PCI
+	select PPC_HAVE_KUAP
 
 config 44x
 	bool "AMCC 44x, 46x or 47x"
-- 
2.31.1

