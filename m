Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8Lg3JyFzF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:47 +1000 (AEST)
Message-Id: <24c0be0ae1d8b9eb800f1e602979a8f79f8f51c2.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 20/20] powerpc/8xx: set GUARDED attribute in the PMD
 directly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:43 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the 8xx, the GUARDED attribute of the pages is managed in the
L1 entry, therefore to avoid having to copy it into L1 entry
at each TLB miss, we set it in the PMD.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 3 ++-
 arch/powerpc/kernel/head_8xx.S               | 9 ---------
 arch/powerpc/platforms/Kconfig.cputype       | 1 +
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 8c9872d93257..20d4c1c04726 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -62,10 +62,11 @@
 
 #define _PMD_PRESENT	0x0001
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
-#define _PMD_BAD	0x0fd0
+#define _PMD_BAD	0x0fc0
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 #define _PMD_PAGE_512K	0x0004
+#define _PMD_GUARDED	0x0010
 #define _PMD_USER	0x0020	/* APG 1 */
 
 #define _PTE_NONE_MASK	0
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3e38af7489a9..89974c938617 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -452,15 +452,6 @@ DataStoreTLBMiss:
 	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
 
-	/* Insert the Guarded flag into the TWC from the Linux PTE.
-	 * It is bit 27 of both the Linux PTE and the TWC (at least
-	 * I got that right :-).  It will be better when we can put
-	 * this into the Linux pgd/pmd and load it in the operation
-	 * above.
-	 */
-	rlwimi	r11, r10, 0, _PAGE_GUARDED
-	mtspr	SPRN_MD_TWC, r11
-
 	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
 	 * We also need to know if the insn is a load/store, so:
 	 * Clear _PAGE_PRESENT and load that which will
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d0984546fbec..c92d084a5a23 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
+	select PPC_PMD_GUARDED
 
 config 40x
 	bool "AMCC 40x"
-- 
2.13.3
