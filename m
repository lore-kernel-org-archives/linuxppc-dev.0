Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6286AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 12:57:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50292084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 12:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NHKG7N0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50292084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449qFs5d46zDqW5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 23:57:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="NHKG7N0/"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449pkT5h59zDqRf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 23:33:53 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 449pkM5ygtz9txrx;
 Fri,  1 Mar 2019 13:33:47 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=NHKG7N0/; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kgZlPUTjQ4vs; Fri,  1 Mar 2019 13:33:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 449pkM3mBtz9txrh;
 Fri,  1 Mar 2019 13:33:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551443627; bh=iDP7gsyvcqTo9RdhF5mvEcZHsCZ/UEXVBMDee0rR734=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=NHKG7N0/a2VHnWnssuQPDjyqdh8s+45CBeHJAWULfSNKeDCxRXNaBh6L+HWRSU6lG
 is+W1ZOteFBe8xziEsvJxKrnhJNkT9cYhZ7GsgfXxb4FnlRBn2WjVxccTD5OZCc12H
 agPEkw2VHiHTFkCPrRqWuxwIVjPZX8HvZWVD9aKI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CB6118BB8B;
 Fri,  1 Mar 2019 13:33:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id STarbLg2zQUC; Fri,  1 Mar 2019 13:33:48 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 815AA8BB73;
 Fri,  1 Mar 2019 13:33:48 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 5C7226F89E; Fri,  1 Mar 2019 12:33:48 +0000 (UTC)
Message-Id: <acc79a0cbc59aeaaacb76b894d1120c1fb3c032a.1551443453.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1551443452.git.christophe.leroy@c-s.fr>
References: <cover.1551443452.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 10/11] powerpc/32s: move hash code patching out of
 MMU_init_hw()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Fri,  1 Mar 2019 12:33:48 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

For KASAN, hash table handling will be activated early for
accessing to KASAN shadow areas.

In order to avoid any modification of the hash functions while
they are still used with the early hash table, the code patching
is moved out of MMU_init_hw() and put close to the big-bang switch
to the final hash table.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S |  3 +++
 arch/powerpc/mm/mmu_decl.h    |  1 +
 arch/powerpc/mm/ppc_mmu_32.c  | 36 ++++++++++++++++++++++--------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 02229c005853..e644aab2cf5b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -960,6 +960,9 @@ start_here:
 	bl	machine_init
 	bl	__save_cpu_setup
 	bl	MMU_init
+BEGIN_MMU_FTR_SECTION
+	bl	MMU_init_hw_patch
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 
 /*
  * Go back to running unmapped so we can load up new values
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 74ff61dabcb1..d726ff776054 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -130,6 +130,7 @@ extern void wii_memory_fixups(void);
  */
 #ifdef CONFIG_PPC32
 extern void MMU_init_hw(void);
+void MMU_init_hw_patch(void);
 unsigned long mmu_mapin_ram(unsigned long base, unsigned long top);
 #endif
 
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 2d5b0d50fb31..38c0e28c21e1 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -39,6 +39,7 @@
 struct hash_pte *Hash, *Hash_end;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
+static unsigned int hash_mb, hash_mb2;
 
 struct ppc_bat BATS[8][2];	/* 8 pairs of IBAT, DBAT */
 
@@ -308,7 +309,6 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
  */
 void __init MMU_init_hw(void)
 {
-	unsigned int hmask, mb, mb2;
 	unsigned int n_hpteg, lg_n_hpteg;
 
 	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
@@ -349,20 +349,30 @@ void __init MMU_init_hw(void)
 	       (unsigned long long)(total_memory >> 20), Hash_size >> 10, Hash);
 
 
-	/*
-	 * Patch up the instructions in hashtable.S:create_hpte
-	 */
-	if ( ppc_md.progress ) ppc_md.progress("hash:patch", 0x345);
 	Hash_mask = n_hpteg - 1;
-	hmask = Hash_mask >> (16 - LG_HPTEG_SIZE);
-	mb2 = mb = 32 - LG_HPTEG_SIZE - lg_n_hpteg;
+	hash_mb2 = hash_mb = 32 - LG_HPTEG_SIZE - lg_n_hpteg;
 	if (lg_n_hpteg > 16)
-		mb2 = 16 - LG_HPTEG_SIZE;
+		hash_mb2 = 16 - LG_HPTEG_SIZE;
+}
+
+void __init MMU_init_hw_patch(void)
+{
+	unsigned int hmask = Hash_mask >> (16 - LG_HPTEG_SIZE);
 
+	if (ppc_md.progress)
+		ppc_md.progress("hash:patch", 0x345);
+	if (ppc_md.progress)
+		ppc_md.progress("hash:done", 0x205);
+
+	/* WARNING: Make sure nothing can trigger a KASAN check past this point */
+
+	/*
+	 * Patch up the instructions in hashtable.S:create_hpte
+	 */
 	modify_instruction_site(&patch__hash_page_A0, 0xffff,
 				((unsigned int)Hash - PAGE_OFFSET) >> 16);
-	modify_instruction_site(&patch__hash_page_A1, 0x7c0, mb << 6);
-	modify_instruction_site(&patch__hash_page_A2, 0x7c0, mb2 << 6);
+	modify_instruction_site(&patch__hash_page_A1, 0x7c0, hash_mb << 6);
+	modify_instruction_site(&patch__hash_page_A2, 0x7c0, hash_mb2 << 6);
 	modify_instruction_site(&patch__hash_page_B, 0xffff, hmask);
 	modify_instruction_site(&patch__hash_page_C, 0xffff, hmask);
 
@@ -371,11 +381,9 @@ void __init MMU_init_hw(void)
 	 */
 	modify_instruction_site(&patch__flush_hash_A0, 0xffff,
 				((unsigned int)Hash - PAGE_OFFSET) >> 16);
-	modify_instruction_site(&patch__flush_hash_A1, 0x7c0, mb << 6);
-	modify_instruction_site(&patch__flush_hash_A2, 0x7c0, mb2 << 6);
+	modify_instruction_site(&patch__flush_hash_A1, 0x7c0, hash_mb << 6);
+	modify_instruction_site(&patch__flush_hash_A2, 0x7c0, hash_mb2 << 6);
 	modify_instruction_site(&patch__flush_hash_B, 0xffff, hmask);
-
-	if ( ppc_md.progress ) ppc_md.progress("hash:done", 0x205);
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-- 
2.13.3

