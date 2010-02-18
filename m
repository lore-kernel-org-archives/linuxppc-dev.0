Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34D7DB7C7E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 14:10:20 +1100 (EST)
Subject: Re: [PATCH 1/5] powerpc/head fsl: fix the case where we are not in
	the first page
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1263573697-17839-2-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Date: Wed, 17 Feb 2010 21:07:49 -0600
Message-Id: <2C4630C6-1537-4653-8F7C-BEE3BB4EDC18@kernel.crashing.org>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<1263573697-17839-2-git-send-email-linuxppc-dev@ml.breakpoint.cc>
To: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 15, 2010, at 10:41 AM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> During boot we change the mapping a few times until we have a =
"defined"
> mapping. During this procedure a small 4KiB mapping is created and =
after
> that one a 64MiB. Currently the offset of the 4KiB page in that we run
> is zero because the complete startup up code is in first page which
> starts at RPN zero.
> If the code is recycled and moved to another location then its =
execution
> will fail because the start address in the 64 MiB mapping is computed
> wrongly. It does not consider the offset to the page from the begin of
> the memory.
> This patch fixes this. Usually (system boot) r25 is zero so this does
> not change anything unless the code is recycled.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

I don't get this.  Why would would we not run at KERNELBASE?

- k

>=20
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S =
b/arch/powerpc/kernel/head_fsl_booke.S
> index 7f4bd7f..799ddbe 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -275,6 +275,7 @@ skpinv:	addi	r6,r6,1				=
/* Increment */
> 1:	mflr	r9
> 	rlwimi	r6,r9,0,20,31
> 	addi	r6,r6,(2f - 1b)
> +	add	r6, r6, r25
> 	mtspr	SPRN_SRR0,r6
> 	mtspr	SPRN_SRR1,r7
> 	rfi				/* start execution out of =
TLB1[0] entry */
> --=20
> 1.6.2.5
