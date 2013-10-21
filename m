Return-Path: <B47053@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC5C22C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 17:59:23 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Date: Mon, 21 Oct 2013 06:59:10 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828667B8@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
In-Reply-To: <526021B0.6050206@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Chen Guangyu-B42378 <B42378@freescale.com>,
 "oskar@scara.com" <oskar@scara.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "rob@landley.net" <rob@landley.net>,
 Jin Zhengxiong-R64188 <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > +static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> > +		struct snd_pcm_hw_params *params,
> > +		struct snd_soc_dai *cpu_dai)
> > +{
> > +	int ret;
> > +
> > +	ret =3D fsl_sai_hw_params_tr(substream, params, cpu_dai,
> > +				FSL_FMT_TRANSMITTER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai transmitter hw params: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D fsl_sai_hw_params_tr(substream, params, cpu_dai,
> > +				FSL_FMT_RECEIVER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai's receiver hw params: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
>=20
> Shouldn't, depending on the substream direction, either transmit or
> receiver be configured, instead of always configuring both?
>=20

Yes, this can be configed separately. Please see the next version.

> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_trigger(struct snd_pcm_substream *substream, int
> cmd,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(dai);
> > +	unsigned int tcsr, rcsr;
> > +
> > +	tcsr =3D readl(sai->base + SAI_TCSR);
> > +	rcsr =3D readl(sai->base + SAI_RCSR);
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +	case SNDRV_PCM_TRIGGER_RESUME:
> > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +		rcsr |=3D SAI_CSR_TERE | SAI_CSR_FRDE;
> > +		tcsr |=3D SAI_CSR_TERE | SAI_CSR_FRDE;
> > +		writel(rcsr, sai->base + SAI_RCSR);
> > +		udelay(10);
> > +		writel(tcsr, sai->base + SAI_TCSR);
> > +		break;
> > +
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +	case SNDRV_PCM_TRIGGER_SUSPEND:
> > +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > +		tcsr &=3D ~(SAI_CSR_TERE | SAI_CSR_FRDE);
> > +		rcsr &=3D ~(SAI_CSR_TERE | SAI_CSR_FRDE);
> > +		writel(tcsr, sai->base + SAI_TCSR);
> > +		udelay(10);
> > +		writel(rcsr, sai->base + SAI_RCSR);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
>=20
> Same here, shouldn't tx and rx be started independently depending on the
> substream direction?
>=20

But this couldn't, from the SAI's spec we can see that:
------
The SAI transmitter and receiver can be configured to operate with synchron=
ous bit clock
and frame sync.

1),=20
If the transmitter bit clock and frame sync are to be used by both the tran=
smitter and
receiver:
* The transmitter must be configured for asynchronous operation and the rec=
eiver for
synchronous operation.
* In synchronous mode, the receiver is enabled only when both the transmitt=
er and
receiver are enabled.
* It is recommended that the transmitter is the last enabled and the first =
disabled.

2),
If the receiver bit clock and frame sync are to be used by both the transmi=
tter and
receiver:
* The receiver must be configured for asynchronous operation and the transm=
itter for
synchronous operation.
* In synchronous mode, the transmitter is enabled only when both the receiv=
er and
transmitter are both enabled.
* It is recommended that the receiver is the last enabled and the first dis=
abled.
------

The receiver and transmitter should be both enabled at the same time if any=
 of them is alive.


> > +	return 0;
> > +}
> > +
> > +static struct snd_soc_dai_ops fsl_sai_pcm_dai_ops =3D {
>=20
> const
>=20

Please see the next version.
