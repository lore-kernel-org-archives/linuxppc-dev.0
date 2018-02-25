Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcP2KfKzF1NX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:01 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id p104so18823056wrc.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:01 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
Date: Sun, 25 Feb 2018 18:22:20 +0100
Message-Id: <20180225172236.29650-6-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rewrite comparison since all values compared are of type `unsigned long`.

Fix a warning (treated as error in W=1):

  CC      arch/powerpc/kernel/irq.o
In file included from ./include/linux/bug.h:5:0,
                 from ./include/linux/cpumask.h:13,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/kernel_stat.h:5,
                 from arch/powerpc/kernel/irq.c:35:
./include/linux/dma-mapping.h: In function ‘dma_map_resource’:
./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
 #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                ^
Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/page.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 8da5d4c1cab2..19dea64e7ed2 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -126,7 +126,8 @@ extern long long virt_phys_offset;
 
 #ifdef CONFIG_FLATMEM
 #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
+#define pfn_valid(pfn) \
+		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
 #endif
 
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-- 
2.11.0
