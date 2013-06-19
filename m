Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix bad pmd error with book3E config
In-reply-to: <87wqpqhb77.fsf@linux.vnet.ibm.com>
References: <1371033004-15864-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <25129.1371620895@ale.ozlabs.ibm.com> <87wqpqhb77.fsf@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 16:27:20 +1000
Message-ID: <3928.1371623240@ale.ozlabs.ibm.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Michael Neuling <mikey@neuling.org> writes:
> 
> > Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >> 
> >> Book3E uses the hugepd at PMD level and don't encode pte directly
> >> at the pmd level. So it will find the lower bits of pmd set
> >> and the pmd_bad check throws error. Infact the current code
> >> will never take the free_hugepd_range call at all because it will
> >> clear the pmd if it find a hugepd pointer.
> >> 
> >
> > Please explain what changes you are making.  Currently you are only
> > describing what the issue is.
> 
> will do
> 
> >
> > Also include which the SHA1 which caused the regression (ie
> > e2b3d202d1dba8f3546ed28224ce485bc50010be "powerpc: Switch 16GB and 16MB
> > explicit hugepages to a different page table format")
> 
> will add
> 
> >
> > Mikey
> >
> >> Reported-by: Scott Wood <scottwood@freescale.com>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/mm/hugetlbpage.c | 29 ++++++++++++++++++-----------
> >>  1 file changed, 18 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> >> index f2f01fd..0d3d3ee 100644
> >> --- a/arch/powerpc/mm/hugetlbpage.c
> >> +++ b/arch/powerpc/mm/hugetlbpage.c
> >> @@ -536,19 +536,26 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> >>  	do {
> >>  		pmd = pmd_offset(pud, addr);
> >>  		next = pmd_addr_end(addr, end);
> >> -		if (pmd_none_or_clear_bad(pmd))
> >> -			continue;
> >> +		if (!is_hugepd(pmd)) {
> >> +			/*
> >> +			 * if it is not hugepd pointer, we should already find
> >> +			 * it cleared.
> >> +			 */
> >> +			if (!pmd_none_or_clear_bad(pmd))
> >> +				WARN_ON(1);
> >
> > How often are we going to hit this?    Should this be a warn_on once or
> > even a bug_on?
> 
> it should never happen. But i was thinking killing the system may a bit
> too much, hence WARN_ON

Maybe WARN_ON_ONCE.  If you do hit it once, you are going to hit it a
lot?

Mikey

> 
> >
> > Also just make it: 
> >   WARN_ON(!pmd_none_or_clear_bad(pmd))
> >
> 
> will do
> 
> -aneesh
> 
