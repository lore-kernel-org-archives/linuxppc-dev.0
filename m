Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 57D2FDDED9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 04:57:42 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so715869wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Aug 2007 11:57:40 -0700 (PDT)
Message-ID: <fa686aa40708091157y3c8c0725kbf25ce8a636d5c27@mail.gmail.com>
Date: Thu, 9 Aug 2007 12:57:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <peter.korsgaard@barco.com>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
In-Reply-To: <87vebryfrv.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<87vebryfrv.fsf@sleipner.barco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/7/07, Peter Korsgaard <peter.korsgaard@barco.com> wrote:
> >>>>> "WR" == Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> writes:
>
> Hi,
>
> WR> diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
> WR> index 5b87779..05631fe 100644
> WR> --- a/arch/ppc/boot/simple/Makefile
> WR> +++ b/arch/ppc/boot/simple/Makefile
> WR> @@ -187,8 +187,7 @@ boot-$(CONFIG_REDWOOD_6)        += embed_config.o
> WR>  boot-$(CONFIG_8xx)         += embed_config.o
> WR>  boot-$(CONFIG_8260)                += embed_config.o
> WR>  boot-$(CONFIG_EP405)               += embed_config.o
> WR> -boot-$(CONFIG_XILINX_ML300)        += embed_config.o
> WR> -boot-$(CONFIG_XILINX_ML403)        += embed_config.o
> WR> +boot-$(CONFIG_XILINX_VIRTEX)       += embed_config.o
>
> Don't do that. Other boards with Xilinx FPGAs don't necessarily need
> embed_config.c

Then post patches for those boards so we can properly support the
different configuration.

>
> WR>  boot-$(CONFIG_BSEIP)               += iic.o
> WR>  boot-$(CONFIG_MBX)         += iic.o pci.o qspan_pci.o
> WR>  boot-$(CONFIG_MV64X60)             += misc-mv64x60.o
> WR> diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
> WR> index 840bff2..e0b8954 100644
> WR> --- a/arch/ppc/boot/simple/embed_config.c
> WR> +++ b/arch/ppc/boot/simple/embed_config.c
> WR> @@ -744,7 +744,7 @@ embed_config(bd_t **bdp)
> WR>  }
> WR>  #endif /* WILLOW */
>
> WR> -#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
> WR> +#if defined(CONFIG_XILINX_VIRTEX)
> WR>  void
> WR>  embed_config(bd_t ** bdp)
>
> .. And if they do, they might have another embed_config (E.G. if the
> bootloader provides a valid struct bd_t).
>
> --
> Bye, Peter Korsgaard
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
