Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51685C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 00:14:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A24A2082D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 00:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A24A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439GLP0f0FzDr5V
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 11:14:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439GJ36jSVzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 11:12:19 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id t204so19204599oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 16:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sRBJaTb1NcTx5xdS9WeLKqDV55sdxP7Eq42Mc/LQ4fA=;
 b=iBjcrhG9HGU4QZ+EbwdQQyzDTiVsqK2XOjscEPrys0pf41L6y2muTRwMQELz8XjFTd
 Nafnvja1rigJyBtAMvaTpnMN5C1lGdIp7UzSgNMkdHApgybJBuWaweXK9Ti0834ioKmC
 FdTahKi3Wy1/wJd1WptYipkRK9KnQsJCFAhUf2bzc2foFQO8sAFc75onPWMV9uBMCG8+
 5dfiHfHkpYdCTGfXnoOB+PAN2TNrKozfVk+MO94UtNjY3bloVmw8Cf79s5vPujkaiqKr
 ZXl5JFSQbwXxGVZLXh+rcAIW33DhsPmpeWyisb6ir3ib926FTUFE5sWr9N1xT56MgoHV
 k79w==
X-Gm-Message-State: AA+aEWYTbaQ5FYTW1MtRAzyENZ3sdFqVR1/1X4Jmy/ghxIXE2059ufE8
 1Rwk0LLlP37lUxDxLPFuucDKeUuiZB8=
X-Google-Smtp-Source: AFSGD/VCYV94R1lCTcyrEdvm6GxZILIK58+NF9/7ePIFxH/7CIKnvxQ6o1ra8aotD0Nmy5bcCRSXCA==
X-Received: by 2002:aca:ef0b:: with SMTP id n11mr15743983oih.116.1544055137868; 
 Wed, 05 Dec 2018 16:12:17 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com.
 [209.85.167.181])
 by smtp.gmail.com with ESMTPSA id k13sm26733274otj.19.2018.12.05.16.12.17
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 16:12:17 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id m6so19201593oig.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 16:12:17 -0800 (PST)
X-Received: by 2002:aca:68c4:: with SMTP id o65mr15469103oik.175.1544055136768; 
 Wed, 05 Dec 2018 16:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20181005085505.29024-1-pankaj.bansal@nxp.com>
 <20181005085505.29024-3-pankaj.bansal@nxp.com>
In-Reply-To: <20181005085505.29024-3-pankaj.bansal@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 18:12:05 -0600
X-Gmail-Original-Message-ID: <CADRPPNSuG_O9u3Jc_9jGxetb5y_h3VmAFgvGpz7sDSKXkuN09A@mail.gmail.com>
Message-ID: <CADRPPNSuG_O9u3Jc_9jGxetb5y_h3VmAFgvGpz7sDSKXkuN09A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsl: add i2c controlled qixis driver
To: pankaj.bansal@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, alexandru.marginean@nxp.com,
 Dongsheng Wang <dongsheng.wang@freescale.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 4, 2018 at 11:03 PM Pankaj Bansal <pankaj.bansal@nxp.com> wrote:
>
> FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
> driver which is basically an i2c client driver to control FPGA.

Is this driver just used to print out the QIXIS version and create
platform devices for all the subnodes?   If that's the case, a
"simple-bus" compatibility in the fpga node would be enough.

