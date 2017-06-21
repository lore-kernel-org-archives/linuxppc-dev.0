Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtGCK66TkzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:14:37 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LKDkU3097691
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:14:34 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7p1kprpt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:14:34 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 21 Jun 2017 16:14:33 -0400
Date: Wed, 21 Jun 2017 13:14:25 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com
Subject: Re: [RFC v2 02/12] powerpc: Free up four 64K PTE bits in 64K backed
 hpte pages.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
 <87wp85al05.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wp85al05.fsf@skywalker.in.ibm.com>
Message-Id: <20170621201425.GM5845@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2017 at 12:24:34PM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> ....
> 
> > diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> > index a84bb44..239ca86 100644
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
> > @@ -71,15 +73,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
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
> > +		gslot = get_hidx_gslot(vpn, shift, ssize, rpte, 0);
> > +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, mmu_psize,
> >  					       mmu_psize, ssize, flags) == -1)
> >  			old_pte &= ~_PAGE_HPTEFLAGS;
> >  	}
> > @@ -106,8 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  			return -1;
> >  		}
> >
> > -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> > -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> > +		new_pte |= set_hidx_slot(ptep, rpte, 0, slot);
> 
> We don't really need rpte here. We are just need to track one entry
> here. May be it becomes simpler if use different helpers for 4k hpte and
> others ?

actually we need rpte here. the hidx for these 64K-hpte backed PTEs are
now stored in the second half of the pte. 
I have abstracted the helpers, so that the caller need not
know the location of the hidx. It comes in really handy.

RP
