Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcHJm2lLZzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 22:15:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org,
	pc@us.ibm.com
Subject: [PATCH] powerpc/64: Fix L1D cache shape vector reporting L1I values
Date: Mon,  6 Mar 2017 22:15:29 +1100
Message-Id: <1488798929-4546-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems we didn't pay quite enough attention when testing the new cache
shape vectors, which means we didn't notice the bug where the vector for
the L1D was using the L1I values. Fix it, resulting in eg:

  L1I  cache size:     0x8000      32768B         32K
  L1I  line size:        0x80       8-way associative
  L1D  cache size:    0x10000      65536B         64K
  L1D  line size:        0x80       8-way associative

Fixes: 98a5f361b862 ("powerpc: Add new cache geometry aux vectors")
Cut-and-paste-bug-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Badly-reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 93b9b84568e8..09bde6e34f5d 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -144,8 +144,8 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #define ARCH_DLINFO_CACHE_GEOMETRY					\
 	NEW_AUX_ENT(AT_L1I_CACHESIZE, ppc64_caches.l1i.size);		\
 	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY, get_cache_geometry(l1i));	\
-	NEW_AUX_ENT(AT_L1D_CACHESIZE, ppc64_caches.l1i.size);		\
-	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY, get_cache_geometry(l1i));	\
+	NEW_AUX_ENT(AT_L1D_CACHESIZE, ppc64_caches.l1d.size);		\
+	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY, get_cache_geometry(l1d));	\
 	NEW_AUX_ENT(AT_L2_CACHESIZE, ppc64_caches.l2.size);		\
 	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY, get_cache_geometry(l2));	\
 	NEW_AUX_ENT(AT_L3_CACHESIZE, ppc64_caches.l3.size);		\
-- 
2.7.4
