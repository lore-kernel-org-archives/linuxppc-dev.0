Return-Path: <kniht@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6FFCDE17B
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 03:21:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4DHNOcM014286
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 13:23:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4DHLExj077228
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 13:21:14 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4DHLDxJ027182
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 13:21:14 -0400
Message-ID: <4829CE0C.80800@us.ibm.com>
Date: Tue, 13 May 2008 12:21:16 -0500
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/6 v2] powerpc: function for allocating gigantic pages
References: <4829CAC3.30900@us.ibm.com>
In-Reply-To: <4829CAC3.30900@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nick Piggin <npiggin@suse.de>, Nishanth Aravamudan <nacc@us.ibm.com>,
	Andi Kleen <andi@firstfloor.org>, Paul Mackerras <paulus@samba.org>
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 16G page locations have been saved during early boot in an array.
The alloc_bm_huge_page() function adds a page from here to the
huge_boot_pages list.


Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
---

 arch/powerpc/mm/hugetlbpage.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 26f212f..383b3b2 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -29,6 +29,12 @@
 
 #define NUM_LOW_AREAS	(0x100000000UL >> SID_SHIFT)
 #define NUM_HIGH_AREAS	(PGTABLE_RANGE >> HTLB_AREA_SHIFT)
+#define MAX_NUMBER_GPAGES	1024
+
+/* Tracks the 16G pages after the device tree is scanned and before the
+ *  huge_boot_pages list is ready.  */
+static unsigned long gpage_freearray[MAX_NUMBER_GPAGES];
+static unsigned nr_gpages;
 
 unsigned int hugepte_shift;
 #define PTRS_PER_HUGEPTE	(1 << hugepte_shift)
@@ -104,6 +110,22 @@ pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr)
 }
 #endif
 
+/* Moves the gigantic page addresses from the temporary list to the
+  * huge_boot_pages list.
+ */
+int alloc_bm_huge_page(struct hstate *h)
+{
+	struct huge_bm_page *m;
+	if (nr_gpages == 0)
+		return 0;
+	m = phys_to_virt(gpage_freearray[--nr_gpages]);
+	gpage_freearray[nr_gpages] = 0;
+	list_add(&m->list, &huge_boot_pages);
+	m->hstate = h;
+	return 1;
+}
+
+
 /* Modelled after find_linux_pte() */
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
