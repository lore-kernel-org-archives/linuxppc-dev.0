Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CB6D7DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 09:28:23 +1000 (EST)
To: Feng Kan <fkan@amcc.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1241042419-19774-1-git-send-email-fkan@amcc.com>
References: <1241042419-19774-1-git-send-email-fkan@amcc.com>
Date: Thu, 30 Apr 2009 01:28:18 +0200
Message-Id: <20090429232818.A15B683420EE@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Feng Kan,

In message <1241042419-19774-1-git-send-email-fkan@amcc.com> you wrote:
> Signed-off-by: Feng Kan <fkan@amcc.com>
> ---
>  drivers/ata/Kconfig    |   76 +-
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_dwc.c | 2047 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2091 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 0bcf264..5321e47 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -72,56 +72,66 @@ config SATA_FSL
>  
>  	  If unsure, say N.
>  
> -config ATA_SFF
> -	bool "ATA SFF support"
> -	default y
> +config SATA_DWC
> +	tristate "DesignWare Cores SATA support"
> +	depends on 460EX
>  	help
> -	  This option adds support for ATA controllers with SFF
> -	  compliant or similar programming interface.
> +	  This option enables support for the Synopsys DesignWare Cores SATA
> +	  controller.
> +	  It can be found on the AMCC 460EX.
>  
> -	  SFF is the legacy IDE interface that has been around since
> -	  the dawn of time.  Almost all PATA controllers have an
> -	  SFF interface.  Many SATA controllers have an SFF interface
> -	  when configured into a legacy compatibility mode.
> +	  If unsure, say N.
>  
> -	  For users with exclusively modern controllers like AHCI,
> -	  Silicon Image 3124, or Marvell 6440, you may choose to
> -	  disable this uneeded SFF support.
> +config ATA_SFF
> +bool "ATA SFF support"
> +default y
> +help
> +  This option adds support for ATA controllers with SFF
> +  compliant or similar programming interface.
>  
> -	  If unsure, say Y.
> +  SFF is the legacy IDE interface that has been around since
> +  the dawn of time.  Almost all PATA controllers have an
> +  SFF interface.  Many SATA controllers have an SFF interface
> +  when configured into a legacy compatibility mode.
> +
> +  For users with exclusively modern controllers like AHCI,
> +  Silicon Image 3124, or Marvell 6440, you may choose to
> +  disable this uneeded SFF support.
> +
> +  If unsure, say Y.

Why are you reformatting exiting, correct help text, into brokenness?

...
> +static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
> +{
...
> +		dev_dbg(ap->dev, "%s non-NCQ cmd interrupt, protocol: %s\n",
> +			__func__, prot_2_txt(qc->tf.protocol));
> +DRVSTILLBUSY:
^^^^^^^^^^^^^^^^
...
> +PROCESS:  /* process completed commands */
^^^^^^^^^^^

...
> +STILLBUSY:
^^^^^^^^^^^^^
...
> +DONE:
^^^^^^^^

etc.  Please do not use all-caps identifier names (not even for
labels).

...
> +/*******************************************************************************
> + * Function : sata_dwc_port_start
> + * arguments : struct ata_ioports *port
> + * Return value : returns 0 if success, error code otherwise
> + * This function allocates the scatter gather LLI table for AHB DMA
> + ******************************************************************************/

Here and elsewhere: incorrect multiline comment style.

...
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");

Should not Mark add his Signed-off-by: line, too?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Conscious is when you are aware of something, and conscience is  when
you wish you weren't.
