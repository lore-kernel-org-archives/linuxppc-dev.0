Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fq7Q3kf5zF1S1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 03:17:38 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w47HF8RI013021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 13:17:34 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htq5ck8rq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 13:17:33 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 7 May 2018 18:17:31 +0100
Subject: Re: [PATCH v2 1/7] powerpc: Add TIDR CPU feature for Power9
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-2-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 19:17:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2f95cc6f-9843-e2b9-6fca-2f4153317a5f@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch adds a CPU feature bit to show whether the CPU has
> the TIDR register available, enabling as_notify/wait in userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/include/asm/cputable.h | 3 ++-
>   arch/powerpc/kernel/dt_cpu_ftrs.c   | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 4e332f3531c5..54c4cbbe57b4 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -215,6 +215,7 @@ static inline void cpu_feature_keys_init(void) { }
>   #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0000100000000000)
>   #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x0000200000000000)
>   #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000400000000000)
> +#define CPU_FTR_P9_TIDR			LONG_ASM_CONST(0x0000800000000000)
> 
>   #ifndef __ASSEMBLY__
> 
> @@ -462,7 +463,7 @@ static inline void cpu_feature_keys_init(void) { }
>   	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
>   	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
>   	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
> -	    CPU_FTR_P9_TLBIE_BUG)
> +	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
>   #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
>   			     (~CPU_FTR_SAO))
>   #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 11a3a4fed3fb..10f8b7f55637 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -722,6 +722,7 @@ static __init void cpufeatures_cpu_quirks(void)
>   	if ((version & 0xffff0000) == 0x004e0000) {
>   		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
>   		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TLBIE_BUG; > +		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TIDR;


Isn't it redundant with adding the flag to CPU_FTRS_POWER9?

   Fred


>   	}
>   }
> 
