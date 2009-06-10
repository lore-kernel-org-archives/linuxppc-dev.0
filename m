Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1875EB719A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:27 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 27/33] sound/ps3: Restructure driver source
Date: Wed, 10 Jun 2009 16:39:02 +0200
Message-Id: <1244644748-24211-28-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-27-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-27-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	cbe-oss-dev@ozlabs.org, Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sort includes, and reorder code so we can kill the forward declarations

No functional changes

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/ppc/snd_ps3.c |  621 ++++++++++++++++++++++++---------------------------
 1 files changed, 288 insertions(+), 333 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index d660b0f..cd9109a 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -18,80 +18,30 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include <sound/asound.h>
+#include <sound/control.h>
 #include <sound/core.h>
 #include <sound/initval.h>
-#include <sound/pcm.h>
-#include <sound/asound.h>
 #include <sound/memalloc.h>
+#include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/control.h>
-#include <linux/dmapool.h>
-#include <linux/dma-mapping.h>
-#include <asm/firmware.h>
+
 #include <asm/dma.h>
+#include <asm/firmware.h>
 #include <asm/lv1call.h>
 #include <asm/ps3.h>
 #include <asm/ps3av.h>
 
-#include "snd_ps3_reg.h"
 #include "snd_ps3.h"
+#include "snd_ps3_reg.h"
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("PS3 sound driver");
-MODULE_AUTHOR("Sony Computer Entertainment Inc.");
-
-/* module  entries */
-static int __init snd_ps3_init(void);
-static void __exit snd_ps3_exit(void);
-
-/* ALSA snd driver ops */
-static int snd_ps3_pcm_open(struct snd_pcm_substream *substream);
-static int snd_ps3_pcm_close(struct snd_pcm_substream *substream);
-static int snd_ps3_pcm_prepare(struct snd_pcm_substream *substream);
-static int snd_ps3_pcm_trigger(struct snd_pcm_substream *substream,
-				 int cmd);
-static snd_pcm_uframes_t snd_ps3_pcm_pointer(struct snd_pcm_substream
-					     *substream);
-static int snd_ps3_pcm_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *hw_params);
-static int snd_ps3_pcm_hw_free(struct snd_pcm_substream *substream);
-
-
-/* ps3_system_bus_driver entries */
-static int __init snd_ps3_driver_probe(struct ps3_system_bus_device *dev);
-static int snd_ps3_driver_remove(struct ps3_system_bus_device *dev);
-
-/* address setup */
-static int snd_ps3_map_mmio(void);
-static void snd_ps3_unmap_mmio(void);
-static int snd_ps3_allocate_irq(void);
-static void snd_ps3_free_irq(void);
-static void snd_ps3_audio_set_base_addr(uint64_t ioaddr_start);
-
-/* interrupt handler */
-static irqreturn_t snd_ps3_interrupt(int irq, void *dev_id);
-
-
-/* set sampling rate/format */
-static int snd_ps3_set_avsetting(struct snd_pcm_substream *substream);
-/* take effect parameter change */
-static int snd_ps3_change_avsetting(struct snd_ps3_card_info *card);
-/* initialize avsetting and take it effect */
-static int snd_ps3_init_avsetting(struct snd_ps3_card_info *card);
-/* setup dma */
-static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
-			       enum snd_ps3_dma_filltype filltype);
-static void snd_ps3_wait_for_dma_stop(struct snd_ps3_card_info *card);
-
-static dma_addr_t v_to_bus(struct snd_ps3_card_info *, void  *vaddr, int ch);
-
-
-module_init(snd_ps3_init);
-module_exit(snd_ps3_exit);
 
 /*
  * global
@@ -165,17 +115,6 @@ static const struct snd_pcm_hardware snd_ps3_pcm_hw = {
 	.fifo_size = PS3_AUDIO_FIFO_SIZE
 };
 
-static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
-	.open = snd_ps3_pcm_open,
-	.close = snd_ps3_pcm_close,
-	.prepare = snd_ps3_pcm_prepare,
-	.ioctl = snd_pcm_lib_ioctl,
-	.trigger = snd_ps3_pcm_trigger,
-	.pointer = snd_ps3_pcm_pointer,
-	.hw_params = snd_ps3_pcm_hw_params,
-	.hw_free = snd_ps3_pcm_hw_free
-};
-
 static int snd_ps3_verify_dma_stop(struct snd_ps3_card_info *card,
 				   int count, int force_stop)
 {
@@ -369,6 +308,71 @@ static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
 }
 
 /*
+ * Interrupt handler
+ */
+static irqreturn_t snd_ps3_interrupt(int irq, void *dev_id)
+{
+
+	uint32_t port_intr;
+	int underflow_occured = 0;
+	struct snd_ps3_card_info *card = dev_id;
+
+	if (!card->running) {
+		update_reg(PS3_AUDIO_AX_IS, 0);
+		update_reg(PS3_AUDIO_INTR_0, 0);
+		return IRQ_HANDLED;
+	}
+
+	port_intr = read_reg(PS3_AUDIO_AX_IS);
+	/*
+	 *serial buffer empty detected (every 4 times),
+	 *program next dma and kick it
+	 */
+	if (port_intr & PS3_AUDIO_AX_IE_ASOBEIE(0)) {
+		write_reg(PS3_AUDIO_AX_IS, PS3_AUDIO_AX_IE_ASOBEIE(0));
+		if (port_intr & PS3_AUDIO_AX_IE_ASOBUIE(0)) {
+			write_reg(PS3_AUDIO_AX_IS, port_intr);
+			underflow_occured = 1;
+		}
+		if (card->silent) {
+			/* we are still in silent time */
+			snd_ps3_program_dma(card,
+				(underflow_occured) ?
+				SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL :
+				SND_PS3_DMA_FILLTYPE_SILENT_RUNNING);
+			snd_ps3_kick_dma(card);
+			card->silent--;
+		} else {
+			snd_ps3_program_dma(card,
+				(underflow_occured) ?
+				SND_PS3_DMA_FILLTYPE_FIRSTFILL :
+				SND_PS3_DMA_FILLTYPE_RUNNING);
+			snd_ps3_kick_dma(card);
+			snd_pcm_period_elapsed(card->substream);
+		}
+	} else if (port_intr & PS3_AUDIO_AX_IE_ASOBUIE(0)) {
+		write_reg(PS3_AUDIO_AX_IS, PS3_AUDIO_AX_IE_ASOBUIE(0));
+		/*
+		 * serial out underflow, but buffer empty not detected.
+		 * in this case, fill fifo with 0 to recover.  After
+		 * filling dummy data, serial automatically start to
+		 * consume them and then will generate normal buffer
+		 * empty interrupts.
+		 * If both buffer underflow and buffer empty are occured,
+		 * it is better to do nomal data transfer than empty one
+		 */
+		snd_ps3_program_dma(card,
+				    SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL);
+		snd_ps3_kick_dma(card);
+		snd_ps3_program_dma(card,
+				    SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL);
+		snd_ps3_kick_dma(card);
+	}
+	/* clear interrupt cause */
+	return IRQ_HANDLED;
+};
+
+/*
  * audio mute on/off
  * mute_on : 0 output enabled
  *           1 mute
@@ -379,6 +383,142 @@ static int snd_ps3_mute(int mute_on)
 }
 
 /*
+ * av setting
+ * NOTE: calling this function may generate audio interrupt.
+ */
+static int snd_ps3_change_avsetting(struct snd_ps3_card_info *card)
+{
+	int ret, retries, i;
+	pr_debug("%s: start\n", __func__);
+
+	ret = ps3av_set_audio_mode(card->avs.avs_audio_ch,
+				  card->avs.avs_audio_rate,
+				  card->avs.avs_audio_width,
+				  card->avs.avs_audio_format,
+				  card->avs.avs_audio_source);
+	/*
+	 * Reset the following unwanted settings:
+	 */
+
+	/* disable all 3wire buffers */
+	update_mask_reg(PS3_AUDIO_AO_3WMCTRL,
+			~(PS3_AUDIO_AO_3WMCTRL_ASOEN(0) |
+			  PS3_AUDIO_AO_3WMCTRL_ASOEN(1) |
+			  PS3_AUDIO_AO_3WMCTRL_ASOEN(2) |
+			  PS3_AUDIO_AO_3WMCTRL_ASOEN(3)),
+			0);
+	wmb();	/* ensure the hardware sees the change */
+	/* wait for actually stopped */
+	retries = 1000;
+	while ((read_reg(PS3_AUDIO_AO_3WMCTRL) &
+		(PS3_AUDIO_AO_3WMCTRL_ASORUN(0) |
+		 PS3_AUDIO_AO_3WMCTRL_ASORUN(1) |
+		 PS3_AUDIO_AO_3WMCTRL_ASORUN(2) |
+		 PS3_AUDIO_AO_3WMCTRL_ASORUN(3))) &&
+	       --retries) {
+		udelay(1);
+	}
+
+	/* reset buffer pointer */
+	for (i = 0; i < 4; i++) {
+		update_reg(PS3_AUDIO_AO_3WCTRL(i),
+			   PS3_AUDIO_AO_3WCTRL_ASOBRST_RESET);
+		udelay(10);
+	}
+	wmb(); /* ensure the hardware actually start resetting */
+
+	/* enable 3wire#0 buffer */
+	update_reg(PS3_AUDIO_AO_3WMCTRL, PS3_AUDIO_AO_3WMCTRL_ASOEN(0));
+
+
+	/* In 24bit mode,ALSA inserts a zero byte at first byte of per sample */
+	update_mask_reg(PS3_AUDIO_AO_3WCTRL(0),
+			~PS3_AUDIO_AO_3WCTRL_ASODF,
+			PS3_AUDIO_AO_3WCTRL_ASODF_LSB);
+	update_mask_reg(PS3_AUDIO_AO_SPDCTRL(0),
+			~PS3_AUDIO_AO_SPDCTRL_SPODF,
+			PS3_AUDIO_AO_SPDCTRL_SPODF_LSB);
+	/* ensure all the setting above is written back to register */
+	wmb();
+	/* avsetting driver altered AX_IE, caller must reset it if you want */
+	pr_debug("%s: end\n", __func__);
+	return ret;
+}
+
+/*
+ *  set sampling rate according to the substream
+ */
+static int snd_ps3_set_avsetting(struct snd_pcm_substream *substream)
+{
+	struct snd_ps3_card_info *card = snd_pcm_substream_chip(substream);
+	struct snd_ps3_avsetting_info avs;
+	int ret;
+
+	avs = card->avs;
+
+	pr_debug("%s: called freq=%d width=%d\n", __func__,
+		 substream->runtime->rate,
+		 snd_pcm_format_width(substream->runtime->format));
+
+	pr_debug("%s: before freq=%d width=%d\n", __func__,
+		 card->avs.avs_audio_rate, card->avs.avs_audio_width);
+
+	/* sample rate */
+	switch (substream->runtime->rate) {
+	case 44100:
+		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_44K;
+		break;
+	case 48000:
+		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_48K;
+		break;
+	case 88200:
+		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_88K;
+		break;
+	case 96000:
+		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_96K;
+		break;
+	default:
+		pr_info("%s: invalid rate %d\n", __func__,
+			substream->runtime->rate);
+		return 1;
+	}
+
+	/* width */
+	switch (snd_pcm_format_width(substream->runtime->format)) {
+	case 16:
+		avs.avs_audio_width = PS3AV_CMD_AUDIO_WORD_BITS_16;
+		break;
+	case 24:
+		avs.avs_audio_width = PS3AV_CMD_AUDIO_WORD_BITS_24;
+		break;
+	default:
+		pr_info("%s: invalid width %d\n", __func__,
+			snd_pcm_format_width(substream->runtime->format));
+		return 1;
+	}
+
+	memcpy(avs.avs_cs_info, ps3av_mode_cs_info, 8);
+
+	if (memcmp(&card->avs, &avs, sizeof(avs))) {
+		pr_debug("%s: after freq=%d width=%d\n", __func__,
+			 card->avs.avs_audio_rate, card->avs.avs_audio_width);
+
+		card->avs = avs;
+		snd_ps3_change_avsetting(card);
+		ret = 0;
+	} else
+		ret = 1;
+
+	/* check CS non-audio bit and mute accordingly */
+	if (avs.avs_cs_info[0] & 0x02)
+		ps3av_audio_mute_analog(1); /* mute if non-audio */
+	else
+		ps3av_audio_mute_analog(0);
+
+	return ret;
+}
+
+/*
  * PCM operators
  */
 static int snd_ps3_pcm_open(struct snd_pcm_substream *substream)
