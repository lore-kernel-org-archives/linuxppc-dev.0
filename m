Return-Path: <sr@denx.de>
Received: from natnoddy.rzone.de (natnoddy.rzone.de [81.169.145.166])
	by ozlabs.org (Postfix) with ESMTP id 84F7167D19
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 23:44:27 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 27 Jul 2005 15:47:30 +0200
References: <42E776DD.9080307@softadvances.com>
In-Reply-To: <42E776DD.9080307@softadvances.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507271547.30827.sr@denx.de>
Cc: John Otken <jotken@softadvances.com>
Subject: Re: [PATCH] Support for AMCC Yosemite 440EP Eval Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi John,

On Wednesday 27 July 2005 13:58, John Otken wrote:
> This patch adds support for the new AMCC Yosemite 440EP Eval
> Board.  I tested it on the both Bamboo and Yosemite boards
> using the 2.6.12 kernel.

How about a patch against a more recent kernel?

> This patch has three dependencies:
>  2005-04-07 Wade Farnsworth's PPC440EP SoC and Bamboo board support

Please use the patches Wade sent yesterday to this list.

>  2005-07-20 My fix invalid function name usb_hcd_put in ohci-ppc-soc.c
>  2005-07-27 My Support 440EP On-Chip OHCI USB Host Controller
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=1311
> http://patchwork.ozlabs.org/linuxppc/patch?id=1803
> http://patchwork.ozlabs.org/linuxppc/patch?id=1855
>
> Comments are welcome.

OK, here we go...

<snip>

> diff -uprN c/arch/ppc/platforms/4xx/bamboo.c
> d/arch/ppc/platforms/4xx/bamboo.c ---
> c/arch/ppc/platforms/4xx/bamboo.c	2005-07-25 06:34:52.000000000 -0500 +++
> d/arch/ppc/platforms/4xx/bamboo.c	2005-07-26 10:31:37.000000000 -0500 @@
> -59,6 +59,20 @@
>   */
>  #include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
>
> +#if defined(CONFIG_BAMBOO)
> +static const int bamboo = 1;
> +static const char cpu_name[] = {"440EP"};
> +static const char brd_name[] = {"Bamboo"};
> +#elif defined(CONFIG_YELLOWSTONE)
> +static const int bamboo = 0;
> +static const char cpu_name[] = {"440GR"};
> +static const char brd_name[] = {"Yellowstone"};
> +#else
> +static const int bamboo = 0;
> +static const char cpu_name[] = {"440EP"};
> +static const char brd_name[] = {"Yosemite"};
> +#endif
> +

Hmmm. You seem to include not only the Yosemite but also the Yellowstone with 
a different processor type (440GR) into the bamboo platform file. I would 
prefer seperate platform files for the different boards, especially since the 
differences are not marginal.

<snip>

> diff -uprN c/arch/ppc/platforms/4xx/Makefile
> d/arch/ppc/platforms/4xx/Makefile ---
> c/arch/ppc/platforms/4xx/Makefile	2005-07-24 16:14:36.000000000 -0500 +++
> d/arch/ppc/platforms/4xx/Makefile	2005-07-26 10:51:35.000000000 -0500 @@
> -15,6 +15,7 @@ obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
>  obj-$(CONFIG_SYCAMORE)		+= sycamore.o
>  obj-$(CONFIG_WALNUT)		+= walnut.o
>  obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
> +obj-$(CONFIG_YOSEMITE)		+= bamboo.o

Please see above.

Best regards,
Stefan
