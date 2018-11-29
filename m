Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF6C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:07:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D6621104
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D6621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435Rpc5jXTzDrFD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 06:07:04 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 435Rfw398tzDrHs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 06:00:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435Rfs3HMjz9tynH;
 Thu, 29 Nov 2018 20:00:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id l1Jnki_uKq5T; Thu, 29 Nov 2018 20:00:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435Rfs2lqRz9tyn6;
 Thu, 29 Nov 2018 20:00:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7479E8B8F1;
 Thu, 29 Nov 2018 20:00:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kv-QSsObkfHF; Thu, 29 Nov 2018 20:00:17 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D9098B8E3;
 Thu, 29 Nov 2018 20:00:14 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 55A2D69B59; Thu, 29 Nov 2018 19:00:14 +0000 (UTC)
Message-Id: <f3639366002f1365626e8bc0652fc44f8a1b7363.1543517818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543517818.git.christophe.leroy@c-s.fr>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 02/13] powerpc/mm/32: add base address to mmu_mapin_ram()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 29 Nov 2018 19:00:14 +0000 (UTC)
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

At the time being, mmu_mapin_ram() always maps RAM from the beginning.
But some platforms like the WII have to map a second block of RAM.

This patch adds to mmu_mapin_ram() the base address of the block.
At the moment, only base address 0 is supported.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/40x_mmu.c       | 2 +-
 arch/powerpc/mm/44x_mmu.c       | 2 +-
 arch/powerpc/mm/8xx_mmu.c       | 2 +-
 arch/powerpc/mm/fsl_booke_mmu.c | 2 +-
 arch/powerpc/mm/mmu_decl.h      | 2 +-
 arch/powerpc/mm/pgtable_32.c    | 6 +++---
 arch/powerpc/mm/ppc_mmu_32.c    | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index 61ac468c87c6..b9cf6f8764b0 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -93,7 +93,7 @@ void __init MMU_init_hw(void)
 #define LARGE_PAGE_SIZE_16M	(1<<24)
 #define LARGE_PAGE_SIZE_4M	(1<<22)
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long v, s, mapped;
 	phys_addr_t p;
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 12d92518e898..f59df82896a0 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -178,7 +178,7 @@ void __init MMU_init_hw(void)
 	flush_instruction_cache();
 }
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long addr;
 	unsigned long memstart = memstart_addr & ~(PPC_PIN_SIZE - 1);
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 01b7f5107c3a..50b640c7a7f9 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -107,7 +107,7 @@ static void __init mmu_patch_cmp_limit(s32 *site, unsigned long mapped)
 	patch_instruction_site(site, instr);
 }
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long mapped;
 
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 080d49b26c3a..210cbc1faf63 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -221,7 +221,7 @@ unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx, bool dryrun)
 #error "LOWMEM_CAM_NUM must be less than NUM_TLBCAMS"
 #endif
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	return tlbcam_addrs[tlbcam_index - 1].limit - PAGE_OFFSET + 1;
 }
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 8574fbbc45e0..c29f061b1678 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -130,7 +130,7 @@ extern void wii_memory_fixups(void);
  */
 #ifdef CONFIG_PPC32
 extern void MMU_init_hw(void);
-extern unsigned long mmu_mapin_ram(unsigned long top);
+unsigned long mmu_mapin_ram(unsigned long base, unsigned long top);
 #endif
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index bda3c6f1bd32..c030f24d1d05 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -275,15 +275,15 @@ void __init mapin_ram(void)
 
 #ifndef CONFIG_WII
 	top = total_lowmem;
-	s = mmu_mapin_ram(top);
+	s = mmu_mapin_ram(0, top);
 	__mapin_ram_chunk(s, top);
 #else
 	if (!wii_hole_size) {
-		s = mmu_mapin_ram(total_lowmem);
+		s = mmu_mapin_ram(0, total_lowmem);
 		__mapin_ram_chunk(s, total_lowmem);
 	} else {
 		top = wii_hole_start;
-		s = mmu_mapin_ram(top);
+		s = mmu_mapin_ram(0, top);
 		__mapin_ram_chunk(s, top);
 
 		top = memblock_end_of_DRAM();
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f6f575bae3bc..3a29e88308b0 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -72,7 +72,7 @@ unsigned long p_block_mapped(phys_addr_t pa)
 	return 0;
 }
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long tot, bl, done;
 	unsigned long max_size = (256<<20);
-- 
2.13.3

