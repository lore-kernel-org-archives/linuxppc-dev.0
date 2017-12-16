Return-Path: <caleb@crome.org>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzZ7z3PmyzDsFY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 04:30:37 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id c204so7978031pfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 09:30:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <01a7d97b-7e80-83b2-e850-d513d7dc35aa@tabi.org>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
 <01a7d97b-7e80-83b2-e850-d513d7dc35aa@tabi.org>
From: Caleb Crome <caleb@crome.org>
Date: Sat, 16 Dec 2017 09:30:14 -0800
Message-ID: <CAG5mAdw04U5gpRMqLYOBeujH=t+59WJLFeGe+Qareh-cuWsDvg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
To: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Fabio Estevam <fabio.estevam@nxp.com>,
 mail@maciej.szmigiero.name, Liam Girdwood <lgirdwood@gmail.com>,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 16, 2017 at 9:15 AM, Timur Tabi <timur@tabi.org> wrote:
>
> On 12/13/17 5:18 PM, Nicolin Chen wrote:
>
>> -       /* Used when using fsl-ssi as sound-card. This is only used by ppc and
>> -        * should be replaced with simple-sound-card. */
>>         struct platform_device *pdev;
>
>
> Is this comment no longer true?
>
>> + * 1) SSI in earlier SoCS has crtical bits in control registers that
>
>
> critical
>
>> -/**
>> - * fsl_ssi_isr: SSI interrupt handler
>> - *
>> - * Although it's possible to use the interrupt handler to send and receive
>> - * data to/from the SSI, we use the DMA instead.  Programming is more
>> - * complicated, but the performance is much better.
>> - *
>> - * This interrupt handler is used only to gather statistics.
>> - *
>> - * @irq: IRQ of the SSI device
>> - * @dev_id: pointer to the fsl_ssi structure for this SSI device
>> - */
>
>
> What's wrong with this comment?
>
>> -/*
>> - * Clear RX or TX FIFO to remove samples from the previous
>> - * stream session which may be still present in the FIFO and
>> - * may introduce bad samples and/or channel slipping.
>> - *
>> - * Note: The SOR is not documented in recent IMX datasheet, but
>> - * is described in IMX51 reference manual at section 56.3.3.15.
>> +/**
>> + * Clear remaining data in the FIFO to avoid dirty data or channel slipping
>
>
> I think the original is better, unless there's something untrue about it.
>
>> -        * We are running on a SoC which does not support online SSI
>> -        * reconfiguration, so we have to enable all necessary flags at once
>> -        * even if we do not use them later (capture and playback configuration)
>> +        * Online configuration is not supported
>> +        * Enable or Disable all necessary bits at once
>
>
> Ditto
>
>> -       /*
>> -        * Configure single direction units while the SSI unit is running
>> -        * (online configuration)
>> -        */
>> +       /* Online configure single direction while SSI is running */
>
>
> Ditto
>
>> -               /*
>> -                * Disabling the necessary flags for one of rx/tx while the
>> -                * other stream is active is a little bit more difficult. We
>> -                * have to disable only those flags that differ between both
>> -                * streams (rx XOR tx) and that are set in the stream that is
>> -                * disabled now. Otherwise we could alter flags of the other
>> -                * stream
>> -                */
>> -
>> -               /* These assignments are simply vals without bits set in avals*/
>> +               /* Exclude necessary bits for the opposite stream */
>
>
> Ditto
>
>> -                       /*
>> -                        * Be sure the Tx FIFO is filled when TE is set.
>> -                        * Otherwise, there are some chances to start the
>> -                        * playback with some void samples inserted first,
>> -                        * generating a channel slip.
>> -                        *
>> -                        * First, SSIEN must be set, to let the FIFO be filled.
>> -                        *
>> -                        * Notes:
>> -                        * - Limit this fix to the DMA case until FIQ cases can
>> -                        *   be tested.
>> -                        * - Limit the length of the busy loop to not lock the
>> -                        *   system too long, even if 1-2 loops are sufficient
>> -                        *   in general.
>> -                        */
>
>
> What's wrong with this comment?
>
>> -               /*
>> -                * Note that these below aren't just normal registers.
>> -                * They are a way to disable or enable bits in SACCST
>> -                * register:
>> -                * - writing a '1' bit at some position in SACCEN sets the
>> -                * relevant bit in SACCST,
>> -                * - writing a '1' bit at some position in SACCDIS unsets
>> -                * the relevant bit in SACCST register.
>> -                *
>> -                * The two writes below first disable all channels slots,
>> -                * then enable just slots 3 & 4 ("PCM Playback Left Channel"
>> -                * and "PCM Playback Right Channel").
>> -                */
>> +               /* Disable all channel slots */
>
>
> Ditto.
>
>
>> -        * Why are we setting up SACCST everytime we are starting a
>> -        * playback?
>> -        * Some CODECs (like VT1613 CODEC on UDOO board) like to
>> -        * (sometimes) set extra bits in their SLOTREQ requests.
>> -        * When a bit is set in a SLOTREQ request then SSI sets the
>> -        * relevant bit in SACCST automatically (it is enough if a bit was
>> -        * set in a SLOTREQ just once, bits in SACCST are 'sticky').
>> -        * If an extra slot gets enabled that's a disaster for playback
>> -        * because some of normal left or right channel samples are
>> -        * redirected instead to this extra slot.
>> +        * SACCST might be modified via AC Link by a CODEC if it sends
>> +        * extra bits in their SLOTREQ requests, which'll accidentally
>> +        * send valid data to slots other than normal playback slots.
>>          *
>> -        * A workaround implemented in fsl-asoc-card of setting an
>> -        * appropriate CODEC register so that slots 3 & 4 (the normal
>> -        * stereo playback slots) are used for S/PDIF seems to mostly fix
>> -        * this issue on the UDOO board but since this CODEC is so
>> -        * untrustworthy let's play safe here and make sure that no extra
>> -        * slots are enabled every time a playback is started.
>> +        * To be safe, configure SACCST right before TX starts.
>
>
> I think the original is better, unless there's something untrue about it.
>
>>          */
>>         if (enable && fsl_ssi_is_ac97(ssi))
>>                 fsl_ssi_tx_ac97_saccst_setup(ssi);
>> @@ -626,10 +563,8 @@ static void fsl_ssi_tx_config(struct fsl_ssi *ssi, bool enable)
>>         fsl_ssi_config(ssi, enable, &ssi->rxtx_reg_val.tx);
>>   }
>>   -/*
>> - * Setup rx/tx register values used to enable/disable the streams. These will
>> - * be used later in fsl_ssi_config to setup the streams without the need to
>> - * check for all different SSI modes.
>> +/**
>> + * Cache critical bits of SIER, SRCR, STCR and SCR to later set them safely
>
>
> This is different comment altogether.  Is the original wrong?
>
>> -/**
>> - * fsl_ssi_startup: create a new substream
>> - *
>> - * This is the first function called when a stream is opened.
>> - *
>> - * If this is the first stream open, then grab the IRQ and program most of
>> - * the SSI registers.
>> - */
>
>
> What's wrong with this?
>
>> - * fsl_ssi_hw_params - program the sample size
>> + * Configure SSI based on PCM hardware parameters
>>    *
>> - * Most of the SSI registers have been programmed in the startup function,
>> - * but the word length must be programmed here.  Unfortunately, programming
>> - * the SxCCR.WL bits requires the SSI to be temporarily disabled.  This can
>> - * cause a problem with supporting simultaneous playback and capture.  If
>> - * the SSI is already playing a stream, then that stream may be temporarily
>> - * stopped when you start capture.
>> - *
>> - * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
>> - * clock master.
>> + * Notes:
>> + * 1) SxCCR.WL bits are critical bits that require SSI to be temporarily
>> + *    disabled on offline_config SoCs. Even for online configurable SoCs
>> + *    running in synchronous mode (both TX and RX use STCCR), it is not
>> + *    safe to re-configure them when both two streams start running.
>> + * 2) SxCCR.PM, SxCCR.DIV2 and SxCCR.PSR bits will be configured in the
>> + *    fsl_ssi_set_bclk() if SSI is the DAI clock master.
>
>
> I think the comment about the stream being temporarily stopped should be kept, since it was a real issue I spent a lot of time trying to debug. Unless it's been fixed, of course.
>
>
>>    */
>>   static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>>         struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
>> @@ -879,8 +795,10 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>>         enabled = scr_val & CCSR_SSI_SCR_SSIEN;
>>         /*
>> -        * If we're in synchronous mode, and the SSI is already enabled,
>> -        * then STCCR is already set properly.
>> +        * SSI is properly configured if it is enabled and running in
>> +        * the synchronous mode; Note that AC97 mode is an exception
>> +        * that should set separate configurations for STCCR and SRCCR
>> +        * despite running in the synchronous mode.
>>          */
>>         if (enabled && ssi->cpu_dai_drv.symmetric_rates)
>>                 return 0;
>> @@ -902,10 +820,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>>         if (!fsl_ssi_is_ac97(ssi)) {
>>                 u8 i2smode;
>> -               /*
>> -                * Switch to normal net mode in order to have a frame sync
>> -                * signal every 32 bits instead of 16 bits
>> -                */
>> +               /* Normal + Network mode to send 16-bit data in 32-bit frames */
>>                 if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
>>                         i2smode = CCSR_SSI_SCR_I2S_MODE_NORMAL |
>>                                 CCSR_SSI_SCR_NET;
>> @@ -917,16 +832,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>>                                 channels == 1 ? 0 : i2smode);
>>         }
>>   -     /*
>> -        * FIXME: The documentation says that SxCCR[WL] should not be
>> -        * modified while the SSI is enabled.  The only time this can
>> -        * happen is if we're trying to do simultaneous playback and
>> -        * capture in asynchronous mode.  Unfortunately, I have been enable
>> -        * to get that to work at all on the P1022DS.  Therefore, we don't
>> -        * bother to disable/enable the SSI when setting SxCCR[WL], because
>> -        * the SSI will stop anyway.  Maybe one day, this will get fixed.
>> -        */
>
>
> Has this been fixed?  If not, then don't delete the comment.
>
>>   /**
>> - * fsl_ssi_trigger: start and stop the DMA transfer.
>> - *
>> - * This function is called by ALSA to start, stop, pause, and resume the DMA
>> - * transfer of data.
>> - *
>> - * The DMA channel is in external master start and pause mode, which
>> - * means the SSI completely controls the flow of data.
>
>
> This last paragraph is important.
>
>> -
>> -               /*
>> -                * Some boards use an incompatible codec. To get it
>> -                * working, we are using imx-fiq-pcm-audio, that
>> -                * can handle those codecs. DMA is not possible in this
>> -                * situation.
>> -                */
>> -
>> +               /* Use imx-fiq-pcm-audio for codec incompatible with DMA */
>
>
> Original is clearer.
>
>> -        * Set the watermark for transmit FIFO 0 and receive FIFO 0. We don't
>> -        * use FIFO 1 but set the watermark appropriately nontheless.
>> -        * We program the transmit water to signal a DMA transfer
>> -        * if there are N elements left in the FIFO. For chips with 15-deep
>> -        * FIFOs, set watermark to 8.  This allows the SSI to operate at a
>> -        * high data rate without channel slipping. Behavior is unchanged
>> -        * for the older chips with a fifo depth of only 8.  A value of 4
>> -        * might be appropriate for the older chips, but is left at
>> -        * fifo_depth-2 until sombody has a chance to test.
>> +        * Configure TX and RX DMA watermarks.
>>          *
>> -        * We set the watermark on the same level as the DMA burstsize.  For
>> -        * fiq it is probably better to use the biggest possible watermark
>> -        * size.
>> +        * Values should be tested to avoid FIFO under/over run. Set maxburst
>> +        * to fifo_watermark to maxiumize DMA transaction to reduce overhead.
>
>
> Why in the world would you delete all this good info?
>
>>          */
>>         switch (ssi->fifo_depth) {
>>         case 15:
>> -               /*
>> -                * 2 samples is not enough when running at high data
>> -                * rates (like 48kHz @ 16 bits/channel, 16 channels)
>> -                * 8 seems to split things evenly and leave enough time
>> -                * for the DMA to fill the FIFO before it's over/under
>> -                * run.
>> -                */
>> +               /* Tested with cases running at 48kHz @ 16 bits x 16 channels */
>
>
> Same here.
>
>> -       /*
>> -        * If codec-handle property is missing from SSI node, we assume
>> -        * that the machine driver uses new binding which does not require
>> -        * SSI driver to trigger machine driver's probe.
>> -        */
>> +       /* Bypass it if using newer DT bindings of ASoC machine drivers */
>
>
> Not an improvement.
>
>> -/* Show the statistics of a flag only if its interrupt is enabled.  The
>> - * compiler will optimze this code to a no-op if the interrupt is not
>> - * enabled.
>> +/**
>> + * Show the statistics of a flag only if its interrupt is enabled
>> + *
>> + * Compilers will optimze it to a no-op if the interrupt is disabled
>
>
> optimize

Having come to work on this driver with very little knowledge about
kernel programming, and i.MX, I have to agree with Timur. It's an
amazingly complex driver (with support of so many variants).  By
eliminating verbose commentary, it's also wiping away a lot of
knowledge.  The more sparse commentary makes things harder to
understand for newcomers, or really anybody who isn't already steeped
in knowledge about the SSI port and linux, and it's interaction with
DMA.

(IMO, the hardware design is fundamentally flawed, which makes this
thing such a bear to program -- interrupts & DMA requests are based on
numbers of samples rather than frames -- but that's a discussion for a
different mailing list ;-) )

-Caleb
