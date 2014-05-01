Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews06.kpnxchange.com (cpsmtpb-ews06.kpnxchange.com
 [213.75.39.9]) by ozlabs.org (Postfix) with ESMTP id 9697F140114
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 19:40:48 +1000 (EST)
Message-ID: <1398936447.4121.12.camel@x220>
Subject: Re: [4/5] IBM Akebono: Add the Akebono platform
From: Paul Bolle <pebolle@tiscali.nl>
To: Alistair Popple <alistair@popple.id.au>
Date: Thu, 01 May 2014 11:27:27 +0200
In-Reply-To: <1394077948-8395-5-git-send-email-alistair@popple.id.au>
References: <1394077948-8395-5-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-06 at 14:52 +1100, Alistair Popple wrote:
> This patch adds support for the IBM Akebono board.

This patch just landed in linux-next (ie, in next-20140501).

> Signed-off-by: Alistair Popple <alistair@popple.id.au>
>[...]
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -199,6 +199,32 @@ config CURRITUCK
>  	help
>  	  This option enables support for the IBM Currituck (476fpe) evaluation board
>  
> +config AKEBONO
> +	bool "IBM Akebono (476gtr) Support"
> +	depends on PPC_47x
> +	default n
> +	select SWIOTLB
> +	select 476FPE
> +	select PPC4xx_PCI_EXPRESS
> +	select I2C
> +	select I2C_IBM_IIC
> +	select NETDEVICES
> +	select ETHERNET
> +	select NET_VENDOR_IBM
> +	select IBM_EMAC_EMAC4
> +	select IBM_EMAC_RGMII_WOL

The patch that added this symbol (and the related driver) was submitted
in https://lkml.org/lkml/2014/2/21/25 . It's not (yet) included in
linux-next. Is it queued somewhere else?

> +	select USB
> +	select USB_OHCI_HCD_PLATFORM
> +	select USB_EHCI_HCD_PLATFORM
> +	select MMC_SDHCI
> +	select MMC_SDHCI_PLTFM
> +	select MMC_SDHCI_OF_476GTR

The plan to add MMC_SDHCI_OF_476GTR seems to have been abandoned (see
the discussion of https://lkml.org/lkml/2014/2/21/24 ). So this select
is not needed. Should I submit a trivial patch to drop this select?

> +	select ATA
> +	select SATA_AHCI_PLATFORM
> +	help
> +	  This option enables support for the IBM Akebono (476gtr) evaluation board
> +
> +
>  config ICON
>  	bool "Icon"
>  	depends on 44x


Paul Bolle
