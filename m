Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4H3H6pNrzDsxb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 17:26:35 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9R6QHSU091653
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 02:26:32 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bbb5a84a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 02:26:29 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 11:56:20 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7A956E0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:56:09 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9R6QGM838797370
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:56:16 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9R6QCUL005057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:56:15 +0530
Subject: Re: [PATCH] powerpc/pseries: Use H_CLEAR_HPT to clear MMU hash table
 during kexec
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, srikar@linux.vnet.ibm.com,
 hbathini@linux.vnet.ibm.com
References: <1475318516-8447-1-git-send-email-anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 27 Oct 2016 11:56:09 +0530
MIME-Version: 1.0
In-Reply-To: <1475318516-8447-1-git-send-email-anton@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <64432903-ea6f-b7b7-f391-5ea98a497869@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/2016 04:11 PM, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> An hcall was recently added that does exactly what we need
> during kexec - it clears the entire MMU hash table, ignoring any
> VRMA mappings.
> 
> Try it and fall back to the old method if we get a failure.
> 
> On a POWER8 box with 5TB of memory, this reduces the time it takes to
> kexec a new kernel from from 4 minutes to 1 minute.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/hvcall.h     |  3 ++-
>  arch/powerpc/platforms/pseries/lpar.c | 14 +++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index 708edeb..489748e 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -275,7 +275,8 @@
>  #define H_COP			0x304
>  #define H_GET_MPP_X		0x314
>  #define H_SET_MODE		0x31C
> -#define MAX_HCALL_OPCODE	H_SET_MODE
> +#define H_CLEAR_HPT		0x358
> +#define MAX_HCALL_OPCODE	H_CLEAR_HPT
> 
>  /* H_VIOCTL functions */
>  #define H_GET_VIOA_DUMP_SIZE	0x01
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 86707e6..03884a8 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -221,7 +221,7 @@ static long pSeries_lpar_hpte_remove(unsigned long hpte_group)
>  	return -1;
>  }
> 
> -static void pSeries_lpar_hptab_clear(void)
> +static void __pSeries_lpar_clear_hpt(void)
>  {
>  	unsigned long size_bytes = 1UL << ppc64_pft_size;
>  	unsigned long hpte_count = size_bytes >> 4;
> @@ -249,6 +249,18 @@ static void pSeries_lpar_hptab_clear(void)
>  					&(ptes[j].pteh), &(ptes[j].ptel));
>  		}
>  	}
> +}
> +
> +static void pSeries_lpar_hptab_clear(void)
> +{
> +	int rc;
> +
> +	do {
> +		rc = plpar_hcall_norets(H_CLEAR_HPT);
> +	} while (rc == H_CONTINUE);
> +
> +	if (rc != H_SUCCESS)
> +		__pSeries_lpar_clear_hpt();
> 
>  #ifdef __LITTLE_ENDIAN__
>  	/*
> 
