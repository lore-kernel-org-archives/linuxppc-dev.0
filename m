Return-Path: <ulf.hansson@linaro.org>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT4Wh2bf5zDrvB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 21:44:31 +1000 (AEST)
Received: by mail-wm0-x230.google.com with SMTP id 1so184467262wmz.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 04:44:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1473150503-9550-8-git-send-email-yangbo.lu@nxp.com>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-8-git-send-email-yangbo.lu@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Sep 2016 13:44:23 +0200
Message-ID: <CAPDyKFrvg3Qr5m3xXvywsCoVvaiF7ggHAj0Aw=WCOXg65Pt0PQ@mail.gmail.com>
Subject: Re: [v11, 7/8] base: soc: introduce soc_device_match() interface
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Scott Wood <oss@buserror.net>,
 Arnd Bergmann <arnd@arndb.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6 September 2016 at 10:28, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> We keep running into cases where device drivers want to know the exact
> version of the a SoC they are currently running on. In the past, this has
> usually been done through a vendor specific API that can be called by a
> driver, or by directly accessing some kind of version register that is
> not part of the device itself but that belongs to a global register area
> of the chip.
>
> Common reasons for doing this include:
>
> - A machine is not using devicetree or similar for passing data about
>   on-chip devices, but just announces their presence using boot-time
>   platform devices, and the machine code itself does not care about the
>   revision.
>
> - There is existing firmware or boot loaders with existing DT binaries
>   with generic compatible strings that do not identify the particular
>   revision of each device, but the driver knows which SoC revisions
>   include which part.
>
> - A prerelease version of a chip has some quirks and we are using the same
>   version of the bootloader and the DT blob on both the prerelease and the
>   final version. An update of the DT binding seems inappropriate because
>   that would involve maintaining multiple copies of the dts and/or
>   bootloader.
>
> This patch introduces the soc_device_match() interface that is meant to
> work like of_match_node() but instead of identifying the version of a
> device, it identifies the SoC itself using a vendor-agnostic interface.
>
> Unlike of_match_node(), we do not do an exact string compare but instead
> use glob_match() to allow wildcards in strings.

Overall, this change make sense to me, although some minor comment below.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v11:
>         - Added this patch for soc match
> ---
>  drivers/base/Kconfig    |  1 +
>  drivers/base/soc.c      | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |  3 +++
>  3 files changed, 65 insertions(+)
>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 98504ec..f1591ad2 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -225,6 +225,7 @@ config GENERIC_CPU_AUTOPROBE
>
>  config SOC_BUS
>         bool
> +       select GLOB
>
>  source "drivers/base/regmap/Kconfig"
>
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> index 75b98aa..5c4e84a 100644
> --- a/drivers/base/soc.c
> +++ b/drivers/base/soc.c
> @@ -14,6 +14,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/sys_soc.h>
>  #include <linux/err.h>
> +#include <linux/glob.h>
>
>  static DEFINE_IDA(soc_ida);
>
> @@ -168,3 +169,63 @@ static void __exit soc_bus_unregister(void)
>         bus_unregister(&soc_bus_type);
>  }
>  module_exit(soc_bus_unregister);
> +
> +static int soc_device_match_one(struct device *dev, void *arg)
> +{
> +       struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> +       const struct soc_device_attribute *match = arg;
> +
> +       if (match->machine &&
> +           !glob_match(match->machine, soc_dev->attr->machine))
> +               return 0;
> +
> +       if (match->family &&
> +           !glob_match(match->family, soc_dev->attr->family))
> +               return 0;
> +
> +       if (match->revision &&
> +           !glob_match(match->revision, soc_dev->attr->revision))
> +               return 0;
> +
> +       if (match->soc_id &&
> +           !glob_match(match->soc_id, soc_dev->attr->soc_id))
> +               return 0;
> +
> +       return 1;
> +}
> +
> +/*
> + * soc_device_match - identify the SoC in the machine
> + * @matches: zero-terminated array of possible matches

Perhaps also express the constraint on the matching entries. As you
need at least one of the ->machine(), ->family(), ->revision() or
->soc_id() callbacks implemented, right!?

> + *
> + * returns the first matching entry of the argument array, or NULL
> + * if none of them match.
> + *
> + * This function is meant as a helper in place of of_match_node()
> + * in cases where either no device tree is available or the information
> + * in a device node is insufficient to identify a particular variant
> + * by its compatible strings or other properties. For new devices,
> + * the DT binding should always provide unique compatible strings
> + * that allow the use of of_match_node() instead.
> + *
> + * The calling function can use the .data entry of the
> + * soc_device_attribute to pass a structure or function pointer for
> + * each entry.

I don't get the use case behind this, could you elaborate?

Perhaps we should postpone adding the .data entry until we actually
see a need for it?

> + */
> +const struct soc_device_attribute *soc_device_match(
> +       const struct soc_device_attribute *matches)
> +{
> +       struct device *dev;
> +       int ret;
> +
> +       for (ret = 0; ret == 0; matches++) {

This loop looks a bit weird and unsafe.

1) Perhaps using a while loop makes this more readable?
2) As this is an exported API, I guess validation of the ->matches
pointer needs to be done before accessing it.

> +               if (!(matches->machine || matches->family ||
> +                     matches->revision || matches->soc_id))
> +                       return NULL;
> +               dev = NULL;

There's no need to use a struct device just to assign it to NULL.
Instead just provide the function below with NULL.

> +               ret = bus_for_each_dev(&soc_bus_type, dev, (void *)matches,
> +                                      soc_device_match_one);
> +       }
> +       return matches;
> +}
> +EXPORT_SYMBOL_GPL(soc_device_match);
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> index 2739ccb..9f5eb06 100644
> --- a/include/linux/sys_soc.h
> +++ b/include/linux/sys_soc.h
> @@ -13,6 +13,7 @@ struct soc_device_attribute {
>         const char *family;
>         const char *revision;
>         const char *soc_id;
> +       const void *data;
>  };
>
>  /**
> @@ -34,4 +35,6 @@ void soc_device_unregister(struct soc_device *soc_dev);
>   */
>  struct device *soc_device_to_device(struct soc_device *soc);
>
> +const struct soc_device_attribute *soc_device_match(
> +       const struct soc_device_attribute *matches);
>  #endif /* __SOC_BUS_H */
> --
> 2.1.0.27.g96db324
>

Kind regards
Uffe
