Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCvYX5z7qzDsxX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 03:15:44 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tCvYX2kDLz9t10
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2016 03:15:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA8GDUAl122744
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Nov 2016 11:15:42 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26kh42ucxm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Nov 2016 11:15:42 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Nov 2016 09:15:41 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/3] Enable storage keys for radix - user mode execution
In-Reply-To: <1478007500-23624-4-git-send-email-bsingharora@gmail.com>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
 <1478007500-23624-4-git-send-email-bsingharora@gmail.com>
Date: Tue, 08 Nov 2016 21:45:36 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874m3i2biv.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> ISA 3 defines new encoded access authority that allows instruction
> access prevention in privileged mode and allows normal access
> to problem state. This patch just enables IAMR (Instruction Authority
> Mask Register), enabling AMR would require more work.


We may want to explain what the rules are with details like IAMR class 0
bit 1 controls the instruction access etc. Also we can metion that we
now setup user pages such that EAA[0] is set to 0

>
> I've tested this with a buggy driver and a simple payload. The payload
> is specific to the build I've tested.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 0fdd8ed..cd3d400 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -339,6 +339,24 @@ static void __init radix_init_amor(void)
>  	mtspr(SPRN_AMOR, amor);
>  }
>  
> +/*
> + * For radix page tables we setup, the IAMR values as follows
> + * IMAR = 0100...00 (key 0 is set to 1)
> + * AMR, UAMR, UAMOR are not affected
> + */
> +static void __init radix_init_iamr(void)
> +{
> +	unsigned long iamr_mask = 0x4000000000000000;
> +	unsigned long iamr = mfspr(SPRN_IAMR);
> +
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		return;

is this needed ?

> +
> +	iamr |= iamr_mask;
> +
> +	mtspr(SPRN_IAMR, iamr);
> +}

Why do '|'. Who else can set this ?

> +
>  void __init radix__early_init_mmu(void)
>  {
>  	unsigned long lpcr;
> @@ -398,6 +416,7 @@ void __init radix__early_init_mmu(void)
>  		radix_init_amor();
>  	}
>  
> +	radix_init_iamr();
>  	radix_init_pgtable();
>  }

What about secondary cpus ?

-aneesh
