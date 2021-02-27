Return-Path: <SRS0=PwIb=H5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80B9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Feb 2021 16:31:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE0E64E55
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Feb 2021 16:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE0E64E55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DnsTx2SQCz3d3Y
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Feb 2021 03:31:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DnsTY0Kxgz3cKy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Feb 2021 03:30:52 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DnsTM3g9Cz9txrK;
 Sat, 27 Feb 2021 17:30:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id tg9Ti39ns7Wn; Sat, 27 Feb 2021 17:30:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DnsTM2S4mz9txrJ;
 Sat, 27 Feb 2021 17:30:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1277A8B77E;
 Sat, 27 Feb 2021 17:30:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VF7aLnK4Ywf4; Sat, 27 Feb 2021 17:30:48 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B2CBB8B75B;
 Sat, 27 Feb 2021 17:30:48 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 6DB0F67452; Sat, 27 Feb 2021 16:30:48 +0000 (UTC)
Message-Id: <cf61345912c078c96f171afd0fcc48ef27cbdc3f.1614443418.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Force inlining of mmu_has_feature to fix build
 failure
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 27 Feb 2021 16:30:48 +0000 (UTC)
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

The test robot has managed to generate a random config leading
to following build failure:

  LD      .tmp_vmlinux.kallsyms1
powerpc64-linux-ld: arch/powerpc/mm/pgtable.o: in function `ptep_set_access_flags':
pgtable.c:(.text.ptep_set_access_flags+0xf0): undefined reference to `hash__flush_tlb_page'
powerpc64-linux-ld: arch/powerpc/mm/book3s32/mmu.o: in function `MMU_init_hw_patch':
mmu.c:(.init.text+0x452): undefined reference to `patch__hash_page_A0'
powerpc64-linux-ld: mmu.c:(.init.text+0x45e): undefined reference to `patch__hash_page_A0'
powerpc64-linux-ld: mmu.c:(.init.text+0x46a): undefined reference to `patch__hash_page_A1'
powerpc64-linux-ld: mmu.c:(.init.text+0x476): undefined reference to `patch__hash_page_A1'
powerpc64-linux-ld: mmu.c:(.init.text+0x482): undefined reference to `patch__hash_page_A2'
powerpc64-linux-ld: mmu.c:(.init.text+0x48e): undefined reference to `patch__hash_page_A2'
powerpc64-linux-ld: mmu.c:(.init.text+0x49e): undefined reference to `patch__hash_page_B'
powerpc64-linux-ld: mmu.c:(.init.text+0x4aa): undefined reference to `patch__hash_page_B'
powerpc64-linux-ld: mmu.c:(.init.text+0x4b6): undefined reference to `patch__hash_page_C'
powerpc64-linux-ld: mmu.c:(.init.text+0x4c2): undefined reference to `patch__hash_page_C'
powerpc64-linux-ld: mmu.c:(.init.text+0x4ce): undefined reference to `patch__flush_hash_A0'
powerpc64-linux-ld: mmu.c:(.init.text+0x4da): undefined reference to `patch__flush_hash_A0'
powerpc64-linux-ld: mmu.c:(.init.text+0x4e6): undefined reference to `patch__flush_hash_A1'
powerpc64-linux-ld: mmu.c:(.init.text+0x4f2): undefined reference to `patch__flush_hash_A1'
powerpc64-linux-ld: mmu.c:(.init.text+0x4fe): undefined reference to `patch__flush_hash_A2'
powerpc64-linux-ld: mmu.c:(.init.text+0x50a): undefined reference to `patch__flush_hash_A2'
powerpc64-linux-ld: mmu.c:(.init.text+0x522): undefined reference to `patch__flush_hash_B'
powerpc64-linux-ld: mmu.c:(.init.text+0x532): undefined reference to `patch__flush_hash_B'
powerpc64-linux-ld: arch/powerpc/mm/book3s32/mmu.o: in function `update_mmu_cache':
mmu.c:(.text.update_mmu_cache+0xa0): undefined reference to `add_hash_page'
powerpc64-linux-ld: mm/memory.o: in function `zap_pte_range':
memory.c:(.text.zap_pte_range+0x160): undefined reference to `flush_hash_pages'
powerpc64-linux-ld: mm/memory.o: in function `handle_pte_fault':
memory.c:(.text.handle_pte_fault+0x180): undefined reference to `hash__flush_tlb_page'

This is due to mmu_has_feature() not being inlined. See extract of build of
mmu.c with -Winline:

In file included from ./include/linux/mm_types.h:19,
                 from ./include/linux/mmzone.h:21,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from arch/powerpc/mm/book3s32/mmu.c:21:
./arch/powerpc/include/asm/mmu.h: In function 'find_free_bat':
./arch/powerpc/include/asm/mmu.h:231:20: warning: inlining failed in call to 'early_mmu_has_feature': call is unlikely and code size would grow [-Winline]
  231 | static inline bool early_mmu_has_feature(unsigned long feature)
      |                    ^~~~~~~~~~~~~~~~~~~~~
./arch/powerpc/include/asm/mmu.h:291:9: note: called from here
  291 |  return early_mmu_has_feature(feature);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The code relies on constant folding of MMU_FTRS_POSSIBLE at buildtime
and elimination of non possible parts of code at compile time.
For this to work, mmu_has_feature() and early_mmu_has_feature()
must be inlined.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 259149cf7c3c ("powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is selected")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 80b27f5d9648..607168b1aef4 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -228,7 +228,7 @@ enum {
 #define MMU_FTRS_ALWAYS		0
 #endif
 
-static inline bool early_mmu_has_feature(unsigned long feature)
+static __always_inline bool early_mmu_has_feature(unsigned long feature)
 {
 	if (MMU_FTRS_ALWAYS & feature)
 		return true;
@@ -286,7 +286,7 @@ static inline void mmu_feature_keys_init(void)
 
 }
 
-static inline bool mmu_has_feature(unsigned long feature)
+static __always_inline bool mmu_has_feature(unsigned long feature)
 {
 	return early_mmu_has_feature(feature);
 }
-- 
2.25.0

