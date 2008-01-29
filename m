Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 938EADDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 06:24:29 +1100 (EST)
Date: Tue, 29 Jan 2008 13:24:54 -0600
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 4/4] 82xx: MGCOGE support
Message-ID: <20080129192454.GC4051@loki.buserror.net>
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
	<479EFE7F.4000104@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <479EFE7F.4000104@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 29, 2008 at 11:22:55AM +0100, Heiko Schocher wrote:
> To get the serial console on the SMC2 working, the
> following patch is needed:
> 
> Fixing serial console on a SMC on MPC82xx based
> board and using CONFIG_PPC_CPM_NEW_BINDING

No, what's needed is for the device tree to be correct (see my comments on
that patch).

> +		u16 __iomem *pram_base;
> +		struct resource res;
> +
>  		pinfo->flags |= FLAG_SMC;
>  		pinfo->smcp = mem;
>  		pinfo->smcup = pram;
> +
> +		if (of_address_to_resource(np, 1, &res)) {
> +			ret = -ENOMEM;
> +			goto out_pram;
> +		}
> +		pram_base = of_iomap(np, 2);
> +		if (!pram_base) {
> +			ret = -ENOMEM;
> +			goto out_pram;
> +		}
> +		*pram_base = res.start;

First of all, use out_be32() rather than direct dereferencing.

Secondly, is it possible for things to get messed up if the SMC registers
were set somewhere else by the bootloader, and that area was previously
allocated by Linux for some other purpose, and the SMC updated the parameter
RAM and corrupted that other purpose?  Especially if we have early debug
enabled, and thus don't reset the CPM on boot (or worse, are actively using
it prior to register relocation).

-Scott
