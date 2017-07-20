Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCjtD51zRzDrHR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 16:00:20 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K5whCu066558
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 02:00:18 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btpr7r80r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 02:00:17 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 16:00:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K5wuXZ25165862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:58:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K5wk6F021725
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:58:48 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net,
 mingo@redhat.com, mhocko@kernel.org
Subject: Re: [RFC v6 07/62] powerpc: use helper functions in
 __hash_page_huge() for 64K PTE
In-Reply-To: <1500177424-13695-8-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-8-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:28:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vamnps2v.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> replace redundant code in __hash_page_huge() with helper
> functions pte_get_hash_gslot() and pte_set_hash_slot()
>

Can you fold all the helper function usage into one patch ?


> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/hugetlbpage-hash64.c |   24 ++++--------------------
>  1 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 6f7aee3..e6dcd50 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -23,7 +23,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		     int ssize, unsigned int shift, unsigned int mmu_psize)
>  {
>  	real_pte_t rpte;
> -	unsigned long *hidxp;
>  	unsigned long vpn;
>  	unsigned long old_pte, new_pte;
>  	unsigned long rflags, pa, sz;
> @@ -74,16 +73,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	/* Check if pte already has an hpte (case 2) */
>  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
>  		/* There MIGHT be an HPTE for this pte */
> -		unsigned long hash, slot, hidx;
> +		unsigned long gslot;
>
> -		hash = hpt_hash(vpn, shift, ssize);
> -		hidx = __rpte_to_hidx(rpte, 0);
> -		if (hidx & _PTEIDX_SECONDARY)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += hidx & _PTEIDX_GROUP_IX;
> -
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
> +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, mmu_psize,
>  					       mmu_psize, ssize, flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
>  	}
> @@ -110,16 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  			return -1;
>  		}
>
> -		/*
> -		 * Insert slot number & secondary bit in PTE second half.
> -		 */
> -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> -		rpte.hidx &= ~(0xfUL);
> -		*hidxp = rpte.hidx  | (slot & 0xfUL);
> -		/*
> -		 * check __real_pte for details on matching smp_rmb()
> -		 */
> -		smp_wmb();
> +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
>  	}
>
>  	/*
> -- 
> 1.7.1
