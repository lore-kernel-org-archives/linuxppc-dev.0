Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6ACC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 12:52:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D9D61039
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 12:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89D9D61039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HPZ9T1pMlz3dqk
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 23:52:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HPZ5K3Bl2z2ywQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Oct 2021 23:48:53 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HPZ4X6vRDz9sVY;
 Wed,  6 Oct 2021 14:48:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4KpPEue7jEus; Wed,  6 Oct 2021 14:48:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HPZ4M4xL5z9sWH;
 Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9158E8B781;
 Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id c18w1kzNLOoe; Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AA0BF8B78D;
 Wed,  6 Oct 2021 14:48:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 196ClppY579416
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 6 Oct 2021 14:47:52 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 196ChscL579291;
 Wed, 6 Oct 2021 14:43:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v1 11/15] powerpc/kuap: Wire-up KUAP on 44x
Date: Wed,  6 Oct 2021 14:43:44 +0200
Message-Id: <6f7dfafe22d5d681135c7e66a39d860d3963b862.1633523837.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633523837.git.christophe.leroy@csgroup.eu>
References: <cover.1633523837.git.christophe.leroy@csgroup.eu>
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

This adds KUAP support to 44x. This is done by checking
the content of SPRN_PID at the time it is read and written
into SPRN_MMUCR.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_44x.S         | 16 ++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 02d2928d1e01..cf92a3434acd 100644
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
@@ -575,6 +583,10 @@ finish_tlb_load_44x:
 3:	mfspr	r11,SPRN_SPRG3
 	lwz	r11,PGDIR(r11)
 	mfspr   r12,SPRN_PID		/* Get PID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r12,0
+	beq	2f			/* KUAP Fault */
+#endif
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
 
 	/* Mask of required permission bits. Note that while we
@@ -672,6 +684,10 @@ finish_tlb_load_44x:
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
index dce1cf31047b..74e5887abbce 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -62,6 +62,7 @@ config 44x
 	select HAVE_PCI
 	select PHYS_64BIT
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 
 endchoice
 
-- 
2.31.1

