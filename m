Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FC7B1007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 02:58:23 +1100 (EST)
Received: from mail76-am1 (localhost.localdomain [127.0.0.1])	by
	mail76-am1-R.bigfish.com (Postfix) with ESMTP id 6D2E8505DA	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 15:58:18 +0000 (UTC)
Received: from am1ehsmhs004.bigfish.com (unknown [10.3.201.244])	by
	mail76-am1.bigfish.com (Postfix) with ESMTP id 70BEE1C40046	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 15:58:13 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9DFwAOv010542	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 08:58:10 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9DGDIHr026048	for <linuxppc-dev@ozlabs.org>;
	Wed, 13 Oct 2010 11:13:18 -0500 (CDT)
Date: Wed, 13 Oct 2010 10:58:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/fsl-booke: Add support for FSL 64-bit e5500
	core
Message-ID: <20101013105808.4ca3b565@udp111988uds.am.freescale.net>
In-Reply-To: <1286975832-31895-1-git-send-email-galak@kernel.crashing.org>
References: <1286975832-31895-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Oct 2010 08:17:11 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> The new e5500 core is similar to the e500mc core but adds 64-bit
> support.  We support running it in 32-bit mode as it is identical to the
> e500mc.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * clean up kconfig further to reduce use of E500MC

Looks better, just a few nits:

> -#ifdef CONFIG_E500
> +#if defined(CONFIG_E500) || defined(CONFIG_PPC_BOOK3E_64)
>  /* All e500 */
>  #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
>  #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */

Is this really supposed to be here for all 64-bit book3e?  Likewise in
the C code.

> +obj-$(CONFIG_PPC_BOOK3E_64)	+= cpu_setup_fsl_booke.o

CONFIG_PPC_FSL_BOOK3E?

> @@ -66,6 +66,10 @@ extern void __restore_cpu_ppc970(void);
>  extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
>  extern void __restore_cpu_power7(void);
>  #endif /* CONFIG_PPC64 */
> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_E500)
> +extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
> +extern void __restore_cpu_e5500(void);
> +#endif /* CONFIG_PPC_BOOK3E_64 || CONFIG_E500 */

CONFIG_E500 should be sufficient.  Not sure why these need to be
ifdeffed at all, though it seems to be existing practice here.

>  /* This table only contains "desktop" CPUs, it need to be filled with embedded
>   * ones as well...
> @@ -1891,7 +1895,28 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.platform		= "ppc5554",
>  	}
>  #endif /* CONFIG_E200 */
> -#ifdef CONFIG_E500
> +#endif /* CONFIG_PPC32 */
> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_E500)

Just E500 should work.

> @@ -538,6 +538,11 @@ int machine_check_e500(struct pt_regs *regs)
>  
>  	return 0;
>  }
> +
> +int machine_check_generic(struct pt_regs *regs)
> +{
> +	return 0;
> +}

Hmm, it seems that either the cputable entry that references this
should not be built in if we don't support those chips, or the real
implementation shouldn't be under an #else if we are going to support
multiplatform coexistence with them.

-Scott