@@ -403,6 +543,13 @@ static int snd_ps3_pcm_open(struct snd_pcm_substream *substream)
 	return 0;
 };
 
+static int snd_ps3_pcm_close(struct snd_pcm_substream *substream)
+{
+	/* mute on */
+	snd_ps3_mute(1);
+	return 0;
+};
+
 static int snd_ps3_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *hw_params)
 {
@@ -414,6 +561,13 @@ static int snd_ps3_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 };
 
+static int snd_ps3_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	int ret;
+	ret = snd_pcm_lib_free_pages(substream);
+	return ret;
+};
+
 static int snd_ps3_delay_to_bytes(struct snd_pcm_substream *substream,
 				  unsigned int delay_ms)
 {
@@ -553,202 +707,6 @@ static snd_pcm_uframes_t snd_ps3_pcm_pointer(
 	return ret;
 };
 
-static int snd_ps3_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	int ret;
-	ret = snd_pcm_lib_free_pages(substream);
-	return ret;
-};
-
-static int snd_ps3_pcm_close(struct snd_pcm_substream *substream)
-{
-	/* mute on */
-	snd_ps3_mute(1);
-	return 0;
-};
-
-static void snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
-{
-	/*
-	 * avsetting driver seems to never change the followings
-	 * so, init them here once
-	 */
-
-	/* no dma interrupt needed */
-	write_reg(PS3_AUDIO_INTR_EN_0, 0);
-
-	/* use every 4 buffer empty interrupt */
-	update_mask_reg(PS3_AUDIO_AX_IC,
-			PS3_AUDIO_AX_IC_AASOIMD_MASK,
-			PS3_AUDIO_AX_IC_AASOIMD_EVERY4);
-
-	/* enable 3wire clocks */
-	update_mask_reg(PS3_AUDIO_AO_3WMCTRL,
-			~(PS3_AUDIO_AO_3WMCTRL_ASOBCLKD_DISABLED |
-			  PS3_AUDIO_AO_3WMCTRL_ASOLRCKD_DISABLED),
-			0);
-	update_reg(PS3_AUDIO_AO_3WMCTRL,
-		   PS3_AUDIO_AO_3WMCTRL_ASOPLRCK_DEFAULT);
-}
-
-/*
- * av setting
- * NOTE: calling this function may generate audio interrupt.
- */
-static int snd_ps3_change_avsetting(struct snd_ps3_card_info *card)
-{
-	int ret, retries, i;
-	pr_debug("%s: start\n", __func__);
-
-	ret = ps3av_set_audio_mode(card->avs.avs_audio_ch,
-				  card->avs.avs_audio_rate,
-				  card->avs.avs_audio_width,
-				  card->avs.avs_audio_format,
-				  card->avs.avs_audio_source);
-	/*
-	 * Reset the following unwanted settings:
-	 */
-
-	/* disable all 3wire buffers */
-	update_mask_reg(PS3_AUDIO_AO_3WMCTRL,
-			~(PS3_AUDIO_AO_3WMCTRL_ASOEN(0) |
-			  PS3_AUDIO_AO_3WMCTRL_ASOEN(1) |
-			  PS3_AUDIO_AO_3WMCTRL_ASOEN(2) |
-			  PS3_AUDIO_AO_3WMCTRL_ASOEN(3)),
-			0);
-	wmb();	/* ensure the hardware sees the change */
-	/* wait for actually stopped */
-	retries = 1000;
-	while ((read_reg(PS3_AUDIO_AO_3WMCTRL) &
-		(PS3_AUDIO_AO_3WMCTRL_ASORUN(0) |
-		 PS3_AUDIO_AO_3WMCTRL_ASORUN(1) |
-		 PS3_AUDIO_AO_3WMCTRL_ASORUN(2) |
-		 PS3_AUDIO_AO_3WMCTRL_ASORUN(3))) &&
-	       --retries) {
-		udelay(1);
-	}
-
-	/* reset buffer pointer */
-	for (i = 0; i < 4; i++) {
-		update_reg(PS3_AUDIO_AO_3WCTRL(i),
-			   PS3_AUDIO_AO_3WCTRL_ASOBRST_RESET);
-		udelay(10);
-	}
-	wmb(); /* ensure the hardware actually start resetting */
-
-	/* enable 3wire#0 buffer */
-	update_reg(PS3_AUDIO_AO_3WMCTRL, PS3_AUDIO_AO_3WMCTRL_ASOEN(0));
-
-
-	/* In 24bit mode,ALSA inserts a zero byte at first byte of per sample */
-	update_mask_reg(PS3_AUDIO_AO_3WCTRL(0),
-			~PS3_AUDIO_AO_3WCTRL_ASODF,
-			PS3_AUDIO_AO_3WCTRL_ASODF_LSB);
-	update_mask_reg(PS3_AUDIO_AO_SPDCTRL(0),
-			~PS3_AUDIO_AO_SPDCTRL_SPODF,
-			PS3_AUDIO_AO_SPDCTRL_SPODF_LSB);
-	/* ensure all the setting above is written back to register */
-	wmb();
-	/* avsetting driver altered AX_IE, caller must reset it if you want */
-	pr_debug("%s: end\n", __func__);
-	return ret;
-}
-
-static int snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
-{
-	int ret;
-	pr_debug("%s: start\n", __func__);
-	card->avs.avs_audio_ch = PS3AV_CMD_AUDIO_NUM_OF_CH_2;
-	card->avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_48K;
-	card->avs.avs_audio_width = PS3AV_CMD_AUDIO_WORD_BITS_16;
-	card->avs.avs_audio_format = PS3AV_CMD_AUDIO_FORMAT_PCM;
-	card->avs.avs_audio_source = PS3AV_CMD_AUDIO_SOURCE_SERIAL;
-	memcpy(card->avs.avs_cs_info, ps3av_mode_cs_info, 8);
-
-	ret = snd_ps3_change_avsetting(card);
-
-	snd_ps3_audio_fixup(card);
-
-	/* to start to generate SPDIF signal, fill data */
-	snd_ps3_program_dma(card, SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL);
-	snd_ps3_kick_dma(card);
-	pr_debug("%s: end\n", __func__);
-	return ret;
-}
-
-/*
- *  set sampling rate according to the substream
- */
-static int snd_ps3_set_avsetting(struct snd_pcm_substream *substream)
-{
-	struct snd_ps3_card_info *card = snd_pcm_substream_chip(substream);
-	struct snd_ps3_avsetting_info avs;
-	int ret;
-
-	avs = card->avs;
-
-	pr_debug("%s: called freq=%d width=%d\n", __func__,
-		 substream->runtime->rate,
-		 snd_pcm_format_width(substream->runtime->format));
-
-	pr_debug("%s: before freq=%d width=%d\n", __func__,
-		 card->avs.avs_audio_rate, card->avs.avs_audio_width);
-
-	/* sample rate */
-	switch (substream->runtime->rate) {
-	case 44100:
-		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_44K;
-		break;
-	case 48000:
-		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_48K;
-		break;
-	case 88200:
-		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_88K;
-		break;
-	case 96000:
-		avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_96K;
-		break;
-	default:
-		pr_info("%s: invalid rate %d\n", __func__,
-			substream->runtime->rate);
-		return 1;
-	}
-
-	/* width */
-	switch (snd_pcm_format_width(substream->runtime->format)) {
-	case 16:
-		avs.avs_audio_width = PS3AV_CMD_AUDIO_WORD_BITS_16;
-		break;
-	case 24:
-		avs.avs_audio_width = PS3AV_CMD_AUDIO_WORD_BITS_24;
-		break;
-	default:
-		pr_info("%s: invalid width %d\n", __func__,
-			snd_pcm_format_width(substream->runtime->format));
-		return 1;
-	}
-
-	memcpy(avs.avs_cs_info, ps3av_mode_cs_info, 8);
-
-	if (memcmp(&card->avs, &avs, sizeof(avs))) {
-		pr_debug("%s: after freq=%d width=%d\n", __func__,
-			 card->avs.avs_audio_rate, card->avs.avs_audio_width);
-
-		card->avs = avs;
-		snd_ps3_change_avsetting(card);
-		ret = 0;
-	} else
-		ret = 1;
-
-	/* check CS non-audio bit and mute accordingly */
-	if (avs.avs_cs_info[0] & 0x02)
-		ps3av_audio_mute_analog(1); /* mute if non-audio */
-	else
-		ps3av_audio_mute_analog(0);
-
-	return ret;
-}
-
 /*
  * SPDIF status bits controls
  */
