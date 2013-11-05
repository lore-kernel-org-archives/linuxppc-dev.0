Return-Path: <B47053@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 558982C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 14:50:19 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Guangyu Chen <B42378@freescale.com>, "shawn.guo@linaro.org"
 <shawn.guo@linaro.org>
Subject: RE: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
Date: Tue, 5 Nov 2013 03:50:07 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82875503@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
In-Reply-To: <20131101102805.GG28401@MrMyself>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
 "oskar@scara.com" <oskar@scara.com>, Fabio Estevam <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicolin,


> > This is the SGTL5000 codec based audio driver supported with both
> > playback and capture dai link implemention.
> >
> > This implementation is only compatible with device tree definition.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> >
> > Conflicts:
> > 	sound/soc/fsl/Makefile
> > ---
> >  sound/soc/fsl/Kconfig              |  10 ++
> >  sound/soc/fsl/Makefile             |   2 +
>=20
> >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208
> > +++++++++++++++++++++++++++++++++++++
>=20
> I just doubt if this file naming is appropriate. Even if we might not
> have rigor rule for the file names, according to existing ones, they are
> all in a same pattern: [SoC name]-[codec name].c
>=20
> "imx-sgtl5000.c" for example
>=20
> I think it would make user less confused about what this file exactly is
> if this machine driver also follow the pattern: vf610-sgtl5000.c
>=20

Yes, it looks nicer.

>=20
> @Shawn
>=20
> What do you think about the file name?
>=20
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 sound/soc/fsl/fsl-sgtl5000-vf610.c
> >
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig index
> > 9a8851e..1b835ba 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -228,4 +228,14 @@ config SND_SOC_FSL_SAI
> >  	tristate
> >  	select SND_SOC_GENERIC_DMAENGINE_PCM
> >
> > +config SND_SOC_FSL_SGTL5000_VF610
>=20
> Same problem with the this define.
>=20
> > +	tristate "SoC Audio support for FSL boards with sgtl5000"
>=20
> And 'FSL' here confuses me a lot. Because those boards based on i.MX
> series also could be called FSL boards.
>=20

Yes, this should be VF610.

> > +	depends on OF && I2C
> > +	select SND_SOC_FSL_SAI
> > +	select SND_SOC_FSL_PCM
> > +	select SND_SOC_SGTL5000
> > +	help
> > +	  Say Y if you want to add support for SoC audio on an FSL board
> with
> > +	  a sgtl5000 codec.
> > +
> >  endif # SND_FSL_SOC
> > diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile index
> > e5acc03..26fc551 100644
> > --- a/sound/soc/fsl/Makefile
> > +++ b/sound/soc/fsl/Makefile
> > @@ -59,5 +59,7 @@ obj-$(CONFIG_SND_SOC_IMX_MC13783) +=3D
> > snd-soc-imx-mc13783.o
> >
> >  # FSL ARM SAI/SGT15000 Platform Support  snd-soc-fsl-sai-objs :=3D
> > fsl-sai.o
> > +snd-soc-fsl-sgtl5000-vf610-objs :=3D fsl-sgtl5000-vf610.o
> >
> >  obj-$(CONFIG_SND_SOC_FSL_SAI) +=3D snd-soc-fsl-sai.o
> > +obj-$(CONFIG_SND_SOC_FSL_SGTL5000_VF610) +=3D
> > +snd-soc-fsl-sgtl5000-vf610.o
> > diff --git a/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > new file mode 100644
> > index 0000000..f535b42
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > @@ -0,0 +1,208 @@
> > +/*
> > + * Freeacale ALSA SoC Audio using SGT1500 as codec.
> > + *
> > + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/i2c.h>
> > +#include <linux/clk.h>
> > +
> > +#include "../codecs/sgtl5000.h"
> > +#include "fsl-sai.h"
> > +
> > +static unsigned int sysclk_rate;
> > +
> > +static int fsl_sgtl5000_dai_init(struct snd_soc_pcm_runtime *rtd)
>=20
> Naming issue here again.
>=20
> At least from my point of view, if you actually merged imx-sgtl5000 with
> vf610-sgtl5000 and made it also compatible to other freescale SoCs, you
> could then fairly call it fsl_sgtl5000_xxxx.
>=20
> Well, I might be a little picky here because it's a static function and
> won't conflict others. Just the name here doesn't look so explicit to me.
>=20
> Please reconsider about this whole file's naming.
>=20

Yes, I still not very sure the names of the functions and files, from your =
replies,
I have got many information about the rules and others, I'll think it over =
and do some
research, Please see the next version.



Best regards,
Xiubo
