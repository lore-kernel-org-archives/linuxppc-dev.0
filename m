Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCtBD2pyQzDvNk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 02:13:56 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tCtBC6J6Wz9t87
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2016 02:13:55 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA8FDjVE117635
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Nov 2016 10:13:53 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26kgfxaeks-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Nov 2016 10:13:53 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Nov 2016 10:13:52 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] Setup AMOR in HV mode
In-Reply-To: <1478007500-23624-2-git-send-email-bsingharora@gmail.com>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
 <1478007500-23624-2-git-send-email-bsingharora@gmail.com>
Date: Tue, 08 Nov 2016 20:43:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a8da2edy.fsf@linux.vnet.ibm.com>
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
> defined in ISA 3
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index ed7bddc..0fdd8ed 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -320,6 +320,25 @@ static void update_hid_for_radix(void)
>  		cpu_relax();
>  }
>  
> +/*
> + * In HV mode, we init AMOR so that the hypervisor
> + * and guest can setup IMAR, enable key 0 and set
> + * it to 1
> + * AMOR = 1100....00 (Mask for key 0 is 11)
> + */
> +static void __init radix_init_amor(void)
> +{
> +	unsigned long amor_mask = 0xc000000000000000;
> +	unsigned long amor = mfspr(SPRN_AMOR);
> +
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		return;

Why is DD1 excluded ?

> +
> +	amor |= amor_mask;
> +

Can't we just init it with the constant 0xc000000000000000;
I can understand kvm code wanting to do the '|' above, but does the host
init code need to look at the previous value there ?


> +	mtspr(SPRN_AMOR, amor);
> +}
> +
>  void __init radix__early_init_mmu(void)
>  {
>  	unsigned long lpcr;
> @@ -376,6 +395,7 @@ void __init radix__early_init_mmu(void)
>  		lpcr = mfspr(SPRN_LPCR);
>  		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>  		radix_init_partition_table();
> +		radix_init_amor();
>  	}
>  
>  	radix_init_pgtable();

What about secondaries ? Don't we need to init AMOR there ?

-aneesh
