Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 37D38B6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 23:00:17 +1000 (EST)
Message-ID: <4E412F5C.7030802@grandegger.com>
Date: Tue, 09 Aug 2011 15:00:12 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 4/4] [powerpc] Add flexcan device support for p1010rdb.
References: <1312892907-20419-1-git-send-email-holt@sgi.com>
	<1312892907-20419-5-git-send-email-holt@sgi.com>
In-Reply-To: <1312892907-20419-5-git-send-email-holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: socketcan-core@lists.berlios.de, U Bhaskar-B22300 <B22300@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Robin,

On 08/09/2011 02:28 PM, Robin Holt wrote:
> I added a simple clock source for the p1010rdb so the flexcan driver
> could determine a clock frequency.  The p1010 can device only has an
> oscillator of system bus frequency divided by 2.
> 
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Marc Kleine-Budde <mkl@pengutronix.de>,
> To: Wolfgang Grandegger <wg@grandegger.com>,
> To: U Bhaskar-B22300 <B22300@freescale.com>
> Cc: socketcan-core@lists.berlios.de,
> Cc: netdev@vger.kernel.org,
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> ---
>  arch/powerpc/platforms/85xx/Kconfig    |    2 +
>  arch/powerpc/platforms/85xx/Makefile   |    2 +
>  arch/powerpc/platforms/85xx/clock.c    |   42 ++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/p1010rdb.c |    8 ++++++
>  4 files changed, 54 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/85xx/clock.c
> 
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index 498534c..c4304ae 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -70,6 +70,8 @@ config MPC85xx_RDB
>  config P1010_RDB
>  	bool "Freescale P1010RDB"
>  	select DEFAULT_UIMAGE
> +	select HAVE_CAN_FLEXCAN if NET && CAN
> +	select PPC_CLOCK if CAN_FLEXCAN
>  	help
>  	  This option enables support for the MPC85xx RDB (P1010 RDB) board
>  
> diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
> index a971b32..cc7f381 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -3,6 +3,8 @@
>  #
>  obj-$(CONFIG_SMP) += smp.o
>  
> +obj-$(CONFIG_PPC_CLOCK)   += clock.o
> +
>  obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
>  obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
>  obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
> diff --git a/arch/powerpc/platforms/85xx/clock.c b/arch/powerpc/platforms/85xx/clock.c
> new file mode 100644
> index 0000000..a6fd2c8
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/clock.c
> @@ -0,0 +1,42 @@
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +
> +#include <asm/clk_interface.h>
> +
> +#include <sysdev/fsl_soc.h>
> +
> +/*
> + * p1010 needs to provide a clock source for the flexcan driver. The
> + * oscillator for the p1010 processor is only ever the system clock / 2.
> + */
> +
> +static struct clk *mpc85xx_clk_get(struct device *dev, const char *id)
> +{
> +	if (!dev)
> +		return ERR_PTR(-ENOENT);
> +

Ah, I think you removed too much code here. I obviously did not
understand what the device node check is good for, sorry. The clock is
only implemented for the Flexcan and therefore we should add a check here:

	if (!dev->of_node ||
	    !of_device_is_compatible(dev->of_node, "fsl,flexcan"))
		return ERR_PTR(-ENOENT);

Something like that should work. For the next version you can then add
my "Acked-by: Wolfgang Grandegger <wg@grandegger.com" to all patches.

Wolfgang.
