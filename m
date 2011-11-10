Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E15A5B6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 00:37:54 +1100 (EST)
Subject: Re: [RFC PATCH 04/17] powerpc: Allow multiple machine-check handlers
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1320883635-17194-5-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 10 Nov 2011 07:37:36 -0600
Message-Id: <C3C78EA9-9E3D-46AC-94D0-537348DCFC64@kernel.crashing.org>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-5-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 9, 2011, at 6:07 PM, Kyle Moffett wrote:

> Certain processor types are co-supportable, and their machine-check
> handlers will be referenced if the entries in cputable.c are actually
> generated, so allow more than one machine-check handler to be built in.
> 
> This fixes a bug where configuring FreeScale E5500 support (P5020DS)
> into the kernel would break machine-check handling on PPC64 A2 systems
> by using a bogus machine_check_generic() handler that does nothing.
> 
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
> arch/powerpc/kernel/traps.c |   18 ++++++++----------
> 1 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 4e59082..e3113341 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -418,7 +418,8 @@ int machine_check_47x(struct pt_regs *regs)
> 
> 	return 0;
> }
> -#elif defined(CONFIG_E500)
> +#endif
> +#if defined(CONFIG_FSL_E500MC) || defined(CONFIG_FSL_E5500)
> int machine_check_e500mc(struct pt_regs *regs)
> {
> 	unsigned long mcsr = mfspr(SPRN_MCSR);
> @@ -517,7 +518,8 @@ silent_out:
> 	mtspr(SPRN_MCSR, mcsr);
> 	return mfspr(SPRN_MCSR) == 0 && recoverable;
> }
> -
> +#endif
> +#ifdef CONFIG_FSL_E500_V1_V2

doesn't exist yet, so patch is wrong sequence order.

> int machine_check_e500(struct pt_regs *regs)
> {
> 	unsigned long reason = get_mc_reason(regs);
> @@ -557,12 +559,8 @@ int machine_check_e500(struct pt_regs *regs)
> 
> 	return 0;
> }
> -
> -int machine_check_generic(struct pt_regs *regs)
> -{
> -	return 0;
> -}
> -#elif defined(CONFIG_E200)
> +#endif
> +#ifdef CONFIG_E200
> int machine_check_e200(struct pt_regs *regs)
> {
> 	unsigned long reason = get_mc_reason(regs);
> @@ -587,7 +585,8 @@ int machine_check_e200(struct pt_regs *regs)
> 
> 	return 0;
> }
> -#else
> +#endif
> +
> int machine_check_generic(struct pt_regs *regs)
> {
> 	unsigned long reason = get_mc_reason(regs);
> @@ -623,7 +622,6 @@ int machine_check_generic(struct pt_regs *regs)
> 	}
> 	return 0;
> }
> -#endif /* everything else */
> 
> void machine_check_exception(struct pt_regs *regs)
> {
> -- 
> 1.7.2.5
