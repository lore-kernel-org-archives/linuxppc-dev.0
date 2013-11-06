Return-Path: <B47053@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A78B2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 20:00:03 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
Date: Wed, 6 Nov 2013 08:59:53 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
In-Reply-To: <20131101185045.GG2493@sirena.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Guangyu Chen <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "oskar@scara.com" <oskar@scara.com>, Fabio Estevam <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
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

> > On VF610 series there are no regulators used, and now whether the
> > CONFIG_REGULATOR mirco is enabled or not, for the VF610 audio patch
> > series, the board cannot be probe successfully.
> > And this patch will solve this issue.
>=20
> I don't understand what this is for at all, you're just saying there is a
> problem you're trying to solve but you don't explain anything about what
> the problem is or how your changes address it.
>=20

Sorry for confusing.

The SGTL5000 is based on regulators and when it is disabled, there will be =
an error returns directly while the SGTL5000 codec is probing.
But on VF610 boards there has no regulators or needn't configure them, so t=
he CONFIG_REGULATOR is disabled, and then the error is returned causing
to the SGTL5000 probe broken.=20

Has I make it clear?

> > +#ifndef CONFIG_SND_SOC_FSL_SGTL5000_VF610
> >  static int ldo_regulator_register(struct snd_soc_codec *codec,
>=20
> This is definitely broken, it won't work with multi-platform kernels, and
> I don't understand what this is supposed to do - what is the reason for
> making this change?
>

Yes, it is.

How about adding one node properties like : "regulator-exist", which will b=
e controlled by platform data ?
