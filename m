Return-Path: <hughd@google.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69AEA1A08A5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 11:51:12 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id q63so27699078pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 Jan 2016 16:51:12 -0800 (PST)
Date: Sat, 9 Jan 2016 16:50:53 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: [PATCH next] powerpc/mm: fix _PAGE_PTE breaking swapoff
Message-ID: <alpine.LSU.2.11.1601091643060.9808@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Swapoff after swapping hangs on the G5.  That's because the _PAGE_PTE
bit, added by set_pte_at(), is not expected by swapoff: so swap ptes
cannot be recognized.

I'm not sure whether a swap pte should or should not have _PAGE_PTE set:
this patch assumes not, and fixes set_pte_at() to set _PAGE_PTE only on
present entries.

But if that's wrong, a reasonable alternative would be to
#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) & ~_PAGE_PTE })
#define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 arch/powerpc/mm/pgtable.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- 4.4-next/arch/powerpc/mm/pgtable.c	2016-01-06 11:54:01.477512251 -0800
+++ linux/arch/powerpc/mm/pgtable.c	2016-01-09 13:51:15.793485717 -0800
@@ -180,9 +180,10 @@ void set_pte_at(struct mm_struct *mm, un
 	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
 		(_PAGE_PRESENT | _PAGE_USER));
 	/*
-	 * Add the pte bit when tryint set a pte
+	 * Add the pte bit when setting a pte (not a swap entry)
 	 */
-	pte = __pte(pte_val(pte) | _PAGE_PTE);
+	if (pte_val(pte) & _PAGE_PRESENT)
+		pte = __pte(pte_val(pte) | _PAGE_PTE);
 
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
