Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B10B41007E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 08:51:26 +1100 (EST)
Date: Thu, 24 Mar 2011 16:51:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: ARCH_PFN_OFFSET should be unsigned long
Message-ID: <20110324215119.GB9632@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pfns are unsigned long, but MEMORY_START is phys_addr_t.  This leads
to page_to_pfn() returning phys_addr_t, and thus type mismatches in a few
print statements.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/page.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index da4b200..2cd664e 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -100,7 +100,7 @@ extern phys_addr_t kernstart_addr;
 #endif
 
 #ifdef CONFIG_FLATMEM
-#define ARCH_PFN_OFFSET		(MEMORY_START >> PAGE_SHIFT)
+#define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
 #define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
 #endif
 
-- 
1.7.1
