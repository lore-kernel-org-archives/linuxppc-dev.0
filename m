Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6031CC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 17:07:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E7F2081D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 17:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E7F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qtCD1bdJzF3Bf
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 04:07:52 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qsyK3BWwzF3Js
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 03:56:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42qsyD152Zz9tvrr;
 Wed,  7 Nov 2018 17:56:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ZeQfATJmZgrI; Wed,  7 Nov 2018 17:56:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42qsyD0XmTz9tvrh;
 Wed,  7 Nov 2018 17:56:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E53898B815;
 Wed,  7 Nov 2018 17:56:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Ou_tpWEU-AH5; Wed,  7 Nov 2018 17:56:37 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AFAF38B814;
 Wed,  7 Nov 2018 17:56:37 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7254C6995E; Wed,  7 Nov 2018 16:56:37 +0000 (UTC)
Message-Id: <e3f3fb1ad020202e13b0e1267ef0e17d7da7b2a4.1541568128.git.christophe.leroy@c-s.fr>
In-Reply-To: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 6/6] powerpc/8xx: Add Kernel Userspace Access Protection
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Wed,  7 Nov 2018 16:56:37 +0000 (UTC)
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

This patch adds Kernel Userspace Access Protection on the 8xx.

When a page is RO or RW, it is set RO or RW for Key 0 and NA
for Key 1.

Up to now, the User group is defined with Key 0 for both User and
Supervisor.

By changing the group to Key 0 for User and Key 1 for Supervisor,
this patch prevents the Kernel from being able to access user data.

At exception entry, the kernel saves SPRN_MD_AP in the regs struct,
and reapply the protection. At exception exit it restore SPRN_MD_AP
with the value it had on exception entry.

For the time being, the unused mq field of pt_regs struct is used for
that.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h           |  7 +++++++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 23 +++++++++++++++++++++++
 arch/powerpc/kernel/asm-offsets.c            |  1 +
 arch/powerpc/kernel/entry_32.S               | 19 +++++++++++++++++++
 arch/powerpc/kernel/process.c                |  2 +-
 arch/powerpc/mm/8xx_mmu.c                    | 10 ++++++++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 7 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 53dbf0788fce..bab8568def50 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_POWERPC_MMU_8XX_H_
 #define _ASM_POWERPC_MMU_8XX_H_
+
 /*
  * PPC8xx support
  */
@@ -120,6 +121,12 @@
  */
 #define MD_APG_INIT	0x44444444
 
+/*
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 10 (all accesses performed according to swaped page definition)
+ */
+#define MD_APG_KUAP	0x66666666
+
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
  * this register are used to create the TLB entry.
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 6bfe041ef59d..f1ec7cf949d5 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -135,6 +135,29 @@ static inline pte_t pte_mkhuge(pte_t pte)
 }
 
 #define pte_mkhuge pte_mkhuge
+
+#ifdef CONFIG_PPC_KUAP
+static inline void lock_user_wr_access(void)
+{
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
+
+static inline void unlock_user_wr_access(void)
+{
+	mtspr(SPRN_MD_AP, MD_APG_INIT);
+}
+
+static inline void lock_user_rd_access(void)
+{
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
+
+static inline void unlock_user_rd_access(void)
+{
+	mtspr(SPRN_MD_AP, MD_APG_INIT);
+}
+#endif
+
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ffc72ded73a..da2f5d011ddb 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -320,6 +320,7 @@ int main(void)
 	 */
 	STACK_PT_REGS_OFFSET(_DEAR, dar);
 	STACK_PT_REGS_OFFSET(_ESR, dsisr);
+	STACK_PT_REGS_OFFSET(_MQ, mq);
 #else /* CONFIG_PPC64 */
 	STACK_PT_REGS_OFFSET(SOFTE, softe);
 	STACK_PT_REGS_OFFSET(_PPR, ppr);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 77decded1175..7fd9dc16dd48 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -155,6 +155,13 @@ transfer_to_handler:
 	mfspr	r2,SPRN_XER
 	stw	r12,_CTR(r11)
 	stw	r2,_XER(r11)
+#ifdef CONFIG_PPC_KUAP
+	mfspr	r2, SPRN_MD_AP
+	stw	r2, _MQ(r11)
+	lis	r2, MD_APG_KUAP@h
+	ori	r2, r2, MD_APG_KUAP@l
+	mtspr	SPRN_MD_AP, r2
+#endif
 	mfspr	r12,SPRN_SPRG_THREAD
 	addi	r2,r12,-THREAD
 	tovirt(r2,r2)			/* set r2 to current */
@@ -447,6 +454,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	mtlr	r4
 	mtcr	r5
 	lwz	r7,_NIP(r1)
+#ifdef CONFIG_PPC_KUAP
+	lwz	r2, _MQ(r1)
+	mtspr	SPRN_MD_AP, r2
+#endif
 	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
@@ -745,6 +756,10 @@ fast_exception_return:
 	mtcr	r10
 	lwz	r10,_LINK(r11)
 	mtlr	r10
+#ifdef CONFIG_PPC_KUAP
+	lwz	r10, _MQ(r11)
+	mtspr	SPRN_MD_AP, r10
+#endif
 	REST_GPR(10, r11)
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
@@ -997,6 +1012,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	.globl exc_exit_restart
 exc_exit_restart:
 	lwz	r12,_NIP(r1)
+#ifdef CONFIG_PPC_KUAP
+	lwz	r10, _MQ(r1)
+	mtspr	SPRN_MD_AP, r10
+#endif
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
 #endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f34730010f..bbec29bda4cb 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1768,7 +1768,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	regs->trap &= ~1UL;
 
 #ifdef CONFIG_PPC32
-	regs->mq = 0;
+	regs->mq = MD_APG_KUAP;
 	regs->nip = start;
 	regs->msr = MSR_USER;
 #else
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 597d3bd2d9b5..acea296d4c76 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -204,3 +204,13 @@ void setup_kuep(bool disabled)
 
 	mtspr(SPRN_MI_AP, MI_APG_KUEP);
 }
+
+void setup_kuap(bool disabled)
+{
+	pr_warn("Activating Kernel Userspace Access Protection\n");
+
+	if (disabled)
+		pr_warn("KUAP cannot be disabled yet on 8xx when compiled in\n");
+
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d1757cedf60b..a20669a9ec13 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 
 config 40x
 	bool "AMCC 40x"
-- 
2.13.3

