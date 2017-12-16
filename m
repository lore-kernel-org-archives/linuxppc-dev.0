Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzcVy6Sf7zDsQm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 06:17:14 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id a90so8064880pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 11:17:14 -0800 (PST)
Date: Sat, 16 Dec 2017 11:17:07 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Timur Tabi <timur@tabi.org>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 fabio.estevam@nxp.com, mail@maciej.szmigiero.name, caleb@crome.org,
 lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
Message-ID: <20171216191706.GC3840@Asurada>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
 <01a7d97b-7e80-83b2-e850-d513d7dc35aa@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01a7d97b-7e80-83b2-e850-d513d7dc35aa@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

First of all, thanks a lot for the review. And I will send a v4
after I refine these comments.

But please please don't think in the way like "you can touch it
unless it's untrue." I never said anything or anyone is wrong
here. As the other patches that shortens variable names, this
patch just does something similar.

The point here is just to make the driver necessarily explained
while being brief. I am totally fine if you feel some of my new
comments are worse. I will refine it until you get satisfied.

And I hope you (or anyone else) can tell me more about what is
wrong with my new comments instead of asking me to drop them all.
I locally have more than 20 patches based on this one. Any change
I make to this one will give me a lot of trouble to rebase them.
So I am more willing to refine those that people really feel hard
to understand.

On Sat, Dec 16, 2017 at 11:15:43AM -0600, Timur Tabi wrote:
> On 12/13/17 5:18 PM, Nicolin Chen wrote:
> 
> >-	/* Used when using fsl-ssi as sound-card. This is only used by ppc and
> >-	 * should be replaced with simple-sound-card. */
> >  	struct platform_device *pdev;
> 
> Is this comment no longer true?

It's moved to the comments of structure fsl_ssi. Since we defined
a pdev at the first place, we should have explained it along with
the definition.

> >-/**
> >- * fsl_ssi_isr: SSI interrupt handler
> >- *
> >- * Although it's possible to use the interrupt handler to send and receive
> >- * data to/from the SSI, we use the DMA instead.  Programming is more
> >- * complicated, but the performance is much better.
> >- *
> >- * This interrupt handler is used only to gather statistics.
> >- *
> >- * @irq: IRQ of the SSI device
> >- * @dev_id: pointer to the fsl_ssi structure for this SSI device
> >- */
> 
> What's wrong with this comment?

Nothing wrong. An interrupt handler is way too common sense in
a driver code. I am okay to retain it if you strongly feel it's
that necessary. But I would feel more plausible to clean it away.

> >- * Clear RX or TX FIFO to remove samples from the previous
> >- * stream session which may be still present in the FIFO and
> >- * may introduce bad samples and/or channel slipping.
> >- *
> >- * Note: The SOR is not documented in recent IMX datasheet, but
> >- * is described in IMX51 reference manual at section 56.3.3.15.
> >+/**
> >+ * Clear remaining data in the FIFO to avoid dirty data or channel slipping
> 
> I think the original is better, unless there's something untrue about it.

It's literally stating the same thing. And SOR register comments
are moved to the header file.

> >-	 * We are running on a SoC which does not support online SSI
> >-	 * reconfiguration, so we have to enable all necessary flags at once
> >-	 * even if we do not use them later (capture and playback configuration)
> >+	 * Online configuration is not supported
> >+	 * Enable or Disable all necessary bits at once
> 
> Ditto

The code also does disabling as well however it doesn't mention
at all. Just like you might have hard time to understand my new
comments, I also had a hard time to understand this one. So I'll
have to change it. My new comments are shorter but covers both
enable and disable. I could make it more descriptive if necessary.

> >-	/*
> >-	 * Configure single direction units while the SSI unit is running
> >-	 * (online configuration)
> >-	 */
> >+	/* Online configure single direction while SSI is running */
> 
> Ditto

It's literally the same but shorter. I don't think anyone would
have trouble to understand mine...

> >-			/*
> >-			 * Be sure the Tx FIFO is filled when TE is set.
> >-			 * Otherwise, there are some chances to start the
> >-			 * playback with some void samples inserted first,
> >-			 * generating a channel slip.
> >-			 *
> >-			 * First, SSIEN must be set, to let the FIFO be filled.
> >-			 *
> >-			 * Notes:
> >-			 * - Limit this fix to the DMA case until FIQ cases can
> >-			 *   be tested.
> >-			 * - Limit the length of the busy loop to not lock the
> >-			 *   system too long, even if 1-2 loops are sufficient
> >-			 *   in general.
> >-			 */
> 
> What's wrong with this comment?

