Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411531A0C95
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 15:13:11 +1100 (AEDT)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Eduardo Valentin <edubezval@gmail.com>
CC: Scott Wood <scottwood@freescale.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH V3] thermal: qoriq: Add thermal management support
Date: Thu, 5 Nov 2015 03:56:54 +0000
Message-ID: <BLUPR03MB149076F9491D463B1486E8CE1290@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1442996938-47147-1-git-send-email-hongtao.jia@freescale.com>
 <1443132592.32298.56.camel@freescale.com>
 <BLUPR03MB14997B46CC6AFC247EDC340E1420@BLUPR03MB149.namprd03.prod.outlook.com>
 <20151104192444.GA14127@localhost.localdomain>
In-Reply-To: <20151104192444.GA14127@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Thursday, November 05, 2015 3:25 AM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH V3] thermal: qoriq: Add thermal management support
>=20
> On Fri, Sep 25, 2015 at 03:09:42AM +0000, Hongtao Jia wrote:
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Friday, September 25, 2015 6:10 AM
> > > To: Jia Hongtao-B38951
> > > Cc: edubezval@gmail.com; linux-pm@vger.kernel.org; linuxppc-
> > > dev@lists.ozlabs.org
> > > Subject: Re: [PATCH V3] thermal: qoriq: Add thermal management
> > > support
> > >
> > > On Wed, 2015-09-23 at 16:28 +0800, Jia Hongtao wrote:
> > > > This driver add thermal management support by enabling TMU
> > > > (Thermal Monitoring Unit) on QorIQ platform.
> > > >
> > > > It's based on thermal of framework:
> > > > - Trip points defined in device tree.
> > > > - Cpufreq as cooling device registered in qoriq cpufreq driver.
> > >
> > > I don't see any cooling device registered in the qoriq cpufreq driver=
.
> > > Is this dependent on some other patch?
> >
> > It's not depend on any patch. But I saw your patch below:
> > [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock implementation
> > details So I hold my patch waiting for your patch merged or there will
> be conflict.
> >
> > I could send it out too if you are fine with it.
>=20
> Would you guys benefit of cpufreq-cpu0?
>=20
>=20
>=20
>=20
> >
> > >
> > > >
> > > > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > > > ---
> > > > V3: Using thermal of framework.
> > > >
> > > >  drivers/thermal/Kconfig         |  11 ++
> > > >  drivers/thermal/Makefile        |   1 +
> > > >  drivers/thermal/qoriq_thermal.c | 267
>=20
> Please include a binding description in your next version. Also, remember
> to include an example of your binding.
>=20
>=20
>=20
> > > > ++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 279 insertions(+)  create mode 100644
> > > > drivers/thermal/qoriq_thermal.c
> > > >
> > > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > > index 0390044..c91041b 100644
> > > > --- a/drivers/thermal/Kconfig
> > > > +++ b/drivers/thermal/Kconfig
> > > > @@ -180,6 +180,17 @@ config IMX_THERMAL
> > > >         cpufreq is used as the cooling device to throttle CPUs when
> the
> > > >         passive trip is crossed.
> > > >
> > > > +config QORIQ_THERMAL
>=20
>=20
> It would be really great if you could consolidate this driver with
> IMX_THERMAL. Do you think it is doable?

The TMU IP on I.MX and QorIQ platform are completely different and they
use the different cpufreq driver.

I don't think they could share the same thermal driver elegantly.

-Hongtao.=20

>=20
> > > > +     tristate "Freescale QorIQ Thermal Monitoring Unit"
> > > > +     depends on CPU_THERMAL
> > > > +     depends on THERMAL_OF
> > > > +     default n
> > > > +     help
> > > > +       Enable thermal management based on Freescale QorIQ Thermal
> > > Monitoring
> > > > +       Unit (TMU). It supports one critical trip point and one
> > > > + passive
> > > trip
> > > > +       point. The cpufreq is used as the cooling device to
> > > > + throttle
> > > CPUs when
> > > > +       the passive trip is crossed.
> > >
> > > "default n" is unnecessary -- n is already the default.
> >
> > Right.
> >
> > >
> > > Where is the interaction between this driver and cpufreq?
> >
> > It's all in cpufreq patch I mentioned above.
> >
> > >
> > > > config SPEAR_THERMAL
> > > >       bool "SPEAr thermal sensor driver"
> > > >       depends on PLAT_SPEAR
> > > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > > index
> > > > 26f1608..e55d703 100644
> > > > --- a/drivers/thermal/Makefile
> > > > +++ b/drivers/thermal/Makefile
> > > > @@ -33,6 +33,7 @@ obj-$(CONFIG_DOVE_THERMAL)          +=3D
> dove_thermal.o
> > > >  obj-$(CONFIG_DB8500_THERMAL) +=3D db8500_thermal.o
> > > >  obj-$(CONFIG_ARMADA_THERMAL) +=3D armada_thermal.o
> > > >  obj-$(CONFIG_IMX_THERMAL)    +=3D imx_thermal.o
> > > > +obj-$(CONFIG_QORIQ_THERMAL)  +=3D qoriq_thermal.o
> > > >  obj-$(CONFIG_DB8500_CPUFREQ_COOLING) +=3D db8500_cpufreq_cooling.o
> > > >  obj-$(CONFIG_INTEL_POWERCLAMP)       +=3D intel_powerclamp.o
> > > >  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)   +=3D x86_pkg_temp_thermal.o
> > > > diff --git a/drivers/thermal/qoriq_thermal.c
> > > > b/drivers/thermal/qoriq_thermal.c new file mode 100644 index
> > > > 0000000..7c2a3261
> > > > --- /dev/null
> > > > +++ b/drivers/thermal/qoriq_thermal.c
> > > > @@ -0,0 +1,267 @@
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
> > > > +License
> > > > for
> > > > + * more details.
> > > > + *
> > > > + */
> > > > +
> > > > +/*
> > > > + * Based on Freescale QorIQ Thermal Monitoring Unit (TMU)  */
> > >
> > > What does this comment mean?  This *is* the "Freescale QorIQ Thermal
> > > Monitoring Unit" driver.
> >
> > I mean thermal management based on the monitor TMU.
> > I could remove this comment though.
> >
> > >
> > > > +#include <linux/cpufreq.h>
> > >
> > > What do you use from this header?
> >
> > Sorry, forget to remove it from last version in which cooling devices
> > are registered in thermal driver instead of cpufreq driver.
> >
> > >
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h> #include <linux/err.h>
> > > > +#include <linux/io.h> #include <linux/of.h> #include
> > > > +<linux/of_address.h> #include <linux/thermal.h>
> > > > +
> > > > +#include "thermal_core.h"
> > > > +
> > > > +#define SITES_MAX    16
> > > > +
> > > > +/*
> > > > + * QorIQ TMU Registers
> > > > + */
> > > > +struct qoriq_tmu_site_regs {
> > > > +     __be32 tritsr;          /* Immediate Temperature Site
> Register */
> > > > +     __be32 tratsr;          /* Average Temperature Site Register
> */
> > > > +     u8 res0[0x8];
> > > > +} __packed;
> > > > +
> > > > +struct qoriq_tmu_regs {
> > > > +     __be32 tmr;             /* Mode Register */
> > > > +#define TMR_DISABLE  0x0
> > > > +#define TMR_ME               0x80000000
> > > > +#define TMR_ALPF     0x0c000000
> > > > +#define TMR_MSITE    0x00008000      /* Core temperature site */
> > > > +#define TMR_ALL              (TMR_ME | TMR_ALPF | TMR_MSITE)
> > > > +     __be32 tsr;             /* Status Register */
> > > > +     __be32 tmtmir;          /* Temperature measurement interval
> > > Register */
> > > > +#define TMTMIR_DEFAULT       0x00000007
> > > > +     u8 res0[0x14];
> > > > +     __be32 tier;            /* Interrupt Enable Register */
> > > > +#define TIER_DISABLE 0x0
> > > > +     __be32 tidr;            /* Interrupt Detect Register */
> > > > +     __be32 tiscr;           /* Interrupt Site Capture Register */
> > > > +     __be32 ticscr;          /* Interrupt Critical Site Capture
> > > Register */
> > > > +     u8 res1[0x10];
> > > > +     __be32 tmhtcrh;         /* High Temperature Capture Register
> */
> > > > +     __be32 tmhtcrl;         /* Low Temperature Capture Register
> */
> > > > +     u8 res2[0x8];
> > > > +     __be32 tmhtitr;         /* High Temperature Immediate
> Threshold
> > > */
> > > > +     __be32 tmhtatr;         /* High Temperature Average Threshold
> */
> > > > +     __be32 tmhtactr;        /* High Temperature Average Crit
> > > Threshold */
> > > > +     u8 res3[0x24];
> > > > +     __be32 ttcfgr;          /* Temperature Configuration Register
> */
> > > > +     __be32 tscfgr;          /* Sensor Configuration Register */
> > > > +     u8 res4[0x78];
> > > > +     struct qoriq_tmu_site_regs site[SITES_MAX];
> > > > +     u8 res5[0x9f8];
> > > > +     __be32 ipbrr0;          /* IP Block Revision Register 0 */
> > > > +     __be32 ipbrr1;          /* IP Block Revision Register 1 */
> > > > +     u8 res6[0x310];
> > > > +     __be32 ttr0cr;          /* Temperature Range 0 Control
> Register
> > > */
> > > > +     __be32 ttr1cr;          /* Temperature Range 1 Control
> Register
> > > */
> > > > +     __be32 ttr2cr;          /* Temperature Range 2 Control
> Register
> > > */
> > > > +     __be32 ttr3cr;          /* Temperature Range 3 Control
> Register
> > > */
> > > > +};
> > > > +
> > > > +/*
> > > > + * Thermal zone data
> > > > + */
> > > > +struct qoriq_tmu_data {
> > > > +     struct thermal_zone_device *tz;
> > > > +     struct qoriq_tmu_regs __iomem *regs; };
> > > > +
> > >
> > > > +static int tmu_get_temp(void *p, int *temp) {
> > > > +     u8 val;
> > > > +     struct qoriq_tmu_data *data =3D p;
> > > > +
> > > > +     val =3D ioread32be(&data->regs->site[0].tritsr);
> > > > +     *temp =3D (int)val * 1000;
> > >
> > > Why don't you declare val as int in the first place?
> >
> > It's a 32bit register.
> > Only the least significant 8 bits represent the temperature.
> > The most significant bit shows the validness of the value.
> > I use u8 type to remove the rest 24bits influence.
> >
> > >
> > > > +     for (i =3D 0; i < len; i +=3D 8, calibration +=3D 2) {
> > > > +             val =3D (int)of_read_number(calibration, 1);
> > > > +             iowrite32be(val, &data->regs->ttcfgr);
> > > > +             val =3D (int)of_read_number(calibration + 1, 1);
> > > > +             iowrite32be(val, &data->regs->tscfgr);
> > >
> > > Unnecessary casts.
> >
> > Ok.
> >
> > >
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void qoriq_tmu_init_device(struct qoriq_tmu_data *data) {
> > > > +     /* Disable interrupt, using polling instead */
> > > > +     iowrite32be(TIER_DISABLE, &data->regs->tier);
> > > > +
> > > > +     /* Set update_interval */
> > > > +     iowrite32be(TMTMIR_DEFAULT, &data->regs->tmtmir);
> > > > +
> > > > +     /* Enable monitoring */
> > > > +     iowrite32be(TMR_ALL, &data->regs->tmr); }
> > > > +
> > > > +static struct thermal_zone_of_device_ops tmu_tz_ops =3D {
> > > > +     .get_temp =3D tmu_get_temp,
> > > > +};
> > > > +
> > > > +static int qoriq_tmu_probe(struct platform_device *pdev) {
> > > > +     int ret;
> > > > +     const struct thermal_trip *trip;
> > > > +     struct qoriq_tmu_data *data;
> > > > +
> > > > +     if (!pdev->dev.of_node) {
> > > > +             dev_err(&pdev->dev, "Device OF-Node is NULL");
> > > > +             return -EFAULT;
> > > > +     }
> > >
> > > EFAULT is for bad user addresses and is not appropriate here.
> >
> > I will change it to ENODEV.
> >
> > >
> > > > +
> > > > +     data =3D devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_dat=
a),
> > > > +                         GFP_KERNEL);
> > > > +     if (!data)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     platform_set_drvdata(pdev, data);
> > > > +     data->regs =3D of_iomap(pdev->dev.of_node, 0);
> > > > +
> > > > +     if (!data->regs) {
> > > > +             dev_err(&pdev->dev, "Failed to get memory region\n");
> > > > +             ret =3D -ENODEV;
> > > > +             goto err_iomap;
> > > > +     }
> > > > +
> > > > +     ret =3D qoriq_tmu_calibration(pdev);      /* TMU calibration =
*/
> > > > +     if (ret < 0) {
> > > > +             dev_err(&pdev->dev, "TMU calibration failed.\n");
> > > > +             ret =3D -ENODEV;
> > > > +             goto err_iomap;
> > > > +     }
> > >
> > > That function returns negative when device tree properties are
> > > missing, not when a calibration procedure fails.
> >
> > What's your suggestion here to return then?
> >
> > >
> > > > +
> > > > +     qoriq_tmu_init_device(data);    /* TMU initialization */
> > > > +
> > > > +     data->tz =3D thermal_zone_of_sensor_register(&pdev->dev, 0,
> > > > +                             data, &tmu_tz_ops);
> > > > +     if (IS_ERR(data->tz)) {
> > > > +             ret =3D PTR_ERR(data->tz);
> > > > +             dev_err(&pdev->dev,
> > > > +                     "Failed to register thermal zone device
> > > > + %d\n",
> > > ret);
> > > > +             goto err_thermal;
> > > > +     }
> > > > +
> > > > +     trip =3D of_thermal_get_trip_points(data->tz);
> > > > +
> > > > +     data->tz->ops->set_mode(data->tz, THERMAL_DEVICE_ENABLED);
> > >
> > > Doesn't thermal_zone_of_sensor_register() already call ops->set_mode
> > > with TERMAL_DEVICE_ENABLED?
> >
> > You are right.
> > I referenced the code from other platform and did not notice this.
> > Thanks.
> >
> > >
> > > > +
> > > > +     return 0;
> > > > +
> > > > +err_thermal:
> > > > +     iounmap(data->regs);
> > > > +
> > > > +err_iomap:
> > > > +     platform_set_drvdata(pdev, NULL);
> > > > +     devm_kfree(&pdev->dev, data);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int qoriq_tmu_remove(struct platform_device *pdev) {
> > > > +     struct qoriq_tmu_data *data =3D platform_get_drvdata(pdev);
> > > > +
> > > > +     /* Disable monitoring */
> > > > +     iowrite32be(TMR_DISABLE, &data->regs->tmr);
> > > > +
> > > > +     thermal_zone_of_sensor_unregister(&pdev->dev, data->tz);
> > > > +     iounmap(data->regs);
> > > > +
> > > > +     platform_set_drvdata(pdev, NULL);
> > > > +     devm_kfree(&pdev->dev, data);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +static int qoriq_tmu_suspend(struct device *dev) {
> > > > +     struct qoriq_tmu_data *data =3D dev_get_drvdata(dev);
> > > > +
> > > > +     /* Disable monitoring */
> > > > +     iowrite32be(TMR_DISABLE, &data->regs->tmr);
> > > > +     data->tz->ops->set_mode(data->tz, THERMAL_DEVICE_DISABLED);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int qoriq_tmu_resume(struct device *dev) {
> > > > +     struct qoriq_tmu_data *data =3D dev_get_drvdata(dev);
> > > > +
> > > > +     /* Enable monitoring */
> > > > +     iowrite32be(TMR_ALL, &data->regs->tmr);
> > > > +     data->tz->ops->set_mode(data->tz, THERMAL_DEVICE_ENABLED);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +#endif
> > > > +
> > > > +static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
> > > > +                      qoriq_tmu_suspend, qoriq_tmu_resume);
> > > > +
> > >
> > >
> > > > +static const struct of_device_id qoriq_tmu_match[] =3D {
> > > > +     { .compatible =3D "fsl,qoriq-tmu", },
> > > > +     {},
> > > > +};
> > >
> > > Binding?
> >
> > Not send out yet.
> > I planned to send the patch with device tree patchset including adding
> > TMU node to T1040/T1024/LS1021A platform.
> >
> > It's depending on the device tree files moving patch I sent out not
> > long ago.
> >
> > >
> > > > +
> > > > +static struct platform_driver qoriq_tmu =3D {
> > > > +     .driver =3D {
> > > > +             .name           =3D "qoriq_thermal",
> > > > +             .pm =3D &qoriq_tmu_pm_ops,
> > > > +             .of_match_table =3D qoriq_tmu_match,
> > > > +     },
> > >
> > > Why the tabs after ".name"?
> >
> > Will indent the other two.
> >
> > >
> > > -Scott
> >
