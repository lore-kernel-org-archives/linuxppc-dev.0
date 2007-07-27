Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B6E3DDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 10:04:28 +1000 (EST)
Date: Thu, 26 Jul 2007 19:04:17 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [POWERPC] Add support of platforms without PHY to
	gianfar driver
Message-Id: <20070726190417.de30bed6.kim.phillips@freescale.com>
In-Reply-To: <20070725174312.5818.61155.stgit@localhost.localdomain>
References: <20070725174312.5818.61155.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Jul 2007 21:43:12 +0400
Vitaly Bordug <vitb@kernel.crashing.org> wrote:

> 
> Gianfar driver is now able to work without real phy subnode,
> that is necessary to cope with fixed-link situation, when
> SoC is connected to the Ethernet inteface or embedded switch 
> without any PHY. In this case, fixed-speed property will
> describe such a situation for gianfar driver.
> 
> The property is in form <duplexity speed>
> 
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> ---
> 
>  arch/powerpc/sysdev/fsl_soc.c |   39 +++++++++++++++++++++++----------------
>  drivers/net/gianfar.c         |   17 ++++++++++++++---

please run this through checkpatch.pl until it passes.

<snip>
> +			bus_id = of_get_property(np, "fixed_speed",NULL);

hyphens are preferred for new properties.  Plus, isn't fixed-link a
better name?  unless you instead want to put speed first and make
duplexity an optional second, or possibly even a string.

Also, can we get this new property documented in b-w-of in a separate
patch?

Kim
