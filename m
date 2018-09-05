Return-Path: <pku.leo@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424psY2n7wzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 13:22:07 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so10951975oix.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 20:22:07 -0700 (PDT)
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com.
 [209.85.218.53])
 by smtp.gmail.com with ESMTPSA id x126-v6sm1758741oig.15.2018.09.04.20.22.04
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Sep 2018 20:22:05 -0700 (PDT)
Received: by mail-oi0-f53.google.com with SMTP id m11-v6so10975620oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 20:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-3-ran.wang_1@nxp.com>
 <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 4 Sep 2018 22:21:53 -0500
Message-ID: <CADRPPNQN=27+pOSckxvwSuBJoFaz7pT+Z6h07Wu3Liz5ao5kkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
To: dongsheng.wang@hxt-semitech.com
Cc: Ran Wang <ran.wang_1@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 4, 2018 at 9:58 PM Wang, Dongsheng
<dongsheng.wang@hxt-semitech.com> wrote:
>
> Please change your comments style.

Although this doesn't get into the Linux kernel coding style
documentation yet, Linus seems changed his mind to prefer // than /*
*/ comment style now.  https://lkml.org/lkml/2017/11/25/133   So the
// style should be acceptable for now.

>
> On 2018/8/31 11:56, Ran Wang wrote:
> > The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> > Control and Power Management), which performs all device-level
> > tasks associated with power management such as wakeup source control.
> >
> > This driver depends on FSL platform PM driver framework which help to
> > isolate user and PM service provider (such as RCPM driver).
> >
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/soc/fsl/Kconfig   |    6 ++
> >  drivers/soc/fsl/Makefile  |    1 +
> >  drivers/soc/fsl/ls-rcpm.c |  153 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 160 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/soc/fsl/ls-rcpm.c
> >
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> > index 6517412..882330d 100644
> > --- a/drivers/soc/fsl/Kconfig
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -30,3 +30,9 @@ config FSL_PLAT_PM
> >         have to know the implement details of wakeup function it requir=
e.
> >         Besides, it is also easy for service side to upgrade its logic =
when
> >         design changed and remain user side unchanged.
> > +
> > +config LS_RCPM
> > +     bool "Freescale RCPM support"
> > +     depends on (FSL_PLAT_PM)
> > +     help
> > +       This feature is to enable specified wakeup source for system sl=
eep.
> > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> > index 8f9db23..43ff71a 100644
> > --- a/drivers/soc/fsl/Makefile
> > +++ b/drivers/soc/fsl/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)            +=3D qe/
> >  obj-$(CONFIG_CPM)                    +=3D qe/
> >  obj-$(CONFIG_FSL_GUTS)                       +=3D guts.o
> >  obj-$(CONFIG_FSL_PLAT_PM)    +=3D plat_pm.o
> > +obj-$(CONFIG_LS_RCPM)                +=3D ls-rcpm.o

Probably use "_" instead of "-" for alignment.

> > diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c
> > new file mode 100644
> > index 0000000..b0feb88
> > --- /dev/null
> > +++ b/drivers/soc/fsl/ls-rcpm.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// plat_pm.c - Freescale Layerscape RCPM driver

The file name here is not the same as the real file name.

> > +//
> > +// Copyright 2018 NXP
> > +//
> > +// Author: Ran Wang <ran.wang_1@nxp.com>,

Where do you need the comma in the end?

> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
> > +#include <soc/fsl/plat_pm.h>
> > +
> > +#define MAX_COMPATIBLE_NUM   10
> > +
> > +struct rcpm_t {
> > +     struct device *dev;
> > +     void __iomem *ippdexpcr_addr;
> > +     bool big_endian;        /* Big/Little endian of RCPM module */
> > +};
> > +
> > +// rcpm_handle - Configure RCPM reg according to wake up source reques=
t
> > +// @user_dev: pointer to user's device struct
> > +// @flag: to enable(true) or disable(false) wakeup source
> > +// @handle_priv: pointer to struct rcpm_t instance
> > +//
> > +// Return 0 on success other negative errno

Although Linus preferred this // comment style.  I'm not sure if this
will be handled correctly by the kernel-doc compiler.
https://www.kernel.org/doc/html/v4.18/doc-guide/kernel-doc.html

