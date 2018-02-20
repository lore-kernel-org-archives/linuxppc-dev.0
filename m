Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmDQS2Lk4zF17t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:34:07 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/6] powerpc: wii: Don't rely on reserved memory hack if
 DISCONTIGMEM is set
Date: Tue, 20 Feb 2018 17:14:24 +0100
Message-Id: <20180220161424.5421-7-j.neuschaefer@gmx.net>
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
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

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 4682327f76a9..589ac87a3ce0 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -81,13 +81,16 @@ void __init wii_memory_fixups(void)
 	BUG_ON(memblock.memory.cnt != 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
 
+	/* determine hole */
+	wii_hole_start = ALIGN(p[0].base + p[0].size, PAGE_SIZE);
+	wii_hole_size = p[1].base - wii_hole_start;
+
+#ifndef CONFIG_DISCONTIGMEM
 	/* trim unaligned tail */
 	memblock_remove(ALIGN(p[1].base + p[1].size, PAGE_SIZE),
 			(phys_addr_t)ULLONG_MAX);
 
-	/* determine hole, add & reserve them */
-	wii_hole_start = ALIGN(p[0].base + p[0].size, PAGE_SIZE);
-	wii_hole_size = p[1].base - wii_hole_start;
+	/* add & reserve hole */
 	memblock_add(wii_hole_start, wii_hole_size);
 	memblock_reserve(wii_hole_start, wii_hole_size);
 
@@ -96,6 +99,7 @@ void __init wii_memory_fixups(void)
 
 	/* allow ioremapping the address space in the hole */
 	__allow_ioremap_reserved = 1;
+#endif
 }
 
 unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
-- 
2.16.1
