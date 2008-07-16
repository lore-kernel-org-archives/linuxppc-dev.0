Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52DD0DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:47:30 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m6GLlNs4017908
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 14:47:24 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6GLlNYN014362
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 16:47:23 -0500 (CDT)
Date: Wed, 16 Jul 2008 16:47:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET
Message-ID: <20080716214722.GA6251@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0807160838520.14127@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0807160838520.14127@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	davej@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 08:39:12AM -0500, Kumar Gala wrote:
> If we don't enable FS_ENET we get build issues:
> 
> arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
> arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to `alloc_mdio_bitbang'
> arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to `mdiobus_register'

How is this possible?  CONFIG_EP8248E selects CONFIG_MDIO_BITBANG.

> +#ifdef CONFIG_FS_ENET_MDIO_FCC
>  static void ep8248e_set_mdc(struct mdiobb_ctrl *ctrl, int level)
>  {
>  	if (level)
> @@ -164,6 +165,7 @@ static struct of_platform_driver ep8248e_mdio_driver = {
>  	.probe = ep8248e_mdio_probe,
>  	.remove = ep8248e_mdio_remove,
>  };
> +#endif

This is wrong -- ep8248e doesn't use the FS_ENET_MDIO_FCC code.

-Scott
