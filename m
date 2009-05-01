Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A65E5DDECF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 07:26:31 +1000 (EST)
Message-ID: <49FB68F2.10301@freescale.com>
Date: Fri, 01 May 2009 16:26:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 1/2] Added support for Designware SATA controller driver
References: <1241211767-32697-1-git-send-email-fkan@amcc.com>
In-Reply-To: <1241211767-32697-1-git-send-email-fkan@amcc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mark Miesfeld <miesfeld@gmail.com>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Feng Kan wrote:
> This adds support for the Designware SATA controller.
> 
> Signed-off-by: Feng Kan <fkan@amcc.com>
> Signed-off-by: Mark Miesfeld <miesfeld@gmail.com>
> ---
>  drivers/ata/Kconfig    |   10 +
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_dwc.c | 2053 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2064 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 0bcf264..c3d0b24 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -72,6 +72,16 @@ config SATA_FSL
>  
>  	  If unsure, say N.
>  
> +config SATA_DWC
> +	tristate "DesignWare Cores SATA support"
> + 	depends on 460EX

That "depends" looks too specific -- we don't want to grow a list if 
this controller gets added to other chips.

Only depend on what this driver actually needs in order to function.

-Scott