I have new comments covering necessary steps. But I could bring
some parts back if that makes you happy.

> >-		/*
> >-		 * Note that these below aren't just normal registers.
> >-		 * They are a way to disable or enable bits in SACCST
> >-		 * register:
> >-		 * - writing a '1' bit at some position in SACCEN sets the
> >-		 * relevant bit in SACCST,
> >-		 * - writing a '1' bit at some position in SACCDIS unsets
> >-		 * the relevant bit in SACCST register.
> >-		 *
> >-		 * The two writes below first disable all channels slots,
> >-		 * then enable just slots 3 & 4 ("PCM Playback Left Channel"
> >-		 * and "PCM Playback Right Channel").
> >-		 */
> >+		/* Disable all channel slots */
> 
> Ditto.

All register related comments are moved to the header file. And
I have new comments covering the 2nd part of original one.

> >-	 * Why are we setting up SACCST everytime we are starting a
> >-	 * playback?
> >-	 * Some CODECs (like VT1613 CODEC on UDOO board) like to
> >-	 * (sometimes) set extra bits in their SLOTREQ requests.
> >-	 * When a bit is set in a SLOTREQ request then SSI sets the
> >-	 * relevant bit in SACCST automatically (it is enough if a bit was
> >-	 * set in a SLOTREQ just once, bits in SACCST are 'sticky').
> >-	 * If an extra slot gets enabled that's a disaster for playback
> >-	 * because some of normal left or right channel samples are
> >-	 * redirected instead to this extra slot.
> >+	 * SACCST might be modified via AC Link by a CODEC if it sends
> >+	 * extra bits in their SLOTREQ requests, which'll accidentally
> >+	 * send valid data to slots other than normal playback slots.
> >  	 *
> >-	 * A workaround implemented in fsl-asoc-card of setting an
> >-	 * appropriate CODEC register so that slots 3 & 4 (the normal
> >-	 * stereo playback slots) are used for S/PDIF seems to mostly fix
> >-	 * this issue on the UDOO board but since this CODEC is so
> >-	 * untrustworthy let's play safe here and make sure that no extra
> >-	 * slots are enabled every time a playback is started.
> >+	 * To be safe, configure SACCST right before TX starts.
> 
> I think the original is better, unless there's something untrue about it.

The 1st part is saying the same thing as mine, the 2nd part is not
that necessary to mention some work in the machine driver since we
have already applied the safest way here.

> >-/*
> >- * Setup rx/tx register values used to enable/disable the streams. These will
> >- * be used later in fsl_ssi_config to setup the streams without the need to
> >- * check for all different SSI modes.
> >+/**
> >+ * Cache critical bits of SIER, SRCR, STCR and SCR to later set them safely
> 
> This is different comment altogether.  Is the original wrong?

"Setup register values" sounds more like touching the registers.
But the function just caches them into a structure which will be
used later. I think mine is more accurate.

> >-/**
> >- * fsl_ssi_startup: create a new substream
> >- *
> >- * This is the first function called when a stream is opened.
> >- *
> >- * If this is the first stream open, then grab the IRQ and program most of
> >- * the SSI registers.
> >- */
> 
> What's wrong with this?

  * If this is the first stream open, then grab the IRQ and program most of
  * the SSI registers.

There is no corresponding code in this function any more.

> >- * fsl_ssi_hw_params - program the sample size
> >+ * Configure SSI based on PCM hardware parameters
> >   *
> >- * Most of the SSI registers have been programmed in the startup function,
> >- * but the word length must be programmed here.  Unfortunately, programming
> >- * the SxCCR.WL bits requires the SSI to be temporarily disabled.  This can
> >- * cause a problem with supporting simultaneous playback and capture.  If
> >- * the SSI is already playing a stream, then that stream may be temporarily
> >- * stopped when you start capture.
> >- *
> >- * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
> >- * clock master.
> >+ * Notes:
> >+ * 1) SxCCR.WL bits are critical bits that require SSI to be temporarily
> >+ *    disabled on offline_config SoCs. Even for online configurable SoCs
> >+ *    running in synchronous mode (both TX and RX use STCCR), it is not
> >+ *    safe to re-configure them when both two streams start running.
> >+ * 2) SxCCR.PM, SxCCR.DIV2 and SxCCR.PSR bits will be configured in the
> >+ *    fsl_ssi_set_bclk() if SSI is the DAI clock master.
> 
> I think the comment about the stream being temporarily stopped should be
> kept, since it was a real issue I spent a lot of time trying to debug.
> Unless it's been fixed, of course.

