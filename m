Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtR4J4dsHzDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 03:54:24 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8EHsJ2e124883
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:54:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cyu30cwyr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:54:20 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 14 Sep 2017 11:54:17 -0600
Date: Thu, 14 Sep 2017 10:54:09 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914114449.40446d96@firefly.ozlabs.ibm.com>
Message-Id: <20170914175408.GF5698@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 11:44:49AM +1000, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:44:44 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> > in the 64K backed HPTE pages. This along with the earlier
> > patch will  entirely free  up the four bits from 64K PTE.
> > The bit numbers are  big-endian as defined in the  ISA3.0
> > 
> > This patch  does  the  following change to 64K PTE backed
> > by 64K HPTE.
> > 
> > H_PAGE_F_SECOND (S) which  occupied  bit  4  moves to the
> > 	second part of the pte to bit 60.
> > H_PAGE_F_GIX (G,I,X) which  occupied  bit 5, 6 and 7 also
> > 	moves  to  the   second part of the pte to bit 61,
> >        	62, 63, 64 respectively
> > 
> > since bit 7 is now freed up, we move H_PAGE_BUSY (B) from
> > bit  9  to  bit  7.
> > 
> > The second part of the PTE will hold
> > (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> > NOTE: None of the bits in the secondary PTE were not used
> > by 64k-HPTE backed PTE.
> > 
> > Before the patch, the 64K HPTE backed 64k PTE format was
> > as follows
> > 
> >  0 1 2 3 4  5  6  7  8 9 10...........................63
> >  : : : : :  :  :  :  : : :                            :
> >  v v v v v  v  v  v  v v v                            v
> > 
> > ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> > |x|x|x| |S |G |I |X |x|B| |x|x|................|x|x|x|x| <- primary pte
> > '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> > | | | | |  |  |  |  | | | | |..................| | | | | <- secondary pte
> > '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
> > 
> > After the patch, the 64k HPTE backed 64k PTE format is
> > as follows
> > 
> >  0 1 2 3 4  5  6  7  8 9 10...........................63
> >  : : : : :  :  :  :  : : :                            :
> >  v v v v v  v  v  v  v v v                            v
> > 
> > ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> > |x|x|x| |  |  |  |B |x| | |x|x|................|.|.|.|.| <- primary pte
> > '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> > | | | | |  |  |  |  | | | | |..................|S|G|I|X| <- secondary pte
> > '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
> > 
> > The above PTE changes is applicable to hugetlbpages aswell.
> > 
> > The patch does the following code changes:
> > 
> > a) moves  the  H_PAGE_F_SECOND and  H_PAGE_F_GIX to 4k PTE
> > 	header   since it is no more needed b the 64k PTEs.
> > b) abstracts  out __real_pte() and __rpte_to_hidx() so the
> > 	caller  need not know the bit location of the slot.
> > c) moves the slot bits to the secondary pte.
> > 
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/hash-4k.h  |    3 ++
> >  arch/powerpc/include/asm/book3s/64/hash-64k.h |   29 +++++++++++-------------
> >  arch/powerpc/include/asm/book3s/64/hash.h     |    3 --
> >  arch/powerpc/mm/hash64_64k.c                  |   23 ++++++++-----------
> >  arch/powerpc/mm/hugetlbpage-hash64.c          |   18 ++++++---------
> >  5 files changed, 33 insertions(+), 43 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > index e66bfeb..dc153c6 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > @@ -16,6 +16,9 @@
> >  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
> >  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
> >  
> > +#define H_PAGE_F_GIX_SHIFT	56
> > +#define H_PAGE_F_SECOND	_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> > +#define H_PAGE_F_GIX	(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> >  #define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
> >  
> >  /* PTE flags to conserve for HPTE identification */
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > index e038f1c..89ef5a9 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > @@ -12,7 +12,7 @@
> >   */
> >  #define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
> >  #define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
> > -#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */
> > +#define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
> >  
> >  /*
> >   * We need to differentiate between explicit huge page and THP huge
> > @@ -21,8 +21,7 @@
> >  #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
> >  
> >  /* PTE flags to conserve for HPTE identification */
> > -#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
> > -			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
> > +#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | H_PAGE_COMBO)
> >  /*
> >   * we support 16 fragments per PTE page of 64K size.
> >   */
> > @@ -50,24 +49,22 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
> >  	unsigned long *hidxp;
> >  
> >  	rpte.pte = pte;
> > -	rpte.hidx = 0;
> > -	if (pte_val(pte) & H_PAGE_COMBO) {
> > -		/*
> > -		 * Make sure we order the hidx load against the H_PAGE_COMBO
> > -		 * check. The store side ordering is done in __hash_page_4K
> > -		 */
> > -		smp_rmb();
> > -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > -		rpte.hidx = *hidxp;
> > -	}
> > +	/*
> > +	 * Ensure that we do not read the hidx before we read
> > +	 * the pte. Because the writer side is  expected
> > +	 * to finish writing the hidx first followed by the pte,
> > +	 * by using smp_wmb().
> > +	 * pte_set_hash_slot() ensures that.
> > +	 */
> > +	smp_rmb();
> > +	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > +	rpte.hidx = *hidxp;
> >  	return rpte;
> >  }
> >  
> >  static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
> >  {
> > -	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
> > -		return (rpte.hidx >> (index<<2)) & 0xf;
> > -	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
> > +	return ((rpte.hidx >> (index<<2)) & 0xfUL);
> >  }
> >  
> >  /*
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> > index 8ce4112..46f3a23 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> > @@ -8,9 +8,6 @@
> >   *
> >   */
> >  #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
> > -#define H_PAGE_F_GIX_SHIFT	56
> > -#define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> > -#define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> >  #define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
> >  
> >  #ifdef CONFIG_PPC_64K_PAGES
> > diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> > index c6c5559..9c63844 100644
> > --- a/arch/powerpc/mm/hash64_64k.c
> > +++ b/arch/powerpc/mm/hash64_64k.c
> > @@ -103,8 +103,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		 * On hash insert failure we use old pte value and we don't
> >  		 * want slot information there if we have a insert failure.
> >  		 */
> > -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > +		old_pte &= ~H_PAGE_HASHPTE;
> > +		new_pte &= ~H_PAGE_HASHPTE;
> 
> Shouldn't we set old/new_pte.slot = invalid? via rpte.hidx

