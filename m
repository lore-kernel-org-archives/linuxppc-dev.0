Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2XT0P5XzF0l3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:28 +1100 (AEDT)
Message-Id: <926230109cba48b36e119ef3c8f6ee541e3ecee0.1515759812.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
References: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/8] powerpc/8xx: remove unused _PAGE_WRITETHRU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:25 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_PAGE_WRITETHRU is only used in:
* AMIGA_Z2RAM block driver which is never activated on powerPC
* Video/FB driver which is for PPC_PMAC

Therefore, no need to spend time in 8xx TLB miss handlers for
handling it.

And by removing it, we free up bit 20 which then avoids having
to clear it on each TLB miss.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 3 +--
 arch/powerpc/include/asm/nohash/pgtable.h    | 2 ++
 arch/powerpc/kernel/head_8xx.S               | 5 -----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 6dc0180fd5c7..19a5ecaef265 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -41,8 +41,7 @@
 #define _PAGE_GUARDED	0x0010	/* Copied to L1 G entry in DTLB */
 #define _PAGE_USER	0x0020	/* Copied to L1 APG lsb */
 #define _PAGE_EXEC	0x0040	/* Copied to L1 APG */
-#define _PAGE_WRITETHRU	0x0080	/* software: caching is write through */
-#define _PAGE_ACCESSED	0x0800	/* software: page referenced */
+#define _PAGE_ACCESSED	0x0080	/* software: page referenced */
 
 #define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 5c68f4a59f75..84120d65d0e9 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -212,8 +212,10 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 #define pgprot_cached(prot)       (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
 				            _PAGE_COHERENT))
 
+#if _PAGE_WRITETHRU != 0
 #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
 				            _PAGE_COHERENT | _PAGE_WRITETHRU))
+#endif
 
 #define pgprot_cached_noncoherent(prot) \
 		(__pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL))
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 641c9a9d4db2..6399dcadf51d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -486,10 +486,6 @@ _ENTRY(DTLBMiss_jmp)
 	 * above.
 	 */
 	rlwimi	r11, r10, 0, 26, 27
-	/* Insert the WriteThru flag into the TWC from the Linux PTE.
-	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
-	 */
-	rlwimi	r11, r10, 32-5, 30, 30
 	mtspr	SPRN_MD_TWC, r11
 
 	/* In 4k pages mode, SPS (bit 28) in RPN must match PS[1] (bit 29)
@@ -523,7 +519,6 @@ _ENTRY(DTLBMiss_jmp)
 #else
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 #endif
-	rlwimi	r10, r11, 0, 20, 20	/* clear 20 */
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
-- 
2.13.3
