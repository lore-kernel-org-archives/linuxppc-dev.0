Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F51CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 14:07:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6272146F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="imulGtqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6272146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447Nzn2sTrzDqPZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 01:07:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="imulGtqB"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447NZp1GtgzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 00:48:50 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 447NZd0Ft2zB09b3;
 Mon, 25 Feb 2019 14:48:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=imulGtqB; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id OO7uHKRQX9Et; Mon, 25 Feb 2019 14:48:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 447NZc6HvszB09Zn;
 Mon, 25 Feb 2019 14:48:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551102520; bh=8i6BZYBVOnklYOVbK567NRMBSuNfNdhf+35JteJYb48=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=imulGtqBo/ES7Z2dxdDVORNqJ3N0i4PSkqYblVgWQX+panXUiCtjEQGguU3Pal7vr
 EBaZzGCsI6+36+zobAcXGdiRj7IkLBt0xbxRtaFyvCGdv/zRr6w1joTF6MgoA7lJLU
 /G29i5DppfA1z7QDqhT51JApPIklKA0m9V17yE/s=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 366BA8B844;
 Mon, 25 Feb 2019 14:48:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VXX0HYr9fIOD; Mon, 25 Feb 2019 14:48:45 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A9AA8B81D;
 Mon, 25 Feb 2019 14:48:45 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8A7636F20E; Mon, 25 Feb 2019 13:48:45 +0000 (UTC)
Message-Id: <a7d608d51bda982afbe51ec6a34c67cd6a7c8cef.1551098215.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1551098214.git.christophe.leroy@c-s.fr>
References: <cover.1551098214.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 10/11] powerpc/32s: move hash code patching out of
 MMU_init_hw()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Mon, 25 Feb 2019 13:48:45 +0000 (UTC)
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
 arch/powerpc/mm/ppc_mmu_32.c  | 34 ++++++++++++++++++++--------------
 3 files changed, 24 insertions(+), 14 deletions(-)

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
index 2d5b0d50fb31..d591f768fac6 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -39,6 +39,7 @@
 struct hash_pte *Hash, *Hash_end;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
+static unsigned int Hash_mb, Hash_mb2;
 
 struct ppc_bat BATS[8][2];	/* 8 pairs of IBAT, DBAT */
 
@@ -308,7 +309,6 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
  */
 void __init MMU_init_hw(void)
 {
-	unsigned int hmask, mb, mb2;
 	unsigned int n_hpteg, lg_n_hpteg;
 
 	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
@@ -349,20 +349,28 @@ void __init MMU_init_hw(void)
 	       (unsigned long long)(total_memory >> 20), Hash_size >> 10, Hash);
 
 
-	/*
-	 * Patch up the instructions in hashtable.S:create_hpte
-	 */
-	if ( ppc_md.progress ) ppc_md.progress("hash:patch", 0x345);
 	Hash_mask = n_hpteg - 1;
-	hmask = Hash_mask >> (16 - LG_HPTEG_SIZE);
-	mb2 = mb = 32 - LG_HPTEG_SIZE - lg_n_hpteg;
+	Hash_mb2 = Hash_mb = 32 - LG_HPTEG_SIZE - lg_n_hpteg;
 	if (lg_n_hpteg > 16)
-		mb2 = 16 - LG_HPTEG_SIZE;
+		Hash_mb2 = 16 - LG_HPTEG_SIZE;
+}
+
+void __init MMU_init_hw_patch(void)
+{
+	unsigned int hmask = Hash_mask >> (16 - LG_HPTEG_SIZE);
+
+	if ( ppc_md.progress ) ppc_md.progress("hash:patch", 0x345);
+	if ( ppc_md.progress ) ppc_md.progress("hash:done", 0x205);
 
+	/* WARNING: Make sure nothing can trigger a KASAN check past this point */
+
+	/*
+	 * Patch up the instructions in hashtable.S:create_hpte
+	 */
 	modify_instruction_site(&patch__hash_page_A0, 0xffff,
 				((unsigned int)Hash - PAGE_OFFSET) >> 16);
-	modify_instruction_site(&patch__hash_page_A1, 0x7c0, mb << 6);
-	modify_instruction_site(&patch__hash_page_A2, 0x7c0, mb2 << 6);
+	modify_instruction_site(&patch__hash_page_A1, 0x7c0, Hash_mb << 6);
+	modify_instruction_site(&patch__hash_page_A2, 0x7c0, Hash_mb2 << 6);
 	modify_instruction_site(&patch__hash_page_B, 0xffff, hmask);
 	modify_instruction_site(&patch__hash_page_C, 0xffff, hmask);
 
@@ -371,11 +379,9 @@ void __init MMU_init_hw(void)
 	 */
 	modify_instruction_site(&patch__flush_hash_A0, 0xffff,
 				((unsigned int)Hash - PAGE_OFFSET) >> 16);
-	modify_instruction_site(&patch__flush_hash_A1, 0x7c0, mb << 6);
-	modify_instruction_site(&patch__flush_hash_A2, 0x7c0, mb2 << 6);
+	modify_instruction_site(&patch__flush_hash_A1, 0x7c0, Hash_mb << 6);
+	modify_instruction_site(&patch__flush_hash_A2, 0x7c0, Hash_mb2 << 6);
 	modify_instruction_site(&patch__flush_hash_B, 0xffff, hmask);
-
-	if ( ppc_md.progress ) ppc_md.progress("hash:done", 0x205);
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-- 
2.13.3

