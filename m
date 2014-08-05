Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DD871A001A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 16:37:06 +1000 (EST)
Date: Tue, 5 Aug 2014 16:37:06 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 paulmck@linux.vnet.ibm.com, Emilian.Medve@Freescale.com
Subject: [PATCH 5/5] powerpc: make __ffs return unsigned long
Message-ID: <20140805163706.688d7b84@kryten>
In-Reply-To: <20140805163218.47c86615@kryten>
References: <20140805163218.47c86615@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
---

Index: b/arch/powerpc/include/asm/bitops.h
===================================================================
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -213,7 +213,7 @@ static __inline__ unsigned long ffz(unsi
 	return __ilog2(x & -x);
 }
 
-static __inline__ int __ffs(unsigned long x)
+static __inline__ unsigned long __ffs(unsigned long x)
 {
 	return __ilog2(x & -x);
 }
Index: b/arch/powerpc/sysdev/fsl_pci.c
===================================================================
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -152,7 +152,7 @@ static int setup_one_atmu(struct ccsr_pc
 		flags |= 0x10000000; /* enable relaxed ordering */
 
 	for (i = 0; size > 0; i++) {
-		unsigned int bits = min(ilog2(size),
+		unsigned int bits = min_t(u32, ilog2(size),
 					__ffs(pci_addr | phys_addr));
 
 		if (index + i >= 5)
