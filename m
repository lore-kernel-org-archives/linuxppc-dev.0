Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryyw05ZtHzDqRV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 10:01:36 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PNxCBp110060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 20:01:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c3vkrrne-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 20:01:33 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 18:01:33 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A497719D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:01:05 -0600 (MDT)
Subject: Re: [PATCH 1/8] powerpc/firmware: Add definitions for new firmware
 features.
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <5e8da0dd-8f11-2e4d-720c-6ff22c781b32@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 25 Jul 2016 17:01:28 -0700
MIME-Version: 1.0
In-Reply-To: <5e8da0dd-8f11-2e4d-720c-6ff22c781b32@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5796A858.7010802@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2016 03:21 PM, Michael Bringmann wrote:
> Firmware Features: Define new bit flags representing the presence of
> new device tree properties "ibm,drc-info", and "ibm,dynamic-memory-v2".
> These flags are used to tell the front end processor when the Linux
> kernel supports the new properties, and by the front end processor to
> tell the Linux kernel that the new properties are present in the devie
> tree.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index b062924..a9d66d5 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -51,6 +51,8 @@
>  #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
>  #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
>  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
> +#define FW_FEATURE_RPS_DM2	ASM_CONST(0x0000000400000000)
> +#define FW_FEATURE_RPS_DRC_INFO	ASM_CONST(0x0000000800000000)

I can't say that these names are my favorite. Especially _RPS_DM2. I
haven't actually seen the PAPR updates that define these things, but I
would hope that these had more self explanatory names. I'm not really
sure what _RPS_ means. Like I said I haven't seen the PAPR update so
maybe that is a new acronym defined there.

-Tyrel

>  
>  #ifndef __ASSEMBLY__
>  
> @@ -66,7 +68,8 @@ enum {
>  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
>  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> -		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
> +		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> +		FW_FEATURE_RPS_DM2 | FW_FEATURE_RPS_DRC_INFO,
>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>  	FW_FEATURE_POWERNV_ALWAYS = 0,
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f436ba..b9a1534 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -155,6 +203,8 @@ struct of_drconf_cell {
>  #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
>  #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
>  #define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
> +#define OV5_RPS_DM2		0x1680	/* Redef Prop Structures: dyn-mem-v2 */
> +#define OV5_RPS_DRC_INFO	0x1640	/* Redef Prop Structures: drc-info   */
>  
>  /* Option Vector 6: IBM PAPR hints */
>  #define OV6_LINUX		0x02	/* Linux is our OS */
> diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
> index 8c80588..00243ee 100644
> --- a/arch/powerpc/platforms/pseries/firmware.c
> +++ b/arch/powerpc/platforms/pseries/firmware.c
> @@ -111,6 +111,8 @@ static __initdata struct vec5_fw_feature
>  vec5_fw_features_table[] = {
>  	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
>  	{FW_FEATURE_PRRN,		OV5_PRRN},
> +	{FW_FEATURE_RPS_DM2,		OV5_RPS_DM2},
> +	{FW_FEATURE_RPS_DRC_INFO,	OV5_RPS_DRC_INFO},
>  };
>  
>  void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
