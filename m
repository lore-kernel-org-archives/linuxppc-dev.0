Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id AE440B7B95
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 06:14:30 +1100 (EST)
Received: by ywh37 with SMTP id 37so2512540ywh.17
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 11:14:28 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258051520.2280.3@antares>
References: <1258051520.2280.3@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 12:14:05 -0700
Message-ID: <fa686aa40911121114r737a929dpd263a6a501702b@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] mpc52xx/wdt: remove obsolete old WDT implementation
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 12, 2009 at 11:45 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Remove the old WDT implementation.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Wim, I'm picking up the other 2 patches into my tree.  Do you want me
to push this patch through my tree, or do you want to pick it up?

g.

> ---
>
> Change against v1: WDT stuff now fully merged into the file
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c.
>
> Note: The file drivers/watchdog/mpc5200_wdt.c is now obsolete and should =
be removed.
>
> =A0drivers/watchdog/Kconfig =A0| =A0 =A04 +++-
> =A0drivers/watchdog/Makefile | =A0 =A01 -
> =A02 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3711b88..d958b76 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -861,8 +861,10 @@ config GEF_WDT
> =A0 =A0 =A0 =A0 =A0Watchdog timer found in a number of GE Fanuc single bo=
ard computers.
>
> =A0config MPC5200_WDT
> - =A0 =A0 =A0 tristate "MPC5200 Watchdog Timer"
> + =A0 =A0 =A0 bool "MPC52xx Watchdog Timer"
> =A0 =A0 =A0 =A0depends on PPC_MPC52xx
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Use General Purpose Timer (GPT) 0 on the MPC5200 as Wat=
chdog.
>
> =A0config 8xxx_WDT
> =A0 =A0 =A0 =A0tristate "MPC8xxx Platform Watchdog Timer"
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 699199b..89c045d 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -118,7 +118,6 @@ obj-$(CONFIG_TXX9_WDT) +=3D txx9wdt.o
>
> =A0# POWERPC Architecture
> =A0obj-$(CONFIG_GEF_WDT) +=3D gef_wdt.o
> -obj-$(CONFIG_MPC5200_WDT) +=3D mpc5200_wdt.o
> =A0obj-$(CONFIG_8xxx_WDT) +=3D mpc8xxx_wdt.o
> =A0obj-$(CONFIG_MV64X60_WDT) +=3D mv64x60_wdt.o
> =A0obj-$(CONFIG_PIKA_WDT) +=3D pika_wdt.o
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
