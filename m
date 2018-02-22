Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znGsL52mtzDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 01:27:33 +1100 (AEDT)
Message-Id: <23e87f3c2d45a12219bb30e93707773f72ff78f9.1519305412.git.christophe.leroy@c-s.fr>
In-Reply-To: <455276187b369bf019e91715b7488e86cd932d49.1519305410.git.christophe.leroy@c-s.fr>
References: <455276187b369bf019e91715b7488e86cd932d49.1519305410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 6/6] powerpc/8xx: Increase number of slices to 64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Feb 2018 15:27:30 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the 8xx, the minimum slice size is the size of the area
covered by a single PMD entry, ie 4M in 4K pages mode and 64M in
16K pages mode.

This patch increases the number of slices from 16 to 64 on the 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: New
 v5: No change

 arch/powerpc/include/asm/nohash/32/slice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
index 95d532e18092..777d62e40ac0 100644
--- a/arch/powerpc/include/asm/nohash/32/slice.h
+++ b/arch/powerpc/include/asm/nohash/32/slice.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_PPC_MM_SLICES
 
-#define SLICE_LOW_SHIFT		28
+#define SLICE_LOW_SHIFT		26	/* 64 slices */
 #define SLICE_LOW_TOP		(0x100000000ull)
 #define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
-- 
2.13.3
