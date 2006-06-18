Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75A3367B38
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 13:05:30 +1000 (EST)
Subject: Re: [PATCH 4/9 v3] Add starting of secondary 86xx CPUs.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1Frjem-0004Ou-2S@jdl.com>
References: <E1Frjem-0004Ou-2S@jdl.com>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 13:05:17 +1000
Message-Id: <1150599918.23600.150.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +	.globl __secondary_start_mpc86xx
> +__secondary_start_mpc86xx:
> +	mfspr	r3, SPRN_PIR
> +	stw	r3, __secondary_hold_acknowledge@l(0)
> +	mr	r24, r3			/* cpu # */
> +	b	__secondary_start

The above looks generic enough... why not call it
__secondary_start_PIR ? :) Might be useful for other platforms I
reckon...

>  	.globl	__secondary_start_pmac_0
>  __secondary_start_pmac_0:
>  	/* NB the entries for cpus 0, 1, 2 must each occupy 8 bytes. */
> @@ -1088,7 +1095,12 @@ load_up_mmu:
>  	LOAD_BAT(1,r3,r4,r5)
>  	LOAD_BAT(2,r3,r4,r5)
>  	LOAD_BAT(3,r3,r4,r5)
> -
> +BEGIN_FTR_SECTION
> +	LOAD_BAT(4,r3,r4,r5)
> +	LOAD_BAT(5,r3,r4,r5)
> +	LOAD_BAT(6,r3,r4,r5)
> +	LOAD_BAT(7,r3,r4,r5)
> +END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
>  	blr

Looks good.
