Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF06CDDE43
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:15:20 +1100 (EST)
Subject: [PATCH] aoa i2sbus: Stop Apple i2s DMA gracefully
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 14:12:37 +0100
Message-Id: <1170940357.4385.46.camel@johannes.berg>
Mime-Version: 1.0
Cc: tiwai@suse.de, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

This fixes the problem of getting extra bytes inserted at the
beginning of a recording when using the Apple i2s interface and DBDMA
controller.  It turns out that we can't just abort the DMA; we have to
let it stop at the end of a command, and then wait for the S7 bit to
be set before turning off the DBDMA controller.  Doing that for
playback doesn't seem to be necessary, but doesn't hurt either.

We use the technique used by the Darwin driver: make each transfer
command branch to a stop command if the S0 status bit is set.  Thus we
can ask the DMA controller to stop at the end of the current command
by setting S0.

The interrupt routine now looks at and clears the status word of the
DBDMA command ring.  This is necessary so it can know when the DBDMA
controller has seen that S0 is set, and so when it should look for the
DBDMA controller being stopped and S7 being set.  This also ended up
simplifying the calculation in i2sbus_pcm_pointer.

Tested on a 15 inch albook.

Signed-off-by: Paul Mackerras <paulus@samba.org>

I modified this patch and added the suspend/resume bits to it to get my
powermac into a decent state when playing sound across suspend to disk
that has a different bitrate from what the firmware programs the
hardware to.

I also added the SNDRV_PCM_INFO_JOINT_DUPLEX flag because it seemed the
right thing to do and I was looking at the info stuff.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
The only relevant change that isn't related to suspend is this piece
(shown as interdiff here):

                        if (in_le32(&pi->dbdma->status) & ACTIVE) {
                                /* possible race here? */
                                udelay(10);
-                               if (in_le32(&pi->dbdma->status) & ACTIVE)
+                               if (in_le32(&pi->dbdma->status) & ACTIVE) {
+                                       pi->dbdma_ring.stopping = 0;
                                        goto out_unlock; /* keep running */
+                               }
                        }
                }

Takashi, please apply this to the alsa tree.

I had also wanted to add PAUSE capability but for some reason that
didn't do anything at all with the applications I used (aplay can't
pause, with mplayer and gstreamer it made no change) so I'll leave that
for when I know how to actually use it from userland and make a new
patch for it then.

--- linux-2.6-git.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2007-02-07 16:57:30.892952741 +0100
+++ linux-2.6-git/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2007-02-07 18:23:51.351935651 +0100
@@ -41,8 +41,8 @@ static int alloc_dbdma_descriptor_ring(s
 				       struct dbdma_command_mem *r,
 				       int numcmds)
 {
-	/* one more for rounding */
-	r->size = (numcmds+1) * sizeof(struct dbdma_cmd);
+	/* one more for rounding, one for branch back, one for stop command */
+	r->size = (numcmds + 3) * sizeof(struct dbdma_cmd);
 	/* We use the PCI APIs for now until the generic one gets fixed
 	 * enough or until we get some macio-specific versions
 	 */
@@ -377,11 +377,8 @@ static int i2sbus_suspend(struct macio_d
 		if (i2sdev->sound.pcm) {
 			/* Suspend PCM streams */
 			snd_pcm_suspend_all(i2sdev->sound.pcm);
-			/* Probably useless as we handle
-			 * power transitions ourselves */
-			snd_power_change_state(i2sdev->sound.pcm->card,
-					       SNDRV_CTL_POWER_D3hot);
 		}
+
 		/* Notify codecs */
 		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
 			err = 0;
@@ -390,7 +387,11 @@ static int i2sbus_suspend(struct macio_d
 			if (err)
 				ret = err;
 		}
+
+		/* wait until streams are stopped */
+		i2sbus_wait_for_stop_both(i2sdev);
 	}
+
 	return ret;
 }
 
