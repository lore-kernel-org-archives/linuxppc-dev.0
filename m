Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA66C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:19:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC3621104
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC3621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435S4X4QJ9zDqX6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 06:19:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435RgG0zlYzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 06:00:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435RgC17yjz9v11h;
 Thu, 29 Nov 2018 20:00:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id BqJt7_E1hwEC; Thu, 29 Nov 2018 20:00:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435RgC0Wt5z9v11Q;
 Thu, 29 Nov 2018 20:00:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0421C8B929;
 Thu, 29 Nov 2018 20:00:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jzY3gZ_jl8WY; Thu, 29 Nov 2018 20:00:36 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 56B638B8F8;
 Thu, 29 Nov 2018 20:00:24 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7461B69B5A; Thu, 29 Nov 2018 19:00:24 +0000 (UTC)
Message-Id: <43cde6255c890f944700accf8769e73786794342.1543517818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543517818.git.christophe.leroy@c-s.fr>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 07/13] powerpc/mm/32s: add setibat() clearibat() and
 update_bats()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 29 Nov 2018 19:00:24 +0000 (UTC)
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
index e38c91388c40..b4ccb832d4fb 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -83,6 +83,8 @@ typedef struct {
 	unsigned long vdso_base;
 } mm_context_t;
 
+void update_bats(void);
+
 #endif /* !__ASSEMBLY__ */
 
 /* We happily ignore the smaller BATs on 601, we don't actually use
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index d1c39b5ccfd6..0f4c72ebb151 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1101,6 +1101,41 @@ BEGIN_MMU_FTR_SECTION
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
index 1078095d9407..58dd71686707 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -105,6 +105,38 @@ static unsigned int block_size(unsigned long base, unsigned long top)
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

