Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wswSY1Mn1zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:54:52 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L6s3Hd069841
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 02:54:50 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b70ycfb72-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 02:54:50 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 16:54:47 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L6siDQ3670514
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:54:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L6sZVc018820
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:54:36 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com
Subject: Re: [RFC v2 02/12] powerpc: Free up four 64K PTE bits in 64K backed
 hpte pages.
In-Reply-To: <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
Date: Wed, 21 Jun 2017 12:24:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp85al05.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

....

> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index a84bb44..239ca86 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -22,6 +22,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		     pte_t *ptep, unsigned long trap, unsigned long flags,
>  		     int ssize, unsigned int shift, unsigned int mmu_psize)
>  {
> +	real_pte_t rpte;
>  	unsigned long vpn;
>  	unsigned long old_pte, new_pte;
>  	unsigned long rflags, pa, sz;
> @@ -61,6 +62,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
>
>  	rflags = htab_convert_pte_flags(new_pte);
> +	rpte = __real_pte(__pte(old_pte), ptep);
>
>  	sz = ((1UL) << shift);
>  	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> @@ -71,15 +73,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	/* Check if pte already has an hpte (case 2) */
>  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
>  		/* There MIGHT be an HPTE for this pte */
> -		unsigned long hash, slot;
> +		unsigned long gslot;
>
> -		hash = hpt_hash(vpn, shift, ssize);
> -		if (old_pte & H_PAGE_F_SECOND)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> -
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
> +		gslot = get_hidx_gslot(vpn, shift, ssize, rpte, 0);
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, mmu_psize,
>  					       mmu_psize, ssize, flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
>  	}
> @@ -106,8 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  			return -1;
>  		}
>
> -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +		new_pte |= set_hidx_slot(ptep, rpte, 0, slot);

We don't really need rpte here. We are just need to track one entry
here. May be it becomes simpler if use different helpers for 4k hpte and
others ?

-aneesh
