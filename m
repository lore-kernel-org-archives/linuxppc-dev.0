Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409pbB6bzLzF2F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 11:26:30 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 4/5] powerpc: wii: Don't rely on the reserved memory hack
Date: Wed, 28 Mar 2018 02:25:43 +0200
Message-Id: <20180328002544.18526-5-j.neuschaefer@gmx.net>
In-Reply-To: <20180328002544.18526-1-j.neuschaefer@gmx.net>
References: <20180328002544.18526-1-j.neuschaefer@gmx.net>
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

Because the two memory blocks (usually called MEM1 and MEM2) are not
merged anymore, __request_region in kernel/resource.c will correctly
allow reserving regions in the physical address space between MEM1 and
MEM2, where many important peripherals are (GPIO, MMC, USB, ...).

A previous change to __ioremap_caller in arch/powerpc/mm/pgtable_32.c
ensures that multiple memblocks are properly considered in ioremap; this
makes it unnecessary to set __allow_ioremap_reserved.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
Add some text to the commit message.
---
 arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 4682327f76a9..fc00d82691e1 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -81,21 +81,9 @@ void __init wii_memory_fixups(void)
 	BUG_ON(memblock.memory.cnt != 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
 
-	/* trim unaligned tail */
-	memblock_remove(ALIGN(p[1].base + p[1].size, PAGE_SIZE),
-			(phys_addr_t)ULLONG_MAX);
-
-	/* determine hole, add & reserve them */
+	/* determine hole */
 	wii_hole_start = ALIGN(p[0].base + p[0].size, PAGE_SIZE);
 	wii_hole_size = p[1].base - wii_hole_start;
-	memblock_add(wii_hole_start, wii_hole_size);
-	memblock_reserve(wii_hole_start, wii_hole_size);
-
-	BUG_ON(memblock.memory.cnt != 1);
-	__memblock_dump_all();
-
-	/* allow ioremapping the address space in the hole */
-	__allow_ioremap_reserved = 1;
 }
 
 unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
-- 
2.16.2
