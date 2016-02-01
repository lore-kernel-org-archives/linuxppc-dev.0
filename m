Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A51D21A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 18:12:03 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 12:41:59 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u117Bli822937952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 12:41:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u117BhAu006344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 12:41:46 +0530
Message-ID: <56AF0523.60902@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 12:41:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 6/9] pseries: Add hypercall wrappers for hash page table
 resizing
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-7-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-7-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:54 AM, David Gibson wrote:
> This adds the hypercall numbers and wrapper functions for the hash page
> table resizing hypercalls.
> 
> These are experimental "platform specific" values for now, until we have a
> formal PAPR update.
> 
> It also adds a new firmware feature flat to track the presence of the
> HPT resizing calls.

Its a flag   ....................... ^^^^^^^ here.

> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/firmware.h       |  5 +++--
>  arch/powerpc/include/asm/hvcall.h         |  2 ++
>  arch/powerpc/include/asm/plpar_wrappers.h | 12 ++++++++++++
>  arch/powerpc/platforms/pseries/firmware.c |  1 +
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index b062924..32435d2 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -42,7 +42,7 @@
>  #define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
>  #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
>  #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
> -/* Free				ASM_CONST(0x0000000001000000) */
> +#define FW_FEATURE_HPT_RESIZE	ASM_CONST(0x0000000001000000)
>  #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
>  #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
>  #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
> @@ -66,7 +66,8 @@ enum {
>  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
>  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> -		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
> +		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> +		FW_FEATURE_HPT_RESIZE,
>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>  	FW_FEATURE_POWERNV_ALWAYS = 0,
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index e3b54dd..195e080 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -293,6 +293,8 @@
>  
>  /* Platform specific hcalls, used by KVM */
>  #define H_RTAS			0xf000
> +#define H_RESIZE_HPT_PREPARE	0xf003
> +#define H_RESIZE_HPT_COMMIT	0xf004

This sound better and matches FW_FEATURE_HPT_RESIZE ?

#define H_HPT_RESIZE_PREPARE	0xf003
#define H_HPT_RESIZE_COMMIT	0xf004
