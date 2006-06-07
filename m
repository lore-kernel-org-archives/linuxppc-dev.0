Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32C9A67E75
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:12:01 +1000 (EST)
Message-Id: <20060607130913.414650000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Date: Wed, 07 Jun 2006 15:09:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 05/12] snd-aoa: add i2sbus
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the required files for i2sbus (the Makefile hook and the
Kconfig item were already added in the previous patch). i2sbus is the module
that handles the i2s busses on newer Apple machines, currently only handling
those machines that have all the required information in the device tree.

--- /dev/null
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-control.h
@@ -0,0 +1,37 @@
+/*
+ * i2sbus driver -- bus register definitions
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+#ifndef __I2SBUS_CONTROLREGS_H
+#define __I2SBUS_CONTROLREGS_H
+
+/* i2s control registers, at least what we know about them */
+
+#define __PAD(m,n) u8 __pad##m[n]
+#define _PAD(line, n) __PAD(line, n)
+#define PAD(n) _PAD(__LINE__, (n))
+struct i2s_control_regs {
+	PAD(0x38);
+	__le32 fcr0;		/* 0x38 (unknown) */
+	__le32 cell_control;	/* 0x3c (fcr1) */
+	__le32 fcr2;		/* 0x40 (unknown) */
+	__le32 fcr3;		/* 0x44 (fcr3) */
+	__le32 clock_control;	/* 0x48 (unknown) */
+	PAD(4);
+	/* total size: 0x50 bytes */
+}  __attribute__((__packed__));
+
+#define CTRL_CLOCK_CELL_0_ENABLE	(1<<10)
+#define CTRL_CLOCK_CLOCK_0_ENABLE	(1<<12)
+#define CTRL_CLOCK_SWRESET_0		(1<<11)
+#define CTRL_CLOCK_INTF_0_ENABLE	(1<<13)
+
+#define CTRL_CLOCK_CELL_1_ENABLE	(1<<17)
+#define CTRL_CLOCK_CLOCK_1_ENABLE	(1<<18)
+#define CTRL_CLOCK_SWRESET_1		(1<<19)
+#define CTRL_CLOCK_INTF_1_ENABLE	(1<<20)
+
+#endif /* __I2SBUS_CONTROLREGS_H */
--- /dev/null
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-pcm.c
@@ -0,0 +1,1017 @@
+/*
+ * i2sbus driver -- pcm routines
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+
+#include <asm/io.h>
+#include <linux/delay.h>
+/* So apparently there's a reason for requiring driver.h
+ * to be included first, even if I don't know it... */
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <asm/macio.h>
+#include <linux/pci.h>
+#include "../soundbus.h"
+#include "i2sbus.h"
+
+static inline void get_pcm_info(struct i2sbus_dev *i2sdev, int in,
+				struct pcm_info **pi, struct pcm_info **other)
+{
+	if (in) {
+		if (pi)
+			*pi = &i2sdev->in;
+		if (other)
+			*other = &i2sdev->out;
+	} else {
+		if (pi)
+			*pi = &i2sdev->out;
+		if (other)
+			*other = &i2sdev->in;
+	}
+}
+
+static int clock_and_divisors(int mclk, int sclk, int rate, int *out)
+{
+	/* sclk must be derived from mclk! */
+	if (mclk % sclk)
+		return -1;
+	/* derive sclk register value */
+	if (i2s_sf_sclkdiv(mclk / sclk, out))
+		return -1;
+
+	if (I2S_CLOCK_SPEED_18MHz % (rate * mclk) == 0) {
+		if (!i2s_sf_mclkdiv(I2S_CLOCK_SPEED_18MHz / rate / mclk, out)) {
+			*out |= I2S_SF_CLOCK_SOURCE_18MHz;
+			return 0;
+		}
+	}
+	if (I2S_CLOCK_SPEED_45MHz % (rate * mclk) == 0) {
+		if (!i2s_sf_mclkdiv(I2S_CLOCK_SPEED_45MHz / rate / mclk, out)) {
+			*out |= I2S_SF_CLOCK_SOURCE_45MHz;
+			return 0;
+		}
+	}
+	if (I2S_CLOCK_SPEED_49MHz % (rate * mclk) == 0) {
+		if (!i2s_sf_mclkdiv(I2S_CLOCK_SPEED_49MHz / rate / mclk, out)) {
+			*out |= I2S_SF_CLOCK_SOURCE_49MHz;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+#define CHECK_RATE(rate)						\
+	do { if (rates & SNDRV_PCM_RATE_ ##rate) {			\
+		int dummy;						\
+		if (clock_and_divisors(sysclock_factor,			\
+				       bus_factor, rate, &dummy))	\
+			rates &= ~SNDRV_PCM_RATE_ ##rate;		\
+	} } while (0)
+
+static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
+{
+	struct pcm_info *pi, *other;
+	struct soundbus_dev *sdev;
+	int masks_inited = 0, err;
+	struct codec_info_item *cii, *rev;
+	struct snd_pcm_hardware *hw;
+	u64 formats = 0;
+	unsigned int rates = 0;
+	struct transfer_info v;
+	int result = 0;
+	int bus_factor = 0, sysclock_factor = 0;
+	int found_this;
+
+	mutex_lock(&i2sdev->lock);
+
+	get_pcm_info(i2sdev, in, &pi, &other);
+
+	hw = &pi->substream->runtime->hw;
+	sdev = &i2sdev->sound;
+
+	if (pi->active) {
+		/* alsa messed up */
+		result = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* we now need to assign the hw */
+	list_for_each_entry(cii, &sdev->codec_list, list) {
+		struct transfer_info *ti = cii->codec->transfers;
+		bus_factor = cii->codec->bus_factor;
+		sysclock_factor = cii->codec->sysclock_factor;
+		while (ti->formats && ti->rates) {
+			v = *ti;
+			if (ti->transfer_in == in
+			    && cii->codec->usable(cii, ti, &v)) {
+				if (masks_inited) {
+					formats &= v.formats;
+					rates &= v.rates;
+				} else {
+					formats = v.formats;
+					rates = v.rates;
+					masks_inited = 1;
+				}
+			}
+			ti++;
+		}
+	}
+	if (!masks_inited || !bus_factor || !sysclock_factor) {
+		result = -ENODEV;
+		goto out_unlock;
+	}
+	/* bus dependent stuff */
+	hw->info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+		   SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_RESUME;
+
+	CHECK_RATE(5512);
+	CHECK_RATE(8000);
+	CHECK_RATE(11025);
+	CHECK_RATE(16000);
+	CHECK_RATE(22050);
+	CHECK_RATE(32000);
+	CHECK_RATE(44100);
+	CHECK_RATE(48000);
+	CHECK_RATE(64000);
+	CHECK_RATE(88200);
+	CHECK_RATE(96000);
+	CHECK_RATE(176400);
+	CHECK_RATE(192000);
+	hw->rates = rates;
+
+	/* well. the codec might want 24 bits only, and we'll
+	 * ever only transfer 24 bits, but they are top-aligned!
+	 * So for alsa, we claim that we're doing full 32 bit
+	 * while in reality we'll ignore the lower 8 bits of
+	 * that when doing playback (they're transferred as 0
+	 * as far as I know, no codecs we have are 32-bit capable
+	 * so I can't really test) and when doing recording we'll
+	 * always have those lower 8 bits recorded as 0 */
+	if (formats & SNDRV_PCM_FMTBIT_S24_BE)
+		formats |= SNDRV_PCM_FMTBIT_S32_BE;
+	if (formats & SNDRV_PCM_FMTBIT_U24_BE)
+		formats |= SNDRV_PCM_FMTBIT_U32_BE;
+	/* now mask off what we can support. I suppose we could
+	 * also support S24_3LE and some similar formats, but I
+	 * doubt there's a codec that would be able to use that,
+	 * so we don't support it here. */
+	hw->formats = formats & (SNDRV_PCM_FMTBIT_S16_BE |
+				 SNDRV_PCM_FMTBIT_U16_BE |
+				 SNDRV_PCM_FMTBIT_S32_BE |
+				 SNDRV_PCM_FMTBIT_U32_BE);
+
+	/* we need to set the highest and lowest rate possible.
+	 * These are the highest and lowest rates alsa can
+	 * support properly in its bitfield.
+	 * Below, we'll use that to restrict to the rate
+	 * currently in use (if any). */
+	hw->rate_min = 5512;
+	hw->rate_max = 192000;
+	/* if the other stream is active, then we can only
+	 * support what it is currently using.
+	 * FIXME: I lied. This comment is wrong. We can support
+	 * anything that works with the same serial format, ie.
+	 * when recording 24 bit sound we can well play 16 bit
+	 * sound at the same time iff using the same transfer mode.
+	 */
+	if (other->active) {
+		/* FIXME: is this guaranteed by the alsa api? */
+		hw->formats &= (1ULL << i2sdev->format);
+		/* see above, restrict rates to the one we already have */
+		hw->rate_min = i2sdev->rate;
+		hw->rate_max = i2sdev->rate;
+	}
+
+	hw->channels_min = 2;
+	hw->channels_max = 2;
+	/* these are somewhat arbitrary */
+	hw->buffer_bytes_max = 131072;
+	hw->period_bytes_min = 256;
+	hw->period_bytes_max = 16384;
+	hw->periods_min = 3;
+	hw->periods_max = MAX_DBDMA_COMMANDS;
+	list_for_each_entry(cii, &sdev->codec_list, list) {
+		if (cii->codec->open) {
+			err = cii->codec->open(cii, pi->substream);
+			if (err) {
+				result = err;
+				/* unwind */
+				found_this = 0;
+				list_for_each_entry_reverse(rev,
+				    &sdev->codec_list, list) {
+					if (found_this && rev->codec->close) {
+						rev->codec->close(rev,
+								pi->substream);
+					}
+					if (rev == cii)
+						found_this = 1;
+				}
+				goto out_unlock;
+			}
+		}
+	}
+
+ out_unlock:
+	mutex_unlock(&i2sdev->lock);
+	return result;
+}
+
+#undef CHECK_RATE
+
+static int i2sbus_pcm_close(struct i2sbus_dev *i2sdev, int in)
+{
+	struct codec_info_item *cii;
+	struct pcm_info *pi;
+	int err = 0, tmp;
+
+	mutex_lock(&i2sdev->lock);
+
+	get_pcm_info(i2sdev, in, &pi, NULL);
+
+	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
+		if (cii->codec->close) {
+			tmp = cii->codec->close(cii, pi->substream);
+			if (tmp)
+				err = tmp;
+		}
+	}
+
+	pi->substream = NULL;
+	pi->active = 0;
+	mutex_unlock(&i2sdev->lock);
+	return err;
+}
+
+static int i2sbus_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+}
+
+static int i2sbus_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_lib_free_pages(substream);
+	return 0;
+}
+
+static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
+{
+	/* whee. Hard work now. The user has selected a bitrate
+	 * and bit format, so now we have to program our
+	 * I2S controller appropriately. */
+	struct snd_pcm_runtime *runtime;
+	struct dbdma_cmd *command;
+	int i, periodsize;
+	dma_addr_t offset;
+	struct bus_info bi;
+	struct codec_info_item *cii;
+	int sfr = 0;		/* serial format register */
+	int dws = 0;		/* data word sizes reg */
+	int input_16bit;
+	struct pcm_info *pi, *other;
+	int cnt;
+	int result = 0;
+
+	mutex_lock(&i2sdev->lock);
+
+	get_pcm_info(i2sdev, in, &pi, &other);
+
+	if (pi->dbdma_ring.running) {
+		result = -EBUSY;
+		goto out_unlock;
+	}
+
+	runtime = pi->substream->runtime;
+	pi->active = 1;
+	if (other->active &&
+	    ((i2sdev->format != runtime->format)
+	     || (i2sdev->rate != runtime->rate))) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
+
+	i2sdev->format = runtime->format;
+	i2sdev->rate = runtime->rate;
+
+	periodsize = snd_pcm_lib_period_bytes(pi->substream);
+	pi->current_period = 0;
+
+	/* generate dbdma command ring first */
+	command = pi->dbdma_ring.cmds;
+	offset = runtime->dma_addr;
+	for (i = 0; i < pi->substream->runtime->periods;
+	     i++, command++, offset += periodsize) {
+		memset(command, 0, sizeof(struct dbdma_cmd));
+		command->command =
+		    cpu_to_le16((in ? INPUT_MORE : OUTPUT_MORE) | INTR_ALWAYS);
+		command->phy_addr = cpu_to_le32(offset);
+		command->req_count = cpu_to_le16(periodsize);
+		command->xfer_status = cpu_to_le16(0);
+	}
+	/* last one branches back to first */
+	command--;
+	command->command |= cpu_to_le16(BR_ALWAYS);
+	command->cmd_dep = cpu_to_le32(pi->dbdma_ring.bus_cmd_start);
+
+	/* ok, let's set the serial format and stuff */
+	switch (runtime->format) {
+	/* 16 bit formats */
+	case SNDRV_PCM_FORMAT_S16_BE:
+	case SNDRV_PCM_FORMAT_U16_BE:
+		/* FIXME: if we add different bus factors we need to
+		 * do more here!! */
+		bi.bus_factor = 0;
+		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
+			bi.bus_factor = cii->codec->bus_factor;
+			break;
+		}
+		if (!bi.bus_factor) {
+			result = -ENODEV;
+			goto out_unlock;
+		}
+		input_16bit = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S32_BE:
+	case SNDRV_PCM_FORMAT_U32_BE:
+		/* force 64x bus speed, otherwise the data cannot be
+		 * transferred quickly enough! */
+		bi.bus_factor = 64;
+		input_16bit = 0;
+		break;
+	default:
+		result = -EINVAL;
+		goto out_unlock;
+	}
+	/* we assume all sysclocks are the same! */
+	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
+		bi.sysclock_factor = cii->codec->sysclock_factor;
+		break;
+	}
+
+	if (clock_and_divisors(bi.sysclock_factor,
+			       bi.bus_factor,
+			       runtime->rate,
+			       &sfr) < 0) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
+	switch (bi.bus_factor) {
+	case 32:
+		sfr |= I2S_SF_SERIAL_FORMAT_I2S_32X;
+		break;
+	case 64:
+		sfr |= I2S_SF_SERIAL_FORMAT_I2S_64X;
+		break;
+	}
+	/* FIXME: THIS ASSUMES MASTER ALL THE TIME */
+	sfr |= I2S_SF_SCLK_MASTER;
+
+	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
+		int err = 0;
+		if (cii->codec->prepare)
+			err = cii->codec->prepare(cii, &bi, pi->substream);
+		if (err) {
+			result = err;
+			goto out_unlock;
+		}
+	}
+	/* codecs are fine with it, so set our clocks */
+	if (input_16bit)
+		dws =	(2 << I2S_DWS_NUM_CHANNELS_IN_SHIFT) |
+			(2 << I2S_DWS_NUM_CHANNELS_OUT_SHIFT) |
+			I2S_DWS_DATA_IN_16BIT | I2S_DWS_DATA_OUT_16BIT;
+	else
+		dws =	(2 << I2S_DWS_NUM_CHANNELS_IN_SHIFT) |
+			(2 << I2S_DWS_NUM_CHANNELS_OUT_SHIFT) |
+			I2S_DWS_DATA_IN_24BIT | I2S_DWS_DATA_OUT_24BIT;
+
+	/* early exit if already programmed correctly */
+	/* not locking these is fine since we touch them only in this function */
+	if (in_le32(&i2sdev->intfregs->serial_format) == sfr
+	 && in_le32(&i2sdev->intfregs->data_word_sizes) == dws)
+		goto out_unlock;
+
+	/* let's notify the codecs about clocks going away.
+	 * For now we only do mastering on the i2s cell... */
+	list_for_each_entry(cii, &i2sdev->sound.codec_list, list)
+		if (cii->codec->switch_clock)
+			cii->codec->switch_clock(cii, CLOCK_SWITCH_PREPARE_SLAVE);
+
+	i2sbus_control_enable(i2sdev->control, i2sdev);
+	i2sbus_control_cell(i2sdev->control, i2sdev, 1);
+
+	out_le32(&i2sdev->intfregs->intr_ctl, I2S_PENDING_CLOCKS_STOPPED);
+
+	i2sbus_control_clock(i2sdev->control, i2sdev, 0);
+
+	msleep(1);
+
+	/* wait for clock stopped. This can apparently take a while... */
+	cnt = 100;
+	while (cnt-- &&
+	    !(in_le32(&i2sdev->intfregs->intr_ctl) & I2S_PENDING_CLOCKS_STOPPED)) {
+		msleep(5);
+	}
+	out_le32(&i2sdev->intfregs->intr_ctl, I2S_PENDING_CLOCKS_STOPPED);
+
+	/* not locking these is fine since we touch them only in this function */
+	out_le32(&i2sdev->intfregs->serial_format, sfr);
+	out_le32(&i2sdev->intfregs->data_word_sizes, dws);
+
+        i2sbus_control_enable(i2sdev->control, i2sdev);
+        i2sbus_control_cell(i2sdev->control, i2sdev, 1);
+        i2sbus_control_clock(i2sdev->control, i2sdev, 1);
+	msleep(1);
+
+	list_for_each_entry(cii, &i2sdev->sound.codec_list, list)
+		if (cii->codec->switch_clock)
+			cii->codec->switch_clock(cii, CLOCK_SWITCH_SLAVE);
+
+ out_unlock:
+	mutex_unlock(&i2sdev->lock);
+	return result;
+}
+
+static struct dbdma_cmd STOP_CMD = {
+	.command = __constant_cpu_to_le16(DBDMA_STOP),
+};
+
+static int i2sbus_pcm_trigger(struct i2sbus_dev *i2sdev, int in, int cmd)
+{
+	struct codec_info_item *cii;
+	struct pcm_info *pi;
+	int timeout;
+	struct dbdma_cmd tmp;
+	int result = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2sdev->low_lock, flags);
+
+	get_pcm_info(i2sdev, in, &pi, NULL);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		if (pi->dbdma_ring.running) {
+			result = -EALREADY;
+			goto out_unlock;
+		}
+		list_for_each_entry(cii, &i2sdev->sound.codec_list, list)
+			if (cii->codec->start)
+				cii->codec->start(cii, pi->substream);
+		pi->dbdma_ring.running = 1;
+
+		/* reset dma engine */
+		out_le32(&pi->dbdma->control,
+			 0 | (RUN | PAUSE | FLUSH | WAKE) << 16);
+		timeout = 100;
+		while (in_le32(&pi->dbdma->status) & RUN && timeout--)
+			udelay(1);
+		if (timeout <= 0) {
+			printk(KERN_ERR
+			       "i2sbus: error waiting for dma reset\n");
+			result = -ENXIO;
+			goto out_unlock;
+		}
+
+		/* write dma command buffer address to the dbdma chip */
+		out_le32(&pi->dbdma->cmdptr, pi->dbdma_ring.bus_cmd_start);
+		/* post PCI write */
+		mb();
+		(void)in_le32(&pi->dbdma->status);
+
+		/* change first command to STOP */
+		tmp = *pi->dbdma_ring.cmds;
+		*pi->dbdma_ring.cmds = STOP_CMD;
+
+		/* set running state, remember that the first command is STOP */
+		out_le32(&pi->dbdma->control, RUN | (RUN << 16));
+		timeout = 100;
+		/* wait for STOP to be executed */
+		while (in_le32(&pi->dbdma->status) & ACTIVE && timeout--)
+			udelay(1);
+		if (timeout <= 0) {
+			printk(KERN_ERR "i2sbus: error waiting for dma stop\n");
+			result = -ENXIO;
+			goto out_unlock;
+		}
+		/* again, write dma command buffer address to the dbdma chip,
+		 * this time of the first real command */
+		*pi->dbdma_ring.cmds = tmp;
+		out_le32(&pi->dbdma->cmdptr, pi->dbdma_ring.bus_cmd_start);
+		/* post write */
+		mb();
+		(void)in_le32(&pi->dbdma->status);
+
+		/* reset dma engine again */
+		out_le32(&pi->dbdma->control,
+			 0 | (RUN | PAUSE | FLUSH | WAKE) << 16);
+		timeout = 100;
+		while (in_le32(&pi->dbdma->status) & RUN && timeout--)
+			udelay(1);
+		if (timeout <= 0) {
+			printk(KERN_ERR
+			       "i2sbus: error waiting for dma reset\n");
+			result = -ENXIO;
+			goto out_unlock;
+		}
+
+		/* wake up the chip with the next descriptor */
+		out_le32(&pi->dbdma->control,
+			 (RUN | WAKE) | ((RUN | WAKE) << 16));
+		/* get the frame count  */
+		pi->frame_count = in_le32(&i2sdev->intfregs->frame_count);
+
+		/* off you go! */
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (!pi->dbdma_ring.running) {
+			result = -EALREADY;
+			goto out_unlock;
+		}
+
+		/* turn off all relevant bits */
+		out_le32(&pi->dbdma->control,
+			 (RUN | WAKE | FLUSH | PAUSE) << 16);
+		{
+			/* FIXME: move to own function */
+			int timeout = 5000;
+			while ((in_le32(&pi->dbdma->status) & RUN)
+			       && --timeout > 0)
+				udelay(1);
+			if (!timeout)
+				printk(KERN_ERR
+				       "i2sbus: timed out turning "
+				       "off dbdma engine!\n");
+		}
+
+		pi->dbdma_ring.running = 0;
+		list_for_each_entry(cii, &i2sdev->sound.codec_list, list)
+			if (cii->codec->stop)
+				cii->codec->stop(cii, pi->substream);
+		break;
+	default:
+		result = -EINVAL;
+		goto out_unlock;
+	}
+
+ out_unlock:
+	spin_unlock_irqrestore(&i2sdev->low_lock, flags);
+	return result;
+}
+
+static snd_pcm_uframes_t i2sbus_pcm_pointer(struct i2sbus_dev *i2sdev, int in)
+{
+	struct pcm_info *pi;
+	u32 fc;
+
+	get_pcm_info(i2sdev, in, &pi, NULL);
+
+	fc = in_le32(&i2sdev->intfregs->frame_count);
+	fc = fc - pi->frame_count;
+
+	return (bytes_to_frames(pi->substream->runtime,
+			pi->current_period *
+			snd_pcm_lib_period_bytes(pi->substream))
+		+ fc) % pi->substream->runtime->buffer_size;
+}
+
+static inline void handle_interrupt(struct i2sbus_dev *i2sdev, int in)
+{
+	struct pcm_info *pi;
+	u32 fc;
+	u32 delta;
+
+	spin_lock(&i2sdev->low_lock);
+	get_pcm_info(i2sdev, in, &pi, NULL);
+	if (!pi->substream) {
+		printk(KERN_INFO "i2sbus: got %s irq while not active!\n",
+		       in ? "rx" : "tx");
+		goto out_unlock;
+	}
+
+	fc = in_le32(&i2sdev->intfregs->frame_count);
+	/* a counter overflow does not change the calculation. */
+	delta = fc - pi->frame_count;
+
+	/* update current_period */
+	while (delta >= pi->substream->runtime->period_size) {
+		pi->current_period++;
+		delta = delta - pi->substream->runtime->period_size;
+	}
+
+	if (unlikely(delta)) {
+		/* Some interrupt came late, so check the dbdma.
+		 * This special case exists to syncronize the frame_count with
+		 * the dbdma transfer, but is hit every once in a while. */
+		int period;
+
+		period = (in_le32(&pi->dbdma->cmdptr)
+		        - pi->dbdma_ring.bus_cmd_start)
+				/ sizeof(struct dbdma_cmd);
+		pi->current_period = pi->current_period
+					% pi->substream->runtime->periods;
+
+		while (pi->current_period != period) {
+			pi->current_period++;
+			pi->current_period %= pi->substream->runtime->periods;
+			/* Set delta to zero, as the frame_count value is too
+			 * high (otherwise the code path will not be executed).
+			 * This corrects the fact that the frame_count is too
+			 * low at the beginning due to buffering. */
+			delta = 0;
+		}
+	}
+
+	pi->frame_count = fc - delta;
+	pi->current_period %= pi->substream->runtime->periods;
+
+	spin_unlock(&i2sdev->low_lock);
+	/* may call _trigger again, hence needs to be unlocked */
+	snd_pcm_period_elapsed(pi->substream);
+	return;
+ out_unlock:
+	spin_unlock(&i2sdev->low_lock);
+}
+
+irqreturn_t i2sbus_tx_intr(int irq, void *devid, struct pt_regs *regs)
+{
+	handle_interrupt((struct i2sbus_dev *)devid, 0);
+	return IRQ_HANDLED;
+}
+
+irqreturn_t i2sbus_rx_intr(int irq, void *devid, struct pt_regs * regs)
+{
+	handle_interrupt((struct i2sbus_dev *)devid, 1);
+	return IRQ_HANDLED;
+}
+
+static int i2sbus_playback_open(struct snd_pcm_substream *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	i2sdev->out.substream = substream;
+	return i2sbus_pcm_open(i2sdev, 0);
+}
+
+static int i2sbus_playback_close(struct snd_pcm_substream *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+	int err;
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->out.substream != substream)
+		return -EINVAL;
+	err = i2sbus_pcm_close(i2sdev, 0);
+	if (!err)
+		i2sdev->out.substream = NULL;
+	return err;
+}
+
+static int i2sbus_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->out.substream != substream)
+		return -EINVAL;
+	return i2sbus_pcm_prepare(i2sdev, 0);
+}
+
+static int i2sbus_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->out.substream != substream)
+		return -EINVAL;
+	return i2sbus_pcm_trigger(i2sdev, 0, cmd);
+}
+
+static snd_pcm_uframes_t i2sbus_playback_pointer(struct snd_pcm_substream
+						 *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->out.substream != substream)
+		return 0;
+	return i2sbus_pcm_pointer(i2sdev, 0);
+}
+
+static struct snd_pcm_ops i2sbus_playback_ops = {
+	.open =		i2sbus_playback_open,
+	.close =	i2sbus_playback_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	i2sbus_hw_params,
+	.hw_free =	i2sbus_hw_free,
+	.prepare =	i2sbus_playback_prepare,
+	.trigger =	i2sbus_playback_trigger,
+	.pointer =	i2sbus_playback_pointer,
+};
+
+static int i2sbus_record_open(struct snd_pcm_substream *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	i2sdev->in.substream = substream;
+	return i2sbus_pcm_open(i2sdev, 1);
+}
+
+static int i2sbus_record_close(struct snd_pcm_substream *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+	int err;
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->in.substream != substream)
+		return -EINVAL;
+	err = i2sbus_pcm_close(i2sdev, 1);
+	if (!err)
+		i2sdev->in.substream = NULL;
+	return err;
+}
+
+static int i2sbus_record_prepare(struct snd_pcm_substream *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->in.substream != substream)
+		return -EINVAL;
+	return i2sbus_pcm_prepare(i2sdev, 1);
+}
+
+static int i2sbus_record_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->in.substream != substream)
+		return -EINVAL;
+	return i2sbus_pcm_trigger(i2sdev, 1, cmd);
+}
+
+static snd_pcm_uframes_t i2sbus_record_pointer(struct snd_pcm_substream
+					       *substream)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
+
+	if (!i2sdev)
+		return -EINVAL;
+	if (i2sdev->in.substream != substream)
+		return 0;
+	return i2sbus_pcm_pointer(i2sdev, 1);
+}
+
+static struct snd_pcm_ops i2sbus_record_ops = {
+	.open =		i2sbus_record_open,
+	.close =	i2sbus_record_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	i2sbus_hw_params,
+	.hw_free =	i2sbus_hw_free,
+	.prepare =	i2sbus_record_prepare,
+	.trigger =	i2sbus_record_trigger,
+	.pointer =	i2sbus_record_pointer,
+};
+
+static void i2sbus_private_free(struct snd_pcm *pcm)
+{
+	struct i2sbus_dev *i2sdev = snd_pcm_chip(pcm);
+	struct codec_info_item *p, *tmp;
+
+	i2sdev->sound.pcm = NULL;
+	i2sdev->out.created = 0;
+	i2sdev->in.created = 0;
+	list_for_each_entry_safe(p, tmp, &i2sdev->sound.codec_list, list) {
+		printk(KERN_ERR "i2sbus: a codec didn't unregister!\n");
+		list_del(&p->list);
+		module_put(p->codec->owner);
+		kfree(p);
+	}
+	soundbus_dev_put(&i2sdev->sound);
+	module_put(THIS_MODULE);
+}
+
+/* FIXME: this function needs an error handling strategy with labels */
+int
+i2sbus_attach_codec(struct soundbus_dev *dev, struct snd_card *card,
+		    struct codec_info *ci, void *data)
+{
+	int err, in = 0, out = 0;
+	struct transfer_info *tmp;
+	struct i2sbus_dev *i2sdev = soundbus_dev_to_i2sbus_dev(dev);
+	struct codec_info_item *cii;
+
+	if (!dev->pcmname || dev->pcmid == -1) {
+		printk(KERN_ERR "i2sbus: pcm name and id must be set!\n");
+		return -EINVAL;
+	}
+
+	list_for_each_entry(cii, &dev->codec_list, list) {
+		if (cii->codec_data == data)
+			return -EALREADY;
+	}
+
+	if (!ci->transfers || !ci->transfers->formats
+	    || !ci->transfers->rates || !ci->usable)
+		return -EINVAL;
+
+	/* we currently code the i2s transfer on the clock, and support only
+	 * 32 and 64 */
+	if (ci->bus_factor != 32 && ci->bus_factor != 64)
+		return -EINVAL;
+
+	/* If you want to fix this, you need to keep track of what transport infos
+	 * are to be used, which codecs they belong to, and then fix all the
+	 * sysclock/busclock stuff above to depend on which is usable */
+	list_for_each_entry(cii, &dev->codec_list, list) {
+		if (cii->codec->sysclock_factor != ci->sysclock_factor) {
+			printk(KERN_DEBUG
+			       "cannot yet handle multiple different sysclocks!\n");
+			return -EINVAL;
+		}
+		if (cii->codec->bus_factor != ci->bus_factor) {
+			printk(KERN_DEBUG
+			       "cannot yet handle multiple different bus clocks!\n");
+			return -EINVAL;
+		}
+	}
+
+	tmp = ci->transfers;
+	while (tmp->formats && tmp->rates) {
+		if (tmp->transfer_in)
+			in = 1;
+		else
+			out = 1;
+		tmp++;
+	}
+
+	cii = kzalloc(sizeof(struct codec_info_item), GFP_KERNEL);
+	if (!cii) {
+		printk(KERN_DEBUG "i2sbus: failed to allocate cii\n");
+		return -ENOMEM;
+	}
+
+	/* use the private data to point to the codec info */
+	cii->sdev = soundbus_dev_get(dev);
+	cii->codec = ci;
+	cii->codec_data = data;
+
+	if (!cii->sdev) {
+		printk(KERN_DEBUG
+		       "i2sbus: failed to get soundbus dev reference\n");
+		kfree(cii);
+		return -ENODEV;
+	}
+
+	if (!try_module_get(THIS_MODULE)) {
+		printk(KERN_DEBUG "i2sbus: failed to get module reference!\n");
+		soundbus_dev_put(dev);
+		kfree(cii);
+		return -EBUSY;
+	}
+
+	if (!try_module_get(ci->owner)) {
+		printk(KERN_DEBUG
+		       "i2sbus: failed to get module reference to codec owner!\n");
+		module_put(THIS_MODULE);
+		soundbus_dev_put(dev);
+		kfree(cii);
+		return -EBUSY;
+	}
+
+	if (!dev->pcm) {
+		err = snd_pcm_new(card,
+				  dev->pcmname,
+				  dev->pcmid,
+				  0,
+				  0,
+				  &dev->pcm);
+		if (err) {
+			printk(KERN_DEBUG "i2sbus: failed to create pcm\n");
+			kfree(cii);
+			module_put(ci->owner);
+			soundbus_dev_put(dev);
+			module_put(THIS_MODULE);
+			return err;
+		}
+	}
+
+	/* ALSA yet again sucks.
+	 * If it is ever fixed, remove this line. See below. */
+	out = in = 1;
+
+	if (!i2sdev->out.created && out) {
+		if (dev->pcm->card != card) {
+			/* eh? */
+			printk(KERN_ERR
+			       "Can't attach same bus to different cards!\n");
+			module_put(ci->owner);
+			kfree(cii);
+			soundbus_dev_put(dev);
+			module_put(THIS_MODULE);
+			return -EINVAL;
+		}
+		if ((err =
+		     snd_pcm_new_stream(dev->pcm, SNDRV_PCM_STREAM_PLAYBACK, 1))) {
+			module_put(ci->owner);
+			kfree(cii);
+			soundbus_dev_put(dev);
+			module_put(THIS_MODULE);
+			return err;
+		}
+		snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				&i2sbus_playback_ops);
+		i2sdev->out.created = 1;
+	}
+
+	if (!i2sdev->in.created && in) {
+		if (dev->pcm->card != card) {
+			printk(KERN_ERR
+			       "Can't attach same bus to different cards!\n");
+			module_put(ci->owner);
+			kfree(cii);
+			soundbus_dev_put(dev);
+			module_put(THIS_MODULE);
+			return -EINVAL;
+		}
+		if ((err =
+		     snd_pcm_new_stream(dev->pcm, SNDRV_PCM_STREAM_CAPTURE, 1))) {
+			module_put(ci->owner);
+			kfree(cii);
+			soundbus_dev_put(dev);
+			module_put(THIS_MODULE);
+			return err;
+		}
+		snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_CAPTURE,
+				&i2sbus_record_ops);
+		i2sdev->in.created = 1;
+	}
+
+	/* so we have to register the pcm after adding any substream
+	 * to it because alsa doesn't create the devices for the
+	 * substreams when we add them later.
+	 * Therefore, force in and out on both busses (above) and
+	 * register the pcm now instead of just after creating it.
+	 */
+	err = snd_device_register(card, dev->pcm);
+	if (err) {
+		printk(KERN_ERR "i2sbus: error registering new pcm\n");
+		module_put(ci->owner);
+		kfree(cii);
+		soundbus_dev_put(dev);
+		module_put(THIS_MODULE);
+		return err;
+	}
+	/* no errors any more, so let's add this to our list */
+	list_add(&cii->list, &dev->codec_list);
+
+	dev->pcm->private_data = i2sdev;
+	dev->pcm->private_free = i2sbus_private_free;
+
+	/* well, we really should support scatter/gather DMA */
+	snd_pcm_lib_preallocate_pages_for_all(
+		dev->pcm, SNDRV_DMA_TYPE_DEV,
+		snd_dma_pci_data(macio_get_pci_dev(i2sdev->macio)),
+		64 * 1024, 64 * 1024);
+
+	return 0;
+}
+
+void i2sbus_detach_codec(struct soundbus_dev *dev, void *data)
+{
+	struct codec_info_item *cii = NULL, *i;
+
+	list_for_each_entry(i, &dev->codec_list, list) {
+		if (i->codec_data == data) {
+			cii = i;
+			break;
+		}
+	}
+	if (cii) {
+		list_del(&cii->list);
+		module_put(cii->codec->owner);
+		kfree(cii);
+	}
+	/* no more codecs, but still a pcm? */
+	if (list_empty(&dev->codec_list) && dev->pcm) {
+		/* the actual cleanup is done by the callback above! */
+		snd_device_free(dev->pcm->card, dev->pcm);
+	}
+}
--- /dev/null
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
@@ -0,0 +1,387 @@
+/*
+ * i2sbus driver
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+
+#include <linux/module.h>
+#include <asm/macio.h>
+#include <asm/dbdma.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <linux/dma-mapping.h>
+#include "../soundbus.h"
+#include "i2sbus.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_DESCRIPTION("Apple Soundbus: I2S support");
+/* for auto-loading, declare that we handle this weird
+ * string that macio puts into the relevant device */
+MODULE_ALIAS("of:Ni2sTi2sC");
+
+static struct of_device_id i2sbus_match[] = {
+	{ .name = "i2s" },
+	{ }
+};
+
+static int alloc_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
+				       struct dbdma_command_mem *r,
+				       int numcmds)
+{
+	/* one more for rounding */
+	r->size = (numcmds+1) * sizeof(struct dbdma_cmd);
+	/* We use the PCI APIs for now until the generic one gets fixed
+	 * enough or until we get some macio-specific versions
+	 */
+	r->space = dma_alloc_coherent(
+			&macio_get_pci_dev(i2sdev->macio)->dev,
+			r->size,
+			&r->bus_addr,
+			GFP_KERNEL);
+
+	if (!r->space) return -ENOMEM;
+
+	memset(r->space, 0, r->size);
+	r->cmds = (void*)DBDMA_ALIGN(r->space);
+	r->bus_cmd_start = r->bus_addr +
+			   (dma_addr_t)((char*)r->cmds - (char*)r->space);
+
+	return 0;
+}
+
+static void free_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
+				       struct dbdma_command_mem *r)
+{
+	if (!r->space) return;
+	
+	dma_free_coherent(&macio_get_pci_dev(i2sdev->macio)->dev,
+			    r->size, r->space, r->bus_addr);
+}
+
+static void i2sbus_release_dev(struct device *dev)
+{
+	struct i2sbus_dev *i2sdev;
+	int i;
+
+	i2sdev = container_of(dev, struct i2sbus_dev, sound.ofdev.dev);
+
+ 	if (i2sdev->intfregs) iounmap(i2sdev->intfregs);
+ 	if (i2sdev->out.dbdma) iounmap(i2sdev->out.dbdma);
+ 	if (i2sdev->in.dbdma) iounmap(i2sdev->in.dbdma);
+	for (i=0;i<3;i++)
+		if (i2sdev->allocated_resource[i])
+			release_resource(i2sdev->allocated_resource[i]);
+	free_dbdma_descriptor_ring(i2sdev, &i2sdev->out.dbdma_ring);
+	free_dbdma_descriptor_ring(i2sdev, &i2sdev->in.dbdma_ring);
+	for (i=0;i<3;i++)
+		free_irq(i2sdev->interrupts[i], i2sdev);
+	i2sbus_control_remove_dev(i2sdev->control, i2sdev);
+	mutex_destroy(&i2sdev->lock);
+	kfree(i2sdev);
+}
+
+static irqreturn_t i2sbus_bus_intr(int irq, void *devid, struct pt_regs *regs)
+{
+	struct i2sbus_dev *dev = devid;
+	u32 intreg;
+
+	spin_lock(&dev->low_lock);
+	intreg = in_le32(&dev->intfregs->intr_ctl);
+
+	/* acknowledge interrupt reasons */
+	out_le32(&dev->intfregs->intr_ctl, intreg);
+
+	spin_unlock(&dev->low_lock);
+
+	return IRQ_HANDLED;
+}
+
+static int force;
+module_param(force, int, 0444);
+MODULE_PARM_DESC(force, "Force loading i2sbus even when"
+			" no layout-id property is present");
+
+/* FIXME: look at device node refcounting */
+static int i2sbus_add_dev(struct macio_dev *macio,
+			  struct i2sbus_control *control,
+			  struct device_node *np)
+{
+	struct i2sbus_dev *dev;
+	struct device_node *child = NULL, *sound = NULL;
+	int i;
+	static const char *rnames[] = { "i2sbus: %s (control)",
+					"i2sbus: %s (tx)",
+					"i2sbus: %s (rx)" };
+	static irqreturn_t (*ints[])(int irq, void *devid,
+				     struct pt_regs *regs) = {
+		i2sbus_bus_intr,
+		i2sbus_tx_intr,
+		i2sbus_rx_intr
+	};
+
+	if (strlen(np->name) != 5)
+		return 0;
+	if (strncmp(np->name, "i2s-", 4))
+		return 0;
+
+	if (np->n_intrs != 3)
+		return 0;
+
+	dev = kzalloc(sizeof(struct i2sbus_dev), GFP_KERNEL);
+	if (!dev)
+		return 0;
+
+	i = 0;
+	while ((child = of_get_next_child(np, child))) {
+		if (strcmp(child->name, "sound") == 0) {
+			i++;
+			sound = child;
+		}
+	}
+	if (i == 1) {
+		u32 *layout_id;
+		layout_id = (u32*) get_property(sound, "layout-id", NULL);
+		if (layout_id) {
+			snprintf(dev->sound.modalias, 32,
+				 "sound-layout-%d", *layout_id);
+			force = 1;
+		}
+	}
+	/* for the time being, until we can handle non-layout-id
+	 * things in some fabric, refuse to attach if there is no
+	 * layout-id property or we haven't been forced to attach.
+	 * When there are two i2s busses and only one has a layout-id,
+	 * then this depends on the order, but that isn't important
+	 * either as the second one in that case is just a modem. */
+	if (!force) {
+		kfree(dev);
+		return -ENODEV;
+	}
+
+	mutex_init(&dev->lock);
+	spin_lock_init(&dev->low_lock);
+	dev->sound.ofdev.node = np;
+	dev->sound.ofdev.dma_mask = macio->ofdev.dma_mask;
+	dev->sound.ofdev.dev.dma_mask = &dev->sound.ofdev.dma_mask;
+	dev->sound.ofdev.dev.parent = &macio->ofdev.dev;
+	dev->sound.ofdev.dev.release = i2sbus_release_dev;
+	dev->sound.attach_codec = i2sbus_attach_codec;
+	dev->sound.detach_codec = i2sbus_detach_codec;
+	dev->sound.pcmid = -1;
+	dev->macio = macio;
+	dev->control = control;
+	dev->bus_number = np->name[4] - 'a';
+	INIT_LIST_HEAD(&dev->sound.codec_list);
+
+	for (i=0;i<3;i++) {
+		dev->interrupts[i] = -1;
+		snprintf(dev->rnames[i], sizeof(dev->rnames[i]), rnames[i], np->name);
+	}
+	for (i=0;i<3;i++) {
+		if (request_irq(np->intrs[i].line, ints[i], 0, dev->rnames[i], dev))
+			goto err;
+		dev->interrupts[i] = np->intrs[i].line;
+	}
+
+	for (i=0;i<3;i++) {
+		if (of_address_to_resource(np, i, &dev->resources[i]))
+			goto err;
+		/* if only we could use our resource dev->resources[i]...
+		 * but request_resource doesn't know about parents and
+		 * contained resources... */
+		dev->allocated_resource[i] = 
+			request_mem_region(dev->resources[i].start,
+					   dev->resources[i].end -
+					   dev->resources[i].start + 1,
+					   dev->rnames[i]);
+		if (!dev->allocated_resource[i]) {
+			printk(KERN_ERR "i2sbus: failed to claim resource %d!\n", i);
+			goto err;
+		}
+	}
+	/* should do sanity checking here about length of them */
+	dev->intfregs = ioremap(dev->resources[0].start,
+				dev->resources[0].end-dev->resources[0].start+1);
+	dev->out.dbdma = ioremap(dev->resources[1].start,
+			 	 dev->resources[1].end-dev->resources[1].start+1);
+	dev->in.dbdma = ioremap(dev->resources[2].start,
+				dev->resources[2].end-dev->resources[2].start+1);
+	if (!dev->intfregs || !dev->out.dbdma || !dev->in.dbdma)
+		goto err;
+
+	if (alloc_dbdma_descriptor_ring(dev, &dev->out.dbdma_ring,
+					MAX_DBDMA_COMMANDS))
+		goto err;
+	if (alloc_dbdma_descriptor_ring(dev, &dev->in.dbdma_ring,
+					MAX_DBDMA_COMMANDS))
+		goto err;
+
+	if (i2sbus_control_add_dev(dev->control, dev)) {
+		printk(KERN_ERR "i2sbus: control layer didn't like bus\n");
+		goto err;
+	}
+
+	if (soundbus_add_one(&dev->sound)) {
+		printk(KERN_DEBUG "i2sbus: device registration error!\n");
+		goto err;
+	}
+
+	/* enable this cell */
+	i2sbus_control_cell(dev->control, dev, 1);
+	i2sbus_control_enable(dev->control, dev);
+	i2sbus_control_clock(dev->control, dev, 1);
+
+	return 1;
+ err:
+	for (i=0;i<3;i++)
+		if (dev->interrupts[i] != -1)
+			free_irq(dev->interrupts[i], dev);
+	free_dbdma_descriptor_ring(dev, &dev->out.dbdma_ring);
+	free_dbdma_descriptor_ring(dev, &dev->in.dbdma_ring);
+	if (dev->intfregs) iounmap(dev->intfregs);
+	if (dev->out.dbdma) iounmap(dev->out.dbdma);
+	if (dev->in.dbdma) iounmap(dev->in.dbdma);
+	for (i=0;i<3;i++)
+		if (dev->allocated_resource[i])
+			release_resource(dev->allocated_resource[i]);
+	mutex_destroy(&dev->lock);
+	kfree(dev);
+	return 0;
+}
+
+static int i2sbus_probe(struct macio_dev* dev, const struct of_device_id *match)
+{
+	struct device_node *np = NULL;
+	int got = 0, err;
+	struct i2sbus_control *control = NULL;
+
+	err = i2sbus_control_init(dev, &control);
+	if (err)
+		return err;
+	if (!control) {
+		printk(KERN_ERR "i2sbus_control_init API breakage\n");
+		return -ENODEV;
+	}
+
+	while ((np = of_get_next_child(dev->ofdev.node, np))) {
+		if (device_is_compatible(np, "i2sbus") ||
+		    device_is_compatible(np, "i2s-modem")) {
+			got += i2sbus_add_dev(dev, control, np);
+		}
+	}
+
+	if (!got) {
+		/* found none, clean up */
+		i2sbus_control_destroy(control);
+		return -ENODEV;
+	}
+
+	dev->ofdev.dev.driver_data = control;
+
+	return 0;
+}
+
+static int i2sbus_remove(struct macio_dev* dev)
+{
+	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct i2sbus_dev *i2sdev, *tmp;
+
+	list_for_each_entry_safe(i2sdev, tmp, &control->list, item)
+		soundbus_remove_one(&i2sdev->sound);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int i2sbus_suspend(struct macio_dev* dev, pm_message_t state)
+{
+	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct codec_info_item *cii;
+	struct i2sbus_dev* i2sdev;
+	int err, ret = 0;
+
+	list_for_each_entry(i2sdev, &control->list, item) {
+		/* Notify Alsa */
+		if (i2sdev->sound.pcm) {
+			/* Suspend PCM streams */
+			snd_pcm_suspend_all(i2sdev->sound.pcm);
+			/* Probably useless as we handle
+			 * power transitions ourselves */
+			snd_power_change_state(i2sdev->sound.pcm->card,
+					       SNDRV_CTL_POWER_D3hot);
+		}
+		/* Notify codecs */
+		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
+			err = 0;
+			if (cii->codec->suspend)
+				err = cii->codec->suspend(cii, state);
+			if (err)
+				ret = err;
+		}
+	}
+	return ret;
+}
+
+static int i2sbus_resume(struct macio_dev* dev)
+{
+	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct codec_info_item *cii;
+	struct i2sbus_dev* i2sdev;
+	int err, ret = 0;
+
+	list_for_each_entry(i2sdev, &control->list, item) {
+		/* Notify codecs so they can re-initialize */
+		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
+			err = 0;
+			if (cii->codec->resume)
+				err = cii->codec->resume(cii);
+			if (err)
+				ret = err;
+		}
+		/* Notify Alsa */
+		if (i2sdev->sound.pcm) {
+			/* Same comment as above, probably useless */
+			snd_power_change_state(i2sdev->sound.pcm->card,
+					       SNDRV_CTL_POWER_D0);
+		}
+	}
+
+	return ret;
+}
+#endif /* CONFIG_PM */
+
+static int i2sbus_shutdown(struct macio_dev* dev)
+{
+	return 0;
+}
+
+static struct macio_driver i2sbus_drv = {
+	.name = "soundbus-i2s",
+	.owner = THIS_MODULE,
+	.match_table = i2sbus_match,
+	.probe = i2sbus_probe,
+	.remove = i2sbus_remove,
+#ifdef CONFIG_PM
+	.suspend = i2sbus_suspend,
+	.resume = i2sbus_resume,
+#endif
+	.shutdown = i2sbus_shutdown,
+};
+
+static int __init soundbus_i2sbus_init(void)
+{
+	return macio_register_driver(&i2sbus_drv);
+}
+
+static void __exit soundbus_i2sbus_exit(void)
+{
+	macio_unregister_driver(&i2sbus_drv);
+}
+
+module_init(soundbus_i2sbus_init);
+module_exit(soundbus_i2sbus_exit);
--- /dev/null
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-interface.h
@@ -0,0 +1,187 @@
+/*
+ * i2sbus driver -- interface register definitions
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+#ifndef __I2SBUS_INTERFACE_H
+#define __I2SBUS_INTERFACE_H
+
+/* i2s bus control registers, at least what we know about them */
+
+#define __PAD(m,n) u8 __pad##m[n]
+#define _PAD(line, n) __PAD(line, n)
+#define PAD(n) _PAD(__LINE__, (n))
+struct i2s_interface_regs {
+	__le32 intr_ctl;	/* 0x00 */
+	PAD(12);
+	__le32 serial_format;	/* 0x10 */
+	PAD(12);
+	__le32 codec_msg_out;	/* 0x20 */
+	PAD(12);
+	__le32 codec_msg_in;	/* 0x30 */
+	PAD(12);
+	__le32 frame_count;	/* 0x40 */
+	PAD(12);
+	__le32 frame_match;	/* 0x50 */
+	PAD(12);
+	__le32 data_word_sizes;	/* 0x60 */
+	PAD(12);
+	__le32 peak_level_sel;	/* 0x70 */
+	PAD(12);
+	__le32 peak_level_in0;	/* 0x80 */
+	PAD(12);
+	__le32 peak_level_in1;	/* 0x90 */
+	PAD(12);
+	/* total size: 0x100 bytes */
+}  __attribute__((__packed__));
+
+/* interrupt register is just a bitfield with
+ * interrupt enable and pending bits */
+#define I2S_REG_INTR_CTL		0x00
+#	define I2S_INT_FRAME_COUNT		(1<<31)
+#	define I2S_PENDING_FRAME_COUNT		(1<<30)
+#	define I2S_INT_MESSAGE_FLAG		(1<<29)
+#	define I2S_PENDING_MESSAGE_FLAG		(1<<28)
+#	define I2S_INT_NEW_PEAK			(1<<27)
+#	define I2S_PENDING_NEW_PEAK		(1<<26)
+#	define I2S_INT_CLOCKS_STOPPED		(1<<25)
+#	define I2S_PENDING_CLOCKS_STOPPED	(1<<24)
+#	define I2S_INT_EXTERNAL_SYNC_ERROR	(1<<23)
+#	define I2S_PENDING_EXTERNAL_SYNC_ERROR	(1<<22)
+#	define I2S_INT_EXTERNAL_SYNC_OK		(1<<21)
+#	define I2S_PENDING_EXTERNAL_SYNC_OK	(1<<20)
+#	define I2S_INT_NEW_SAMPLE_RATE		(1<<19)
+#	define I2S_PENDING_NEW_SAMPLE_RATE	(1<<18)
+#	define I2S_INT_STATUS_FLAG		(1<<17)
+#	define I2S_PENDING_STATUS_FLAG		(1<<16)
+
+/* serial format register is more interesting :)
+ * It contains:
+ *  - clock source
+ *  - MClk divisor
+ *  - SClk divisor
+ *  - SClk master flag
+ *  - serial format (sony, i2s 64x, i2s 32x, dav, silabs)
+ *  - external sample frequency interrupt (don't understand)
+ *  - external sample frequency
+ */
+#define I2S_REG_SERIAL_FORMAT		0x10
+/* clock source. You get either 18.432, 45.1584 or 49.1520 MHz */
+#	define I2S_SF_CLOCK_SOURCE_SHIFT	30
+#	define I2S_SF_CLOCK_SOURCE_MASK		(3<<I2S_SF_CLOCK_SOURCE_SHIFT)
+#	define I2S_SF_CLOCK_SOURCE_18MHz	(0<<I2S_SF_CLOCK_SOURCE_SHIFT)
+#	define I2S_SF_CLOCK_SOURCE_45MHz	(1<<I2S_SF_CLOCK_SOURCE_SHIFT)
+#	define I2S_SF_CLOCK_SOURCE_49MHz	(2<<I2S_SF_CLOCK_SOURCE_SHIFT)
+/* also, let's define the exact clock speeds here, in Hz */
+#define I2S_CLOCK_SPEED_18MHz	18432000
+#define I2S_CLOCK_SPEED_45MHz	45158400
+#define I2S_CLOCK_SPEED_49MHz	49152000
+/* MClk is the clock that drives the codec, usually called its 'system clock'.
+ * It is derived by taking only every 'divisor' tick of the clock.
+ */
+#	define I2S_SF_MCLKDIV_SHIFT		24
+#	define I2S_SF_MCLKDIV_MASK		(0x1F<<I2S_SF_MCLKDIV_SHIFT)
+#	define I2S_SF_MCLKDIV_1			(0x14<<I2S_SF_MCLKDIV_SHIFT)
+#	define I2S_SF_MCLKDIV_3			(0x13<<I2S_SF_MCLKDIV_SHIFT)
+#	define I2S_SF_MCLKDIV_5			(0x12<<I2S_SF_MCLKDIV_SHIFT)
+#	define I2S_SF_MCLKDIV_14		(0x0E<<I2S_SF_MCLKDIV_SHIFT)
+#	define I2S_SF_MCLKDIV_OTHER(div)	(((div/2-1)<<I2S_SF_MCLKDIV_SHIFT)&I2S_SF_MCLKDIV_MASK)
+static inline int i2s_sf_mclkdiv(int div, int *out)
+{
+	int d;
+
+	switch(div) {
+	case 1: *out |= I2S_SF_MCLKDIV_1; return 0;
+	case 3: *out |= I2S_SF_MCLKDIV_3; return 0;
+	case 5: *out |= I2S_SF_MCLKDIV_5; return 0;
+	case 14: *out |= I2S_SF_MCLKDIV_14; return 0;
+	default:
+		if (div%2) return -1;
+		d = div/2-1;
+		if (d == 0x14 || d == 0x13 || d == 0x12 || d == 0x0E)
+			return -1;
+		*out |= I2S_SF_MCLKDIV_OTHER(div);
+		return 0;
+	}
+}
+/* SClk is the clock that drives the i2s wire bus. Note that it is
+ * derived from the MClk above by taking only every 'divisor' tick
+ * of MClk.
+ */
+#	define I2S_SF_SCLKDIV_SHIFT		20
+#	define I2S_SF_SCLKDIV_MASK		(0xF<<I2S_SF_SCLKDIV_SHIFT)
+#	define I2S_SF_SCLKDIV_1			(8<<I2S_SF_SCLKDIV_SHIFT)
+#	define I2S_SF_SCLKDIV_3			(9<<I2S_SF_SCLKDIV_SHIFT)
+#	define I2S_SF_SCLKDIV_OTHER(div)	(((div/2-1)<<I2S_SF_SCLKDIV_SHIFT)&I2S_SF_SCLKDIV_MASK)
+static inline int i2s_sf_sclkdiv(int div, int *out)
+{
+	int d;
+
+	switch(div) {
+	case 1: *out |= I2S_SF_SCLKDIV_1; return 0;
+	case 3: *out |= I2S_SF_SCLKDIV_3; return 0;
+	default:
+		if (div%2) return -1;
+		d = div/2-1;
+		if (d == 8 || d == 9) return -1;
+		*out |= I2S_SF_SCLKDIV_OTHER(div);
+		return 0;
+	}
+}
+#	define I2S_SF_SCLK_MASTER		(1<<19)
+/* serial format is the way the data is put to the i2s wire bus */
+#	define I2S_SF_SERIAL_FORMAT_SHIFT	16
+#	define I2S_SF_SERIAL_FORMAT_MASK	(7<<I2S_SF_SERIAL_FORMAT_SHIFT)
+#	define I2S_SF_SERIAL_FORMAT_SONY	(0<<I2S_SF_SERIAL_FORMAT_SHIFT)
+#	define I2S_SF_SERIAL_FORMAT_I2S_64X	(1<<I2S_SF_SERIAL_FORMAT_SHIFT)
+#	define I2S_SF_SERIAL_FORMAT_I2S_32X	(2<<I2S_SF_SERIAL_FORMAT_SHIFT)
+#	define I2S_SF_SERIAL_FORMAT_I2S_DAV	(4<<I2S_SF_SERIAL_FORMAT_SHIFT)
+#	define I2S_SF_SERIAL_FORMAT_I2S_SILABS	(5<<I2S_SF_SERIAL_FORMAT_SHIFT)
+/* unknown */
+#	define I2S_SF_EXT_SAMPLE_FREQ_INT_SHIFT	12
+#	define I2S_SF_EXT_SAMPLE_FREQ_INT_MASK	(0xF<<I2S_SF_SAMPLE_FREQ_INT_SHIFT)
+/* probably gives external frequency? */
+#	define I2S_SF_EXT_SAMPLE_FREQ_MASK	0xFFF
+
+/* used to send codec messages, but how isn't clear */
+#define I2S_REG_CODEC_MSG_OUT		0x20
+
+/* used to receive codec messages, but how isn't clear */
+#define I2S_REG_CODEC_MSG_IN		0x30
+
+/* frame count reg isn't clear to me yet, but probably useful */
+#define I2S_REG_FRAME_COUNT		0x40
+
+/* program to some value, and get interrupt if frame count reaches it */
+#define I2S_REG_FRAME_MATCH		0x50
+
+/* this register describes how the bus transfers data */
+#define I2S_REG_DATA_WORD_SIZES		0x60
+/* number of interleaved input channels */
+#	define I2S_DWS_NUM_CHANNELS_IN_SHIFT	24
+#	define I2S_DWS_NUM_CHANNELS_IN_MASK	(0x1F<<I2S_DWS_NUM_CHANNELS_IN_SHIFT)
+/* word size of input data */
+#	define I2S_DWS_DATA_IN_SIZE_SHIFT	16
+#	define I2S_DWS_DATA_IN_16BIT		(0<<I2S_DWS_DATA_IN_SIZE_SHIFT)
+#	define I2S_DWS_DATA_IN_24BIT		(3<<I2S_DWS_DATA_IN_SIZE_SHIFT)
+/* number of interleaved output channels */
+#	define I2S_DWS_NUM_CHANNELS_OUT_SHIFT	8
+#	define I2S_DWS_NUM_CHANNELS_OUT_MASK	(0x1F<<I2S_DWS_NUM_CHANNELS_OUT_SHIFT)
+/* word size of output data */
+#	define I2S_DWS_DATA_OUT_SIZE_SHIFT	0
+#	define I2S_DWS_DATA_OUT_16BIT		(0<<I2S_DWS_DATA_OUT_SIZE_SHIFT)
+#	define I2S_DWS_DATA_OUT_24BIT		(3<<I2S_DWS_DATA_OUT_SIZE_SHIFT)
+
+
+/* unknown */
+#define I2S_REG_PEAK_LEVEL_SEL		0x70
+
+/* unknown */
+#define I2S_REG_PEAK_LEVEL_IN0		0x80
+
+/* unknown */
+#define I2S_REG_PEAK_LEVEL_IN1		0x90
+
+#endif /* __I2SBUS_INTERFACE_H */
--- /dev/null
+++ b/sound/aoa/soundbus/i2sbus/i2sbus.h
@@ -0,0 +1,112 @@
+/*
+ * i2sbus driver -- private definitions
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+#ifndef __I2SBUS_H
+#define __I2SBUS_H
+#include <asm/dbdma.h>
+#include <linux/interrupt.h>
+#include <sound/pcm.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <asm/prom.h>
+#include "i2sbus-interface.h"
+#include "i2sbus-control.h"
+#include "../soundbus.h"
+
+struct i2sbus_control {
+	volatile struct i2s_control_regs __iomem *controlregs;
+	struct resource rsrc;
+	struct list_head list;
+};
+
+#define MAX_DBDMA_COMMANDS	32
+
+struct dbdma_command_mem {
+	dma_addr_t bus_addr;
+	dma_addr_t bus_cmd_start;
+	struct dbdma_cmd *cmds;
+	void *space;
+	int size;
+	u32 running:1;
+};
+
+struct pcm_info {
+	u32 created:1, /* has this direction been created with alsa? */
+	    active:1;  /* is this stream active? */
+	/* runtime information */
+	struct snd_pcm_substream *substream;
+	int current_period;
+	u32 frame_count;
+	struct dbdma_command_mem dbdma_ring;
+	volatile struct dbdma_regs __iomem *dbdma;
+};
+
+struct i2sbus_dev {
+	struct soundbus_dev sound;
+	struct macio_dev *macio;
+	struct i2sbus_control *control;
+	volatile struct i2s_interface_regs __iomem *intfregs;
+
+	struct resource resources[3];
+	struct resource *allocated_resource[3];
+	int interrupts[3];
+	char rnames[3][32];
+
+	/* info about currently active substreams */
+	struct pcm_info out, in;
+	snd_pcm_format_t format;
+	unsigned int rate;
+
+	/* list for a single controller */
+	struct list_head item;
+	/* number of bus on controller */
+	int bus_number;
+	/* for use by control layer */
+	struct pmf_function *enable,
+			    *cell_enable,
+			    *cell_disable,
+			    *clock_enable,
+			    *clock_disable;
+
+	/* locks */
+	/* spinlock for low-level interrupt locking */
+	spinlock_t low_lock;
+	/* mutex for high-level consistency */
+	struct mutex lock;
+};
+
+#define soundbus_dev_to_i2sbus_dev(sdev) \
+		container_of(sdev, struct i2sbus_dev, sound)
+
+/* pcm specific functions */
+extern int
+i2sbus_attach_codec(struct soundbus_dev *dev, struct snd_card *card,
+		    struct codec_info *ci, void *data);
+extern void
+i2sbus_detach_codec(struct soundbus_dev *dev, void *data);
+extern irqreturn_t
+i2sbus_tx_intr(int irq, void *devid, struct pt_regs *regs);
+extern irqreturn_t
+i2sbus_rx_intr(int irq, void *devid, struct pt_regs *regs);
+
+/* control specific functions */
+extern int i2sbus_control_init(struct macio_dev* dev,
+			       struct i2sbus_control **c);
+extern void i2sbus_control_destroy(struct i2sbus_control *c);
+extern int i2sbus_control_add_dev(struct i2sbus_control *c,
+				  struct i2sbus_dev *i2sdev);
+extern void i2sbus_control_remove_dev(struct i2sbus_control *c,
+				      struct i2sbus_dev *i2sdev);
+extern int i2sbus_control_enable(struct i2sbus_control *c,
+				 struct i2sbus_dev *i2sdev);
+extern int i2sbus_control_cell(struct i2sbus_control *c,
+			       struct i2sbus_dev *i2sdev,
+			       int enable);
+extern int i2sbus_control_clock(struct i2sbus_control *c,
+				struct i2sbus_dev *i2sdev,
+				int enable);
+#endif /* __I2SBUS_H */
--- /dev/null
+++ b/sound/aoa/soundbus/i2sbus/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SND_AOA_SOUNDBUS_I2S) += snd-aoa-i2sbus.o
+snd-aoa-i2sbus-objs := i2sbus-core.o i2sbus-pcm.o i2sbus-control.o
--- /dev/null
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-control.c
@@ -0,0 +1,192 @@
+/*
+ * i2sbus driver -- bus control routines
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <asm/prom.h>
+#include <asm/macio.h>
+#include <asm/pmac_feature.h>
+#include <asm/pmac_pfunc.h>
+#include "i2sbus.h"
+
+int i2sbus_control_init(struct macio_dev* dev, struct i2sbus_control **c)
+{
+	*c = kzalloc(sizeof(struct i2sbus_control), GFP_KERNEL);
+	if (!*c)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&(*c)->list);
+
+	if (of_address_to_resource(dev->ofdev.node, 0, &(*c)->rsrc))
+		goto err;
+	/* we really should be using feature calls instead of mapping
+	 * these registers. It's safe for now since no one else is
+	 * touching them... */
+	(*c)->controlregs = ioremap((*c)->rsrc.start,
+				    sizeof(struct i2s_control_regs));
+	if (!(*c)->controlregs)
+		goto err;
+
+	return 0;
+ err:
+	kfree(*c);
+	*c = NULL;
+	return -ENODEV;
+}
+
+void i2sbus_control_destroy(struct i2sbus_control *c)
+{
+	iounmap(c->controlregs);
+	kfree(c);
+}
+
+/* this is serialised externally */
+int i2sbus_control_add_dev(struct i2sbus_control *c,
+			   struct i2sbus_dev *i2sdev)
+{
+	struct device_node *np;
+
+	np = i2sdev->sound.ofdev.node;
+	i2sdev->enable = pmf_find_function(np, "enable");
+	i2sdev->cell_enable = pmf_find_function(np, "cell-enable");
+	i2sdev->clock_enable = pmf_find_function(np, "clock-enable");
+	i2sdev->cell_disable = pmf_find_function(np, "cell-disable");
+	i2sdev->clock_disable = pmf_find_function(np, "clock-disable");
+
+	/* if the bus number is not 0 or 1 we absolutely need to use
+	 * the platform functions -- there's nothing in Darwin that
+	 * would allow seeing a system behind what the FCRs are then,
+	 * and I don't want to go parsing a bunch of platform functions
+	 * by hand to try finding a system... */
+	if (i2sdev->bus_number != 0 && i2sdev->bus_number != 1 &&
+	    (!i2sdev->enable ||
+	     !i2sdev->cell_enable || !i2sdev->clock_enable ||
+	     !i2sdev->cell_disable || !i2sdev->clock_disable)) {
+		pmf_put_function(i2sdev->enable);
+		pmf_put_function(i2sdev->cell_enable);
+		pmf_put_function(i2sdev->clock_enable);
+		pmf_put_function(i2sdev->cell_disable);
+		pmf_put_function(i2sdev->clock_disable);
+		return -ENODEV;
+	}
+
+	list_add(&i2sdev->item, &c->list);
+
+	return 0;
+}
+
+void i2sbus_control_remove_dev(struct i2sbus_control *c,
+			       struct i2sbus_dev *i2sdev)
+{
+	/* this is serialised externally */
+	list_del(&i2sdev->item);
+	if (list_empty(&c->list))
+		i2sbus_control_destroy(c);
+}
+
+int i2sbus_control_enable(struct i2sbus_control *c,
+			  struct i2sbus_dev *i2sdev)
+{
+	struct pmf_args args = { .count = 0 };
+	int cc;
+
+	if (i2sdev->enable)
+		return pmf_call_one(i2sdev->enable, &args);
+
+	switch (i2sdev->bus_number) {
+	case 0:
+		cc = in_le32(&c->controlregs->cell_control);
+		out_le32(&c->controlregs->cell_control, cc | CTRL_CLOCK_INTF_0_ENABLE);
+		break;
+	case 1:
+		cc = in_le32(&c->controlregs->cell_control);
+		out_le32(&c->controlregs->cell_control, cc | CTRL_CLOCK_INTF_1_ENABLE);
+		break;
+	default:
+		return -ENODEV;
+	}
+	return 0;
+}
+
+int i2sbus_control_cell(struct i2sbus_control *c,
+			struct i2sbus_dev *i2sdev,
+			int enable)
+{
+	struct pmf_args args = { .count = 0 };
+	int cc;
+
+	switch (enable) {
+	case 0:
+		if (i2sdev->cell_disable)
+			return pmf_call_one(i2sdev->cell_disable, &args);
+		break;
+	case 1:
+		if (i2sdev->cell_enable)
+			return pmf_call_one(i2sdev->cell_enable, &args);
+		break;
+	default:
+		printk(KERN_ERR "i2sbus: INVALID CELL ENABLE VALUE\n");
+		return -ENODEV;
+	}
+	switch (i2sdev->bus_number) {
+	case 0:
+		cc = in_le32(&c->controlregs->cell_control);
+		cc &= ~CTRL_CLOCK_CELL_0_ENABLE;
+		cc |= enable * CTRL_CLOCK_CELL_0_ENABLE;
+		out_le32(&c->controlregs->cell_control, cc);
+		break;
+	case 1:
+		cc = in_le32(&c->controlregs->cell_control);
+		cc &= ~CTRL_CLOCK_CELL_1_ENABLE;
+		cc |= enable * CTRL_CLOCK_CELL_1_ENABLE;
+		out_le32(&c->controlregs->cell_control, cc);
+		break;
+	default:
+		return -ENODEV;
+	}
+	return 0;
+}
+
+int i2sbus_control_clock(struct i2sbus_control *c,
+			 struct i2sbus_dev *i2sdev,
+			 int enable)
+{
+	struct pmf_args args = { .count = 0 };
+	int cc;
+
+	switch (enable) {
+	case 0:
+		if (i2sdev->clock_disable)
+			return pmf_call_one(i2sdev->clock_disable, &args);
+		break;
+	case 1:
+		if (i2sdev->clock_enable)
+			return pmf_call_one(i2sdev->clock_enable, &args);
+		break;
+	default:
+		printk(KERN_ERR "i2sbus: INVALID CLOCK ENABLE VALUE\n");
+		return -ENODEV;
+	}
+	switch (i2sdev->bus_number) {
+	case 0:
+		cc = in_le32(&c->controlregs->cell_control);
+		cc &= ~CTRL_CLOCK_CLOCK_0_ENABLE;
+		cc |= enable * CTRL_CLOCK_CLOCK_0_ENABLE;
+		out_le32(&c->controlregs->cell_control, cc);
+		break;
+	case 1:
+		cc = in_le32(&c->controlregs->cell_control);
+		cc &= ~CTRL_CLOCK_CLOCK_1_ENABLE;
+		cc |= enable * CTRL_CLOCK_CLOCK_1_ENABLE;
+		out_le32(&c->controlregs->cell_control, cc);
+		break;
+	default:
+		return -ENODEV;
+	}
+	return 0;
+}

--
