Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynvPQ1FT9zDrqM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 10:53:45 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id a90so3839026pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 15:53:45 -0800 (PST)
Date: Thu, 30 Nov 2017 15:53:36 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_ssi: add 20-bit sample format for AC'97
 and use it for capture
Message-ID: <20171130235335.GA26530@Asurada-Nvidia>
References: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
 <20171130072357.GA992@Asurada>
 <ba46e597-6ae7-5fb4-40b3-bb2a5e08066a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba46e597-6ae7-5fb4-40b3-bb2a5e08066a@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 30, 2017 at 08:20:08PM +0100, Maciej S. Szmigiero wrote:

> In the AC'97 mode we have to differentiate two things:
> 1) Bit width of the physical AC'97 interface ("AC-link"),
> 2) Bit width of samples that are accepted during a playback and output
> during a recording by the SSI (and, so by the sound card that it driven
> by this CPU).
> 
> Bit width of the physical AC'97 interface is fixed at 20 bits per sample
> (both in playback and capture direction).
> 
> Bit width of samples that are accepted (or produced) by the SSI could
> be set in its STCCR and SRCCR registers (although in the AC'97 mode
> only settings of either 16 or 20 bits are possible).
> Each direction could be set independently from the other one.

I checked the reference manual regarding the AC97 configurations.
It seems that AC97 sets SYNC bit in SCR register. However, unlike
I2S which only uses STCCR for both TX and RX, AC97 does use STCCR
and SRCCR separately. So bypassing SRCCR if SYNC bit is set isn't
correct for AC97 cases.

I will clean up the driver a bit and I think the change would be
highly related to AC97 code. So I'll later need you review/test.

> Regarding a sample rate in AC'97 mode its effective value isn't really
> controlled by the CPU (that is, SSI), but by a CODEC since it is
> the CODEC which tells the CPU when it should send a next sample for
> playback and when a next capture sample is ready.
> There are no problems if they are different (as long as the CODEC
> supports this, naturally, but it's up to its driver to restrict the
> sample rate space accordingly).

It's because CODEC drives the bit clock and framesync clock, isn't
it? Could SSI act as the clock master side? It doesn't seem to be
configurable to do so according to the reference manual though.

> A comment above "fsl,ssi-asynchronous" property says that it is about
> whether "the RX and the TX clocks [are] locked".
> They are on the physical AC'97 interface, but they aren't on the logical
> playback / capture interface.
> IMHO, this configurable property simply makes no sense in the AC'97
> mode.

The property is more on the hardware level. And we should refer to
the DT binding doc:
    fsl,ssi-asynchronous:
         If specified, the SSI is to be programmed in asynchronous
         mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
         all be connected to valid signals.  In synchronous mode,
         SRCK and SRFS are ignored.  Asynchronous mode allows
         playback and capture to use different sample sizes and
         sample rates.  Some drivers may require that SRCK and STCK
         be connected together, and SRFS and STFS be connected
         together.  This would still allow different sample sizes,
         but not different sample rates.

If AC97 doesn't need SRFS and SRCK at all, it's fine to ignore it.

Thanks
Nic
