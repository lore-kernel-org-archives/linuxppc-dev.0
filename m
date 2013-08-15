Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 402012C0224
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 21:56:43 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: add the missing required isync for the coherent
 icache flush
Date: Thu, 15 Aug 2013 19:56:07 +0800
Message-ID: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Even we don't need to flush the dcache and invalidate the icache
on the CPU which has coherent icache. But we do need an isync to
discard the prefetched instructions in this case.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/misc_32.S | 2 ++
 arch/powerpc/kernel/misc_64.S | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 777d999..0b84c8d 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -433,6 +433,7 @@ _GLOBAL(invalidate_dcache_range)
  */
 _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
+	isync
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address */
@@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
  */
 _GLOBAL(__flush_dcache_icache_phys)
 BEGIN_FTR_SECTION
+	isync
 	blr					/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	mfmsr	r10
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 992a78e..d74fefb 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -69,6 +69,7 @@ PPC64_CACHES:
 
 _KPROBE(flush_icache_range)
 BEGIN_FTR_SECTION
+	isync
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 /*
-- 
1.8.3.1
