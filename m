Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FF05DDFD7
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 02:04:06 +1000 (EST)
Message-ID: <484419EE.5040503@garzik.org>
Date: Mon, 02 Jun 2008 12:03:58 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] phylib: Don't allow core of phylib to build as a module
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> The core portions of the phylib aren't capable of being used as
> a module.  This isn't really any different than something like i2c
> in that the bus driver and core need to be built into the kernel.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Jeff, please consider this for 2.6.26 as w/o it we get build issues
> if phylib is config'd as a module on ppc.
> 
>  drivers/net/phy/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 6eb2d31..ab04cc7 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -3,7 +3,7 @@
>  #
> 
>  menuconfig PHYLIB
> -	tristate "PHY Device support and infrastructure"
> +	bool "PHY Device support and infrastructure"
>  	depends on !S390
>  	depends on NET_ETHERNET

What are the issues?

The core _should_ be able to be built as a module.

	Jeff
