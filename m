Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A987B1A0932
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 22:15:45 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Emilian.Medve@Freescale.com
Subject: [PATCH 5/5] powerpc: make __ffs return unsigned long
Date: Wed, 17 Sep 2014 22:15:37 +1000
Message-Id: <1410956137-4824-5-git-send-email-anton@samba.org>
In-Reply-To: <1410956137-4824-1-git-send-email-anton@samba.org>
References: <1410956137-4824-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm seeing a build warning in mm/nobootmem.c after removing
bootmem:

mm/nobootmem.c: In function '__free_pages_memory':
include/linux/kernel.h:713:17: warning: comparison of distinct pointer types lacks a cast [enabled by default]
  (void) (&_min1 == &_min2);  \
                 ^
mm/nobootmem.c:90:11: note: in expansion of macro 'min'
   order = min(MAX_ORDER - 1UL, __ffs(start));
           ^

The rest of the worlds seems to define __ffs as returning unsigned long,
so lets do that.

Signed-off-by: Anton Blanchard <anton@samba.org>
Tested-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/include/asm/bitops.h | 2 +-
 arch/powerpc/sysdev/fsl_pci.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index bd3bd57..c633f05 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -213,7 +213,7 @@ static __inline__ unsigned long ffz(unsigned long x)
 	return __ilog2(x & -x);
 }
 
-static __inline__ int __ffs(unsigned long x)
+static __inline__ unsigned long __ffs(unsigned long x)
 {
 	return __ilog2(x & -x);
 }
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index c507767..dae96fb 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -152,7 +152,7 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 		flags |= 0x10000000; /* enable relaxed ordering */
 
 	for (i = 0; size > 0; i++) {
-		unsigned int bits = min(ilog2(size),
+		unsigned int bits = min_t(u32, ilog2(size),
 					__ffs(pci_addr | phys_addr));
 
 		if (index + i >= 5)
-- 
1.9.1
