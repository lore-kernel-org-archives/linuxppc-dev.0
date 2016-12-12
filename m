Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcmjV5bJHzDvkP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 02:19:58 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBCFEDKo082181
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:19:55 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 279u71ep9w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:19:55 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 12 Dec 2016 08:19:53 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 578F23E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 08:19:51 -0700 (MST)
Subject: Re: [PATCH V9 1/8] powerpc/firmware: Add definitions for new firmware
 features.
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
 <148109483155.193207.7458792041495158698.stgit@powerkvm6.aus.stglabs.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 09:19:49 -0600
MIME-Version: 1.0
In-Reply-To: <148109483155.193207.7458792041495158698.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8d021d3e-f83c-11d1-712f-9ee48e5fa3d3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2016 01:14 AM, Michael Bringmann wrote:
> Firmware Features: Define new bit flags representing the presence of
> new device tree properties "ibm,drc-info", and "ibm,dynamic-memory-v2".
> These flags are used to tell the front end processor when the Linux
> kernel supports the new properties, and by the front end processor to
> tell the Linux kernel that the new properties are present in the devie
> tree.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/firmware.h       |    5 ++++-
>  arch/powerpc/include/asm/prom.h           |    2 ++
>  arch/powerpc/platforms/pseries/firmware.c |    2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index 1e0b5a5..6b5cf38 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -51,6 +51,8 @@
>  #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
>  #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
>  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
> +#define FW_FEATURE_DYN_MEM_V2	ASM_CONST(0x0000000400000000)
> +#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
> 
>  #ifndef __ASSEMBLY__
> 
> @@ -66,7 +68,8 @@ enum {
>  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
>  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> -		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
> +		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> +		FW_FEATURE_DYN_MEM_V2 | FW_FEATURE_DRC_INFO,
>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>  	FW_FEATURE_POWERNV_ALWAYS = 0,
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f436ba..bc7c4b5 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -155,6 +155,8 @@ struct of_drconf_cell {
>  #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
>  #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
>  #define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
> +#define OV5_DYN_MEM_V2		0x1680	/* Redef Prop Structures: dyn-mem-v2 */
> +#define OV5_DRC_INFO		0x1640	/* Redef Prop Structures: drc-info   */
> 
>  /* Option Vector 6: IBM PAPR hints */
>  #define OV6_LINUX		0x02	/* Linux is our OS */
> diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
> index ea7f09b..d2d23f5 100644
> --- a/arch/powerpc/platforms/pseries/firmware.c
> +++ b/arch/powerpc/platforms/pseries/firmware.c
> @@ -113,6 +113,8 @@ struct vec5_fw_feature {
>  vec5_fw_features_table[] = {
>  	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
>  	{FW_FEATURE_PRRN,		OV5_PRRN},
> +	{FW_FEATURE_DYN_MEM_V2,		OV5_DYN_MEM_V2},
> +	{FW_FEATURE_DRC_INFO,		OV5_DRC_INFO},
>  };
> 
>  static void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
> 
