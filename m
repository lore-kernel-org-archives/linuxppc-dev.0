Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXwbN4mtmzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 08:02:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/powernv: Fix IMC_MAX_PMU macro
In-Reply-To: <1510229426-5547-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1510229426-5547-1-git-send-email-anju@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 08:02:23 +1100
Message-ID: <877euzp3mo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> IMC_MAX_PMU is used for static storage (per_nest_pmu_arr) which holds
> nest pmu information. Current value for the macro is 32 based on
> the initial number of nest pmu units supported by the nest microcode.
> Currently 29 nest units are enabled based on the system configuration.
> But going forward, microcode could support more nest units (max of 64
> nest units). Hence fix the value for the macro.

There should be no reason to have a hard coded limit.

We should just fix the code to dynamically size the array based on
what's found in the device tree.

cheers

> Fixes:8f95faaac56c1 ('powerpc/powernv: Detect and create IMC device')
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/imc-pmu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
> index 7f74c28..f9f0f2e 100644
> --- a/arch/powerpc/include/asm/imc-pmu.h
> +++ b/arch/powerpc/include/asm/imc-pmu.h
> @@ -23,7 +23,7 @@
>  /*
>   * For static allocation of some of the structures.
>   */
> -#define IMC_MAX_PMUS			32
> +#define IMC_MAX_PMUS			64
>  
>  /*
>   * Compatibility macros for IMC devices
> -- 
> 2.7.4
