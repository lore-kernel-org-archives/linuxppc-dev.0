Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id DCF52DE153
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 22:27:11 +1000 (EST)
Date: Wed, 20 May 2009 14:27:07 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: [PATCH] powerpc/ep8248e: phylib needs NET_SCHED to build
In-Reply-To: <1242821902-16836-1-git-send-email-a.beregalov@gmail.com>
Message-ID: <alpine.LRH.2.00.0905201425540.5871@vixen.sonytel.be>
References: <1242821902-16836-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 May 2009, Alexander Beregalov wrote:
> Fix this build error:
> drivers/built-in.o: In function `phy_state_machine':
> drivers/net/phy/phy.c:893: undefined reference to 'netif_carrier_off'
> drivers/net/phy/phy.c:854: undefined reference to 'netif_carrier_on'
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> ---
>  arch/powerpc/platforms/82xx/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
> index 7c7df40..36a3e58 100644
> --- a/arch/powerpc/platforms/82xx/Kconfig
> +++ b/arch/powerpc/platforms/82xx/Kconfig
> @@ -31,6 +31,9 @@ config EP8248E
>  	select 8260
>  	select FSL_SOC
>  	select PHYLIB
> +	select NET
> +	select NETDEVICE
> +	select NET_SCHED
>  	select MDIO_BITBANG
>  	help
>  	  This enables support for the Embedded Planet EP8248E board.

Why is there a `select PHYLIB' at the platform level? Shouldn't it be in
drivers/net/Kconfig, near the appropriate network driver? That way people can
build kernels without networking support, if they want.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
