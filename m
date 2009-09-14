Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C4A16B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 03:28:33 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CF98DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 03:28:32 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8EHSDNS019712
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 10:28:23 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8EHSC2g019367
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 12:28:12 -0500 (CDT)
Date: Mon, 14 Sep 2009 12:28:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/5] powerpc/85xx/86xx: Add suspend/resume support
Message-ID: <20090914172811.GA9074@b07421-ec1.am.freescale.net>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193718.GB17519@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090830193718.GB17519@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 30, 2009 at 11:37:18PM +0400, Anton Vorontsov wrote:
> This patch adds suspend/resume support for MPC8540, MPC8569 and
> MPC8641D-compatible CPUs.
> 
> MPC8540 and MPC8641D-compatible PMCs are trivial: we just write
> the SLP bit into the PM control and status register.
> 
> MPC8569 is a bit trickier, QE turns off during suspend, thus on
> resume we must reload QE microcode and reset QE.
> 
> So far we don't support Deep Sleep mode as found in newer MPC85xx
> CPUs (i.e. MPC8536). It can be relatively easy implemented though,
> and for it we reserve 'mem' suspend type.

We've got some code floating around here for that; it's just been falling
through the cracks as far as getting a chance to clean up and push
upstream.  Hopefully it'll happen soon.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/Kconfig          |   11 +++-
>  arch/powerpc/sysdev/Makefile  |    1 +
>  arch/powerpc/sysdev/fsl_pmc.c |  124 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/fsl_pmc.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d00131c..a0743a7 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -212,7 +212,8 @@ config ARCH_HIBERNATION_POSSIBLE
>  
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
> -	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx
> +	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
> +		   PPC_85xx || PPC_86xx

This isn't directed at this patch, but why do we need this list?  Can't
each platform figure out for itself whether it can actually register that
suspend_ops struct, just like any other driver?

>  config PPC_DCR_NATIVE
>  	bool
> @@ -642,6 +643,14 @@ config FSL_PCI
>  	select PPC_INDIRECT_PCI
>  	select PCI_QUIRKS
>  
> +config FSL_PMC
> +	bool
> +	default y
> +	depends on SUSPEND && (PPC_85xx || PPC_86xx)
> +	help
> +	  Freescale MPC85xx/MPC86xx power management controller support
> +	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c

I wish we had a better name for 85xx+86xx than "FSL". :-(

> +static int pmc_suspend_enter(suspend_state_t state)
> +{
> +	setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
> +	/* At this point, the CPU is asleep. */

I'm not sure that we're guaranteed that the sleep has taken effect
immediately -- we may need to do a loop waiting for it to clear (on
85xx), probably with some delays to give the bus a chance to become idle.

I'm not sure how much of that is necessary under certain conditions,
versus just paranoia, though.  Something like what you have here worked
well enough for us in testing -- but having that clear immediately after
makes me nervous.  At least a read-back seems appropriate (which I
suppose the clbits32 does, but I'd prefer something more explicit).

> +	/* For 86xx we need to clear the bit on resume, 85xx don't care. */
> +	clrbits32(&pmc_regs->pmcsr, PMCSR_SLP);

Hmm, how does this work?  Does it only enter sleep mode on the rising
edge of that bit?

The 8610 manual says that that bit should only be set as part of a
sequence also involving the use of MSR[POW] (section 23.5.1.4).

> +	if (pmc_qefw) {
> +		int ret;
> +
> +		ret = qe_upload_firmware(pmc_qefw);
> +		if (ret)
> +			dev_err(pmc_dev, "could not upload firmware\n");
> +
> +		qe_reset();
> +	}

Does this really belong here, or should the QE subsystem have a device
struct with suspend/resume ops?

-Scott
