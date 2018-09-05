Return-Path: <dongsheng.wang@hxt-semitech.com>
Received: from barracuda.hxt-semitech.com (mx01.hxt-semitech.com
 [223.203.96.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424pl54bXPzF0PW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 13:16:31 +1000 (AEST)
From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To: Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
Date: Wed, 5 Sep 2018 02:57:58 +0000
Message-ID: <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-3-ran.wang_1@nxp.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please change your comments style.=0A=
=0A=
On 2018/8/31 11:56, Ran Wang wrote:=0A=
> The NXP's QorIQ Processors based on ARM Core have RCPM module (Run=0A=
> Control and Power Management), which performs all device-level=0A=
> tasks associated with power management such as wakeup source control.=0A=
>=0A=
> This driver depends on FSL platform PM driver framework which help to=0A=
> isolate user and PM service provider (such as RCPM driver).=0A=
>=0A=
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>=0A=
> Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>=0A=
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>=0A=
> ---=0A=
>  drivers/soc/fsl/Kconfig   |    6 ++=0A=
>  drivers/soc/fsl/Makefile  |    1 +=0A=
>  drivers/soc/fsl/ls-rcpm.c |  153 +++++++++++++++++++++++++++++++++++++++=
++++++=0A=
>  3 files changed, 160 insertions(+), 0 deletions(-)=0A=
>  create mode 100644 drivers/soc/fsl/ls-rcpm.c=0A=
>=0A=
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig=0A=
> index 6517412..882330d 100644=0A=
> --- a/drivers/soc/fsl/Kconfig=0A=
> +++ b/drivers/soc/fsl/Kconfig=0A=
> @@ -30,3 +30,9 @@ config FSL_PLAT_PM=0A=
>  	  have to know the implement details of wakeup function it require.=0A=
>  	  Besides, it is also easy for service side to upgrade its logic when=
=0A=
>  	  design changed and remain user side unchanged.=0A=
> +=0A=
> +config LS_RCPM=0A=
> +	bool "Freescale RCPM support"=0A=
> +	depends on (FSL_PLAT_PM)=0A=
> +	help=0A=
> +	  This feature is to enable specified wakeup source for system sleep.=
=0A=
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile=0A=
> index 8f9db23..43ff71a 100644=0A=
> --- a/drivers/soc/fsl/Makefile=0A=
> +++ b/drivers/soc/fsl/Makefile=0A=
> @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/=0A=
>  obj-$(CONFIG_CPM)			+=3D qe/=0A=
>  obj-$(CONFIG_FSL_GUTS)			+=3D guts.o=0A=
>  obj-$(CONFIG_FSL_PLAT_PM)	+=3D plat_pm.o=0A=
> +obj-$(CONFIG_LS_RCPM)		+=3D ls-rcpm.o=0A=
> diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c=0A=
> new file mode 100644=0A=
> index 0000000..b0feb88=0A=
> --- /dev/null=0A=
> +++ b/drivers/soc/fsl/ls-rcpm.c=0A=
> @@ -0,0 +1,153 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +//=0A=
> +// plat_pm.c - Freescale Layerscape RCPM driver=0A=
> +//=0A=
> +// Copyright 2018 NXP=0A=
> +//=0A=
> +// Author: Ran Wang <ran.wang_1@nxp.com>,=0A=
> +=0A=
> +#include <linux/init.h>=0A=
> +#include <linux/module.h>=0A=
> +#include <linux/platform_device.h>=0A=
> +#include <linux/of_address.h>=0A=
> +#include <linux/slab.h>=0A=
> +#include <soc/fsl/plat_pm.h>=0A=
> +=0A=
> +#define MAX_COMPATIBLE_NUM	10=0A=
> +=0A=
> +struct rcpm_t {=0A=
> +	struct device *dev;=0A=
> +	void __iomem *ippdexpcr_addr;=0A=
> +	bool big_endian;	/* Big/Little endian of RCPM module */=0A=
> +};=0A=
> +=0A=
> +// rcpm_handle - Configure RCPM reg according to wake up source request=
=0A=
> +// @user_dev: pointer to user's device struct=0A=
> +// @flag: to enable(true) or disable(false) wakeup source=0A=
> +// @handle_priv: pointer to struct rcpm_t instance=0A=
> +//=0A=
> +// Return 0 on success other negative errno=0A=
> +static int rcpm_handle(struct device *user_dev, bool flag, void *handle_=
priv)=0A=
> +{=0A=
> +	struct rcpm_t *rcpm;=0A=
> +	bool big_endian;=0A=
> +	const char  *dev_compatible_array[MAX_COMPATIBLE_NUM];=0A=
> +	void __iomem *ippdexpcr_addr;=0A=
> +	u32 ippdexpcr;=0A=
> +	u32 set_bit;=0A=
> +	int ret, num, i;=0A=
> +=0A=
> +	rcpm =3D handle_priv;=0A=
> +	big_endian =3D rcpm->big_endian;=0A=
> +	ippdexpcr_addr =3D rcpm->ippdexpcr_addr;=0A=
> +=0A=
> +	num =3D device_property_read_string_array(user_dev, "compatible",=0A=
> +			dev_compatible_array, MAX_COMPATIBLE_NUM);=0A=
> +	if (num < 0)=0A=
> +		return num;=0A=
> +=0A=
> +	for (i =3D 0; i < num; i++) {=0A=
> +		if (!device_property_present(rcpm->dev,=0A=
> +					dev_compatible_array[i]))=0A=
> +			continue;=0A=
> +		else {=0A=
Remove this else.=0A=
> +			ret =3D device_property_read_u32(rcpm->dev,=0A=
> +					dev_compatible_array[i], &set_bit);=0A=
> +			if (ret)=0A=
> +				return ret;=0A=
> +=0A=
> +			if (!device_property_present(rcpm->dev,=0A=
> +						dev_compatible_array[i]))=0A=
This has been checked. Continue ? or return ENODEV=1B$B!)=1B(B=0A=
> +				return -ENODEV;=0A=
> +			else {=0A=
Remove this else.=0A=
> +				ret =3D device_property_read_u32(rcpm->dev,=0A=
> +						dev_compatible_array[i], &set_bit);=0A=
> +				if (ret)=0A=
> +					return ret;=0A=
> +=0A=
> +				if (big_endian)=0A=
> +					ippdexpcr =3D ioread32be(ippdexpcr_addr);=0A=
> +				else=0A=
> +					ippdexpcr =3D ioread32(ippdexpcr_addr);=0A=
> +=0A=
> +				if (flag)=0A=
> +					ippdexpcr |=3D set_bit;=0A=
> +				else=0A=
> +					ippdexpcr &=3D ~set_bit;=0A=
> +=0A=
> +				if (big_endian) {=0A=
> +					iowrite32be(ippdexpcr, ippdexpcr_addr);=0A=
> +					ippdexpcr =3D ioread32be(ippdexpcr_addr);=0A=
> +				} else=0A=
if (x) {=0A=
....=0A=
....=0A=
}  else {=0A=
=0A=
}=0A=
> +					iowrite32(ippdexpcr, ippdexpcr_addr);=0A=
> +=0A=
> +				return 0;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return -ENODEV;=0A=
> +}=0A=
> +=0A=
> +static int ls_rcpm_probe(struct platform_device *pdev)=0A=
> +{=0A=
> +	struct resource *r;=0A=
> +	struct rcpm_t *rcpm;=0A=
> +=0A=
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);=0A=
> +	if (!r)=0A=
> +		return -ENODEV;=0A=
> +=0A=
> +	rcpm =3D kmalloc(sizeof(*rcpm), GFP_KERNEL);=0A=
kzalloc is better.=0A=
> +	if (!rcpm)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	rcpm->big_endian =3D device_property_read_bool(&pdev->dev, "big-endian"=
);=0A=
> +=0A=
> +	rcpm->ippdexpcr_addr =3D devm_ioremap_resource(&pdev->dev, r);=0A=
> +	if (IS_ERR(rcpm->ippdexpcr_addr))=0A=
> +		return PTR_ERR(rcpm->ippdexpcr_addr);=0A=
> +=0A=
> +	rcpm->dev =3D &pdev->dev;=0A=
> +	platform_set_drvdata(pdev, rcpm);=0A=
> +=0A=
> +	return register_fsl_platform_wakeup_source(rcpm_handle, rcpm);=0A=
> +}=0A=
> +=0A=
> +static int ls_rcpm_remove(struct platform_device *pdev)=0A=
> +{=0A=
> +	struct rcpm_t	*rcpm;=0A=
Not need a table.=0A=
=0A=
Cheers,=0A=
-Dongsheng=0A=
=0A=
> +=0A=
> +	rcpm =3D platform_get_drvdata(pdev);=0A=
> +	deregister_fsl_platform_wakeup_source(rcpm);=0A=
> +	kfree(rcpm);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static const struct of_device_id ls_rcpm_of_match[] =3D {=0A=
> +	{ .compatible =3D "fsl,qoriq-rcpm-2.1", },=0A=
> +	{}=0A=
> +};=0A=
> +MODULE_DEVICE_TABLE(of, ls_rcpm_of_match);=0A=
> +=0A=
> +static struct platform_driver ls_rcpm_driver =3D {=0A=
> +	.driver =3D {=0A=
> +		.name =3D "ls-rcpm",=0A=
> +		.of_match_table =3D ls_rcpm_of_match,=0A=
> +	},=0A=
> +	.probe =3D ls_rcpm_probe,=0A=
> +	.remove =3D ls_rcpm_remove,=0A=
> +};=0A=
> +=0A=
> +static int __init ls_rcpm_init(void)=0A=
> +{=0A=
> +	return platform_driver_register(&ls_rcpm_driver);=0A=
> +}=0A=
> +subsys_initcall(ls_rcpm_init);=0A=
> +=0A=
> +static void __exit ls_rcpm_exit(void)=0A=
> +{=0A=
> +	platform_driver_unregister(&ls_rcpm_driver);=0A=
> +}=0A=
> +module_exit(ls_rcpm_exit);=0A=
=0A=
=0A=