Mine also has "require SSI to be temporarily disabled".

> >   */
> >  static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
> >  	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
> >@@ -879,8 +795,10 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
> >  	enabled = scr_val & CCSR_SSI_SCR_SSIEN;
> >  	/*
> >-	 * If we're in synchronous mode, and the SSI is already enabled,
> >-	 * then STCCR is already set properly.
> >+	 * SSI is properly configured if it is enabled and running in
> >+	 * the synchronous mode; Note that AC97 mode is an exception
> >+	 * that should set separate configurations for STCCR and SRCCR
> >+	 * despite running in the synchronous mode.
> >  	 */
> >  	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
> >  		return 0;
> >@@ -902,10 +820,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
> >  	if (!fsl_ssi_is_ac97(ssi)) {
> >  		u8 i2smode;
> >-		/*
> >-		 * Switch to normal net mode in order to have a frame sync
> >-		 * signal every 32 bits instead of 16 bits
> >-		 */
> >+		/* Normal + Network mode to send 16-bit data in 32-bit frames */
> >  		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
> >  			i2smode = CCSR_SSI_SCR_I2S_MODE_NORMAL |
> >  				CCSR_SSI_SCR_NET;
> >@@ -917,16 +832,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
> >  				channels == 1 ? 0 : i2smode);
> >  	}
> >-	/*
> >-	 * FIXME: The documentation says that SxCCR[WL] should not be
> >-	 * modified while the SSI is enabled.  The only time this can
> >-	 * happen is if we're trying to do simultaneous playback and
> >-	 * capture in asynchronous mode.  Unfortunately, I have been enable
> >-	 * to get that to work at all on the P1022DS.  Therefore, we don't
> >-	 * bother to disable/enable the SSI when setting SxCCR[WL], because
> >-	 * the SSI will stop anyway.  Maybe one day, this will get fixed.
> >-	 */
> 
> Has this been fixed?  If not, then don't delete the comment.

The comments about WL is moved to the previous one that you just
reviewed. Besides, this is fixed since hw_params() returns the
2nd stream when running in the synchronous mode (you may take a
quick look at the driver code.)
 
> >-	 * Set the watermark for transmit FIFO 0 and receive FIFO 0. We don't
> >-	 * use FIFO 1 but set the watermark appropriately nontheless.
> >-	 * We program the transmit water to signal a DMA transfer
> >-	 * if there are N elements left in the FIFO. For chips with 15-deep
> >-	 * FIFOs, set watermark to 8.  This allows the SSI to operate at a
> >-	 * high data rate without channel slipping. Behavior is unchanged
> >-	 * for the older chips with a fifo depth of only 8.  A value of 4
> >-	 * might be appropriate for the older chips, but is left at
> >-	 * fifo_depth-2 until sombody has a chance to test.
> >+	 * Configure TX and RX DMA watermarks.
> >  	 *
> >-	 * We set the watermark on the same level as the DMA burstsize.  For
> >-	 * fiq it is probably better to use the biggest possible watermark
> >-	 * size.
> >+	 * Values should be tested to avoid FIFO under/over run. Set maxburst
> >+	 * to fifo_watermark to maxiumize DMA transaction to reduce overhead.
> 
> Why in the world would you delete all this good info?

Firstly, FIFO 1 is now being used on i.MX. Secondly, I have some
comments covering important part in my opinion. You may tell me
which part that I am missing here..

> >-	/*
> >-	 * If codec-handle property is missing from SSI node, we assume
> >-	 * that the machine driver uses new binding which does not require
> >-	 * SSI driver to trigger machine driver's probe.
> >-	 */
> >+	/* Bypass it if using newer DT bindings of ASoC machine drivers */
> 
> Not an improvement.

Simplification is an improvement in my opinion. And this is the
purpose of the whole set. Touching comments is a sensitive step
and I realized it before sending this patch. But I am willing to
take it as there probably won't be any second chance to do this
kinda cleanup again. If some of the changes made things worse or
even *destroyed* something, I'll definitely change it. Otherwise,
I would like to take this aggressive step.

Thanks
Nicolin
