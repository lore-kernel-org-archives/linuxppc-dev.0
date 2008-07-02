Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id BB2A7DDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 23:50:33 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so80387yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 06:50:32 -0700 (PDT)
Message-ID: <9e4733910807020650n48fe8130iffe0eb2c7131ced@mail.gmail.com>
Date: Wed, 2 Jul 2008 09:50:27 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
In-Reply-To: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
>  Simple utility layer for creating ASoC machine instances based on data
>  in the OpenFirmware device tree.  OF aware platform drivers and codec
>  drivers register themselves with this framework and the framework
>  automatically instantiates a machine driver.
>
>  This is most likely temporary glue code to work around limitations in
>  the ASoC v1 framework.  I expect ASoC v2 won't need this.
>  ---
>
>   sound/soc/Kconfig  |    6 ++
>   sound/soc/Makefile |    1
>   sound/soc/soc-of.c |  171 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 178 insertions(+), 0 deletions(-)
>
>  diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
>  index 18f28ac..c5736e5 100644
>  --- a/sound/soc/Kconfig
>  +++ b/sound/soc/Kconfig
>  @@ -23,6 +23,12 @@ config SND_SOC
>           This ASoC audio support can also be built as a module.  If so, the module
>           will be called snd-soc-core.
>
>  +config SND_SOC_OF
>  +       tristate "OF helpers for SoC audio support"
>  +       depends on SND_SOC
>  +       ---help---
>  +         Add support for OpenFirmware device tree descriptions of sound device
>  +
>   # All the supported Soc's
>   source "sound/soc/at91/Kconfig"
>   source "sound/soc/pxa/Kconfig"
>  diff --git a/sound/soc/Makefile b/sound/soc/Makefile
>  index 782db21..191c2e5 100644
>  --- a/sound/soc/Makefile
>  +++ b/sound/soc/Makefile
>  @@ -2,3 +2,4 @@ snd-soc-core-objs := soc-core.o soc-dapm.o
>
>   obj-$(CONFIG_SND_SOC)  += snd-soc-core.o
>   obj-$(CONFIG_SND_SOC)  += codecs/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/ omap/
>  +obj-$(CONFIG_SND_SOC_OF)       += soc-of.o
>  diff --git a/sound/soc/soc-of.c b/sound/soc/soc-of.c
>  new file mode 100644
>  index 0000000..9694979
>  --- /dev/null
>  +++ b/sound/soc/soc-of.c
>  @@ -0,0 +1,171 @@
>  +/*
>  + * OF helpers for ALSA SoC Layer
>  + *
>  + * Copyright (C) 2008, Secret Lab Technologies Ltd.
>  + */
>  +
>  +#include <linux/module.h>
>  +#include <linux/moduleparam.h>
>  +#include <linux/init.h>
>  +#include <linux/delay.h>
>  +#include <linux/pm.h>
>  +#include <linux/bitops.h>
>  +#include <linux/platform_device.h>
>  +#include <linux/of.h>
>  +#include <sound/core.h>
>  +#include <sound/pcm.h>
>  +#include <sound/pcm_params.h>
>  +#include <sound/soc.h>
>  +#include <sound/soc-of.h>
>  +#include <sound/initval.h>
>  +
>  +MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
>  +MODULE_LICENSE("GPL");
>  +MODULE_DESCRIPTION("ALSA SoC OpenFirmware bindings");
>  +
>  +DEFINE_MUTEX(of_snd_soc_mutex);
>  +LIST_HEAD(of_snd_soc_device_list);
>  +static int of_snd_soc_next_index;
>  +
>  +struct of_snd_soc_device {
>  +       int id;
>  +       struct list_head list;
>  +       struct snd_soc_device device;
>  +       struct snd_soc_machine machine;
>  +       struct snd_soc_dai_link dai_link;
>  +       struct platform_device *pdev;
>  +       struct device_node *platform_node;
>  +       struct device_node *codec_node;
>  +};
>  +
>  +static struct snd_soc_ops of_snd_soc_ops = {
>  +};
>  +
>  +static struct of_snd_soc_device *
>  +of_snd_soc_get_device(struct device_node *codec_node)
>  +{
>  +       struct of_snd_soc_device *of_soc;
>  +
>  +       list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
>  +               if (of_soc->codec_node == codec_node)
>  +                       return of_soc;
>  +       }
>  +
>  +       of_soc = kzalloc(sizeof(struct of_snd_soc_device), GFP_KERNEL);
>  +       if (!of_soc)
>  +               return NULL;
>  +
>  +       /* Initialize the structure and add it to the global list */
>  +       of_soc->codec_node = codec_node;
>  +       of_soc->id = of_snd_soc_next_index++;
>  +       of_soc->machine.dai_link = &of_soc->dai_link;
>  +       of_soc->machine.num_links = 1;
>  +       of_soc->device.machine = &of_soc->machine;
>  +       of_soc->dai_link.ops = &of_snd_soc_ops;
>  +       list_add(&of_soc->list, &of_snd_soc_device_list);
>  +
>  +       return of_soc;
>  +}
>  +
>  +static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
>  +{
>  +       struct platform_device *pdev;
>  +       int rc;
>  +
>  +       /* Only register the device if both the codec and platform have
>  +        * been registered */
>  +       if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
>  +               return;
>  +
>  +       pr_info("platform<-->codec match achieved; registering machine\n");
>  +
>  +       pdev = platform_device_alloc("soc-audio", of_soc->id);
>  +       if (!pdev) {
>  +               pr_err("of_soc: platform_device_alloc() failed\n");
>  +               return;
>  +       }
>  +
>  +       pdev->dev.platform_data = of_soc;
>  +       platform_set_drvdata(pdev, &of_soc->device);
>  +       of_soc->device.dev = &pdev->dev;
>  +
>  +       /* The ASoC device is complete; register it */
>  +       rc = platform_device_add(pdev);
>  +       if (rc) {
>  +               pr_err("of_soc: platform_device_add() failed\n");
>  +               return;
>  +       }

Is there a driver for this device?  Is another file missing?
sof_of.h is missing too.

>  +
>  +}
>  +
>  +int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
>  +                             void *codec_data, struct snd_soc_codec_dai *dai,
>  +                             struct device_node *node)
>  +{
>  +       struct of_snd_soc_device *of_soc;
>  +       int rc = 0;
>  +
>  +       pr_info("registering ASoC codec driver: %s\n", node->full_name);
>  +
>  +       mutex_lock(&of_snd_soc_mutex);
>  +       of_soc = of_snd_soc_get_device(node);
>  +       if (!of_soc) {
>  +               rc = -ENOMEM;
>  +               goto out;
>  +       }
>  +
>  +       /* Store the codec data */
>  +       of_soc->device.codec_data = codec_data;
>  +       of_soc->device.codec_dev = codec_dev;
>  +       of_soc->dai_link.name = node->name;
>  +       of_soc->dai_link.stream_name = node->name;
>  +       of_soc->dai_link.codec_dai = dai;
>  +
>  +       /* Now try to register the SoC device */
>  +       of_snd_soc_register_device(of_soc);
>  +
>  + out:
>  +       mutex_unlock(&of_snd_soc_mutex);
>  +       return rc;
>  +}
>  +EXPORT_SYMBOL_GPL(of_snd_soc_register_codec);
>  +
>  +int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  +                                struct device_node *node,
>  +                                struct snd_soc_cpu_dai *cpu_dai)
>  +{
>  +       struct of_snd_soc_device *of_soc;
>  +       struct device_node *codec_node;
>  +       const phandle *handle;
>  +       int len, rc = 0;
>  +
>  +       pr_info("registering ASoC platform driver: %s\n", node->full_name);
>  +
>  +       handle = of_get_property(node, "codec-handle", &len);
>  +       if (!handle || len < sizeof(handle))
>  +               return -ENODEV;
>  +       codec_node = of_find_node_by_phandle(*handle);
>  +       if (!codec_node)
>  +               return -ENODEV;
>  +       pr_info("looking for codec: %s\n", codec_node->full_name);
>  +
>  +       mutex_lock(&of_snd_soc_mutex);
>  +       of_soc = of_snd_soc_get_device(codec_node);
>  +       if (!of_soc) {
>  +               rc = -ENOMEM;
>  +               goto out;
>  +       }
>  +
>  +       of_soc->platform_node = node;
>  +       of_soc->dai_link.cpu_dai = cpu_dai;
>  +       of_soc->device.platform = platform;
>  +       of_soc->machine.name = of_soc->dai_link.cpu_dai->name;
>  +
>  +       /* Now try to register the SoC device */
>  +       of_snd_soc_register_device(of_soc);
>  +
>  + out:
>  +       mutex_unlock(&of_snd_soc_mutex);
>  +       return rc;
>  +}
>  +EXPORT_SYMBOL_GPL(of_snd_soc_register_platform);
>
>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Jon Smirl
jonsmirl@gmail.com
