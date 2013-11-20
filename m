Return-Path: <Li.Xiubo@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 678CB2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 18:49:22 +1100 (EST)
From: Li Xiubo <Li.Xiubo@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
Date: Wed, 20 Nov 2013 07:49:06 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828B38EC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101184008.GF2493@sirena.org.uk>
In-Reply-To: <20131101184008.GF2493@sirena.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>,
 "perex@perex.cz" <perex@perex.cz>, Huan Wang <Huan.Wang@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Shawn Guo <Shawn.Guo@freescale.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Zhengxiong Jin <Jason.Jin@freescale.com>, "oskar@scara.com" <oskar@scara.com>,
 Fabio Estevam <Fabio.Estevam@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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


> > +	/* TODO: The SAI driver should figure this out for us */
> > +	switch (channels) {
> > +	case 2:
> > +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffc, 0xfffffffc, 2,
> 0);
> > +		break;
> > +	case 1:
> > +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffe, 0xfffffffe, 1,
> 0);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
>=20
> Yes, it should - this code should probably just be copied straight into
> the SAI driver.  If we need to support other configurations we can do
> that later.
>=20

Well, yes.
I have considered carefully about this, It maybe nicer to move this to SAI =
driver's .hw_params.



--
Best Regards,
Xiubo
