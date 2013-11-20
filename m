Return-Path: <Li.Xiubo@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1855D2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 14:37:54 +1100 (EST)
From: Li Xiubo <Li.Xiubo@freescale.com>
To: Guangyu Chen <guangyu.chen@freescale.com>
Subject: RE: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Wed, 20 Nov 2013 03:37:45 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828AE980@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131104043338.GA2345@MrMyself>
In-Reply-To: <20131104043338.GA2345@MrMyself>
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
 "broonie@kernel.org" <broonie@kernel.org>,
 Zhengxiong Jin <Jason.Jin@freescale.com>, "oskar@scara.com" <oskar@scara.com>,
 Fabio Estevam <Fabio.Estevam@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>,
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

=20
> The udelay just doesn't make sense to what you are talking about.
>=20
> Does SAI really need 10us delay between two register-updating?
>=20

No, this is not must be.

> We basically use udelay only if the IP hardware actually needs it: some
> IP needs time to boot itself up after doing software reset for example.
> But it doesn't look reasonable to me by using udelay to make sure "the
> last enabled".
>=20
> And from the 'Synchronous mode' you just provided, there're another issue=
:
>=20
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		tcsr |=3D FSL_SAI_CSR_TERE;
> +		rcsr |=3D FSL_SAI_CSR_TERE;
> +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> +		udelay(10);
> +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		if (!(dai->playback_active || dai->capture_active)) {
> +			tcsr &=3D ~FSL_SAI_CSR_TERE;
> +			rcsr &=3D ~FSL_SAI_CSR_TERE;
> +		}
> +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> +		udelay(10);
> +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> +		break;
>=20
> ISSUE 1: You might make sure transmitter is the last enabled.
> 	 However, it's not the first disabled. Is this okay?
>=20

Yes, this is just programming mistake. I'll revise it.

In this case the transmitter should be the last enabled and the first disab=
led.


> ISSUE 2: There are two cases listed in 'Synchronous mode'.
> 	 However, your driver doesn't take care of them.
> 	 The SAI's synchronous mode looks like more flexible
> 	 than SSI's. The driver needs to be more sophisticated
> 	 so that it can handle multiple cases when TX/RX clocks
> 	 are controlled by either TX or RX, and surely, the
> 	 asynchronous mode as well.
>=20

Because in Vybrid the transmitter bit clock and frame sync are to be used b=
y both the transmitter and receiver, and only this case can be used here, s=
o now I only handle this case.

>=20
> And there's another personal tip: I think you can first try to focus on
> this SAI driver and pend the others. There might be two many things you
> need to refine if you are doing them at the same time.
>=20

I'll implement them later if needed.


--
Best Regards,
Xiubo
