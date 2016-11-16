Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJc7z5d1lzDvmr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 18:58:23 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG7rXP9012932
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 02:58:21 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26rcgc66yp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 02:58:21 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 00:58:21 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [powerpc v6 1/3] Setup AMOR in HV mode
In-Reply-To: <1479192976-17847-2-git-send-email-bsingharora@gmail.com>
References: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
 <1479192976-17847-2-git-send-email-bsingharora@gmail.com>
Date: Wed, 16 Nov 2016 13:28:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871sybn9ex.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> AMOR should be setup in HV mode, we set it up once
> and let the generic kernel handle IAMR. This patch is
> used to enable storage keys in a following patch as
> defined in ISA 3. We don't setup AMOR in DD1, since we
> can't setup IAMR in DD1 (bits have to be 0). If we setup
> AMOR some other code could potentially try to set IAMR
> (guest kernel for example).
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index ed7bddc..7aa104d 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -320,6 +320,27 @@ static void update_hid_for_radix(void)
>  		cpu_relax();
>  }
>  
> +/*
> + * In HV mode, we init AMOR so that the hypervisor
> + * and guest can setup IMAR, enable key 0 and set
> + * it to 1
> + * AMOR = 1100....00 (Mask for key 0 is 11)
> + */
> +static void radix_init_amor(void)
> +{
> +	unsigned long amor_mask = 0xc000000000000000;
> +	unsigned long amor;

I guess michael mentioned this in another email, why two variables ?

> +
> +	/*
> +	 * The amor bits are unused in DD1
> +	 */
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		return;
> +
> +	amor = amor_mask;
> +	mtspr(SPRN_AMOR, amor);
> +}
> +
>  void __init radix__early_init_mmu(void)
>  {
>  	unsigned long lpcr;
> @@ -376,6 +397,7 @@ void __init radix__early_init_mmu(void)
>  		lpcr = mfspr(SPRN_LPCR);
>  		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>  		radix_init_partition_table();
> +		radix_init_amor();
>  	}
>  
>  	radix_init_pgtable();
> @@ -393,6 +415,7 @@ void radix__early_init_mmu_secondary(void)
>  
>  		mtspr(SPRN_PTCR,
>  		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
> +		radix_init_amor();
>  	}
>  }
>  
> -- 
> 2.5.5
