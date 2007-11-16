Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8161DDE33
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 06:20:18 +1100 (EST)
Message-Id: <96AAE1CB-3F7F-4231-AD52-01F358E01594@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071116112956.0f1ca5b1@weaponx>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] 4xx: Use virtual PVR value to init FPU on
	arch/ppc 440EP
Date: Fri, 16 Nov 2007 13:20:09 -0600
References: <20071116112956.0f1ca5b1@weaponx>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 16, 2007, at 11:29 AM, Josh Boyer wrote:

> This fixes arch/ppc 440EP platforms to setup the FPU correctly.  A  
> virtual
> PVR is used, as 440GR platforms share an identical hardware PVR  
> value and do
> not have an FPU.
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Index: linux-2.6/arch/ppc/kernel/setup.c
> ===================================================================
> --- linux-2.6.orig/arch/ppc/kernel/setup.c
> +++ linux-2.6/arch/ppc/kernel/setup.c
> @@ -312,7 +312,14 @@ early_init(int r3, int r4, int r5)
> 	 * Identify the CPU type and fix up code sections
> 	 * that depend on which cpu we have.
> 	 */
> +#if defined(CONFIG_440EP) && defined(CONFIG_PPC_FPU)
> +	/* We pass the virtual PVR here for 440EP as 440EP and 440GR have
> +	 * identical PVRs and there is no reliable way to check for the FPU
> +	 */
> +	spec = identify_cpu(offset, (mfspr(SPRN_PVR) | 0x8));
> +#else
> 	spec = identify_cpu(offset, mfspr(SPRN_PVR));
> +#endif
> 	do_feature_fixups(spec->cpu_features,
> 			  PTRRELOC(&__start___ftr_fixup),
> 			  PTRRELOC(&__stop___ftr_fixup));

Are we really adding support for new processors to arch/ppc?

- k