@@ -402,6 +403,9 @@ static int i2sbus_resume(struct macio_de
 	int err, ret = 0;
 
 	list_for_each_entry(i2sdev, &control->list, item) {
+		/* reset i2s bus format etc. */
+		i2sbus_pcm_prepare_both(i2sdev);
+
 		/* Notify codecs so they can re-initialize */
 		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
 			err = 0;
@@ -410,12 +414,6 @@ static int i2sbus_resume(struct macio_de
 			if (err)
 				ret = err;
 		}
-		/* Notify Alsa */
-		if (i2sdev->sound.pcm) {
-			/* Same comment as above, probably useless */
-			snd_power_change_state(i2sdev->sound.pcm->card,
-					       SNDRV_CTL_POWER_D0);
-		}
 	}
 
 	return ret;
--- linux-2.6-git.orig/sound/aoa/soundbus/i2sbus/i2sbus-pcm.c	2007-02-07 16:57:23.522952741 +0100
+++ linux-2.6-git/sound/aoa/soundbus/i2sbus/i2sbus-pcm.c	2007-02-07 18:35:29.844933818 +0100
@@ -125,7 +125,8 @@ static int i2sbus_pcm_open(struct i2sbus
 	}
 	/* bus dependent stuff */
 	hw->info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		   SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_RESUME;
+		   SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_RESUME |
+		   SNDRV_PCM_INFO_JOINT_DUPLEX;
 
 	CHECK_RATE(5512);
 	CHECK_RATE(8000);
@@ -245,18 +246,78 @@ static int i2sbus_pcm_close(struct i2sbu
 	return err;
 }
 
+static void i2sbus_wait_for_stop(struct i2sbus_dev *i2sdev,
+				 struct pcm_info *pi)
+{
+	unsigned long flags;
+	struct completion done;
+	long timeout;
+
+	spin_lock_irqsave(&i2sdev->low_lock, flags);
+	if (pi->dbdma_ring.stopping) {
+		init_completion(&done);
+		pi->stop_completion = &done;
+		spin_unlock_irqrestore(&i2sdev->low_lock, flags);
+		timeout = wait_for_completion_timeout(&done, HZ);
+		spin_lock_irqsave(&i2sdev->low_lock, flags);
+		pi->stop_completion = NULL;
+		if (timeout == 0) {
+			/* timeout expired, stop dbdma forcefully */
+			printk(KERN_ERR "i2sbus_wait_for_stop: timed out\n");
+			/* make sure RUN, PAUSE and S0 bits are cleared */
+			out_le32(&pi->dbdma->control, (RUN | PAUSE | 1) << 16);
+			pi->dbdma_ring.stopping = 0;
+			timeout = 10;
+			while (in_le32(&pi->dbdma->status) & ACTIVE) {
+				if (--timeout <= 0)
+					break;
+				udelay(1);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&i2sdev->low_lock, flags);
+}
+
+#ifdef CONFIG_PM
+void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev)
+{
+	struct pcm_info *pi;
+
+	get_pcm_info(i2sdev, 0, &pi, NULL);
+	i2sbus_wait_for_stop(i2sdev, pi);
+	get_pcm_info(i2sdev, 1, &pi, NULL);
+	i2sbus_wait_for_stop(i2sdev, pi);
+}
+#endif
+
 static int i2sbus_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
 {
 	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 }
 
-static int i2sbus_hw_free(struct snd_pcm_substream *substream)
+static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 {
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+	struct pcm_info *pi;
+
+	get_pcm_info(i2sdev, in, &pi, NULL);
+	if (pi->dbdma_ring.stopping)
+		i2sbus_wait_for_stop(i2sdev, pi);
 	snd_pcm_lib_free_pages(substream);
 	return 0;
 }
 
+static int i2sbus_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	return i2sbus_hw_free(substream, 0);
+}
+
+static int i2sbus_record_hw_free(struct snd_pcm_substream *substream)
+{
+	return i2sbus_hw_free(substream, 1);
+}
+
 static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 {
 	/* whee. Hard work now. The user has selected a bitrate
@@ -264,7 +325,7 @@ static int i2sbus_pcm_prepare(struct i2s
 	 * I2S controller appropriately. */
 	struct snd_pcm_runtime *runtime;
 	struct dbdma_cmd *command;
-	int i, periodsize;
+	int i, periodsize, nperiods;
 	dma_addr_t offset;
 	struct bus_info bi;
 	struct codec_info_item *cii;
@@ -274,6 +335,7 @@ static int i2sbus_pcm_prepare(struct i2s
 	struct pcm_info *pi, *other;
 	int cnt;
 	int result = 0;
+	unsigned int cmd, stopaddr;
 
 	mutex_lock(&i2sdev->lock);
 
@@ -283,6 +345,13 @@ static int i2sbus_pcm_prepare(struct i2s
 		result = -EBUSY;
 		goto out_unlock;
 	}
+	if (pi->dbdma_ring.stopping)
+		i2sbus_wait_for_stop(i2sdev, pi);
+
+	if (!pi->substream || !pi->substream->runtime) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
 
 	runtime = pi->substream->runtime;
 	pi->active = 1;
@@ -297,24 +366,43 @@ static int i2sbus_pcm_prepare(struct i2s
 	i2sdev->rate = runtime->rate;
 
 	periodsize = snd_pcm_lib_period_bytes(pi->substream);
+	nperiods = pi->substream->runtime->periods;
 	pi->current_period = 0;
 
 	/* generate dbdma command ring first */
 	command = pi->dbdma_ring.cmds;
+	memset(command, 0, (nperiods + 2) * sizeof(struct dbdma_cmd));
+
+	/* commands to DMA to/from the ring */
+	/*
+	 * For input, we need to do a graceful stop; if we abort
+	 * the DMA, we end up with leftover bytes that corrupt
+	 * the next recording.  To do this we set the S0 status
+	 * bit and wait for the DMA controller to stop.  Each
+	 * command has a branch condition to
+	 * make it branch to a stop command if S0 is set.
+	 * On input we also need to wait for the S7 bit to be
+	 * set before turning off the DMA controller.
+	 * In fact we do the graceful stop for output as well.
+	 */
 	offset = runtime->dma_addr;
-	for (i = 0; i < pi->substream->runtime->periods;
-	     i++, command++, offset += periodsize) {
-		memset(command, 0, sizeof(struct dbdma_cmd));
-		command->command =
-		    cpu_to_le16((in ? INPUT_MORE : OUTPUT_MORE) | INTR_ALWAYS);
+	cmd = (in? INPUT_MORE: OUTPUT_MORE) | BR_IFSET | INTR_ALWAYS;
+	stopaddr = pi->dbdma_ring.bus_cmd_start +
+		(nperiods + 1) * sizeof(struct dbdma_cmd);
+	for (i = 0; i < nperiods; i++, command++, offset += periodsize) {
+		command->command = cpu_to_le16(cmd);
+		command->cmd_dep = cpu_to_le32(stopaddr);
 		command->phy_addr = cpu_to_le32(offset);
 		command->req_count = cpu_to_le16(periodsize);
-		command->xfer_status = cpu_to_le16(0);
 	}
-	/* last one branches back to first */
-	command--;
-	command->command |= cpu_to_le16(BR_ALWAYS);
+
+	/* branch back to beginning of ring */
+	command->command = cpu_to_le16(DBDMA_NOP | BR_ALWAYS);
 	command->cmd_dep = cpu_to_le32(pi->dbdma_ring.bus_cmd_start);
+	command++;
+
+	/* set stop command */
+	command->command = cpu_to_le16(DBDMA_STOP);
 
 	/* ok, let's set the serial format and stuff */
 	switch (runtime->format) {
@@ -435,16 +523,18 @@ static int i2sbus_pcm_prepare(struct i2s
 	return result;
 }
 
-static struct dbdma_cmd STOP_CMD = {
-	.command = __constant_cpu_to_le16(DBDMA_STOP),
-};
+#ifdef CONFIG_PM
+void i2sbus_pcm_prepare_both(struct i2sbus_dev *i2sdev)
+{
+	i2sbus_pcm_prepare(i2sdev, 0);
+	i2sbus_pcm_prepare(i2sdev, 1);
+}
+#endif
 
 static int i2sbus_pcm_trigger(struct i2sbus_dev *i2sdev, int in, int cmd)
 {
 	struct codec_info_item *cii;
 	struct pcm_info *pi;
-	int timeout;
-	struct dbdma_cmd tmp;
 	int result = 0;
 	unsigned long flags;
 
@@ -464,92 +554,50 @@ static int i2sbus_pcm_trigger(struct i2s
 				cii->codec->start(cii, pi->substream);
 		pi->dbdma_ring.running = 1;
 
-		/* reset dma engine */
-		out_le32(&pi->dbdma->control,
-			 0 | (RUN | PAUSE | FLUSH | WAKE) << 16);
-		timeout = 100;
-		while (in_le32(&pi->dbdma->status) & RUN && timeout--)
-			udelay(1);
-		if (timeout <= 0) {
-			printk(KERN_ERR
-			       "i2sbus: error waiting for dma reset\n");
-			result = -ENXIO;
-			goto out_unlock;
+		if (pi->dbdma_ring.stopping) {
+			/* Clear the S0 bit, then see if we stopped yet */
+			out_le32(&pi->dbdma->control, 1 << 16);
+			if (in_le32(&pi->dbdma->status) & ACTIVE) {
+				/* possible race here? */
+				udelay(10);
+				if (in_le32(&pi->dbdma->status) & ACTIVE) {
+					pi->dbdma_ring.stopping = 0;
+					goto out_unlock; /* keep running */
+				}
+			}
 		}
 
+		/* make sure RUN, PAUSE and S0 bits are cleared */
+		out_le32(&pi->dbdma->control, (RUN | PAUSE | 1) << 16);
+
+		/* set branch condition select register */
+		out_le32(&pi->dbdma->br_sel, (1 << 16) | 1);
+
 		/* write dma command buffer address to the dbdma chip */
 		out_le32(&pi->dbdma->cmdptr, pi->dbdma_ring.bus_cmd_start);
-		/* post PCI write */
-		mb();
-		(void)in_le32(&pi->dbdma->status);
-
-		/* change first command to STOP */
-		tmp = *pi->dbdma_ring.cmds;
-		*pi->dbdma_ring.cmds = STOP_CMD;
-
-		/* set running state, remember that the first command is STOP */
-		out_le32(&pi->dbdma->control, RUN | (RUN << 16));
-		timeout = 100;
-		/* wait for STOP to be executed */
-		while (in_le32(&pi->dbdma->status) & ACTIVE && timeout--)
-			udelay(1);
-		if (timeout <= 0) {
-			printk(KERN_ERR "i2sbus: error waiting for dma stop\n");
-			result = -ENXIO;
-			goto out_unlock;
-		}
-		/* again, write dma command buffer address to the dbdma chip,
-		 * this time of the first real command */
-		*pi->dbdma_ring.cmds = tmp;
-		out_le32(&pi->dbdma->cmdptr, pi->dbdma_ring.bus_cmd_start);
-		/* post write */
-		mb();
-		(void)in_le32(&pi->dbdma->status);
-
-		/* reset dma engine again */
-		out_le32(&pi->dbdma->control,
-			 0 | (RUN | PAUSE | FLUSH | WAKE) << 16);
-		timeout = 100;
-		while (in_le32(&pi->dbdma->status) & RUN && timeout--)
-			udelay(1);
-		if (timeout <= 0) {
-			printk(KERN_ERR
-			       "i2sbus: error waiting for dma reset\n");
-			result = -ENXIO;
-			goto out_unlock;
-		}
 
-		/* wake up the chip with the next descriptor */
-		out_le32(&pi->dbdma->control,
-			 (RUN | WAKE) | ((RUN | WAKE) << 16));
-		/* get the frame count  */
+		/* initialize the frame count and current period */
+		pi->current_period = 0;
 		pi->frame_count = in_le32(&i2sdev->intfregs->frame_count);
 
+		/* set the DMA controller running */
+		out_le32(&pi->dbdma->control, (RUN << 16) | RUN);
+
 		/* off you go! */
 		break;
+
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		if (!pi->dbdma_ring.running) {
 			result = -EALREADY;
 			goto out_unlock;
 		}
+		pi->dbdma_ring.running = 0;
 
-		/* turn off all relevant bits */
-		out_le32(&pi->dbdma->control,
-			 (RUN | WAKE | FLUSH | PAUSE) << 16);
-		{
-			/* FIXME: move to own function */
-			int timeout = 5000;
-			while ((in_le32(&pi->dbdma->status) & RUN)
-			       && --timeout > 0)
-				udelay(1);
-			if (!timeout)
-				printk(KERN_ERR
-				       "i2sbus: timed out turning "
-				       "off dbdma engine!\n");
-		}
+		/* Set the S0 bit to make the DMA branch to the stop cmd */
+		out_le32(&pi->dbdma->control, (1 << 16) | 1);
+		pi->dbdma_ring.stopping = 1;
 
-		pi->dbdma_ring.running = 0;
 		list_for_each_entry(cii, &i2sdev->sound.codec_list, list)
 			if (cii->codec->stop)
 				cii->codec->stop(cii, pi->substream);
@@ -574,70 +622,82 @@ static snd_pcm_uframes_t i2sbus_pcm_poin
 	fc = in_le32(&i2sdev->intfregs->frame_count);
 	fc = fc - pi->frame_count;
 
-	return (bytes_to_frames(pi->substream->runtime,
-			pi->current_period *
-			snd_pcm_lib_period_bytes(pi->substream))
-		+ fc) % pi->substream->runtime->buffer_size;
+	if (fc >= pi->substream->runtime->buffer_size)
+		fc %= pi->substream->runtime->buffer_size;
+	return fc;
 }
 
 static inline void handle_interrupt(struct i2sbus_dev *i2sdev, int in)
 {
 	struct pcm_info *pi;
-	u32 fc;
-	u32 delta;
+	u32 fc, nframes;
+	u32 status;
+	int timeout, i;
+	int dma_stopped = 0;
+	struct snd_pcm_runtime *runtime;
 
 	spin_lock(&i2sdev->low_lock);
 	get_pcm_info(i2sdev, in, &pi, NULL);
-
-	if (!pi->dbdma_ring.running) {
-		/* there was still an interrupt pending
-		 * while we stopped. or maybe another
-		 * processor (not the one that was stopping
-		 * the DMA engine) was spinning above
-		 * waiting for the lock. */
+	if (!pi->dbdma_ring.running && !pi->dbdma_ring.stopping)
 		goto out_unlock;
-	}
-
-	fc = in_le32(&i2sdev->intfregs->frame_count);
-	/* a counter overflow does not change the calculation. */
-	delta = fc - pi->frame_count;
 
-	/* update current_period */
-	while (delta >= pi->substream->runtime->period_size) {
-		pi->current_period++;
-		delta = delta - pi->substream->runtime->period_size;
-	}
-
-	if (unlikely(delta)) {
-		/* Some interrupt came late, so check the dbdma.
-		 * This special case exists to syncronize the frame_count with
-		 * the dbdma transfer, but is hit every once in a while. */
-		int period;
-
-		period = (in_le32(&pi->dbdma->cmdptr)
-		        - pi->dbdma_ring.bus_cmd_start)
-				/ sizeof(struct dbdma_cmd);
-		pi->current_period = pi->current_period
-					% pi->substream->runtime->periods;
-
-		while (pi->current_period != period) {
-			pi->current_period++;
-			pi->current_period %= pi->substream->runtime->periods;
-			/* Set delta to zero, as the frame_count value is too
-			 * high (otherwise the code path will not be executed).
-			 * This corrects the fact that the frame_count is too
-			 * low at the beginning due to buffering. */
-			delta = 0;
+	i = pi->current_period;
+	runtime = pi->substream->runtime;
+	while (pi->dbdma_ring.cmds[i].xfer_status) {
+		if (le16_to_cpu(pi->dbdma_ring.cmds[i].xfer_status) & BT)
+			/*
+			 * BT is the branch taken bit.  If it took a branch
+			 * it is because we set the S0 bit to make it
+			 * branch to the stop command.
+			 */
+			dma_stopped = 1;
+		pi->dbdma_ring.cmds[i].xfer_status = 0;
+
+		if (++i >= runtime->periods) {
+			i = 0;
+			pi->frame_count += runtime->buffer_size;
+		}
+		pi->current_period = i;
+
+		/*
+		 * Check the frame count.  The DMA tends to get a bit
+		 * ahead of the frame counter, which confuses the core.
+		 */
+		fc = in_le32(&i2sdev->intfregs->frame_count);
+		nframes = i * runtime->period_size;
+		if (fc < pi->frame_count + nframes)
+			pi->frame_count = fc - nframes;
+	}
+
+	if (dma_stopped) {
+		timeout = 1000;
+		for (;;) {
+			status = in_le32(&pi->dbdma->status);
+			if (!(status & ACTIVE) && (!in || (status & 0x80)))
+				break;
+			if (--timeout <= 0) {
+				printk(KERN_ERR "i2sbus: timed out "
+				       "waiting for DMA to stop!\n");
+				break;
+			}
+			udelay(1);
 		}
-	}
 
-	pi->frame_count = fc - delta;
-	pi->current_period %= pi->substream->runtime->periods;
+		/* Turn off DMA controller, clear S0 bit */
+		out_le32(&pi->dbdma->control, (RUN | PAUSE | 1) << 16);
 
+		pi->dbdma_ring.stopping = 0;
+		if (pi->stop_completion)
+			complete(pi->stop_completion);
+	}
+
+	if (!pi->dbdma_ring.running)
+		goto out_unlock;
 	spin_unlock(&i2sdev->low_lock);
 	/* may call _trigger again, hence needs to be unlocked */
 	snd_pcm_period_elapsed(pi->substream);
 	return;
+
  out_unlock:
 	spin_unlock(&i2sdev->low_lock);
 }
@@ -718,7 +778,7 @@ static struct snd_pcm_ops i2sbus_playbac
 	.close =	i2sbus_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	i2sbus_hw_params,
-	.hw_free =	i2sbus_hw_free,
+	.hw_free =	i2sbus_playback_hw_free,
 	.prepare =	i2sbus_playback_prepare,
 	.trigger =	i2sbus_playback_trigger,
 	.pointer =	i2sbus_playback_pointer,
@@ -788,7 +848,7 @@ static struct snd_pcm_ops i2sbus_record_
 	.close =	i2sbus_record_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	i2sbus_hw_params,
-	.hw_free =	i2sbus_hw_free,
+	.hw_free =	i2sbus_record_hw_free,
 	.prepare =	i2sbus_record_prepare,
 	.trigger =	i2sbus_record_trigger,
 	.pointer =	i2sbus_record_pointer,
--- linux-2.6-git.orig/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-12-06 12:18:26.000000000 +0100
+++ linux-2.6-git/sound/aoa/soundbus/i2sbus/i2sbus.h	2007-02-07 18:07:02.209802252 +0100
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/completion.h>
 
 #include <sound/pcm.h>
 
@@ -34,6 +35,7 @@ struct dbdma_command_mem {
 	void *space;
 	int size;
 	u32 running:1;
+	u32 stopping:1;
 };
 
 struct pcm_info {
@@ -45,6 +47,7 @@ struct pcm_info {
 	u32 frame_count;
 	struct dbdma_command_mem dbdma_ring;
 	volatile struct dbdma_regs __iomem *dbdma;
+	struct completion *stop_completion;
 };
 
 enum {
@@ -101,6 +104,9 @@ i2sbus_tx_intr(int irq, void *devid);
 extern irqreturn_t
 i2sbus_rx_intr(int irq, void *devid);
 
+extern void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev);
+extern void i2sbus_pcm_prepare_both(struct i2sbus_dev *i2sdev);
+
 /* control specific functions */
 extern int i2sbus_control_init(struct macio_dev* dev,
 			       struct i2sbus_control **c);
