Return-Path: <Li.Xiubo@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DB9B2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 18:36:05 +1100 (EST)
From: Li Xiubo <Li.Xiubo@freescale.com>
To: Vinod Koul <vinod.koul@intel.com>, "lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Date: Tue, 12 Nov 2013 07:35:55 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8287E87B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
 <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131112050226.GK8834@intel.com>
In-Reply-To: <20131112050226.GK8834@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Huan Wang <Huan.Wang@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 Shawn Guo <Shawn.Guo@freescale.com>, "djbw@fb.com" <djbw@fb.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 Zhengxiong Jin <Jason.Jin@freescale.com>, "oskar@scara.com" <oskar@scara.com>,
 Fabio Estevam <Fabio.Estevam@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "rob@landley.net" <rob@landley.net>, Guangyu Chen <guangyu.chen@freescale.com>,
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

> > > > +static int fsl_sai_probe(struct platform_device *pdev) {
> > > [...]
> > > > +
> > > > +	sai->dma_params_rx.addr =3D res->start + SAI_RDR;
> > > > +	sai->dma_params_rx.maxburst =3D 6;
> > > > +	index =3D of_property_match_string(np, "dma-names", "rx");
> > > > +	ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells",
> index,
> > > > +				&dma_args);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +	sai->dma_params_rx.slave_id =3D dma_args.args[1];
> > > > +
> > > > +	sai->dma_params_tx.addr =3D res->start + SAI_TDR;
> > > > +	sai->dma_params_tx.maxburst =3D 6;
> > > > +	index =3D of_property_match_string(np, "dma-names", "tx");
> > > > +	ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells",
> index,
> > > > +				&dma_args);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +	sai->dma_params_tx.slave_id =3D dma_args.args[1];
> > >
> > > The driver should not have to manually parse the dma devicetree
> > > properties, this is something that should be handled by the dma
> > > engine driver.
> > >
> >
> > What do you think about the DMA slave_id ?
> > I have been noticed by one colleague that this should be parsed here,
> > which is from your opinions ?
> Sure slave_id can be parsed here, but IMO it should be programmed via the
> dma_slave_confog into the respective channel
>=20

Actually, these are parsed for cpu_dai->playback_dma_data and cpu_dai->capt=
ure_dma_data dynamically, whose type is struct dma_slave_config.

And now I must parse them here, because the platform eDMA driver's newest v=
ersion will check and use the slave_ids to select and configure the eDMA ch=
annels via dma_device->device_control().=20

--
Xiubo
