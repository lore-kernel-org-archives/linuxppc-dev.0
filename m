Return-Path: <wharms@bfs.de>
Received: from mx01-fr.bfs.de (mx01-fr.bfs.de [193.174.231.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28D0C1A0CFF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 22:05:31 +1000 (AEST)
Message-ID: <5579774F.4010706@bfs.de>
Date: Thu, 11 Jun 2015 13:55:59 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Quentin Lambert <lambert.quentin@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: aoa: convert bus code to use dev_groups
References: <1434009818-16711-1-git-send-email-lambert.quentin@gmail.com>
In-Reply-To: <1434009818-16711-1-git-send-email-lambert.quentin@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 11.06.2015 10:03, schrieb Quentin Lambert:
> The dev_attrs field of struct bus_type is going away, use dev_groups instead.
> This converts the soundbus code to use the correct field.
> 
> Given that all other usages of the macro define the struct attribute
> *xxx_attrs[] in the same file they assign the .dev_groups field, this patch
> merges sysfs.c into core.c.
> 
> These modifications were made using Coccinelle.
> 
> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
> ---
>  Changes since v1:
>   - Fix the commit message to actually talk about soundbus rather than MDIO
>   - This version attempt to fix a problem resulting from the macro
>     ATTRIBUTE_GROUPS declaring the structure as static by merging sysfs.c into
>     core.c. I understand that this may not be the prefered solution since 
>     Takashi suggested that adding a comment line to the previous version could
>     be acceptable. 
> 
>  sound/aoa/soundbus/Makefile   |    2 -
>  sound/aoa/soundbus/core.c     |   44 +++++++++++++++++++++++++++++++++++++++++-
>  sound/aoa/soundbus/soundbus.h |    2 -
>  sound/aoa/soundbus/sysfs.c    |   42 ----------------------------------------
>  4 files changed, 44 insertions(+), 46 deletions(-)
> 
> --- a/sound/aoa/soundbus/Makefile
> +++ b/sound/aoa/soundbus/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_SND_AOA_SOUNDBUS) += snd-aoa-soundbus.o
> -snd-aoa-soundbus-objs := core.o sysfs.o
> +snd-aoa-soundbus-objs := core.o
>  obj-$(CONFIG_SND_AOA_SOUNDBUS_I2S) += i2sbus/
> --- a/sound/aoa/soundbus/core.c
> +++ b/sound/aoa/soundbus/core.c
> @@ -150,6 +150,48 @@ static int soundbus_device_resume(struct
>  
>  #endif /* CONFIG_PM */
>  
> +#define soundbus_config_of_attr(field, format_string)			\
> +static ssize_t								\
> +field##_show (struct device *dev, struct device_attribute *attr,	\
> +              char *buf)						\
> +{									\
> +	struct soundbus_dev *mdev = to_soundbus_device (dev);		\
> +	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
> +}
> +
> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct soundbus_dev *sdev = to_soundbus_device(dev);
> +	struct platform_device *of = &sdev->ofdev;
> +	int length;
> +
> +	if (*sdev->modalias) {
> +		strlcpy(buf, sdev->modalias, sizeof(sdev->modalias) + 1);
> +		strcat(buf, "\n");
> +		length = strlen(buf);


for my curiosity:
why not sprintf() ? almost any other code seems to use sprintf().

re,
 wh


> +	} else {
> +		length = sprintf(buf, "of:N%sT%s\n",
> +				 of->dev.of_node->name, of->dev.of_node->type);
> +	}
> +
> +	return length;
> +}
> +static DEVICE_ATTR_RO(modalias);
> +
> +soundbus_config_of_attr (name, "%s\n");
> +static DEVICE_ATTR_RO(name);
> +soundbus_config_of_attr (type, "%s\n");
> +static DEVICE_ATTR_RO(type);
> +
> +struct attribute *soundbus_dev_attrs[] = {
> +	&dev_attr_name.attr,
> +	&dev_attr_type.attr,
> +	&dev_attr_modalias.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(soundbus_dev);
> +
>  static struct bus_type soundbus_bus_type = {
>  	.name		= "aoa-soundbus",
>  	.probe		= soundbus_probe,
> @@ -160,7 +202,7 @@ static struct bus_type soundbus_bus_type
>  	.suspend	= soundbus_device_suspend,
>  	.resume		= soundbus_device_resume,
>  #endif
> -	.dev_attrs	= soundbus_dev_attrs,
> +	.dev_groups	= soundbus_dev_groups,
>  };
>  
>  int soundbus_add_one(struct soundbus_dev *dev)
> --- a/sound/aoa/soundbus/soundbus.h
> +++ b/sound/aoa/soundbus/soundbus.h
> @@ -199,6 +199,4 @@ struct soundbus_driver {
>  extern int soundbus_register_driver(struct soundbus_driver *drv);
>  extern void soundbus_unregister_driver(struct soundbus_driver *drv);
>  
> -extern struct device_attribute soundbus_dev_attrs[];
> -
>  #endif /* __SOUNDBUS_H */
> --- a/sound/aoa/soundbus/sysfs.c
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -#include <linux/kernel.h>
> -#include <linux/stat.h>
> -/* FIX UP */
> -#include "soundbus.h"
> -
> -#define soundbus_config_of_attr(field, format_string)			\
> -static ssize_t								\
> -field##_show (struct device *dev, struct device_attribute *attr,	\
> -              char *buf)						\
> -{									\
> -	struct soundbus_dev *mdev = to_soundbus_device (dev);		\
> -	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
> -}
> -
> -static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> -			     char *buf)
> -{
> -	struct soundbus_dev *sdev = to_soundbus_device(dev);
> -	struct platform_device *of = &sdev->ofdev;
> -	int length;
> -
> -	if (*sdev->modalias) {
> -		strlcpy(buf, sdev->modalias, sizeof(sdev->modalias) + 1);
> -		strcat(buf, "\n");
> -		length = strlen(buf);
> -	} else {
> -		length = sprintf(buf, "of:N%sT%s\n",
> -				 of->dev.of_node->name, of->dev.of_node->type);
> -	}
> -
> -	return length;
> -}
> -
> -soundbus_config_of_attr (name, "%s\n");
> -soundbus_config_of_attr (type, "%s\n");
> -
> -struct device_attribute soundbus_dev_attrs[] = {
> -	__ATTR_RO(name),
> -	__ATTR_RO(type),
> -	__ATTR_RO(modalias),
> -	__ATTR_NULL
> -};
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
