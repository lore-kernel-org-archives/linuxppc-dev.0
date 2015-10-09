Return-Path: <kuleshovmail@gmail.com>
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com
 [IPv6:2a00:1450:4010:c04::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1A811A0394
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 05:32:07 +1100 (AEDT)
Received: by lbcao8 with SMTP id ao8so90679976lbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2015 11:32:03 -0700 (PDT)
From: Alexander Kuleshov <kuleshovmail@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Scott Wood <scottwood@freescale.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] powerpc/mm: use memblock_is_memory
Date: Sat, 10 Oct 2015 00:30:30 +0600
Message-Id: <1444415430-25827-1-git-send-email-kuleshovmail@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The <linux/memblock.h> provides memblock_is_memory() function that
tries to find a given physical address in the memblock.memory.regions.
Let's use this function instead of direct coding of the same functionality.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/powerpc/mm/mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 22d94c3..85b462b 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -82,11 +82,9 @@ int page_is_ram(unsigned long pfn)
 	return pfn < max_pfn;
 #else
 	unsigned long paddr = (pfn << PAGE_SHIFT);
-	struct memblock_region *reg;

-	for_each_memblock(memory, reg)
-		if (paddr >= reg->base && paddr < (reg->base + reg->size))
-			return 1;
+	if (memblock_is_memory(paddr))
+		return 1;
 	return 0;
 #endif
 }
--
2.6.0
