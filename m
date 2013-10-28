Return-Path: <B47053@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 109FC2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 16:58:52 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: "djbw@fb.com" <djbw@fb.com>, "vinod.koul@intel.com" <vinod.koul@intel.com>
Subject: RE: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Date: Mon, 28 Oct 2013 05:58:42 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
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
 Lars-Peter Clausen <lars@metafoo.de>,
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

Hi Dan, Vinod,


> > +static int fsl_sai_probe(struct platform_device *pdev) {
> [...]
> > +
> > +	sai->dma_params_rx.addr =3D res->start + SAI_RDR;
> > +	sai->dma_params_rx.maxburst =3D 6;
> > +	index =3D of_property_match_string(np, "dma-names", "rx");
> > +	ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > +				&dma_args);
> > +	if (ret)
> > +		return ret;
> > +	sai->dma_params_rx.slave_id =3D dma_args.args[1];
> > +
> > +	sai->dma_params_tx.addr =3D res->start + SAI_TDR;
> > +	sai->dma_params_tx.maxburst =3D 6;
> > +	index =3D of_property_match_string(np, "dma-names", "tx");
> > +	ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > +				&dma_args);
> > +	if (ret)
> > +		return ret;
> > +	sai->dma_params_tx.slave_id =3D dma_args.args[1];
>=20
> The driver should not have to manually parse the dma devicetree
> properties, this is something that should be handled by the dma engine
> driver.
>=20

What do you think about the DMA slave_id ?
I have been noticed by one colleague that this should be parsed here, which
is from your opinions ?


> > +
> > +	ret =3D snd_soc_register_component(&pdev->dev, &fsl_component,
> > +			&fsl_sai_dai, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D fsl_pcm_dma_init(pdev);
> > +	if (ret)
> > +		goto out;