by resetting the H_PAGE_HASHPTE flag, we are invalidating
slot information.  Would that not be sufficient?

RP

> 
> >  		goto htab_insert_hpte;
> >  	}
> >  	/*
> > @@ -227,6 +227,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  		    unsigned long vsid, pte_t *ptep, unsigned long trap,
> >  		    unsigned long flags, int ssize)
> >  {
> > +	real_pte_t rpte;
> >  	unsigned long hpte_group;
> >  	unsigned long rflags, pa;
> >  	unsigned long old_pte, new_pte;
> > @@ -263,6 +264,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
> >  
> >  	rflags = htab_convert_pte_flags(new_pte);
> > +	rpte = __real_pte(__pte(old_pte), ptep);
> >  
> >  	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> >  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> > @@ -270,18 +272,13 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  
> >  	vpn  = hpt_vpn(ea, vsid, ssize);
> >  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
> > +		unsigned long gslot;
> >  		/*
> >  		 * There MIGHT be an HPTE for this pte
> >  		 */
> > -		hash = hpt_hash(vpn, shift, ssize);
> > -		if (old_pte & H_PAGE_F_SECOND)
> > -			hash = ~hash;
> > -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> > -
> > -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> > -					       MMU_PAGE_64K, ssize,
> > -					       flags) == -1)
> > +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
> > +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_64K,
> > +				MMU_PAGE_64K, ssize, flags) == -1)
> >  			old_pte &= ~_PAGE_HPTEFLAGS;
> >  	}
> >  
> > @@ -328,9 +325,9 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  					   MMU_PAGE_64K, MMU_PAGE_64K, old_pte);
> >  			return -1;
> >  		}
> > +
> >  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> > -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> > -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> > +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
> >  	}
> >  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
> >  	return 0;
> > diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> > index a84bb44..d52d667 100644
> > --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> > +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> > @@ -22,6 +22,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		     pte_t *ptep, unsigned long trap, unsigned long flags,
> >  		     int ssize, unsigned int shift, unsigned int mmu_psize)
> >  {
> > +	real_pte_t rpte;
> >  	unsigned long vpn;
> >  	unsigned long old_pte, new_pte;
> >  	unsigned long rflags, pa, sz;
> > @@ -61,6 +62,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
> >  
> >  	rflags = htab_convert_pte_flags(new_pte);
> > +	rpte = __real_pte(__pte(old_pte), ptep);
> >  
> >  	sz = ((1UL) << shift);
> >  	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> > @@ -71,16 +73,11 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  	/* Check if pte already has an hpte (case 2) */
> >  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
> >  		/* There MIGHT be an HPTE for this pte */
> > -		unsigned long hash, slot;
> > +		unsigned long gslot;
> >  
> > -		hash = hpt_hash(vpn, shift, ssize);
> > -		if (old_pte & H_PAGE_F_SECOND)
> > -			hash = ~hash;
> > -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> > -
> > -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
> > -					       mmu_psize, ssize, flags) == -1)
> > +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
> > +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, mmu_psize,
> > +				mmu_psize, ssize, flags) == -1)
> >  			old_pte &= ~_PAGE_HPTEFLAGS;
> >  	}
> >  
> > @@ -106,8 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  			return -1;
> >  		}
> >  
> > -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> > -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> > +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
> >  	}
> >  
> >  	/*
> 
> Balbir

-- 
Ram Pai
