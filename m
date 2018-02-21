Return-Path: <srs0=okox=fp=linux.vnet.ibm.com=tyreld@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmrRc2ZFQzF0wm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 08:37:16 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zmrRc1Z9Gz8t0R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 08:37:16 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zmrRb50qTz9sW5
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 08:37:15 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LLYDRN061352
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 16:37:13 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9dt8q24b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 16:37:13 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 16:37:12 -0500
Subject: Re: [PATCH] powerpc/pseries: Fix duplicate firmware feature for
 DRC_INFO
To: Michael Ellerman <mpe@ellerman.id.au>, mwb@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org
References: <20180221130523.27836-1-mpe@ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 13:37:06 -0800
MIME-Version: 1.0
In-Reply-To: <20180221130523.27836-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <00af50c2-e749-10ba-f16e-39f0187581ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 05:05 AM, Michael Ellerman wrote:
> We had a mid-air collision between two new firmware features, DRMEM_V2
> and DRC_INFO, and they ended up with the same value.
> 
> No one's actually reported any problems, presumably because the new
> firmware that supports both properties is not widely available, and
> the two properties tend to be enabled together.
> 
> Still if we ever had one enabled but not the other, the bugs that
> could result are many and varied. So fix it.
> 
> Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmware feature")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Good catch.

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

>  arch/powerpc/include/asm/firmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index 511acfd7ab0d..535add3f7791 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -52,7 +52,7 @@
>  #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
>  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
>  #define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
> -#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000400000000)
> +#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
> 
>  #ifndef __ASSEMBLY__
> 
