Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ADD26B70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 05:43:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07F5DDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 05:43:28 +1000 (EST)
Message-Id: <DFA2A0E2-54C6-4FFB-804C-F639B952F3F1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244573639.29684.1536.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -next] powerpc/85xx: Add support for X-ES MPC85xx boards
Date: Tue, 9 Jun 2009 14:43:20 -0500
References: <1244499228-18602-1-git-send-email-ncase@xes-inc.com>
	<2AF4BA69-D05A-4D2E-BD32-5E1C93ACF445@kernel.crashing.org>
	<1244573639.29684.1536.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 9, 2009, at 1:53 PM, Nate Case wrote:

> On Mon, 2009-06-08 at 17:52 -0500, Kumar Gala wrote:
>>> +static void xes_mpc85xx_configure_l1(void)
>>> +{
> [snip]
>>
>> I'd prefer we move this into __setup_cpu_e500v1/__setup_cpu_e500v2 so
>> its done for all processors regardless of platform.
>
> How does something like this look?  Let me know and I can test and
> submit it separately.
>
> - Nate
>
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/ 
> powerpc/kernel/cpu_setup_fsl_booke.S
> index eb4b9ad..546804f 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -17,6 +17,34 @@
> #include <asm/cputable.h>
> #include <asm/ppc_asm.h>
>
> +_GLOBAL(__e500_icache_enable)

I'd prefer we test to see if the cache is enabled and if it is just  
return

> +	mfspr	r3, SPRN_L1CSR1
> +	oris	r3, r3, L1CSR1_CPE@h
> +	ori	r3, r3, (L1CSR1_ICFI | L1CSR1_ICE)
> +	mtspr	SPRN_L1CSR1, r3		/* Enable I-Cache */
> +	isync
> +	blr
> +
> +_GLOBAL(__e500_dcache_enable)

I'd prefer we test to see if the cache is enabled and if it is just  
return
>
> +	msync
> +	isync
> +	li	r3, 0
> +	mtspr	SPRN_L1CSR0, r3		/* Disable */
> +	msync
> +	isync
> +	li	r3, L1CSR0_DCFI

should probably flash reset the locks as well.

>
> +	mtspr	SPRN_L1CSR0, r3		/* Invalidate */
> +	msync
> +	isync
> +	mfspr	r3, SPRN_L1CSR0
> +	oris	r3, r3, L1CSR0_CPE@h
> +	ori	r3, r3, (L1CSR0_DCFI | L1CSR0_DCE)
> +	msync
> +	isync
> +	mtspr	SPRN_L1CSR0, r3		/* Enable */
> +	isync
> +	blr
> +
> _GLOBAL(__setup_cpu_e20
