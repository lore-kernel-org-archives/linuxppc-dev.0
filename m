Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0144.outbound.protection.outlook.com [157.56.110.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79CEA1A011B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 04:36:21 +1000 (EST)
Message-ID: <1412015766.13320.253.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl: Add support for pci(e) machine check
 exception on E500MC / E5500
From: Scott Wood <scottwood@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Sep 2014 13:36:06 -0500
In-Reply-To: <1412009312-7400-1-git-send-email-linux@roeck-us.net>
References: <1412009312-7400-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: hongtao.jia@freescale.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <groeck@juniper.net>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Jojy G Varghese <jojyv@juniper.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-29 at 09:48 -0700, Guenter Roeck wrote:
> From: Jojy G Varghese <jojyv@juniper.net>
> 
> For E500MC and E5500, a machine check exception in pci(e) memory space
> crashes the kernel.
> 
> Testing shows that the MCAR(U) register is zero on a MC exception for the
> E5500 core. At the same time, DEAR register has been found to have the
> address of the faulty load address during an MC exception for this core.
> 
> This fix changes the current behavior to fixup the result register
> and instruction pointers in the case of a load operation on a faulty
> PCI address.
> 
> The changes are:
> - Added the hook to pci machine check handing to the e500mc machine check
>   exception handler.
> - For the E5500 core, load faulting address from SPRN_DEAR register.
>   As mentioned above, this is necessary because the E5500 core does not
>   report the fault address in the MCAR register.
> 
> Cc: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Jojy G Varghese <jojyv@juniper.net>
> [Guenter Roeck: updated description]
> Signed-off-by: Guenter Roeck <groeck@juniper.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/powerpc/kernel/traps.c   | 3 ++-
>  arch/powerpc/sysdev/fsl_pci.c | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 0dc43f9..ecb709b 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -494,7 +494,8 @@ int machine_check_e500mc(struct pt_regs *regs)
>  	int recoverable = 1;
>  
>  	if (reason & MCSR_LD) {
> -		recoverable = fsl_rio_mcheck_exception(regs);
> +		recoverable = fsl_rio_mcheck_exception(regs) ||
> +			fsl_pci_mcheck_exception(regs);
>  		if (recoverable == 1)
>  			goto silent_out;
>  	}
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index c507767..bdb956b 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1021,6 +1021,11 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
>  #endif
>  	addr += mfspr(SPRN_MCAR);
>  
> +#ifdef CONFIG_E5500_CPU
> +	if (mfspr(SPRN_EPCR) & SPRN_EPCR_ICM)
> +		addr = PFN_PHYS(vmalloc_to_pfn((void *)mfspr(SPRN_DEAR)));
> +#endif

Kconfig tells you what hardware is supported, not what hardware you're
actually running on.

Jia Hongtao, do you know anything about this issue?  Is there an
erratum?  What chips are affected by the the erratum covered by
<http://patchwork.ozlabs.org/patch/240239/>?

Can we rely on DEAR or is this just a side effect of likely having taken
a TLB miss for the address recently?  Perhaps we should use the
instruction emulation to determine the effective address instead.

Guenter, is this patch intended to deal with an erratum or are you
covering up legitimate errors?

-Scott
