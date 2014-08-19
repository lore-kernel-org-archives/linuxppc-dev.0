Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EACC81A06F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:55:27 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 4/4] powerpc: Move htab_remove_mapping function prototype into
 header file
Date: Wed, 20 Aug 2014 08:55:21 +1000
Message-Id: <1408488921-19187-4-git-send-email-anton@samba.org>
In-Reply-To: <1408488921-19187-1-git-send-email-anton@samba.org>
References: <1408488921-19187-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A recent patch added a function prototype for htab_remove_mapping in
c code. Fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/mmu-hash64.h | 2 ++
 arch/powerpc/mm/init_64.c             | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index d765144..92bc3a6 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -342,6 +342,8 @@ extern void hash_failure_debug(unsigned long ea, unsigned long access,
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long prot,
 			     int psize, int ssize);
+int htab_remove_mapping(unsigned long vstart, unsigned long vend,
+			int psize, int ssize);
 extern void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages);
 extern void demote_segment_4k(struct mm_struct *mm, unsigned long addr);
 
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 253b4b9..3481556 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -233,9 +233,6 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern int htab_remove_mapping(unsigned long vstart, unsigned long vend,
-			int psize, int ssize);
-
 static void vmemmap_remove_mapping(unsigned long start,
 				   unsigned long page_size)
 {
-- 
1.9.1
