Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3227C2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2012 12:31:18 +1100 (EST)
In-Reply-To: <1352441953-29096-10-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
 <1352441953-29096-10-git-send-email-mikey@neuling.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B2250515-36A9-4826-B50B-49298A28FB39@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 09/14] powerpc: Setup relocation on exceptions for bare
 metal systems
Date: Mon, 12 Nov 2012 02:32:28 +0100
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -249,6 +249,8 @@
>  #define   LPCR_RMLS    0x1C000000      /* impl dependent rmo limit  
> sel */
>  #define	  LPCR_RMLS_SH	(63-37)
>  #define   LPCR_ILE     0x02000000      /* !HV irqs set MSR:LE */
> +#define   LPCR_AIL_0	0x00000000	/* MMU off IRQ location 0x0 */
> +#define   LPCR_AIL_3	0x01800000	/* MMU on IRQ location  
> 0xc00...4xxx */

s/IRQ location/exception offset/ ?

> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -54,6 +54,7 @@ _GLOBAL(__setup_cpu_power8)
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
>  	mfspr	r3,SPRN_LPCR
> +	oris	r3, r3, LPCR_AIL_3@h

Is the AIL field only two bits?  If not, you probably want to clear
the other bits.

This series looks really nice btw :-)


Segher
