Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE2C7DDED6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 12:54:03 +1100 (EST)
Message-ID: <47EDA135.9040003@garzik.org>
Date: Fri, 28 Mar 2008 21:53:57 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Make pasemi_mac.c depend on PPC_PASEMI to prevent link
	errors
References: <c9b4b088d00e37e33907b15ac59450c04ef36112.1206666963.git.michael@ellerman.id.au>
In-Reply-To: <c9b4b088d00e37e33907b15ac59450c04ef36112.1206666963.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> drivers/net/pasemi_mac.c is enabled by CONFIG_PASEMI_MAC, which depends on
> PPC64 && PCI. However pasemi_mac.c uses several routines that are only
> built when PPC_PASEMI is selected. This can lead to an unbuildable config:
> 
>  ERROR: ".pasemi_dma_start_chan" [drivers/net/pasemi_mac.ko] undefined!
> 
> So make CONFIG_PASEMI_MAC depend on PPC_PASEMI instead of PPC64.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  drivers/net/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> 
> Jeff, pending Olof's ack, this would be nice for 25, but is obviously
> not super important.
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index fe7b5ec..3a0b20a 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2635,7 +2635,7 @@ config NIU
>  
>  config PASEMI_MAC
>  	tristate "PA Semi 1/10Gbit MAC"
> -	depends on PPC64 && PCI
> +	depends on PPC_PASEMI && PCI
>  	select PHYLIB

applied
