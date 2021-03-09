Return-Path: <SRS0=gB3U=IH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C77BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 12:22:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B9065268
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 12:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B9065268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DvvV43GRGz3f4w
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 23:22:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DvvCy65MKz3d4M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Mar 2021 23:10:06 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DvvCv16hCz9tyjF;
 Tue,  9 Mar 2021 13:10:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EOrWV_vEg6UO; Tue,  9 Mar 2021 13:10:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DvvCt74njz9tyjJ;
 Tue,  9 Mar 2021 13:10:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 554CD8B7FC;
 Tue,  9 Mar 2021 13:10:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id R2PkV2PUuxor; Tue,  9 Mar 2021 13:10:04 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 11A048B804;
 Tue,  9 Mar 2021 13:10:04 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id E353D67555; Tue,  9 Mar 2021 12:10:03 +0000 (UTC)
Message-Id: <6bc7fdcfbcae1d8f81af2e13eaca43d3e2bf2ebc.1615291474.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615291471.git.christophe.leroy@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 37/43] powerpc/32: Return directly from
 power_save_ppc32_restore()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com
Date: Tue,  9 Mar 2021 12:10:03 +0000 (UTC)
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

transfer_to_handler_cont: is now just a blr.

Directly perform blr in power_save_ppc32_restore().

Also remove useless setting of r11 in e500 version of
power_save_ppc32_restore().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S  |  3 ---
 arch/powerpc/kernel/idle_6xx.S  |  2 +-
 arch/powerpc/kernel/idle_e500.S | 10 +---------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 815a4ff1ba76..5cfa10816261 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -67,8 +67,6 @@ prepare_transfer_to_handler:
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
 #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
-	.globl transfer_to_handler_cont
-transfer_to_handler_cont:
 	blr
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
@@ -84,7 +82,6 @@ transfer_to_handler_cont:
 	b	fast_exception_return
 #endif
 _ASM_NOKPROBE_SYMBOL(prepare_transfer_to_handler)
-_ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
 
 	.globl	transfer_to_syscall
 transfer_to_syscall:
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 153366e178c4..13cad9297d82 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -176,7 +176,7 @@ BEGIN_FTR_SECTION
 	lwz	r9,nap_save_hid1@l(r9)
 	mtspr	SPRN_HID1, r9
 END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
-	b	transfer_to_handler_cont
+	blr
 _ASM_NOKPROBE_SYMBOL(power_save_ppc32_restore)
 
 	.data
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 7795727e7f08..9e1bc4502c50 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -81,13 +81,5 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 _GLOBAL(power_save_ppc32_restore)
 	lwz	r9,_LINK(r11)		/* interrupted in e500_idle */
 	stw	r9,_NIP(r11)		/* make it do a blr */
-
-#ifdef CONFIG_SMP
-	lwz	r11,TASK_CPU(r2)		/* get cpu number * 4 */
-	slwi	r11,r11,2
-#else
-	li	r11,0
-#endif
-
-	b	transfer_to_handler_cont
+	blr
 _ASM_NOKPROBE_SYMBOL(power_save_ppc32_restore)
-- 
2.25.0

