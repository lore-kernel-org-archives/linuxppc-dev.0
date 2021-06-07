Return-Path: <SRS0=rLAe=LB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BACFC47082
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 10:57:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B6260FDA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 10:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B6260FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fz9LJ2l7Zz3c6V
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 20:57:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fz9KL5FWkz308P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jun 2021 20:56:22 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4Fz9K31GJdzB9X2;
 Mon,  7 Jun 2021 12:56:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id knNczCCxCNDI; Mon,  7 Jun 2021 12:56:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Fz9K30MmCzB9Ww;
 Mon,  7 Jun 2021 12:56:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F3B718B78F;
 Mon,  7 Jun 2021 12:56:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id u07wuyf3V8SH; Mon,  7 Jun 2021 12:56:06 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C948A8B78D;
 Mon,  7 Jun 2021 12:56:06 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B1B1764C69; Mon,  7 Jun 2021 10:56:06 +0000 (UTC)
Message-Id: <83a008a9fd6cc3f2bbcb470f592555d260ed7a3d.1623063174.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5838caffa269e0957c5a50cc85477876220298b0.1623063174.git.christophe.leroy@csgroup.eu>
References: <5838caffa269e0957c5a50cc85477876220298b0.1623063174.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/3] powerpc/32s: Rename PTE_SIZE to PTE_T_SIZE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon,  7 Jun 2021 10:56:06 +0000 (UTC)
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

PTE_SIZE means PTE page table size in most placed, whereas
in hash_low.S in means size of one entry in the table.

Rename it PTE_T_SIZE, and define it directly in hash_low.S
instead of going through asm-offsets.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/asm-offsets.c   | 2 --
 arch/powerpc/mm/book3s32/hash_low.S | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f1b6ff14c8a0..2bd936ebcae8 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -361,8 +361,6 @@ int main(void)
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
 #endif
 
-	DEFINE(PTE_SIZE, sizeof(pte_t));
-
 #ifdef CONFIG_KVM
 	OFFSET(VCPU_HOST_STACK, kvm_vcpu, arch.host_stack);
 	OFFSET(VCPU_HOST_PID, kvm_vcpu, arch.host_pid);
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index fb4233a5bdf7..6925ce998557 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -27,8 +27,10 @@
 #include <asm/code-patching-asm.h>
 
 #ifdef CONFIG_PTE_64BIT
+#define PTE_T_SIZE		8
 #define PTE_FLAGS_OFFSET	4	/* offset of PTE flags, in bytes */
 #else
+#define PTE_T_SIZE		4
 #define PTE_FLAGS_OFFSET	0
 #endif
 
@@ -488,7 +490,7 @@ _GLOBAL(flush_hash_pages)
 	bne	2f
 	ble	cr1,19f
 	addi	r4,r4,0x1000
-	addi	r5,r5,PTE_SIZE
+	addi	r5,r5,PTE_T_SIZE
 	addi	r6,r6,-1
 	b	1b
 
@@ -573,7 +575,7 @@ _GLOBAL(flush_hash_pages)
 
 8:	ble	cr1,9f			/* if all ptes checked */
 81:	addi	r6,r6,-1
-	addi	r5,r5,PTE_SIZE
+	addi	r5,r5,PTE_T_SIZE
 	addi	r4,r4,0x1000
 	lwz	r0,0(r5)		/* check next pte */
 	cmpwi	cr1,r6,1
-- 
2.25.0

