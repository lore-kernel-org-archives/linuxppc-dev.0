Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A1392C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 15:40:31 +1100 (EST)
Date: Mon, 4 Nov 2013 12:33:39 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Xiubo Li-B47053 <B47053@freescale.com>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Message-ID: <20131104043338.GA2345@MrMyself>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Mon, Nov 04, 2013 at 11:45:10AM +0800, Xiubo Li-B47053 wrote:
> > > +snd-soc-fsl-sai-objs := fsl-sai.o
> > 
> > And I think it should be better to put it along with fsl-ssi.o and fsl-
> > spdif.o
> > 
> 
> But fsl-ssi.o and fsl-spdif.o is based PowrePC platform? Which we can see from the comments.

No. fsl-ssi.c is compatible to both ARM and PPC. And fsl-spdif.c is currently
used on ARM only. So please just put along with them.

> > > +	case SNDRV_PCM_TRIGGER_START:
> > > +	case SNDRV_PCM_TRIGGER_RESUME:
> > > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > > +		tcsr |= FSL_SAI_CSR_TERE;
> > > +		rcsr |= FSL_SAI_CSR_TERE;
> > > +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> > > +		udelay(10);
> > 
> > Does SAI really needs this udelay() here? Required by IP's operation flow?
> > If so, I think it's better to add comments here to explain it.
> > 
> +++++++++++++++++
> Synchronous mode
> The SAI transmitter and receiver can be configured to operate with synchronous bit clock
> and frame sync.
> 
> 1,
> If the transmitter bit clock and frame sync are to be used by both the transmitter and
> receiver:
> 	...
> * It is recommended that the transmitter is the last enabled and the first disabled.
> 
> 2,
> If the receiver bit clock and frame sync are to be used by both the transmitter and
> receiver:
> 	...
> * It is recommended that the receiver is the last enabled and the first disabled.
> ------------------
> 
> So I think the delay is needed, and I still tunning it.
> 

The udelay just doesn't make sense to what you are talking about.

Does SAI really need 10us delay between two register-updating?

We basically use udelay only if the IP hardware actually needs it: some
IP needs time to boot itself up after doing software reset for example.
But it doesn't look reasonable to me by using udelay to make sure "the 
last enabled".

And from the 'Synchronous mode' you just provided, there're another issue:

+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		tcsr |= FSL_SAI_CSR_TERE;
+		rcsr |= FSL_SAI_CSR_TERE;
+		writel(rcsr, sai->base + FSL_SAI_RCSR);
+		udelay(10);
+		writel(tcsr, sai->base + FSL_SAI_TCSR);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (!(dai->playback_active || dai->capture_active)) {
+			tcsr &= ~FSL_SAI_CSR_TERE;
+			rcsr &= ~FSL_SAI_CSR_TERE;
+		}
+		writel(rcsr, sai->base + FSL_SAI_RCSR);
+		udelay(10);
+		writel(tcsr, sai->base + FSL_SAI_TCSR);
+		break;

ISSUE 1: You might make sure transmitter is the last enabled.
	 However, it's not the first disabled. Is this okay?

ISSUE 2: There are two cases listed in 'Synchronous mode'.
	 However, your driver doesn't take care of them.
	 The SAI's synchronous mode looks like more flexible
	 than SSI's. The driver needs to be more sophisticated
	 so that it can handle multiple cases when TX/RX clocks
	 are controlled by either TX or RX, and surely, the
	 asynchronous mode as well.


And there's another personal tip: I think you can first try to focus on
this SAI driver and pend the others. There might be two many things you
need to refine if you are doing them at the same time.

Best regards,
Nicolin Chen
