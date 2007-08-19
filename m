Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DF00DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Aug 2007 11:52:01 +1000 (EST)
Received: from hp-dhlii.dlasys.net ([206.223.20.205])
	by mx.dlasys.net with esmtp (Exim 4.67 #1 (Debian))
	id 1IMZdS-00067l-Ik
	for <linuxppc-embedded@ozlabs.org>; Sat, 18 Aug 2007 21:31:22 -0400
Message-ID: <46C79E33.8090600@dlasys.net>
Date: Sat, 18 Aug 2007 21:34:43 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<87vebryfrv.fsf@sleipner.barco.com>
In-Reply-To: <87vebryfrv.fsf@sleipner.barco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

arch/boot/simple/embed_config.c jusst seems to be a random collection of 
board specific code anyway.
A giant case statement implimented with #ifdef's. It is just screaming 
to be done some better way.

Peter Korsgaard wrote:
>>>>>> "WR" == Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> writes:
>>>>>>             
>
> Hi,
>
> WR> diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
> WR> index 5b87779..05631fe 100644
> WR> --- a/arch/ppc/boot/simple/Makefile
> WR> +++ b/arch/ppc/boot/simple/Makefile
> WR> @@ -187,8 +187,7 @@ boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
> WR>  boot-$(CONFIG_8xx)		+= embed_config.o
> WR>  boot-$(CONFIG_8260)		+= embed_config.o
> WR>  boot-$(CONFIG_EP405)		+= embed_config.o
> WR> -boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
> WR> -boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
> WR> +boot-$(CONFIG_XILINX_VIRTEX)	+= embed_config.o
>
> Don't do that. Other boards with Xilinx FPGAs don't necessarily need
> embed_config.c
>
> WR>  boot-$(CONFIG_BSEIP)		+= iic.o
> WR>  boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
> WR>  boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o
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
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
