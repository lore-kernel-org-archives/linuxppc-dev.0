Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 736E41A0368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 11:26:45 +1000 (AEST)
Message-ID: <1435281991.4306.1.camel@freescale.com>
Subject: Re: [v2,1/9] fsl/fman: Add the FMan FLIB
From: Scott Wood <scottwood@freescale.com>
To: igal.liberman@freescale.com
CC: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 madalin.bucur@freescale.com, pebolle@tiscali.nl
Date: Thu, 25 Jun 2015 20:26:31 -0500
In-Reply-To: <1435174389-8016-1-git-send-email-igal.liberman@freescale.com>
References: <1435174389-8016-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-24 at 22:33 +0300, igal.liberman@freescale.com wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> The FMan FLib provides the basic API used by the FMan drivers to
> > configure and control the FMan hardware.
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>

Again, what is an FLib?  What determines whether content should go in 
the "flib" directory?

The patch title says "Add the FMan FLIB", but there's more code added 
outside the "flib" directory than inside.
 
"FMan drivers"?  There's more than one?  What is 
"drivers/net/ethernet/freescale/fman/fman.c" if not "the FMan driver"? 
 What is "the FMan driver" if not the code "to configure and control 
the FMan hardware"?  If this is a public API, where's the 
documentation?

---
>  drivers/net/ethernet/freescale/Kconfig             |    1 +
>  drivers/net/ethernet/freescale/Makefile            |    2 +
>  drivers/net/ethernet/freescale/fman/Kconfig        |    7 +
>  drivers/net/ethernet/freescale/fman/Makefile       |    5 +
>  .../net/ethernet/freescale/fman/flib/fsl_fman.h    |  608 
> ++++++++++++
>  drivers/net/ethernet/freescale/fman/fman.c         |  975 
> ++++++++++++++++++++
>  6 files changed, 1598 insertions(+)
>  create mode 100644 drivers/net/ethernet/freescale/fman/Kconfig
>  create mode 100644 drivers/net/ethernet/freescale/fman/Makefile
>  create mode 100644 
> drivers/net/ethernet/freescale/fman/flib/fsl_fman.h
>  create mode 100644 drivers/net/ethernet/freescale/fman/fman.c
> 
> diff --git a/drivers/net/ethernet/freescale/Kconfig 
> b/drivers/net/ethernet/freescale/Kconfig
> index 25e3425..24e938d 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -55,6 +55,7 @@ config FEC_MPC52xx_MDIO
>         If compiled as module, it will be called fec_mpc52xx_phy.
>  
>  source "drivers/net/ethernet/freescale/fs_enet/Kconfig"
> +source "drivers/net/ethernet/freescale/fman/Kconfig"
>  
>  config FSL_PQ_MDIO
>       tristate "Freescale PQ MDIO"
> diff --git a/drivers/net/ethernet/freescale/Makefile 
> b/drivers/net/ethernet/freescale/Makefile
> index 71debd1..4097c58 100644
> --- a/drivers/net/ethernet/freescale/Makefile
> +++ b/drivers/net/ethernet/freescale/Makefile
> @@ -17,3 +17,5 @@ gianfar_driver-objs := gianfar.o \
>               gianfar_ethtool.o
>  obj-$(CONFIG_UCC_GETH) += ucc_geth_driver.o
>  ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
> +
> +obj-$(CONFIG_FSL_FMAN) += fman/
> diff --git a/drivers/net/ethernet/freescale/fman/Kconfig 
> b/drivers/net/ethernet/freescale/fman/Kconfig
> new file mode 100644
> index 0000000..8aeae29
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/Kconfig
> @@ -0,0 +1,7 @@
> +config FSL_FMAN
> +     bool "FMan support"
> +     depends on FSL_SOC || COMPILE_TEST
> +     default n
> +     help
> +             Freescale Data-Path Acceleration Architecture Frame Manager
> +             (FMan) support

"default n" is a no-op.

What does enabling this option actually do, in terms of user-visible 
features?

> +typedef struct fm_prs_result_t fm_prs_result;
> +typedef enum e_enet_mode enet_mode_t;

This use of typedef is contrary to kernel coding style.

-Scott
