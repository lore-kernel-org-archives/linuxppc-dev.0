Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j3RP1yTHzF2Fm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 18:39:13 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4B8csbM059631
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 04:39:10 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hw6nk2xp6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 04:39:09 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Fri, 11 May 2018 09:39:07 +0100
Subject: Re: [PATCH v5 1/7] powerpc: Add TIDR CPU feature for POWER9
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-2-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 10:38:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <215f7aba-4e24-bc09-e164-1618693be072@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/05/2018 à 08:12, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch adds a CPU feature bit to show whether the CPU has
> the TIDR register available, enabling as_notify/wait in userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>



>   arch/powerpc/include/asm/cputable.h | 3 ++-
>   arch/powerpc/kernel/dt_cpu_ftrs.c   | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 66fcab13c8b4..9c0a3083571b 100644
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
> index 8ab51f6ca03a..415555e5b69f 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -716,6 +716,7 @@ static __init void cpufeatures_cpu_quirks(void)
>   	if ((version & 0xffff0000) == 0x004e0000) {
>   		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
>   		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TLBIE_BUG;
> +		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TIDR;
>   	}
> 
>   	/*
> 
