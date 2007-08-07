Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id E7CFADDE05
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 17:21:35 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1IIJ3t-0001u0-4Y
	for linuxppc-embedded@ozlabs.org; Tue, 07 Aug 2007 09:01:01 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
Date: Tue, 07 Aug 2007 09:01:01 +0200
In-Reply-To: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com> (Wolfgang
	Reissnegger's message of "Mon, 06 Aug 2007 15:57:25 -0700")
Message-ID: <87zm13ygk2.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "WR" == Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> writes:

Hi,

WR> diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
WR> index 5b87779..05631fe 100644
WR> --- a/arch/ppc/boot/simple/Makefile
WR> +++ b/arch/ppc/boot/simple/Makefile
WR> @@ -187,8 +187,7 @@ boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
WR>  boot-$(CONFIG_8xx)		+= embed_config.o
WR>  boot-$(CONFIG_8260)		+= embed_config.o
WR>  boot-$(CONFIG_EP405)		+= embed_config.o
WR> -boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
WR> -boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
WR> +boot-$(CONFIG_XILINX_VIRTEX)	+= embed_config.o

Don't do that. Other boards with Xilinx FPGAs don't necessarily need
embed_config.c

WR>  boot-$(CONFIG_BSEIP)		+= iic.o
WR>  boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
WR>  boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o
WR> diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
WR> index 840bff2..e0b8954 100644
WR> --- a/arch/ppc/boot/simple/embed_config.c
WR> +++ b/arch/ppc/boot/simple/embed_config.c
WR> @@ -744,7 +744,7 @@ embed_config(bd_t **bdp)
WR>  }
WR>  #endif /* WILLOW */
 
WR> -#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
WR> +#if defined(CONFIG_XILINX_VIRTEX)
WR>  void
WR>  embed_config(bd_t ** bdp)

.. And if they do, they might have another embed_config (E.G. if the
bootloader provides a valid struct bd_t).

-- 
Bye, Peter Korsgaard
