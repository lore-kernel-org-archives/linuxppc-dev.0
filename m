Return-Path: <scottwood@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 125BDB712F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 07:31:53 +1100 (EST)
Date: Thu, 27 Jan 2011 14:31:38 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix pfn_valid() when memory starts at a non-zero
	address
Message-ID: <20110127203137.GA30996@udp111988uds.am.freescale.net>
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

max_mapnr is a pfn, not an index innto mem_map[].  So don't add
ARCH_PFN_OFFSET a second time.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/page.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 53b64be..da4b200 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -101,7 +101,7 @@ extern phys_addr_t kernstart_addr;
 
 #ifdef CONFIG_FLATMEM
 #define ARCH_PFN_OFFSET		(MEMORY_START >> PAGE_SHIFT)
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < (ARCH_PFN_OFFSET + max_mapnr))
+#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
 #endif
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-- 
1.7.0.4