>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig        |  9 ++++
>  drivers/soc/fsl/Makefile       |  1 +
>  drivers/soc/fsl/qixis_ctrl.c   | 75 ++++++++++++++++++++++++++++++++
>  include/linux/fsl/qixis_ctrl.h | 20 +++++++++
>  4 files changed, 105 insertions(+)
>
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 8f80e8bbf29e..c355c2cbbd45 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -28,4 +28,13 @@ config FSL_MC_DPIO
>           other DPAA2 objects. This driver does not expose the DPIO
>           objects individually, but groups them under a service layer
>           API.
> +
> +config FSL_QIXIS
> +       tristate "QIXIS system controller driver"
> +       select REGMAP_I2C
> +       default n
> +       help
> +         Say y here to enable QIXIS system controller api. The qixis driver
> +         provides FPGA functions to control system.
> +
>  endmenu
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> index 803ef1bfb5ff..47e0cfc66ca4 100644
> --- a/drivers/soc/fsl/Makefile
> +++ b/drivers/soc/fsl/Makefile
> @@ -5,5 +5,6 @@
>  obj-$(CONFIG_FSL_DPAA)                 += qbman/
>  obj-$(CONFIG_QUICC_ENGINE)             += qe/
>  obj-$(CONFIG_CPM)                      += qe/
> +obj-$(CONFIG_FSL_QIXIS)                += qixis_ctrl.o
>  obj-$(CONFIG_FSL_GUTS)                 += guts.o
>  obj-$(CONFIG_FSL_MC_DPIO)              += dpio/
> diff --git a/drivers/soc/fsl/qixis_ctrl.c b/drivers/soc/fsl/qixis_ctrl.c
> new file mode 100644
> index 000000000000..b94649fb9726
> --- /dev/null
> +++ b/drivers/soc/fsl/qixis_ctrl.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/* Freescale QIXIS system controller driver.
> + *
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + * Copyright 2018 NXP
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fsl/qixis_ctrl.h>
> +#include <linux/io.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static struct regmap *qixis_regmap;
> +
> +static struct regmap_config qixis_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +};
> +
> +static int fsl_qixis_i2c_probe(struct i2c_client *client)
> +{
> +       struct platform_device *pdev;
> +       struct device_node *child;
> +       u32 qver;
> +
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +               return -EOPNOTSUPP;
> +
> +       qixis_regmap = regmap_init_i2c(client, &qixis_regmap_config);
> +
> +       /* create platform device for  each of the child node of FPGA node */
> +       for_each_child_of_node(client->dev.of_node, child) {
> +               pdev = of_platform_device_create(child, NULL, &client->dev);
> +       };
> +
> +       regmap_read(qixis_regmap, offsetof(struct fsl_qixis_regs, qixis_ver),
> +                   &qver);
> +
> +       pr_info("Freescale QIXIS Version: 0x%08x\n", qver);
> +
> +       return 0;
> +}
> +
> +static int fsl_qixis_i2c_remove(struct i2c_client *client)
> +{

Don't need to cleanup the regmap created?

> +       return 0;
> +}
> +
> +static const struct of_device_id fsl_qixis_of_match[] = {
> +       { .compatible = "fsl,fpga-qixis-i2c" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_qixis_of_match);
> +
> +static struct i2c_driver fsl_qixis_i2c_driver = {
> +       .driver = {
> +               .name   = "qixis_ctrl",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = of_match_ptr(fsl_qixis_of_match),
> +       },
> +       .probe_new      = fsl_qixis_i2c_probe,
> +       .remove         = fsl_qixis_i2c_remove,
> +};
> +module_i2c_driver(fsl_qixis_i2c_driver);
> +
> +MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
> +MODULE_DESCRIPTION("Freescale QIXIS system controller driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/fsl/qixis_ctrl.h b/include/linux/fsl/qixis_ctrl.h
> new file mode 100644
> index 000000000000..00e80ef21adc
> --- /dev/null
> +++ b/include/linux/fsl/qixis_ctrl.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+
> + *
> + * Definitions for Freescale QIXIS system controller.
> + *
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + * Copyright 2018 NXP
> + */
> +
> +#ifndef _FSL_QIXIS_CTRL_H_
> +#define _FSL_QIXIS_CTRL_H_
> +
> +/* QIXIS MAP */
> +struct fsl_qixis_regs {
> +       u8              id;             /* Identification Registers */
> +       u8              version;        /* Version Register */
> +       u8              qixis_ver;      /* QIXIS Version Register */
> +       u8              reserved1[0x1f];
> +};
> +
> +#endif
> --
> 2.17.1
>
