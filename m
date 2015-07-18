Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DBC41A1967
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:39 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 15/17] powerpc/booke: Only use VIRT_PHYS_OFFSET on booke32
Date: Sat, 18 Jul 2015 15:08:52 -0500
Message-ID: <1437250134-307-16-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The way VIRT_PHYS_OFFSET is not correct on book3e-64, because
it does not account for CONFIG_RELOCATABLE other than via the
32-bit-only virt_phys_offset.

book3e-64 can (and if the comment about a GCC miscompilation is still
relevant, should) use the normal ppc64 __va/__pa.

At this point, only booke-32 will use VIRT_PHYS_OFFSET, so given the
issues with its calculation, restrict its definition to booke-32.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/page.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 71294a6..11889d8 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -107,12 +107,13 @@ extern long long virt_phys_offset;
 #endif
 
 /* See Description below for VIRT_PHYS_OFFSET */
-#ifdef CONFIG_RELOCATABLE_PPC32
+#if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
+#ifdef CONFIG_RELOCATABLE
 #define VIRT_PHYS_OFFSET virt_phys_offset
 #else
 #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
 #endif
-
+#endif
 
 #ifdef CONFIG_PPC64
 #define MEMORY_START	0UL
@@ -204,7 +205,7 @@ extern long long virt_phys_offset;
  * On non-Book-E PPC64 PAGE_OFFSET and MEMORY_START are constants so use
  * the other definitions for __va & __pa.
  */
-#ifdef CONFIG_BOOKE
+#if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
 #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
 #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
 #else
-- 
2.1.4