@@ -815,6 +773,17 @@ static struct snd_kcontrol_new spdif_ctls[] = {
 	},
 };
 
+static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
+	.open = snd_ps3_pcm_open,
+	.close = snd_ps3_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_ps3_pcm_hw_params,
+	.hw_free = snd_ps3_pcm_hw_free,
+	.prepare = snd_ps3_pcm_prepare,
+	.trigger = snd_ps3_pcm_trigger,
+	.pointer = snd_ps3_pcm_pointer,
+};
+
 
 static int snd_ps3_map_mmio(void)
 {
@@ -912,6 +881,52 @@ static void snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
 			ret);
 }
 
+static void snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
+{
+	/*
+	 * avsetting driver seems to never change the followings
+	 * so, init them here once
+	 */
+
+	/* no dma interrupt needed */
+	write_reg(PS3_AUDIO_INTR_EN_0, 0);
+
+	/* use every 4 buffer empty interrupt */
+	update_mask_reg(PS3_AUDIO_AX_IC,
+			PS3_AUDIO_AX_IC_AASOIMD_MASK,
+			PS3_AUDIO_AX_IC_AASOIMD_EVERY4);
+
+	/* enable 3wire clocks */
+	update_mask_reg(PS3_AUDIO_AO_3WMCTRL,
+			~(PS3_AUDIO_AO_3WMCTRL_ASOBCLKD_DISABLED |
+			  PS3_AUDIO_AO_3WMCTRL_ASOLRCKD_DISABLED),
+			0);
+	update_reg(PS3_AUDIO_AO_3WMCTRL,
+		   PS3_AUDIO_AO_3WMCTRL_ASOPLRCK_DEFAULT);
+}
+
+static int snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
+{
+	int ret;
+	pr_debug("%s: start\n", __func__);
+	card->avs.avs_audio_ch = PS3AV_CMD_AUDIO_NUM_OF_CH_2;
+	card->avs.avs_audio_rate = PS3AV_CMD_AUDIO_FS_48K;
+	card->avs.avs_audio_width = PS3AV_CMD_AUDIO_WORD_BITS_16;
+	card->avs.avs_audio_format = PS3AV_CMD_AUDIO_FORMAT_PCM;
+	card->avs.avs_audio_source = PS3AV_CMD_AUDIO_SOURCE_SERIAL;
+	memcpy(card->avs.avs_cs_info, ps3av_mode_cs_info, 8);
+
+	ret = snd_ps3_change_avsetting(card);
+
+	snd_ps3_audio_fixup(card);
+
+	/* to start to generate SPDIF signal, fill data */
+	snd_ps3_program_dma(card, SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL);
+	snd_ps3_kick_dma(card);
+	pr_debug("%s: end\n", __func__);
+	return ret;
+}
+
 static int __init snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 {
 	int i, ret;
@@ -1113,71 +1128,6 @@ static struct ps3_system_bus_driver snd_ps3_bus_driver_info = {
 
 
 /*
- * Interrupt handler
- */
-static irqreturn_t snd_ps3_interrupt(int irq, void *dev_id)
-{
-
-	uint32_t port_intr;
-	int underflow_occured = 0;
-	struct snd_ps3_card_info *card = dev_id;
-
-	if (!card->running) {
-		update_reg(PS3_AUDIO_AX_IS, 0);
-		update_reg(PS3_AUDIO_INTR_0, 0);
-		return IRQ_HANDLED;
-	}
-
-	port_intr = read_reg(PS3_AUDIO_AX_IS);
-	/*
-	 *serial buffer empty detected (every 4 times),
-	 *program next dma and kick it
-	 */
-	if (port_intr & PS3_AUDIO_AX_IE_ASOBEIE(0)) {
-		write_reg(PS3_AUDIO_AX_IS, PS3_AUDIO_AX_IE_ASOBEIE(0));
-		if (port_intr & PS3_AUDIO_AX_IE_ASOBUIE(0)) {
-			write_reg(PS3_AUDIO_AX_IS, port_intr);
-			underflow_occured = 1;
-		}
-		if (card->silent) {
-			/* we are still in silent time */
-			snd_ps3_program_dma(card,
-				(underflow_occured) ?
-				SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL :
-				SND_PS3_DMA_FILLTYPE_SILENT_RUNNING);
-			snd_ps3_kick_dma(card);
-			card->silent--;
-		} else {
-			snd_ps3_program_dma(card,
-				(underflow_occured) ?
-				SND_PS3_DMA_FILLTYPE_FIRSTFILL :
-				SND_PS3_DMA_FILLTYPE_RUNNING);
-			snd_ps3_kick_dma(card);
-			snd_pcm_period_elapsed(card->substream);
-		}
-	} else if (port_intr & PS3_AUDIO_AX_IE_ASOBUIE(0)) {
-		write_reg(PS3_AUDIO_AX_IS, PS3_AUDIO_AX_IE_ASOBUIE(0));
-		/*
-		 * serial out underflow, but buffer empty not detected.
-		 * in this case, fill fifo with 0 to recover.  After
-		 * filling dummy data, serial automatically start to
-		 * consume them and then will generate normal buffer
-		 * empty interrupts.
-		 * If both buffer underflow and buffer empty are occured,
-		 * it is better to do nomal data transfer than empty one
-		 */
-		snd_ps3_program_dma(card,
-				    SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL);
-		snd_ps3_kick_dma(card);
-		snd_ps3_program_dma(card,
-				    SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL);
-		snd_ps3_kick_dma(card);
-	}
-	/* clear interrupt cause */
-	return IRQ_HANDLED;
-};
-
-/*
  * module/subsystem initialize/terminate
  */
 static int __init snd_ps3_init(void)
@@ -1195,10 +1145,15 @@ static int __init snd_ps3_init(void)
 
 	return ret;
 }
+module_init(snd_ps3_init);
 
 static void __exit snd_ps3_exit(void)
 {
 	ps3_system_bus_driver_unregister(&snd_ps3_bus_driver_info);
 }
+module_exit(snd_ps3_exit);
 
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("PS3 sound driver");
+MODULE_AUTHOR("Sony Computer Entertainment Inc.");
 MODULE_ALIAS(PS3_MODULE_ALIAS_SOUND);
-- 
1.6.2.4
