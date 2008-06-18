Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080618223329.009886485@linux.vnet.ibm.com>
References: <20080618223254.966080905@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2008 17:32:56 -0500
From: shaggy@linux.vnet.ibm.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 2/6] powerpc: hash_huge_page() should get the WIMG bits from
	the lpte
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Linuxppc-dev@ozlabs.org,
	linux-mm@kvack.org, Paul Mackerras <paulus@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/hugetlbpage.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.26-rc5/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- linux-2.6.26-rc5.orig/arch/powerpc/mm/hugetlbpage.c
+++ linux-2.6.26-rc5/arch/powerpc/mm/hugetlbpage.c
@@ -502,9 +502,8 @@ repeat:
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
 
 		/* Add in WIMG bits */
-		/* XXX We should store these in the pte */
-		/* --BenH: I think they are ... */
-		rflags |= _PAGE_COHERENT;
+		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
+				      _PAGE_COHERENT | _PAGE_GUARDED));
 
 		/* Insert into the hash table, primary slot */
 		slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags, 0,

-- 
