Return-Path: <galak@gate.crashing.org>
Date: Tue, 15 Nov 2005 11:03:24 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0511151102540.25366-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] powerpc: replace page_to_virt() with lowmem_page_address()
 for Book-E
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

page_to_virt and lowmem_page_address provided equiavlent functionality
so use the more standard lowmem_page_address

This also addresses build issue in ARCH=powerpc since page_to_virt()
has been removed from include/asm-powerpc/page.h

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit bd544f8830a563d50d58970c9360379efc555641
tree 887891cdf18bef998f5b5a5ffff9b879ff3591db
parent 1b5b521b837ee0a9366a0750d915e09566229be4
author Kumar Gala <galak@kernel.crashing.org> Tue, 15 Nov 2005 11:03:34 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 15 Nov 2005 11:03:34 -0600

 include/asm-ppc/pgalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-ppc/pgalloc.h b/include/asm-ppc/pgalloc.h
index 931b6de..bdefd1c 100644
--- a/include/asm-ppc/pgalloc.h
+++ b/include/asm-ppc/pgalloc.h
@@ -28,7 +28,7 @@ extern void pgd_free(pgd_t *pgd);
 #define pmd_populate_kernel(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (unsigned long)pte | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (unsigned long)page_to_virt(pte) | _PMD_PRESENT)
+		(pmd_val(*(pmd)) = (unsigned long)lowmem_page_address(pte) | _PMD_PRESENT)
 #endif
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
