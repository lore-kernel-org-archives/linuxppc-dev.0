Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy3Rj5RZ2zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 19:23:13 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v349ITaL026097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 05:23:10 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29m259aa0x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 05:23:09 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 14:53:06 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v349N4Ja5832770
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 14:53:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v349N3OH030889
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 14:53:04 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Add missing global TLBI if cxl is active
In-Reply-To: <20170329171942.14267-1-fbarrat@linux.vnet.ibm.com>
References: <20170329171942.14267-1-fbarrat@linux.vnet.ibm.com>
Date: Tue, 04 Apr 2017 14:53:02 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874ly434sp.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Commit 4c6d9acce1f4 ("powerpc/mm: Add hooks for cxl") converted local
> TLBIs to global if the cxl driver is active. It is necessary because
> the CAPP snoops invalidations to forward them to the PSL on the cxl
> adapter.
> However one path was apparently forgotten. native_flush_hash_range()
> still sends local TLBIs, as found out the hard way recently.
>
> This patch fixes it by following the same logic as previously: if the
> cxl driver is active, the local TLBIs are 'upgraded' to global.
>
> Fixes: 4c6d9acce1f4 ("powerpc/mm: Add hooks for cxl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/hash_native_64.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index cc33260..65bb8f3 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -638,6 +638,10 @@ static void native_flush_hash_range(unsigned long number, int local)
>  	unsigned long psize = batch->psize;
>  	int ssize = batch->ssize;
>  	int i;
> +	unsigned int use_local;
> +
> +	use_local = local && mmu_has_feature(MMU_FTR_TLBIEL) &&
> +		mmu_psize_defs[psize].tlbiel && !cxl_ctx_in_use();
>
>  	local_irq_save(flags);
>
> @@ -667,8 +671,7 @@ static void native_flush_hash_range(unsigned long number, int local)
>  		} pte_iterate_hashed_end();
>  	}
>
> -	if (mmu_has_feature(MMU_FTR_TLBIEL) &&
> -	    mmu_psize_defs[psize].tlbiel && local) {
> +	if (use_local) {
>  		asm volatile("ptesync":::"memory");
>  		for (i = 0; i < number; i++) {
>  			vpn = batch->vpn[i];
> -- 
> 2.9.3
