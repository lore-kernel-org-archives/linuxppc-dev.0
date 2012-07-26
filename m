Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 690BA2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 03:47:57 +1000 (EST)
Subject: Re: [PATCH V3 3/5] powerpc/mpc85xx: convert to unified PCI init
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343305827-26734-3-git-send-email-B38951@freescale.com>
Date: Thu, 26 Jul 2012 12:47:53 -0500
Message-Id: <23B0038A-4C17-4EDD-9185-47DC3947F6A4@kernel.crashing.org>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <1343305827-26734-3-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2012, at 7:30 AM, Jia Hongtao wrote:

> PCI initialization is now done by PCI controller driver. In =
board_setup_arch
> stage we don't need PCI init any more but swiotlb should be determined =
at this
> stage.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> We now just apply this for mpc85xx_ds and qemu
>=20
> arch/powerpc/kernel/iommu.c.rej          |   22 -----------------
> arch/powerpc/platforms/85xx/common.c     |    9 +++++++
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   38 =
+++++++----------------------
> arch/powerpc/platforms/85xx/qemu_e500.c  |    5 +++-
> 4 files changed, 22 insertions(+), 52 deletions(-)
> delete mode 100644 arch/powerpc/kernel/iommu.c.rej
>=20
> diff --git a/arch/powerpc/kernel/iommu.c.rej =
b/arch/powerpc/kernel/iommu.c.rej
> deleted file mode 100644
> index 9d10d34..0000000
> --- a/arch/powerpc/kernel/iommu.c.rej
> +++ /dev/null
> @@ -1,22 +0,0 @@
> ---- arch/powerpc/kernel/iommu.c	2012-06-08 09:01:02.785709100 =
+1000
> -+++ arch/powerpc/kernel/iommu.c	2012-06-08 09:01:07.489784856 =
+1000
> -@@ -33,7 +33,9 @@
> - #include <linux/bitmap.h>
> - #include <linux/iommu-helper.h>
> - #include <linux/crash_dump.h>
> -+#include <linux/fault-inject.h>
> - #include <asm/io.h>
> -+#include <asm/vio.h>
> - #include <asm/prom.h>
> - #include <asm/iommu.h>
> - #include <asm/pci-bridge.h>
> -@@ -171,6 +261,9 @@
> - 		return DMA_ERROR_CODE;
> - 	}
> -=20
> -+	if (should_fail_iommu(dev))
> -+		return DMA_ERROR_CODE;
> -+
> - 	if (handle && *handle)
> - 		start =3D *handle;
> - 	else
> diff --git a/arch/powerpc/platforms/85xx/common.c =
b/arch/powerpc/platforms/85xx/common.c
> index 67dac22..303fedb 100644
> --- a/arch/powerpc/platforms/85xx/common.c
> +++ b/arch/powerpc/platforms/85xx/common.c
> @@ -27,6 +27,15 @@ static struct of_device_id __initdata =
mpc85xx_common_ids[] =3D {
> 	{ .compatible =3D "fsl,mpc8548-guts", },
> 	/* Probably unnecessary? */
> 	{ .compatible =3D "gpio-leds", },
> +	/* For all PCI controllers */
> +	{ .compatible =3D "fsl,mpc8540-pci", },
> +	{ .compatible =3D "fsl,mpc8548-pcie", },
> +	{ .compatible =3D "fsl,p1022-pcie", },
> +	{ .compatible =3D "fsl,p1010-pcie", },
> +	{ .compatible =3D "fsl,p1023-pcie", },
> +	{ .compatible =3D "fsl,p4080-pcie", },

Add:

	{ .compatible =3D "fsl,qoriq-pcie-v2.4", },

> +	{ .compatible =3D "fsl,qoriq-pcie-v2.3", },
> +	{ .compatible =3D "fsl,qoriq-pcie-v2.2", },


> 	{},
> };

- k=
