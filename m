Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3DC0ADDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:29:33 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2QLVXj7004977
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 17:31:33 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2QLTU9A309566
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 17:29:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2QLTTY0001489
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 17:29:30 -0400
Message-ID: <47EAC048.30006@linux.vnet.ibm.com>
Date: Wed, 26 Mar 2008 16:29:44 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc: define page support for 16G pages
References: <47EABE2D.7080400@linux.vnet.ibm.com>
In-Reply-To: <47EABE2D.7080400@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, Andi Kleen <andi@firstfloor.org>,
	Adam Litke <agl@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The huge page size is setup for 16G pages if that size is specified at boot-time.  The support for
multiple huge page sizes is not being utilized yet.  That will be in a future patch.


Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
---

 hugetlbpage.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 44d3d55..b6a02b7 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -26,6 +26,7 @@
 
 #define HPAGE_SHIFT_64K	16
 #define HPAGE_SHIFT_16M	24
+#define HPAGE_SHIFT_16G	34
 
 #define NUM_LOW_AREAS	(0x100000000UL >> SID_SHIFT)
 #define NUM_HIGH_AREAS	(PGTABLE_RANGE >> HTLB_AREA_SHIFT)
@@ -589,9 +590,11 @@ void set_huge_psize(int psize)
 {
 	/* Check that it is a page size supported by the hardware and
 	 * that it fits within pagetable limits. */
-	if (mmu_psize_defs[psize].shift && mmu_psize_defs[psize].shift < SID_SHIFT &&
+	if (mmu_psize_defs[psize].shift &&
+		mmu_psize_defs[psize].shift < SID_SHIFT_1T &&
 		(mmu_psize_defs[psize].shift > MIN_HUGEPTE_SHIFT ||
-			mmu_psize_defs[psize].shift == HPAGE_SHIFT_64K)) {
+		 mmu_psize_defs[psize].shift == HPAGE_SHIFT_64K ||
+		 mmu_psize_defs[psize].shift == HPAGE_SHIFT_16G)) {
 		HPAGE_SHIFT = mmu_psize_defs[psize].shift;
 		mmu_huge_psize = psize;
 #ifdef CONFIG_PPC_64K_PAGES
@@ -599,6 +602,8 @@ void set_huge_psize(int psize)
 #else
 		if (HPAGE_SHIFT == HPAGE_SHIFT_64K)
 			hugepte_shift = (PMD_SHIFT-HPAGE_SHIFT);
+		else if (HPAGE_SHIFT == HPAGE_SHIFT_16G)
+			hugepte_shift = (PGDIR_SHIFT-HPAGE_SHIFT);
 		else
 			hugepte_shift = (PUD_SHIFT-HPAGE_SHIFT);
 #endif
@@ -625,6 +630,9 @@ static int __init hugepage_setup_sz(char *str)
 	case HPAGE_SHIFT_16M:
 		mmu_psize = MMU_PAGE_16M;
 		break;
+	case HPAGE_SHIFT_16G:
+		mmu_psize = MMU_PAGE_16G;
+		break;
 	}
 
 	if (mmu_psize >=0 && mmu_psize_defs[mmu_psize].shift)
