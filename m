Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6903C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 07:07:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3000020811
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 07:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="U8C7qwq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3000020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Fz8V4RfLzDqHX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 18:07:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="U8C7qwq5"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Fz6M2kCKzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 18:05:28 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Fz6B0fVdz9tySV;
 Fri,  8 Mar 2019 08:05:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=U8C7qwq5; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id gPdid5AlgUey; Fri,  8 Mar 2019 08:05:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Fz696Zpzz9tyST;
 Fri,  8 Mar 2019 08:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552028721; bh=OR2fnmd/9BeL9wEAn8cBSd36T+Fm861SgnzGfC8I3K0=;
 h=From:Subject:To:Cc:Date:From;
 b=U8C7qwq5ZH5ZMve08G3xAzb+txxVO0hWVD8IPeZ2PXkY5YqHeN15N8S5aMjg7Pqxa
 nhpxT/3evAgXGd19sSP1+KDxxmaw8eEdMs6rPCRkAShIh7G2ERrPqPrrTw7xXKC87c
 o8/YrMWBycRytuTRXaXszQpytsVWfViHV3ciJtys=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C92F48B75A;
 Fri,  8 Mar 2019 08:05:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uzYi-DwFFyss; Fri,  8 Mar 2019 08:05:22 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AA67F8BF5D;
 Fri,  8 Mar 2019 08:05:22 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8D0406F8A3; Fri,  8 Mar 2019 07:05:22 +0000 (UTC)
Message-Id: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Guenter Roeck <linux@roeck-us.net>
Date: Fri,  8 Mar 2019 07:05:22 +0000 (UTC)
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

Not only the 603 but all 6xx need SPRN_PGDIR to be initialised at
startup. This patch move it from __setup_cpu_603() to start_here()
and __secondary_start(), close to the initialisation of SPRN_THREAD.

Previously, virt addr of PGDIR was retrieved from thread struct.
Now that it is the phys addr which is stored in SPRN_PGDIR,
hash_page() shall not convert it to phys anymore.
This patch removes the conversion.

Fixes: 93c4a162b014("powerpc/6xx: Store PGDIR physical address in a SPRG")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/cpu_setup_6xx.S | 3 ---
 arch/powerpc/kernel/head_32.S       | 6 ++++++
 arch/powerpc/mm/hash_low_32.S       | 8 ++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 6f1c11e0691f..7534ecff5e92 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -24,9 +24,6 @@ BEGIN_MMU_FTR_SECTION
 	li	r10,0
 	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
-	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
-	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
-	mtspr	SPRN_SPRG_PGDIR, r10
 
 BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index ce6a972f2584..48051c8977c5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -855,6 +855,9 @@ __secondary_start:
 	li	r3,0
 	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
 #endif
+	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
+	mtspr	SPRN_SPRG_PGDIR, r4
 
 	/* enable MMU and jump to start_secondary */
 	li	r4,MSR_KERNEL
@@ -942,6 +945,9 @@ start_here:
 	li	r3,0
 	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
 #endif
+	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
+	mtspr	SPRN_SPRG_PGDIR, r4
 
 	/* stack */
 	lis	r1,init_thread_union@ha
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 1f13494efb2b..a6c491f18a04 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -70,12 +70,12 @@ _GLOBAL(hash_page)
 	lis	r0,KERNELBASE@h		/* check if kernel address */
 	cmplw	0,r4,r0
 	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
-	mfspr	r5, SPRN_SPRG_PGDIR	/* virt page-table root */
+	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
 	blt+	112f			/* assume user more likely */
-	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
-	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
+	lis	r5, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
+	addi	r5 ,r5 ,(swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
-112:	tophys(r5, r5)
+112:
 #ifndef CONFIG_PTE_64BIT
 	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
 	lwz	r8,0(r5)		/* get pmd entry */
-- 
2.13.3

