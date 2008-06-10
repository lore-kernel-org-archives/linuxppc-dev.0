Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Tue, 10 Jun 2008 18:01:01 -0400
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20080610220101.10257.57966.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
References: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 01/06] powerpc: hash_huge_page() should get the WIMG bits
	from the lpte
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: hash_huge_page() should get the WIMG bits from the lpte

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/mm/hugetlbpage.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff -Nurp linux000/arch/powerpc/mm/hugetlbpage.c linux001/arch/powerpc/mm/hugetlbpage.c
--- linux000/arch/powerpc/mm/hugetlbpage.c	2008-04-16 21:49:44.000000000 -0500
+++ linux001/arch/powerpc/mm/hugetlbpage.c	2008-06-10 16:48:59.000000000 -0500
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
