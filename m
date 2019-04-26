Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079E6C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:55:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC03206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="A6s5CKZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC03206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rKtX2hHFzDqS0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:55:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="A6s5CKZP"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rKSp2skDzDqTg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 02:36:42 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rKSj4n18z9v0ym;
 Fri, 26 Apr 2019 18:36:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=A6s5CKZP; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id fXeWUN2Hv5t2; Fri, 26 Apr 2019 18:36:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rKSj3dJsz9v0yk;
 Fri, 26 Apr 2019 18:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556296597; bh=Zs590auh6XIiCAThTCcP+QvprkjeL+YR+h7oV8tJLZA=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=A6s5CKZP5vXWEtM98TbL5F3TNeIQhW6d/b/XzIaPC6IOcLgQiUloAqsUdzUJxBHZ7
 CR52qz5FyIeP7MKbvQJi7BHjTIR9xXs1GGMPoQrp+g+lceCunWVOrrihaIary/+HDK
 Ib6cDR/AyJZa2lK+V7whtzIeU2dzE8EiFPNIwNBY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 36A378B950;
 Fri, 26 Apr 2019 18:36:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id tdrYdXkPIH2B; Fri, 26 Apr 2019 18:36:39 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 140088B82F;
 Fri, 26 Apr 2019 18:36:39 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 08FBB666FD; Fri, 26 Apr 2019 16:36:39 +0000 (UTC)
Message-Id: <974ccc233b182fbc2539a1d597230854ed769523.1556296364.git.christophe.leroy@c-s.fr>
In-Reply-To: <809c41e209068baf1045edbf154cc8d25c520d1e.1556296364.git.christophe.leroy@c-s.fr>
References: <809c41e209068baf1045edbf154cc8d25c520d1e.1556296364.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/mm: print hash info in a helper
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 26 Apr 2019 16:36:39 +0000 (UTC)
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

Reduce #ifdef mess by defining a helper to print
hash info at startup.

In the meantime, remove the display of hash table address
to reduce leak of non necessary information.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: added header to avoid sparse warning
v3: rebased due to commit a092a03fa942 ("powerpc/mm: Print kernel map details to dmesg")

 arch/powerpc/kernel/setup-common.c | 22 +---------------------
 arch/powerpc/mm/hash_utils_64.c    | 13 +++++++++++++
 arch/powerpc/mm/mmu_decl.h         |  5 ++++-
 arch/powerpc/mm/ppc_mmu_32.c       |  9 ++++++++-
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1729bf409562..ef424e934ee7 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -799,12 +799,6 @@ void arch_setup_pdev_archdata(struct platform_device *pdev)
 static __init void print_system_info(void)
 {
 	pr_info("-----------------------------------------------------\n");
-#ifdef CONFIG_PPC_BOOK3S_64
-	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
-#endif
-#ifdef CONFIG_PPC_BOOK3S_32
-	pr_info("Hash_size         = 0x%lx\n", Hash_size);
-#endif
 	pr_info("phys_mem_size     = 0x%llx\n",
 		(unsigned long long)memblock_phys_mem_size());
 
@@ -826,21 +820,7 @@ static __init void print_system_info(void)
 	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
-	if (htab_address)
-		pr_info("htab_address      = 0x%p\n", htab_address);
-	if (htab_hash_mask)
-		pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
-	pr_info("kernel vmalloc start   = 0x%lx\n", KERN_VIRT_START);
-	pr_info("kernel IO start        = 0x%lx\n", KERN_IO_START);
-	pr_info("kernel vmemmap start   = 0x%lx\n", (unsigned long)vmemmap);
-#endif
-#ifdef CONFIG_PPC_BOOK3S_32
-	if (Hash)
-		pr_info("Hash              = 0x%p\n", Hash);
-	if (Hash_mask)
-		pr_info("Hash_mask         = 0x%lx\n", Hash_mask);
-#endif
+	print_system_hash_info();
 
 	if (PHYSICAL_START > 0)
 		pr_info("physical_start    = 0x%llx\n",
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f727197de713..098bae10ceab 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -65,6 +65,8 @@
 #include <asm/pte-walk.h>
 #include <asm/asm-prototypes.h>
 
+#include "mmu_decl.h"
+
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
 #else
@@ -1928,3 +1930,14 @@ static int __init hash64_debugfs(void)
 }
 machine_device_initcall(pseries, hash64_debugfs);
 #endif /* CONFIG_DEBUG_FS */
+
+void __init print_system_hash_info(void)
+{
+	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
+
+	if (htab_hash_mask)
+		pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
+	pr_info("kernel vmalloc start   = 0x%lx\n", KERN_VIRT_START);
+	pr_info("kernel IO start        = 0x%lx\n", KERN_IO_START);
+	pr_info("kernel vmemmap start   = 0x%lx\n", (unsigned long)vmemmap);
+}
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index f7f1374ba3ee..dc617ade83ab 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -83,6 +83,8 @@ static inline void _tlbivax_bcast(unsigned long address, unsigned int pid,
 }
 #endif
 
+static inline void print_system_hash_info(void) {}
+
 #else /* CONFIG_PPC_MMU_NOHASH */
 
 extern void hash_preload(struct mm_struct *mm, unsigned long ea,
@@ -92,6 +94,8 @@ extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 extern void _tlbie(unsigned long address);
 extern void _tlbia(void);
 
+void print_system_hash_info(void);
+
 #endif /* CONFIG_PPC_MMU_NOHASH */
 
 #ifdef CONFIG_PPC32
@@ -105,7 +109,6 @@ extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
 extern struct hash_pte *Hash;
-extern unsigned long Hash_size, Hash_mask;
 
 #endif /* CONFIG_PPC32 */
 
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c908538720ac..f2e88b8a48e1 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -37,7 +37,7 @@
 #include "mmu_decl.h"
 
 struct hash_pte *Hash;
-unsigned long Hash_size, Hash_mask;
+static unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
 
 struct ppc_bat BATS[8][2];	/* 8 pairs of IBAT, DBAT */
@@ -393,6 +393,13 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000));
 }
 
+void __init print_system_hash_info(void)
+{
+	pr_info("Hash_size         = 0x%lx\n", Hash_size);
+	if (Hash_mask)
+		pr_info("Hash_mask         = 0x%lx\n", Hash_mask);
+}
+
 #ifdef CONFIG_PPC_KUEP
 void __init setup_kuep(bool disabled)
 {
-- 
2.13.3

