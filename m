Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D75A1A1916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 19:13:40 +1100 (AEDT)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8ADB140080
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 19:13:37 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Oct 2014 13:43:33 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mpe <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 3/4] powerpc/copro: Use appropriate ESID mask in
 copro_calculate_slb
In-Reply-To: <1414466730-15591-4-git-send-email-imunsie@au.ibm.com>
References: <1414466730-15591-1-git-send-email-imunsie@au.ibm.com>
 <1414466730-15591-4-git-send-email-imunsie@au.ibm.com>
Date: Tue, 28 Oct 2014 13:43:28 +0530
Message-ID: <877fzky5lj.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, greg <greg@kroah.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Munsie <imunsie@au1.ibm.com> writes:

> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This patch makes copro_calculate_slb mask the ESID by the correct mask
> for 1T vs 256M segments.
>
> This has no effect by itself as the extra bits were ignored, but it
> makes debugging the segment table entries easier and means that we can
> directly compare the ESID values for duplicates without needing to worry
> about masking in the comparison.
>
> This will be used to simplify a comparison in the following patch.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/copro_fault.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
> index 0f9939e..5a236f0 100644
> --- a/arch/powerpc/mm/copro_fault.c
> +++ b/arch/powerpc/mm/copro_fault.c
> @@ -99,8 +99,6 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
>  	u64 vsid;
>  	int psize, ssize;
>  
> -	slb->esid = (ea & ESID_MASK) | SLB_ESID_V;
> -
>  	switch (REGION_ID(ea)) {
>  	case USER_REGION_ID:
>  		pr_devel("%s: 0x%llx -- USER_REGION_ID\n", __func__, ea);
> @@ -133,6 +131,7 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
>  	vsid |= mmu_psize_defs[psize].sllp |
>  		((ssize == MMU_SEGSIZE_1T) ? SLB_VSID_B_1T : 0);
>  
> +	slb->esid = (ea & (ssize == MMU_SEGSIZE_1T ? ESID_MASK_1T : ESID_MASK)) | SLB_ESID_V;
>  	slb->vsid = vsid;
>  
>  	return 0;
> -- 
> 2.1.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
