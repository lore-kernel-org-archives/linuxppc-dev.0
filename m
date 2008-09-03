Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D64DDE138
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 02:14:10 +1000 (EST)
Date: Wed, 3 Sep 2008 11:12:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] powerpc: Introduce local (non-broadcast) forms
	of tlb invalidates
Message-ID: <20080903161251.GA10877@loki.buserror.net>
References: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 29, 2008 at 08:56:50AM -0500, Kumar Gala wrote:
> +_GLOBAL(_tlbil_all)
> +#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
> +			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
> +	li	r3,(MMUCSR0_TLBFI)@l
> +	mtspr	SPRN_MMUCSR0, r3
> +1:
> +	mfspr	r3,SPRN_MMUCSR0
> +	andi.	r3,r3,MMUCSR0_TLBFI@l
> +	bne	1b
> +	blr
> +
> +/*
> + * Flush MMU TLB for a particular process id, but only on the local processor
> + * (no broadcast)
> + */
> +_GLOBAL(_tlbil_pid)
> +	li	r3,(MMUCSR0_TLBFI)@l
> +	mtspr	SPRN_MMUCSR0, r3
> +1:
> +	mfspr	r3,SPRN_MMUCSR0
> +	andi.	r1,r2,MMUCSR0_TLBFI@l
> +	bne	1b
> +	blr

I'm guessing _tlbil_pid is never called, as it will clobber the stack
pointer.

Should probably just point both function names at the same implementation,
since PID-specific invalidation isn't supported on non-tlbilx cores.

-Scott
