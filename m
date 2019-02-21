Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C307BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:30:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332AD2077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cwzK+Mgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332AD2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4454MM2Z3NzDq64
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 06:30:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="cwzK+Mgp"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4453sw2ddXzDqRg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:08:52 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4453ss26Plz9v9DJ;
 Thu, 21 Feb 2019 20:08:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=cwzK+Mgp; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 6WulGeij27Uo; Thu, 21 Feb 2019 20:08:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4453ss148vz9v9DG;
 Thu, 21 Feb 2019 20:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550776129; bh=CIDCQplRaPuHh8Jod9JMYw1VsHVW6X2UEb3TMqnZNuo=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=cwzK+Mgpyfu/GfhKM815cIMVeHZJJfW6j2OPd03nKtndujvqFTKUwqfPlumlZ5pIB
 agTnr3Wcs2AJu5Az7U5L7kJ+YNQxoqkol/oxmJkc2z4tF+UQ9Locm87ktDm4UsWBxy
 wtDBMvg4du65IuAdDlQuZTXAsUWdUqIj5oTYl2xg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2676D8B86A;
 Thu, 21 Feb 2019 20:08:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id G8b9ZjZa_Kpf; Thu, 21 Feb 2019 20:08:49 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E13D58B852;
 Thu, 21 Feb 2019 20:08:48 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A99DB6EF61; Thu, 21 Feb 2019 19:08:48 +0000 (UTC)
Message-Id: <a99cf894a8b80ae914550af6a711319430425a71.1550775950.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550775950.git.christophe.leroy@c-s.fr>
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 12/16] powerpc/mm/32s: add setibat() clearibat() and
 update_bats()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 21 Feb 2019 19:08:48 +0000 (UTC)
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

setibat() and clearibat() allows to manipulate IBATs independently
of DBATs.

update_bats() allows to update bats after init. This is done
with MMU off.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 ++
 arch/powerpc/kernel/head_32.S                 | 35 +++++++++++++++++++++++++++
 arch/powerpc/mm/ppc_mmu_32.c                  | 32 ++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 0c261ba2c826..5cb588395fdc 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -92,6 +92,8 @@ typedef struct {
 	unsigned long vdso_base;
 } mm_context_t;
 
+void update_bats(void);
+
 /* patch sites */
 extern s32 patch__hash_page_A0, patch__hash_page_A1, patch__hash_page_A2;
 extern s32 patch__hash_page_B, patch__hash_page_C;
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index c2f564690778..91b302b0797f 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1104,6 +1104,41 @@ BEGIN_MMU_FTR_SECTION
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	blr
 
+_ENTRY(update_bats)
+	lis	r4, 1f@h
+	ori	r4, r4, 1f@l
+	tophys(r4, r4)
+	mfmsr	r6
+	mflr	r7
+	li	r3, MSR_KERNEL & ~(MSR_IR | MSR_DR)
+	rlwinm	r0, r6, 0, ~MSR_RI
+	rlwinm	r0, r0, 0, ~MSR_EE
+	mtmsr	r0
+	mtspr	SPRN_SRR0, r4
+	mtspr	SPRN_SRR1, r3
+	SYNC
+	RFI
+1:	bl	clear_bats
+	lis	r3, BATS@ha
+	addi	r3, r3, BATS@l
+	tophys(r3, r3)
+	LOAD_BAT(0, r3, r4, r5)
+	LOAD_BAT(1, r3, r4, r5)
+	LOAD_BAT(2, r3, r4, r5)
+	LOAD_BAT(3, r3, r4, r5)
+BEGIN_MMU_FTR_SECTION
+	LOAD_BAT(4, r3, r4, r5)
+	LOAD_BAT(5, r3, r4, r5)
+	LOAD_BAT(6, r3, r4, r5)
+	LOAD_BAT(7, r3, r4, r5)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
+	li	r3, MSR_KERNEL & ~(MSR_IR | MSR_DR | MSR_RI)
+	mtmsr	r3
+	mtspr	SPRN_SRR0, r7
+	mtspr	SPRN_SRR1, r6
+	SYNC
+	RFI
+
 flush_tlbs:
 	lis	r10, 0x40
 1:	addic.	r10, r10, -0x1000
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index ff8580c6ab11..66f1319e8e20 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -106,6 +106,38 @@ static unsigned int block_size(unsigned long base, unsigned long top)
 	return min3(max_size, 1U << base_shift, 1U << block_shift);
 }
 
+/*
+ * Set up one of the IBAT (block address translation) register pairs.
+ * The parameters are not checked; in particular size must be a power
+ * of 2 between 128k and 256M.
+ * Only for 603+ ...
+ */
+static void setibat(int index, unsigned long virt, phys_addr_t phys,
+		    unsigned int size, pgprot_t prot)
+{
+	unsigned int bl = (size >> 17) - 1;
+	int wimgxpp;
+	struct ppc_bat *bat = BATS[index];
+	unsigned long flags = pgprot_val(prot);
+
+	if (!cpu_has_feature(CPU_FTR_NEED_COHERENT))
+		flags &= ~_PAGE_COHERENT;
+
+	wimgxpp = (flags & _PAGE_COHERENT) | (_PAGE_EXEC ? BPP_RX : BPP_XX);
+	bat[0].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
+	bat[0].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
+	if (flags & _PAGE_USER)
+		bat[0].batu |= 1;	/* Vp = 1 */
+}
+
+static void clearibat(int index)
+{
+	struct ppc_bat *bat = BATS[index];
+
+	bat[0].batu = 0;
+	bat[0].batl = 0;
+}
+
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	int idx;
-- 
2.13.3

