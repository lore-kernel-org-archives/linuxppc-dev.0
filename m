Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E865DDDF34
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 23:23:58 +1000 (EST)
Message-Id: <177599B6-6236-4292-A69B-CA13617A6576@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1211270856-26579-3-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
Date: Tue, 20 May 2008 08:23:49 -0500
References: <1211270856-26579-1-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-2-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-3-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/ 
> powerpc/platforms/86xx/mpc8610_hpcd.c
> index dea1320..290d717 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -71,9 +71,13 @@ static void __init mpc86xx_hpcd_init_irq(void)
> 	/* Alloc mpic structure and per isu has 16 INT entries. */
> 	mpic1 = mpic_alloc(np, res.start,
> 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> -			0, 256, " MPIC     ");
> +			64, 256, " MPIC     ");
> 	BUG_ON(mpic1 == NULL);
>
> +	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
> +	mpic_assign_isu(mpic1, 1, res.start + 0x10800);
> +	mpic_assign_isu(mpic1, 2, res.start + 0x11600);
> +

I don't understand why you are breaking the interrupts up like this.

If you leave as it was, the MSIs would start at hw irq 176

- k
