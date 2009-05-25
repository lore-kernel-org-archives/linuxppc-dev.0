Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 42A4DDE0D1
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 16:35:18 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1442615ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 23:35:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090525013851.3073.79847.stgit@terra>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013851.3073.79847.stgit@terra>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 00:34:57 -0600
Message-ID: <fa686aa40905242334o4867d701n9de332721eb2f3b4@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] Support for AC97 on Phytec pmc030 base board.
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Support for AC97 on Phytec pmc030 base board. A wm9712 AC97 codec is used=
.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +++
> =A0sound/soc/fsl/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0sound/soc/fsl/pcm030-audio-fabric.c | =A0 95 +++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 105 insertions(+), 0 deletions(-)
> =A0create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 3bce952..79579ae 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -39,4 +39,11 @@ config SND_SOC_MPC5200_AC97
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y here to support the MPC5200 PSCs in AC97 mode.
>
> +config SND_MPC52xx_SOC_PCM030
> + =A0 =A0 =A0 tristate "SoC AC97 Audio support for Phytec pcm030 and WM97=
12"
> + =A0 =A0 =A0 depends on PPC_MPC5200_SIMPLE
> + =A0 =A0 =A0 select SND_SOC_MPC5200_AC97
> + =A0 =A0 =A0 select SND_SOC_WM9712
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y if you want to add support for sound on the Phyte=
c pcm030 baseboard.
>
> diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
> index 14631a1..66d88c8 100644
> --- a/sound/soc/fsl/Makefile
> +++ b/sound/soc/fsl/Makefile
> @@ -15,3 +15,6 @@ obj-$(CONFIG_SND_MPC52xx_DMA) +=3D mpc5200_dma.o
> =A0obj-$(CONFIG_SND_SOC_MPC5200_I2S) +=3D mpc5200_psc_i2s.o
> =A0obj-$(CONFIG_SND_SOC_MPC5200_AC97) +=3D mpc5200_psc_ac97.o
>
> +# MPC5200 Machine Support
> +obj-$(CONFIG_SND_MPC52xx_SOC_PCM030) +=3D pcm030-audio-fabric.o
> +
> diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-a=
udio-fabric.c
> new file mode 100644
> index 0000000..2c426d5
> --- /dev/null
> +++ b/sound/soc/fsl/pcm030-audio-fabric.c
> @@ -0,0 +1,95 @@
> +/*
> + * Phytec pcm030 driver for the PSC of the Freescale MPC52xx
> + * configured as AC97 interface
> + *
> + * Copyright 2008 Jon Smirl, Digispeaker
> + * Author: Jon Smirl <jonsmirl@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public Licen=
se
> + * version 2. This program is licensed "as is" without any warranty of a=
ny
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include <sound/soc-of-simple.h>
> +
> +#include "mpc5200_dma.h"
> +#include "mpc5200_psc_ac97.h"
> +#include "../codecs/wm9712.h"
> +
> +static struct snd_soc_device device;
> +static struct snd_soc_card card;
> +
> +static struct snd_soc_dai_link pcm030_fabric_dai[] =3D {
> +{
> + =A0 =A0 =A0 .name =3D "AC97",
> + =A0 =A0 =A0 .stream_name =3D "AC97 Analog",
> + =A0 =A0 =A0 .codec_dai =3D &wm9712_dai[WM9712_DAI_AC97_HIFI],
> + =A0 =A0 =A0 .cpu_dai =3D &psc_ac97_dai[MPC5200_AC97_NORMAL],
> +},
> +{
> + =A0 =A0 =A0 .name =3D "AC97",
> + =A0 =A0 =A0 .stream_name =3D "AC97 IEC958",
> + =A0 =A0 =A0 .codec_dai =3D &wm9712_dai[WM9712_DAI_AC97_AUX],
> + =A0 =A0 =A0 .cpu_dai =3D &psc_ac97_dai[MPC5200_AC97_SPDIF],
> +},
> +};
> +
> +static __init int pcm030_fabric_init(void)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev;
> + =A0 =A0 =A0 int rc;
> +
> + =A0 =A0 =A0 if (!machine_is_compatible("phytec,pcm030"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 card.platform =3D &mpc5200_audio_dma_platform;
> + =A0 =A0 =A0 card.name =3D "pcm030";
> + =A0 =A0 =A0 card.dai_link =3D pcm030_fabric_dai;
> + =A0 =A0 =A0 card.num_links =3D ARRAY_SIZE(pcm030_fabric_dai);
> +
> + =A0 =A0 =A0 device.card =3D &card;
> + =A0 =A0 =A0 device.codec_dev =3D &soc_codec_dev_wm9712;
> +
> + =A0 =A0 =A0 pdev =3D platform_device_alloc("soc-audio", 1);
> + =A0 =A0 =A0 if (!pdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("pcm030_fabric_init: platform_device=
_alloc() failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, &device);
> + =A0 =A0 =A0 device.dev =3D &pdev->dev;
> +
> + =A0 =A0 =A0 rc =3D platform_device_add(pdev);
> + =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("pcm030_fabric_init: platform_device=
_add() failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}

This is ugly.  I'd really rather have a generic mechanism for creating
a fabric driver based on the OF data.  But failing that, it seems to
me that this platform device registration should be done in the
platform code (arch/powerpc/platforms/52xx).  Doing it in a module
init looks wrong.

I was trying to do a sort of generic matching mechanism with the of
simple stuff; but admittedly it was hacky and half-assed.  However, I
do still think it is viable to have OF hooks that kick in when codec
and machine drivers are registered.  If linkage data is encoded in the
device tree, then generic code should be able to hook them up; pulling
additional data out of the device tree as needed to configure the
coded.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
