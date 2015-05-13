Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0113.outbound.protection.outlook.com [207.46.100.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2DD01A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 13:08:06 +1000 (AEST)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Eduardo Valentin <edubezval@gmail.com>
Subject: RE: [PATCH] QorIQ/TMU: add thermal management support based on TMU
Date: Wed, 13 May 2015 03:07:59 +0000
Message-ID: <BLUPR03MB14934C15123151F76F9F81DE1D90@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1428045087-15557-1-git-send-email-hongtao.jia@freescale.com>
 <20150512014859.GG4810@localhost.localdomain>
 <BY2PR03MB157CC7A02D0010EB746709FE1DA0@BY2PR03MB157.namprd03.prod.outlook.com>
 <20150512232512.GA5064@localhost.localdomain>
In-Reply-To: <20150512232512.GA5064@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for the comments.
Answered inline.


> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Wednesday, May 13, 2015 7:25 AM
> To: Jia Hongtao-B38951
> Cc: rui.zhang@intel.com; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Wood Scott-B07421
> Subject: Re: [PATCH] QorIQ/TMU: add thermal management support based on
> TMU
>=20
> On Tue, May 12, 2015 at 08:17:21AM +0000, Hongtao Jia wrote:
> > Eduardo,
> >
> > Thanks for your comments.
> > See my answers inline.
> >
> > ---
> > Best Regards,
> > Hongtao
> >
> >
> > > -----Original Message-----
> > > From: Eduardo Valentin [mailto:edubezval@gmail.com]
> > > Sent: Tuesday, May 12, 2015 9:49 AM
> > > To: Jia Hongtao-B38951
> > > Cc: rui.zhang@intel.com; linux-pm@vger.kernel.org; linuxppc-
> > > dev@lists.ozlabs.org; Wood Scott-B07421
> > > Subject: Re: [PATCH] QorIQ/TMU: add thermal management support based
> > > on TMU
> > >
> > > Jia Hongtao,
> > >
> > > Thanks for sharing your driver. Sorry for the late answer. Please
> > > find couple of comments as follows.
> > >
> > > On Fri, Apr 03, 2015 at 03:11:27PM +0800, Jia Hongtao wrote:
> > > > It supports one critical trip point and one passive trip point.
> > > > The cpufreq is used as the cooling device to throttle CPUs when
> > > > the passive trip is crossed.
> > > >
> > > > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > > > ---
> > > >  drivers/thermal/Kconfig         |  11 ++
> > > >  drivers/thermal/Makefile        |   1 +
> > > >  drivers/thermal/qoriq_thermal.c | 405
> > > > ++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 417 insertions(+)  create mode 100644
> > > > drivers/thermal/qoriq_thermal.c
> > > >
> > > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > > index
> > > > af40db0..c0a8bd1 100644
> > > > --- a/drivers/thermal/Kconfig
> > > > +++ b/drivers/thermal/Kconfig
> > > > @@ -147,6 +147,17 @@ config IMX_THERMAL
> > > >  	  cpufreq is used as the cooling device to throttle CPUs when
> the
> > > >  	  passive trip is crossed.
> > > >
> > > > +config QORIQ_THERMAL
> > > > +	tristate "Freescale QorIQ Thermal Monitoring Unit"
> > > > +	depends on CPU_THERMAL
> > > > +	depends on OF
> > > > +	default n
> > > > +	help
> > > > +	  Enable thermal management based on Freescale QorIQ Thermal
> > > Monitoring
> > > > +	  Unit (TMU). It supports one critical trip point and one
> > > > +passive
> > > trip
> > > > +	  point. The cpufreq is used as the cooling device to
> throttle
> > > > +CPUs
> > > when
> > > > +	  the passive trip is crossed.
> > >
> > > dummy question, what is the level of overlap between QorIQ and IMX
> > > thermal drivers?
> >
> > Actually they both have two trip points.
> > Besides, they have no others in common per my understanding.
> >
> > >
> > > > +
> > > >  config SPEAR_THERMAL
> > > >  	bool "SPEAr thermal sensor driver"
> > > >  	depends on PLAT_SPEAR
> > > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > > index
> > > > fa0dc48..7de4847 100644
> > > > --- a/drivers/thermal/Makefile
> > > > +++ b/drivers/thermal/Makefile
> > > > @@ -31,6 +31,7 @@ obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
> > > >  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
> > > >  obj-$(CONFIG_ARMADA_THERMAL)	+=3D armada_thermal.o
> > > >  obj-$(CONFIG_IMX_THERMAL)	+=3D imx_thermal.o
> > > > +obj-$(CONFIG_QORIQ_THERMAL)	+=3D qoriq_thermal.o
> > > >  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D
> db8500_cpufreq_cooling.o
> > > >  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
> > > >  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+=3D x86_pkg_temp_thermal.o
> > > > diff --git a/drivers/thermal/qoriq_thermal.c
> > > > b/drivers/thermal/qoriq_thermal.c new file mode 100644 index
> > > > 0000000..f5d3a2c
> > > > --- /dev/null
> > > > +++ b/drivers/thermal/qoriq_thermal.c
> > > > @@ -0,0 +1,405 @@
> > > > +/*
> > > > + * Copyright 2015 Freescale Semiconductor, Inc.
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > > +modify it
> > > > + * under the terms and conditions of the GNU General Public
> > > > +License,
> > > > + * version 2, as published by the Free Software Foundation.
> > > > + *
> > > > + * This program is distributed in the hope it will be useful, but
> > > > +WITHOUT
> > > > + * ANY WARRANTY; without even the implied warranty of
> > > > +MERCHANTABILITY or
> > > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > > > +License for
> > > > + * more details.
> > > > + *
> > > > + */
> > > > +
> > > > +/*
> > > > + * Based on Freescale QorIQ Thermal Monitoring Unit (TMU)  */
> > > > +#include <linux/cpufreq.h> #include <linux/cpu_cooling.h>
> > > > +#include <linux/module.h> #include <linux/platform_device.h>
> > > > +#include <linux/err.h> #include <linux/io.h> #include
> > > > +<linux/of.h> #include <linux/thermal.h>
> > > > +
> > > > +#define SITES_MAX		16
> > > > +
> > > > +#define TMU_TEMP_PASSIVE	85000
> > > > +#define TMU_TEMP_CRITICAL	95000
> > > > +
> > > > +#define TMU_PASSIVE_DELAY	1000	/* Milliseconds */
> > > > +#define TMU_POLLING_DELAY	5000
> > > > +
> > > > +/* The driver supports 1 passive trip point and 1 critical trip
> > > > +point */ enum tmu_thermal_trip {
> > > > +	TMU_TRIP_PASSIVE,
> > > > +	TMU_TRIP_CRITICAL,
> > > > +	TMU_TRIP_NUM,
> > > > +};
> > > > +
> > >
> > > the above symbol is not used in this driver.
> >
> > TMU_TRIP_CRITICAL is not used but it is defined to make this symbol
> list clear.
> >
> > >
> > > > +/*
> > > > + * QorIQ TMU Registers
> > > > + */
> > > > +struct qoriq_tmu_site_regs {
> > > > +	__be32 tritsr;		/* Immediate Temperature Site
> Register */
> > > > +	__be32 tratsr;		/* Average Temperature Site Register
> */
> > > > +	u8 res0[0x8];
> > > > +} __packed;
> > > > +
> > > > +struct qoriq_tmu_regs {
> > > > +	__be32 tmr;		/* Mode Register */
> > > > +#define TMR_DISABLE	0x0
> > > > +#define TMR_ME		0x80000000
> > > > +#define TMR_ALPF	0x0c000000
> > > > +#define TMR_MSITE	0x00008000
> > > > +#define TMR_ALL		(TMR_ME | TMR_ALPF | TMR_MSITE)
> > > > +	__be32 tsr;		/* Status Register */
> > > > +	__be32 tmtmir;		/* Temperature measurement interval
> > > Register */
> > > > +#define TMTMIR_DEFAULT	0x00000007
> > > > +	u8 res0[0x14];
> > > > +	__be32 tier;		/* Interrupt Enable Register */
> > > > +#define TIER_DISABLE	0x0
> > > > +	__be32 tidr;		/* Interrupt Detect Register */
> > > > +	__be32 tiscr;		/* Interrupt Site Capture Register */
> > > > +	__be32 ticscr;		/* Interrupt Critical Site Capture
> Register
> > > */
> > > > +	u8 res1[0x10];
> > > > +	__be32 tmhtcrh;		/* High Temperature Capture Register
> */
> > > > +	__be32 tmhtcrl;		/* Low Temperature Capture Register
> */
> > > > +	u8 res2[0x8];
> > > > +	__be32 tmhtitr;		/* High Temperature Immediate
> Threshold */
> > > > +	__be32 tmhtatr;		/* High Temperature Average Threshold
> */
> > > > +	__be32 tmhtactr;	/* High Temperature Average Crit Threshold
> */
> > > > +	u8 res3[0x24];
> > > > +	__be32 ttcfgr;		/* Temperature Configuration Register
> */
> > > > +	__be32 tscfgr;		/* Sensor Configuration Register */
> > > > +	u8 res4[0x78];
> > > > +	struct qoriq_tmu_site_regs site[SITES_MAX];
> > > > +	u8 res5[0x9f8];
> > > > +	__be32 ipbrr0;		/* IP Block Revision Register 0 */
> > > > +	__be32 ipbrr1;		/* IP Block Revision Register 1 */
> > > > +	u8 res6[0x310];
> > > > +	__be32 ttr0cr;		/* Temperature Range 0 Control
> Register */
> > > > +	__be32 ttr1cr;		/* Temperature Range 1 Control
> Register */
> > > > +	__be32 ttr2cr;		/* Temperature Range 2 Control
> Register */
> > > > +	__be32 ttr3cr;		/* Temperature Range 3 Control
> Register */
> > > > +};
> > > > +
> > > > +/*
> > > > + * Thermal zone data
> > > > + */
> > > > +struct qoriq_tmu_data {
> > > > +	struct thermal_zone_device *tz;
> > > > +	struct thermal_cooling_device *cdev;
> > > > +	enum thermal_device_mode mode;
> > > > +	unsigned long temp_passive;
> > > > +	unsigned long temp_critical;
> > > > +	struct qoriq_tmu_regs __iomem *regs; };
> > > > +
> > > > +static int tmu_get_mode(struct thermal_zone_device *tz,
> > > > +			enum thermal_device_mode *mode) {
> > > > +	struct qoriq_tmu_data *data =3D tz->devdata;
> > > > +
> > > > +	*mode =3D data->mode;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tmu_set_mode(struct thermal_zone_device *tz,
> > > > +			enum thermal_device_mode mode) {
> > > > +	struct qoriq_tmu_data *data =3D tz->devdata;
> > > > +
> > > > +	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
> > > > +		tz->polling_delay =3D TMU_POLLING_DELAY;
> > > > +		tz->passive_delay =3D TMU_PASSIVE_DELAY;
> > > > +		thermal_zone_device_update(tz);
> > > > +	} else {
> > > > +		tz->polling_delay =3D 0;
> > > > +		tz->passive_delay =3D 0;
> > > > +	}
> > > > +
> > > > +	data->mode =3D mode;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tmu_get_temp(struct thermal_zone_device *tz, unsigned
> > > > +long
> > > > +*temp) {
> > > > +	u8 val;
> > > > +	struct qoriq_tmu_data *data =3D tz->devdata;
> > > > +
> > > > +	val =3D ioread32be(&data->regs->site[0].tritsr);
> > > > +	*temp =3D (unsigned long)val * 1000;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tmu_get_trip_type(struct thermal_zone_device *tz, int
> trip,
> > > > +			     enum thermal_trip_type *type) {
> > > > +	*type =3D (trip =3D=3D TMU_TRIP_PASSIVE) ? THERMAL_TRIP_PASSIVE :
> > > > +					     THERMAL_TRIP_CRITICAL;
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tmu_get_trip_temp(struct thermal_zone_device *tz, int
> trip,
> > > > +			     unsigned long *temp)
> > > > +{
> > > > +	struct qoriq_tmu_data *data =3D tz->devdata;
> > > > +
> > > > +	*temp =3D (trip =3D=3D TMU_TRIP_PASSIVE) ? data->temp_passive :
> > > > +					     data->temp_critical;
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tmu_get_crit_temp(struct thermal_zone_device *tz,
> > > > +			     unsigned long *temp)
> > > > +{
> > > > +	struct qoriq_tmu_data *data =3D tz->devdata;
> > > > +
> > > > +	*temp =3D data->temp_critical;
> > >
> > > nip: add an empty line, to follow your pattern.
> >
> > Sorry and thanks for the correction.
> >
> > >
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tmu_get_trend(struct thermal_zone_device *thermal,
> > > > +			int trip, enum thermal_trend *trend) {
> > > > +	int ret;
> > > > +	unsigned long trip_temp;
> > > > +
> > > > +	ret =3D tmu_get_trip_temp(thermal, trip, &trip_temp);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (thermal->temperature >=3D trip_temp)
> > > > +		*trend =3D THERMAL_TREND_RAISE_FULL;
> > > > +	else
> > > > +		*trend =3D THERMAL_TREND_DROP_FULL;
> > > > +
> > >
> > >
> > > Did I miss something here
> > > or that is not really trending, is it?
> > >
> > > Trending is supposed to be
> > > delta(temperature)/delta(time).
> > >
> >
> > That's right, trending is what you said.
> >
> > Here is what and why I provide this trend ops like this:
> > It provides a simple strategy of thermal management.
> > (Not care about trending, care about current temperature.)
> > - When the temperature is higher than the first trip point we'd like to
> >   reduce the cpufreq to minimum immediately and hold it steady.
> >
> > Using "step_wise" may cause the following issue:
> > - If the sensor report the temperature up and down repeatedly like
> >   "90C -> 89C -> 90C -> 89C -> 90C -> ..." cpufreq will be changed
> >   unnecessarily.
> >
> > Actually my trend ops took reference from samsumg's thermal driver back
> to 3.12 kernel.
> > It disappeared now.
> >
> > Maybe I will use the "step_wise". But discussions are needed before
> moving forward.
> >
> >
> > >
> > >
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tmu_bind(struct thermal_zone_device *tz,
> > > > +		    struct thermal_cooling_device *cdev) {
> > > > +	int ret;
> > > > +
> > > > +	ret =3D thermal_zone_bind_cooling_device(tz, TMU_TRIP_PASSIVE,
> cdev,
> > > > +					       THERMAL_NO_LIMIT,
> > > > +					       THERMAL_NO_LIMIT);
> > > > +	if (ret) {
> > > > +		dev_err(&tz->device,
> > > > +			"Binding zone %s with cdev %s failed:%d\n",
> > > > +			tz->type, cdev->type, ret);
> > > > +		return ret;
> > > > +	}
> > >
> > >
> > > > +
> > > > +	return 0;
> > >
> > > I think it is fine if you just return ret;
> >
> > Right, will change.
> >
> > >
> > > > +}
> > > > +
> > > > +static int tmu_unbind(struct thermal_zone_device *tz,
> > > > +		      struct thermal_cooling_device *cdev) {
> > > > +	int ret;
> > > > +
> > > > +	ret =3D thermal_zone_unbind_cooling_device(tz, TMU_TRIP_PASSIVE,
> > > cdev);
> > > > +	if (ret) {
> > > > +		dev_err(&tz->device,
> > > > +			"Unbinding zone %s with cdev %s failed:%d\n",
> > > > +			tz->type, cdev->type, ret);
> > > > +		return ret;
> > > > +	}
> > >
> > > ditto.
> > >
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void qoriq_tmu_calibration(struct platform_device *pdev) {
> > > > +	int i, val, len;
> > > > +	const __be32 *calibration;
> > > > +	struct device_node *node =3D pdev->dev.of_node;
> > > > +	struct qoriq_tmu_data *data =3D dev_get_drvdata(&pdev->dev);
> > > > +
> > > > +	/* Disable monitoring before calibration */
> > > > +	iowrite32be(TMR_DISABLE, &data->regs->tmr);
> > > > +
> > > > +	calibration =3D of_get_property(node, "calibration", &len);
> > > > +	if (calibration =3D=3D NULL) {
> > > > +		pr_err("TMU: Failed to get calibration data.\n");
> > >
> > > use dev_err when possible.
> >
> > Right, will change.
> >
> > >
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	for (i =3D 0; i < len; i +=3D 8, calibration +=3D 2) {
> > > > +		val =3D (int)of_read_number(calibration, 1);
> > > > +		iowrite32be(val, &data->regs->ttcfgr);
> > > > +		val =3D (int)of_read_number(calibration + 1, 1);
> > > > +		iowrite32be(val, &data->regs->tscfgr);
> > >
> > > are the above properties your offset and slope extrapolation
> constants?
> >
> > The offset is constant, but the total number of properties pairs is not=
.
>=20
> OK. I understand. After having a look in your DT code, I realized that
> what your name calibration data, it is actually a ADC conversion table.
>=20
>=20
> In this case, you need to mark the property with the prefix "fsl,"
> because it is specific to freescale.

Right, Thanks.

>=20
> BTW, I see that IMX has same property. However, I am a bit in doubt if
> this property is part of DT. Does it change from chip to chip?

It does vary from chip to chip.

>=20
> >
> > >
> > > If yes, please use the coefficients DT property. Please, check the
> > > of thermal code.
> > >
> > > > +	}
> > > > +}
> > > > +
> > > > +static void qoriq_tmu_init_device(struct qoriq_tmu_data *data) {
> > > > +	/* Disable interrupt, using polling instead */
> > > > +	iowrite32be(TIER_DISABLE, &data->regs->tier);
> > > > +
> > > > +	/* Set update_interval */
> > > > +	iowrite32be(TMTMIR_DEFAULT, &data->regs->tmtmir);
> > > > +
> > > > +	/* Enable monitoring */
> > > > +	iowrite32be(TMR_ALL, &data->regs->tmr); }
> > > > +
> > > > +static struct thermal_zone_device_ops tmu_tz_ops =3D {
> > > > +	.bind =3D tmu_bind,
> > > > +	.unbind =3D tmu_unbind,
> > > > +	.get_temp =3D tmu_get_temp,
> > > > +	.get_trend =3D tmu_get_trend,
> > > > +	.get_mode =3D tmu_get_mode,
> > > > +	.set_mode =3D tmu_set_mode,
> > > > +	.get_trip_type =3D tmu_get_trip_type,
> > > > +	.get_trip_temp =3D tmu_get_trip_temp,
> > > > +	.get_crit_temp =3D tmu_get_crit_temp, };
> > > > +
> > > > +static int qoriq_tmu_probe(struct platform_device *pdev) {
> > > > +	int ret;
> > > > +	struct cpumask clip_cpus;
> > > > +	struct qoriq_tmu_data *data;
> > > > +
> > > > +	if (!cpufreq_get_current_driver()) {
> > > > +		dev_dbg(&pdev->dev, "No cpufreq driver yet\n");
> > > > +		return -EPROBE_DEFER;
> > > > +	}
> > > > +
> > > > +	if (!pdev->dev.of_node) {
> > > > +		dev_err(&pdev->dev, "Device OF-Node is NULL");
> > > > +		return -EFAULT;
> > > > +	}
> > > > +
> > > > +	data =3D devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
> > > > +			    GFP_KERNEL);
> > > > +	if (!data)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	dev_set_drvdata(&pdev->dev, data);
> > > > +	data->regs =3D of_iomap(pdev->dev.of_node, 0);
> > > > +
> > > > +	if (!data->regs) {
> > > > +		dev_err(&pdev->dev, "Failed to get memory region\n");
> > > > +		ret =3D -ENODEV;
> > > > +		goto err_iomap;
> > > > +	}
> > > > +
> > > > +	qoriq_tmu_calibration(pdev);	/* TMU calibration */
> > > > +
> > > > +	qoriq_tmu_init_device(data);	/* TMU initialization */
> > > > +
> > > > +	cpumask_setall(&clip_cpus);
> > > > +	data->cdev =3D cpufreq_cooling_register(&clip_cpus);
> > >
> > > Given that this is a DT based device driver, have you considered
> > > using OF thermal APIs?
> >
> > This driver was developed based on kernel 3.12 back then. If I'd like
> > to use OF thermal APIs is there an reference driver available?
>=20
> Just check the latest linus kernel tree:  drivers/thermal/of-thermal.c
>=20
> >
> > >
> > > > +	if (IS_ERR(data->cdev)) {
> > > > +		ret =3D PTR_ERR(data->cdev);
> > > > +		dev_err(&data->cdev->device,
> > > > +			"Failed to register cpufreq cooling device: %d\n",
> ret);
> > > > +		goto err_cooling;
> > > > +	}
> > > > +
> > > > +	data->temp_passive =3D TMU_TEMP_PASSIVE;
> > > > +	data->temp_critical =3D TMU_TEMP_CRITICAL;
> > > > +	data->tz =3D thermal_zone_device_register("tmu_thermal_zone",
> > > > +						TMU_TRIP_NUM,
> > > > +						0, data,
> > > > +						&tmu_tz_ops, NULL,
> > > > +						TMU_PASSIVE_DELAY,
> > > > +						TMU_POLLING_DELAY);
> > > > +
> > > > +	if (IS_ERR(data->tz)) {
> > > > +		ret =3D PTR_ERR(data->tz);
> > > > +		dev_err(&pdev->dev,
> > > > +			"Failed to register thermal zone device %d\n",
> ret);
> > > > +		goto err_thermal;
> > > > +	}
> > > > +
> > > > +	data->mode =3D THERMAL_DEVICE_ENABLED;
> > >
> > >
> > > Don't you need to get a clock and enable it before handling this
> sensor?
> >
> > I did it in qoriq_tmu_init_device() already if you mean it.
>=20
> No, I meant the fact that you do not do clk_get clk_put anywhere.

I thought it's not needed. But as you mentioned I did some investigation.
I looked up the code and find the following sentence in the comments:
"Drivers must assume that the clock source is not enabled."

In my understanding clk_get() is for checking if the clk is ready. Right?
I will add this check if my understanding is right.

>=20
> >
> > >
> > > > +
> > > > +	return 0;
> > > > +
> > > > +err_thermal:
> > > > +	cpufreq_cooling_unregister(data->cdev);
> > > > +
> > > > +err_cooling:
> > > > +	iounmap(data->regs);
> > > > +
> > > > +err_iomap:
> > > > +	dev_set_drvdata(&pdev->dev, NULL);
> > > > +	devm_kfree(&pdev->dev, data);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int qoriq_tmu_remove(struct platform_device *pdev) {
> > > > +	struct qoriq_tmu_data *data =3D dev_get_drvdata(&pdev->dev);
> > > > +
> > > > +	/* Disable monitoring */
> > > > +	iowrite32be(TMR_DISABLE, &data->regs->tmr);
> > > > +
> > > > +	thermal_zone_device_unregister(data->tz);
> > > > +	cpufreq_cooling_unregister(data->cdev);
> > > > +	iounmap(data->regs);
> > > > +
> > > > +	dev_set_drvdata(&pdev->dev, NULL);
> > > > +	devm_kfree(&pdev->dev, data);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +static int qoriq_tmu_suspend(struct device *dev) {
> > > > +	struct qoriq_tmu_data *data =3D dev_get_drvdata(dev);
> > > > +
> > > > +	/* Disable monitoring */
> > > > +	iowrite32be(TMR_DISABLE, &data->regs->tmr);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int qoriq_tmu_resume(struct device *dev) {
> > > > +	struct qoriq_tmu_data *data =3D dev_get_drvdata(dev);
> > > > +
> > > > +	/* Enable monitoring */
> > > > +	iowrite32be(TMR_ALL, &data->regs->tmr);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +#endif
> > > > +
> > > > +static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
> > > > +			 qoriq_tmu_suspend, qoriq_tmu_resume);
> > > > +
> > > > +static const struct of_device_id qoriq_tmu_match[] =3D {
> > > > +	{ .compatible =3D "fsl,qoriq-tmu", },
> > > > +	{},
> > > > +};
> > >
> > >
> > > You need to add a binding file describing your chip, and how to
> > > deploy its DT nodes under:
> > >  Documentation/devicetree/bindings/thermal/
> >
> > Already did in another patch:
> > http://patchwork.ozlabs.org/patch/461412/
>=20
> OK. I missed that one. I will have a look.
>=20
> >
> > >
> > >
> > > > +
> > > > +static struct platform_driver qoriq_tmu =3D {
> > > > +	.driver	=3D {
> > > > +		.owner		=3D THIS_MODULE,
> > > > +		.name		=3D "qoriq_thermal",
> > > > +		.pm =3D &qoriq_tmu_pm_ops,
> > > > +		.of_match_table	=3D qoriq_tmu_match,
> > > > +	},
> > > > +	.probe	=3D qoriq_tmu_probe,
> > > > +	.remove	=3D qoriq_tmu_remove,
> > > > +};
> > > > +module_platform_driver(qoriq_tmu);
> > > > +
> > > > +MODULE_AUTHOR("Jia Hongtao <hongtao.jia@freescale.com>");
> > > > +MODULE_DESCRIPTION("Freescale QorIQ Thermal Monitoring Unit
> > > > +driver"); MODULE_LICENSE("GPL v2");
> > > > --
> > > > 2.1.0.27.g96db324
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > linux-pm" in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
