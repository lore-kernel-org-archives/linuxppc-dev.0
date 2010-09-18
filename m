Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 03F7CB70B8
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 10:37:49 +1000 (EST)
Received: by wyf19 with SMTP id 19so3619101wyf.15
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 17:37:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1284764008-19469-2-git-send-email-timur@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<1284764008-19469-2-git-send-email-timur@freescale.com>
Date: Fri, 17 Sep 2010 20:37:47 -0400
Message-ID: <AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver to
	be compiled as a module
From: Josh Boyer <jwboyer@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, linux-watchdog@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 17, 2010 at 6:53 PM, Timur Tabi <timur@freescale.com> wrote:
> Register the __init and __exit functions in the PowerPC e500 watchdog dri=
ver
> as module entry/exit functions, and modify the Kconfig entry.
>
> Add a .release method for the PowerPC e500 watchdog driver, so that the
> watchdog is disabled when the driver is closed.

This is used for more than just e500.

>
> Loosely based on original code from Jiang Yutang <b14898@freescale.com>.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch requires:
>
> =A0 =A0 =A0 =A0powerpc: export ppc_tb_freq so that modules can reference =
it
>
> =A0drivers/watchdog/Kconfig =A0 =A0 | =A0 =A05 ++++-
> =A0drivers/watchdog/booke_wdt.c | =A0 39 ++++++++++++++++++++++++++++++++=
+++++--
> =A02 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 24efd8e..d9cf5a9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -957,9 +957,12 @@ config PIKA_WDT
> =A0 =A0 =A0 =A0 =A0the Warp platform.
>
> =A0config BOOKE_WDT
> - =A0 =A0 =A0 bool "PowerPC Book-E Watchdog Timer"
> + =A0 =A0 =A0 tristate "PowerPC Book-E Watchdog Timer"
> =A0 =A0 =A0 =A0depends on BOOKE || 4xx
> =A0 =A0 =A0 =A0---help---
> + =A0 =A0 =A0 =A0 Watchdog driver for PowerPC e500 chips, such as the Fre=
escale
> + =A0 =A0 =A0 =A0 MPC85xx SOCs.
> +

Again, used for more than e500.  That || 4xx in the depends statement
right above your addition isn't there for fun :).

josh
