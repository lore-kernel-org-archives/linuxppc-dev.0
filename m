Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 66F9A2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 12:15:40 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, Chris Ball <cjb@laptop.org>,
 linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/8] IBM Akebono: Add a SDHCI platform driver
Date: Tue, 17 Dec 2013 12:11:28 +1100
Message-ID: <1449993.dLHmhtoyuX@mexican>
In-Reply-To: <1385086116-10972-2-git-send-email-alistair@popple.id.au>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
 <1385086116-10972-2-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I originally sent this to the linuxppc-dev list thinking Ben H might ta=
ke it,=20
however it should go through the appropriate subsystem. Can someone ple=
ase=20
merge it into the appropriate tree (unless the are problems with it)?

Thanks.

Regards,

Alistair

On Fri, 22 Nov 2013 13:08:30 Alistair Popple wrote:
> This patch adds a SDHCI platform driver for the new IBM PPC476GTR SoC=

> which is on the Akebono board.
>=20
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/Kconfig           |   12 ++++++++
>  drivers/mmc/host/Makefile          |    1 +
>  drivers/mmc/host/sdhci-of-476gtr.c |   60
> ++++++++++++++++++++++++++++++++++++ 3 files changed, 73 insertions(+=
)
>  create mode 100644 drivers/mmc/host/sdhci-of-476gtr.c
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..14210df 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -130,6 +130,18 @@ config MMC_SDHCI_OF_HLWD
>=20
>  =09  If unsure, say N.
>=20
> +config MMC_SDHCI_OF_476GTR
> +=09tristate "SDHCI OF support for the IBM PPC476GTR SoC"
> +=09depends on MMC_SDHCI_PLTFM
> +=09depends on PPC_OF
> +=09help
> +=09  This selects the Secure Digital Host Controller Interface (SDHC=
I)
> +=09  found on the PPC476GTR SoC.
> +
> +=09  If you have a controller with this interface, say Y or M here.
> +
> +=09  If unsure, say N.
> +
>  config MMC_SDHCI_CNS3XXX
>  =09tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
>  =09depends on ARCH_CNS3XXX
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index c41d0c3..92beff3 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)=09=09+=3D sdhci-dove.o=

>  obj-$(CONFIG_MMC_SDHCI_TEGRA)=09=09+=3D sdhci-tegra.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)=09+=3D sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)=09=09+=3D sdhci-of-hlwd.o
> +obj-$(CONFIG_MMC_SDHCI_OF_476GTR)=09+=3D sdhci-of-476gtr.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)=09+=3D sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_BCM2835)=09=09+=3D sdhci-bcm2835.o
>=20
> diff --git a/drivers/mmc/host/sdhci-of-476gtr.c
> b/drivers/mmc/host/sdhci-of-476gtr.c new file mode 100644
> index 0000000..1310f8c
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-476gtr.c
> @@ -0,0 +1,60 @@
> +/*
> + * drivers/mmc/host/sdhci-of-476gtr.c
> + *
> + * Copyright =A9 2013 Alistair Popple <alistair@popple.id.au> IBM Co=
rporation
> + *
> + * Based on sdhci-of-hlwd.c
> + *
> + * Copyright (C) 2009 The GameCube Linux Team
> + * Copyright (C) 2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or=
 (at
> + * your option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/mmc/host.h>
> +#include "sdhci-pltfm.h"
> +
> +static const struct sdhci_ops sdhci_476gtr_ops =3D {
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_476gtr_pdata =3D {
> +=09.ops =3D &sdhci_476gtr_ops,
> +};
> +
> +static int sdhci_476gtr_probe(struct platform_device *pdev)
> +{
> +=09return sdhci_pltfm_register(pdev, &sdhci_476gtr_pdata, 0);
> +}
> +
> +static int sdhci_476gtr_remove(struct platform_device *pdev)
> +{
> +=09return sdhci_pltfm_unregister(pdev);
> +}
> +
> +static const struct of_device_id sdhci_476gtr_of_match[] =3D {
> +=09{ .compatible =3D "ibm,476gtr-sdhci" },
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_476gtr_of_match);
> +
> +static struct platform_driver sdhci_476gtr_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D "sdhci-476gtr",
> +=09=09.owner =3D THIS_MODULE,
> +=09=09.of_match_table =3D sdhci_476gtr_of_match,
> +=09=09.pm =3D SDHCI_PLTFM_PMOPS,
> +=09},
> +=09.probe =3D sdhci_476gtr_probe,
> +=09.remove =3D sdhci_476gtr_remove,
> +};
> +
> +module_platform_driver(sdhci_476gtr_driver);
> +
> +MODULE_DESCRIPTION("PPC476GTR SDHCI OF driver");
> +MODULE_AUTHOR("Alistair Popple");
> +MODULE_LICENSE("GPL v2");
