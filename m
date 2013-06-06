Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 8AA512C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 17:20:49 +1000 (EST)
Date: Thu, 6 Jun 2013 00:20:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
Message-Id: <20130606002034.2b442e8a.akpm@linux-foundation.org>
In-Reply-To: <8738svyds4.fsf@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1370475066.3766.249.camel@pasglop>
 <20130605171310.065c6fe2a3313c69bcfa0fc8@linux-foundation.org>
 <8738svyds4.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 06 Jun 2013 11:35:47 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Thu, 06 Jun 2013 09:31:06 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> >> On Wed, 2013-06-05 at 20:58 +0530, Aneesh Kumar K.V wrote:
> >> > 
> >> > This is the second patchset needed to support THP on ppc64. Some of the changes
> >> > included in this series are tricky in that it changes the powerpc linux page table
> >> > walk subtly. We also overload few of the pte flags for ptes at PMD level (huge
> >> > page PTEs).
> >> > 
> >> > The related mm/ changes are already merged to Andrew's -mm tree.
> >> 
> >> If I am to put that into powerpc-next, I need the dependent mm/ changes as well.
> >> 
> >> Do you have them in the form of a separate git tree that is *exactly* (same SHA1s)
> >> what is expected to go upstream via Andrew ?
> >> 
> >> Andrew, are they fully acked on your side and ready to go ?
> >
> > Not being on linuxppc-dev I'm at a bit of a loss here.
> >
> > I assume we're referring to
> >
> > mm-thp-add-pmd-args-to-pgtable-deposit-and-withdraw-apis.patch
> > mm-thp-withdraw-the-pgtable-after-pmdp-related-operations.patch
> > mm-thp-withdraw-the-pgtable-after-pmdp-related-operations-fix.patch
> > mm-thp-dont-use-hpage_shift-in-transparent-hugepage-code.patch
> > mm-thp-deposit-the-transpare-huge-pgtable-before-set_pmd.patch
> >
> 
> There is one more:
> 
> mm/THP: Use the right function when updating access flags
> 
> mm-thp-use-the-right-function-when-updating-access-flags.patc

Hereunder.  This actually precedes the above four(+fix) patches.


From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: mm/thp: use the correct function when updating access flags

We should use pmdp_set_access_flags to update access flags.  Archs like
powerpc use extra checks(_PAGE_BUSY) when updating a hugepage PTE.  A
set_pmd_at doesn't do those checks.  We should use set_pmd_at only when
updating a none hugepage PTE.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>a
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN mm/huge_memory.c~mm-thp-use-the-right-function-when-updating-access-flags mm/huge_memory.c
--- a/mm/huge_memory.c~mm-thp-use-the-right-function-when-updating-access-flags
+++ a/mm/huge_memory.c
@@ -1265,7 +1265,9 @@ struct page *follow_trans_huge_pmd(struc
 		 * young bit, instead of the current set_pmd_at.
 		 */
 		_pmd = pmd_mkyoung(pmd_mkdirty(*pmd));
-		set_pmd_at(mm, addr & HPAGE_PMD_MASK, pmd, _pmd);
+		if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
+					  pmd, _pmd,  1))
+			update_mmu_cache_pmd(vma, addr, pmd);
 	}
 	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
 		if (page->mapping && trylock_page(page)) {
_
