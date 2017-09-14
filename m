Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtRmS1nQ8zDqr5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 04:25:44 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8EIL8OV024536
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 14:25:38 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cyur532x7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 14:25:37 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 14 Sep 2017 14:25:37 -0400
Date: Thu, 14 Sep 2017 11:25:30 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 4/7] powerpc: Free up four 64K PTE bits in 64K backed
 HPTE pages
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-5-git-send-email-linuxram@us.ibm.com>
 <20170914114449.40446d96@firefly.ozlabs.ibm.com>
 <20170914175408.GF5698@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914175408.GF5698@ram.oc3035372033.ibm.com>
Message-Id: <20170914182530.GA5721@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 10:54:08AM -0700, Ram Pai wrote:
> On Thu, Sep 14, 2017 at 11:44:49AM +1000, Balbir Singh wrote:
> > On Fri,  8 Sep 2017 15:44:44 -0700
> > Ram Pai <linuxram@us.ibm.com> wrote:
> > 
> > > Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> > > in the 64K backed HPTE pages. This along with the earlier
> > > patch will  entirely free  up the four bits from 64K PTE.
> > > The bit numbers are  big-endian as defined in the  ISA3.0
> > > 
> > > This patch  does  the  following change to 64K PTE backed
> > > by 64K HPTE.
> > > 
> > > H_PAGE_F_SECOND (S) which  occupied  bit  4  moves to the
> > > 	second part of the pte to bit 60.
> > > H_PAGE_F_GIX (G,I,X) which  occupied  bit 5, 6 and 7 also
> > > 	moves  to  the   second part of the pte to bit 61,
> > >        	62, 63, 64 respectively
> > > 
> > > since bit 7 is now freed up, we move H_PAGE_BUSY (B) from
> > > bit  9  to  bit  7.
> > > 
> > > The second part of the PTE will hold
> > > (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> > > NOTE: None of the bits in the secondary PTE were not used
> > > by 64k-HPTE backed PTE.
> > > 
> > > Before the patch, the 64K HPTE backed 64k PTE format was
> > > as follows
> > > 
> > >  0 1 2 3 4  5  6  7  8 9 10...........................63
> > >  : : : : :  :  :  :  : : :                            :
> > >  v v v v v  v  v  v  v v v                            v
> > > 
> > > ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> > > |x|x|x| |S |G |I |X |x|B| |x|x|................|x|x|x|x| <- primary pte
> > > '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> > > | | | | |  |  |  |  | | | | |..................| | | | | <- secondary pte
> > > '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
> > > 
> > > After the patch, the 64k HPTE backed 64k PTE format is
> > > as follows
> > > 
> > >  0 1 2 3 4  5  6  7  8 9 10...........................63
> > >  : : : : :  :  :  :  : : :                            :
> > >  v v v v v  v  v  v  v v v                            v
> > > 
> > > ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> > > |x|x|x| |  |  |  |B |x| | |x|x|................|.|.|.|.| <- primary pte
> > > '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> > > | | | | |  |  |  |  | | | | |..................|S|G|I|X| <- secondary pte
> > > '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
> > > 
> > > The above PTE changes is applicable to hugetlbpages aswell.
> > > 
> > > The patch does the following code changes:
> > > 
> > > a) moves  the  H_PAGE_F_SECOND and  H_PAGE_F_GIX to 4k PTE
> > > 	header   since it is no more needed b the 64k PTEs.
> > > b) abstracts  out __real_pte() and __rpte_to_hidx() so the
> > > 	caller  need not know the bit location of the slot.
> > > c) moves the slot bits to the secondary pte.
> > > 
> > > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/book3s/64/hash-4k.h  |    3 ++
> > >  arch/powerpc/include/asm/book3s/64/hash-64k.h |   29 +++++++++++-------------
> > >  arch/powerpc/include/asm/book3s/64/hash.h     |    3 --
> > >  arch/powerpc/mm/hash64_64k.c                  |   23 ++++++++-----------
> > >  arch/powerpc/mm/hugetlbpage-hash64.c          |   18 ++++++---------
> > >  5 files changed, 33 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > > index e66bfeb..dc153c6 100644
> > > --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > > +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > > @@ -16,6 +16,9 @@
> > >  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
> > >  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
> > >  
> > > +#define H_PAGE_F_GIX_SHIFT	56
> > > +#define H_PAGE_F_SECOND	_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> > > +#define H_PAGE_F_GIX	(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> > >  #define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
> > >  
> > >  /* PTE flags to conserve for HPTE identification */
> > > diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > > index e038f1c..89ef5a9 100644
> > > --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > > +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > > @@ -12,7 +12,7 @@
> > >   */
> > >  #define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
> > >  #define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
> > > -#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */
> > > +#define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
> > >  
> > >  /*
> > >   * We need to differentiate between explicit huge page and THP huge
> > > @@ -21,8 +21,7 @@
> > >  #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
> > >  
> > >  /* PTE flags to conserve for HPTE identification */
> > > -#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
> > > -			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
> > > +#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | H_PAGE_COMBO)
> > >  /*
> > >   * we support 16 fragments per PTE page of 64K size.
> > >   */
> > > @@ -50,24 +49,22 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
> > >  	unsigned long *hidxp;
> > >  
> > >  	rpte.pte = pte;
> > > -	rpte.hidx = 0;
> > > -	if (pte_val(pte) & H_PAGE_COMBO) {
> > > -		/*
> > > -		 * Make sure we order the hidx load against the H_PAGE_COMBO
> > > -		 * check. The store side ordering is done in __hash_page_4K
> > > -		 */
> > > -		smp_rmb();
> > > -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > > -		rpte.hidx = *hidxp;
> > > -	}
> > > +	/*
> > > +	 * Ensure that we do not read the hidx before we read
> > > +	 * the pte. Because the writer side is  expected
> > > +	 * to finish writing the hidx first followed by the pte,
> > > +	 * by using smp_wmb().
> > > +	 * pte_set_hash_slot() ensures that.
> > > +	 */
> > > +	smp_rmb();
> > > +	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > > +	rpte.hidx = *hidxp;
> > >  	return rpte;
> > >  }
> > >  
> > >  static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
> > >  {
> > > -	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
> > > -		return (rpte.hidx >> (index<<2)) & 0xf;
> > > -	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
> > > +	return ((rpte.hidx >> (index<<2)) & 0xfUL);
> > >  }
> > >  
> > >  /*
> > > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> > > index 8ce4112..46f3a23 100644
> > > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> > > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> > > @@ -8,9 +8,6 @@
> > >   *
> > >   */
> > >  #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
> > > -#define H_PAGE_F_GIX_SHIFT	56
> > > -#define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> > > -#define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> > >  #define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
> > >  
> > >  #ifdef CONFIG_PPC_64K_PAGES
> > > diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> > > index c6c5559..9c63844 100644
> > > --- a/arch/powerpc/mm/hash64_64k.c
> > > +++ b/arch/powerpc/mm/hash64_64k.c
> > > @@ -103,8 +103,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> > >  		 * On hash insert failure we use old pte value and we don't
> > >  		 * want slot information there if we have a insert failure.
> > >  		 */
> > > -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > > -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > > +		old_pte &= ~H_PAGE_HASHPTE;
> > > +		new_pte &= ~H_PAGE_HASHPTE;
> > 
> > Shouldn't we set old/new_pte.slot = invalid? via rpte.hidx
> 
> by resetting the H_PAGE_HASHPTE flag, we are invalidating
> slot information.  Would that not be sufficient?

I think i misunderstood you question. Yes rpte.hidx will have
to be reset to invalid. The code does that further down in that
function.

	if (!(old_pte & H_PAGE_COMBO))
		rpte.hidx = ~0x0UL;


RP
