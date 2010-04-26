Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6F3AB7D57
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 08:54:56 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o3QMsqwl003546
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 17:54:53 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/fsl-booke: Fix CONFIG_RELOCATABLE support on FSL
	Book-E ppc32
Date: Mon, 26 Apr 2010 17:54:52 -0500
Message-Id: <1272322492-27408-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following commit broke CONFIG_RELOCATABLE support on FSL Book-E
parts:

commit 549e8152de8039506f69c677a4546e5427aa6ae7
Author: Paul Mackerras <paulus@samba.org>
Date:   Sat Aug 30 11:43:47 2008 +1000

    powerpc: Make the 64-bit kernel as a position-independent executable

The change to __va and __pa to use PAGE_OFFSET & MEMORY_START causes
problems on the Book-E parts because we don't know MEMORY_START until
after we parse the device tree.  We need __va to work properly to even
parse the device tree so we have a chicken an egg.  So go back to using
he other definition of __va/__pa on CONFIG_BOOKE and use the
PAGE_OFFSET/MEMORY_START version on "Classic" PPC64.

Also updated casts to handle phys_addr_t being a different size from
unsigned long (ie 36-bit physical on PPC32).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Fixed some grammaticaly issues pointed out by Becky in code comments

 arch/powerpc/include/asm/page.h |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e96d52a..53b64be 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -108,8 +108,21 @@ extern phys_addr_t kernstart_addr;
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET - MEMORY_START))
+/*
+ * On Book-E parts we need __va to parse the device tree and we can't
+ * determine MEMORY_START until then.  However we can determine PHYSICAL_START
+ * from information at hand (program counter, TLB lookup).
+ *
+ * On non-Book-E PPC64 PAGE_OFFSET and MEMORY_START are constants so use
+ * the other definitions for __va & __pa.
+ */
+#ifdef CONFIG_BOOKE
+#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + KERNELBASE))
+#define __pa(x) ((unsigned long)(x) + PHYSICAL_START - KERNELBASE)
+#else
+#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + PAGE_OFFSET - MEMORY_START))
 #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + MEMORY_START)
+#endif
 
 /*
  * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
-- 
1.6.0.6