> > +static int rcpm_handle(struct device *user_dev, bool flag, void *handl=
e_priv)
> > +{
> > +     struct rcpm_t *rcpm;
> > +     bool big_endian;
> > +     const char  *dev_compatible_array[MAX_COMPATIBLE_NUM];
> > +     void __iomem *ippdexpcr_addr;
> > +     u32 ippdexpcr;
> > +     u32 set_bit;
> > +     int ret, num, i;
> > +
> > +     rcpm =3D handle_priv;
> > +     big_endian =3D rcpm->big_endian;
> > +     ippdexpcr_addr =3D rcpm->ippdexpcr_addr;
> > +
> > +     num =3D device_property_read_string_array(user_dev, "compatible",
> > +                     dev_compatible_array, MAX_COMPATIBLE_NUM);
> > +     if (num < 0)
> > +             return num;
> > +
> > +     for (i =3D 0; i < num; i++) {
> > +             if (!device_property_present(rcpm->dev,
> > +                                     dev_compatible_array[i]))
> > +                     continue;
> > +             else {
> Remove this else.
> > +                     ret =3D device_property_read_u32(rcpm->dev,
> > +                                     dev_compatible_array[i], &set_bit=
);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     if (!device_property_present(rcpm->dev,
> > +                                             dev_compatible_array[i]))
> This has been checked. Continue ? or return ENODEV=EF=BC=9F
> > +                             return -ENODEV;
> > +                     else {
> Remove this else.
> > +                             ret =3D device_property_read_u32(rcpm->de=
v,
> > +                                             dev_compatible_array[i], =
&set_bit);
> > +                             if (ret)
> > +                                     return ret;
> > +
> > +                             if (big_endian)
> > +                                     ippdexpcr =3D ioread32be(ippdexpc=
r_addr);
> > +                             else
> > +                                     ippdexpcr =3D ioread32(ippdexpcr_=
addr);
> > +
> > +                             if (flag)
> > +                                     ippdexpcr |=3D set_bit;
> > +                             else
> > +                                     ippdexpcr &=3D ~set_bit;
> > +
> > +                             if (big_endian) {
> > +                                     iowrite32be(ippdexpcr, ippdexpcr_=
addr);
> > +                                     ippdexpcr =3D ioread32be(ippdexpc=
r_addr);
> > +                             } else
> if (x) {
> ....
> ....
> }  else {
>
> }
> > +                                     iowrite32(ippdexpcr, ippdexpcr_ad=
dr);
> > +
> > +                             return 0;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return -ENODEV;
> > +}
> > +
> > +static int ls_rcpm_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *r;
> > +     struct rcpm_t *rcpm;
> > +
> > +     r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!r)
> > +             return -ENODEV;
> > +
> > +     rcpm =3D kmalloc(sizeof(*rcpm), GFP_KERNEL);
> kzalloc is better.
> > +     if (!rcpm)
> > +             return -ENOMEM;
> > +
> > +     rcpm->big_endian =3D device_property_read_bool(&pdev->dev, "big-e=
ndian");
> > +
> > +     rcpm->ippdexpcr_addr =3D devm_ioremap_resource(&pdev->dev, r);
> > +     if (IS_ERR(rcpm->ippdexpcr_addr))
> > +             return PTR_ERR(rcpm->ippdexpcr_addr);
> > +
> > +     rcpm->dev =3D &pdev->dev;
> > +     platform_set_drvdata(pdev, rcpm);
> > +
> > +     return register_fsl_platform_wakeup_source(rcpm_handle, rcpm);
> > +}
> > +
> > +static int ls_rcpm_remove(struct platform_device *pdev)
> > +{
> > +     struct rcpm_t   *rcpm;
> Not need a table.
>
> Cheers,
> -Dongsheng
>
> > +
> > +     rcpm =3D platform_get_drvdata(pdev);
> > +     deregister_fsl_platform_wakeup_source(rcpm);
> > +     kfree(rcpm);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id ls_rcpm_of_match[] =3D {
> > +     { .compatible =3D "fsl,qoriq-rcpm-2.1", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, ls_rcpm_of_match);
> > +
> > +static struct platform_driver ls_rcpm_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "ls-rcpm",
> > +             .of_match_table =3D ls_rcpm_of_match,
> > +     },
> > +     .probe =3D ls_rcpm_probe,
> > +     .remove =3D ls_rcpm_remove,
> > +};
> > +
> > +static int __init ls_rcpm_init(void)
> > +{
> > +     return platform_driver_register(&ls_rcpm_driver);
> > +}
> > +subsys_initcall(ls_rcpm_init);
> > +
> > +static void __exit ls_rcpm_exit(void)
> > +{
> > +     platform_driver_unregister(&ls_rcpm_driver);
> > +}
> > +module_exit(ls_rcpm_exit);
>
>
