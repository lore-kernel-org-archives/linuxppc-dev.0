Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygmkW3RWLzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 11:32:18 +1100 (AEDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt()
 just once in AC'97 mode
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
References: <81ad2e7e-e070-c38e-b318-9607b4558ee7@maciej.szmigiero.name>
 <20171121000042.GB14136@Asurada-Nvidia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <da7bf2c5-5a4d-d2cc-823d-3f8cdfccd51c@maciej.szmigiero.name>
Date: Tue, 21 Nov 2017 01:32:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171121000042.GB14136@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.11.2017 01:00, Nicolin Chen wrote:
> On Mon, Nov 20, 2017 at 11:13:45PM +0100, Maciej S. Szmigiero wrote:
(..)
>> We need to make sure, however, that only proper channel slots are enabled
>> at playback start time since some AC'97 CODECs (like VT1613) were observed
>> requesting via SLOTREQ (and so enabling at SSI) spurious ones just after
>> an AC'97 link is started but before the CODEC is configured by its driver.
> 
> I don't really understand this part. Why do we need to *make sure*
> and set SACCDIS and SACCEN again since they're initialized already> 
> Could you please elaborate a bit more?

SACCDIS and SACCEN aren't just normal registers.
They are a way to disable or enable bits in SACCST register - writing
a '1' bit at some position in SACCDIS unsets the relevant bit in SACCST,
writing a '1' bit at some position in SACCEN sets the relevant bit in
SACCST.

But a bit in SACCST can also be set (and so an AC'97 channel slot
enabled) if a CODEC sets the relevant bit in its SLOTREQ request (it is
enough if this bit was set in SLOTREQ just once, bits in SACCST are
'sticky').
If an extra slot gets enabled that's a disaster for playback because some
of normal left or right channel samples are instead redirected to this
extra slot.

Unfortunately, the VT1613 codec on UDOO board (which is the only user of
fsl_ssi driver in the AC'97 mode) is a bit broken and likes to (sometimes)
set extra bits in its SLOTREQ request - I've confirmed this on two boards
bought a few months apart directly from UDOO shop.

A workaround implemented in fsl-asoc-card of setting an appropriate
CODEC register so that slots 3/4 (the normal stereo playback slots) are
used for S/PDIF seems to mostly fix this issue but since this codec is so
untrustworthy then:
>> let's play safe here and make sure that no extra slots are enabled
>> every time a playback is started.

(..)
>> @@ -1149,9 +1146,16 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>>  	case SNDRV_PCM_TRIGGER_START:
>>  	case SNDRV_PCM_TRIGGER_RESUME:
>>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> -		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +			/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
>> +			if (fsl_ssi_is_ac97(ssi_private) &&
>> +				!ssi_private->soc->imx21regs) {
>> +				regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
>> +				regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
>> +			}
> 
> And second, why could we ignore them for STREAM_CAPTURE here?

Capture is not affected by SACCST register content.

> Well, at least this part could be moved into fsl_ssi_tx_config()
> since we have an abstraction layer of register configurations.

Will move this into fsl_ssi_tx_config() in a respin.

> 
> Thanks
> Nic

Thanks,
Maciej
