Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCjr520gBzDrGD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:58:29 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K5wA5U136563
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:58:27 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btce3w5b7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:58:26 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 15:58:24 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K5wMWw21954594
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:58:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K5wKHm020201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:58:21 +1000
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
Subject: Re: [RFC v6 06/62] powerpc: use helper functions in __hash_page_64K()
 for 64K PTE
In-Reply-To: <1500177424-13695-7-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-7-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:28:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3rjps3u.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> replace redundant code in __hash_page_64K() with helper
> functions pte_get_hash_gslot() and pte_set_hash_slot()
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/hash64_64k.c |   24 ++++--------------------
>  1 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 0012618..645f621 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -244,7 +244,6 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  		    unsigned long flags, int ssize)
>  {
>  	real_pte_t rpte;
> -	unsigned long *hidxp;
>  	unsigned long hpte_group;
>  	unsigned long rflags, pa;
>  	unsigned long old_pte, new_pte;
> @@ -289,18 +288,12 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>
>  	vpn  = hpt_vpn(ea, vsid, ssize);
>  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
> -		unsigned long hash, slot, hidx;
> -
> -		hash = hpt_hash(vpn, shift, ssize);
> -		hidx = __rpte_to_hidx(rpte, 0);
> -		if (hidx & _PTEIDX_SECONDARY)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += hidx & _PTEIDX_GROUP_IX;
> +		unsigned long gslot;
>  		/*
>  		 * There MIGHT be an HPTE for this pte
>  		 */
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_64K,
>  					       MMU_PAGE_64K, ssize,
>  					       flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
> @@ -350,17 +343,8 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
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
>  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
>  	}
>  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
>  	return 0;
> -- 
> 1.7.1
