Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3CD17DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 20:36:59 +1000 (EST)
Subject: [PATCH 1/2] Xlinx ML403 AC97 Controller Reference device driver
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 12:36:50 +0200
Message-Id: <1186655810.7420.26.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Joachim Foerster <JOFT@gmx.de>

Add ALSA support for the opb_ac97_controller_ref_v1_00_a ip core found
in Xilinx' ML403 reference design.

Known issue: Currently this driver hits a WARN_ON_ONCE(1) statement in
kernel/irq/resend.c (line 70). According to Linus
(http://lkml.org/lkml/2007/8/5/5) this may be ignored, right? I haven't
had a look into this "problem" yet.

(Patch for Linus' master branch, date 2007/08/08)

This patchset _will_ be published on
http://www.esic-solutions.com/support.html soon (like the first version
of the driver (tar file), but this may take some days ...).

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
---
 sound/ppc/Kconfig         |   13 +
 sound/ppc/Makefile        |    2 +
 sound/ppc/ml403_ac97cr.c  | 1274 +++++++++++++++++++++++++++++++++++++++++++++
 sound/ppc/pcm-indirect2.h |  658 +++++++++++++++++++++++
 4 files changed, 1947 insertions(+), 0 deletions(-)
 create mode 100644 sound/ppc/ml403_ac97cr.c
 create mode 100644 sound/ppc/pcm-indirect2.h

diff --git a/sound/ppc/Kconfig b/sound/ppc/Kconfig
index cacb0b1..cd492bf 100644
--- a/sound/ppc/Kconfig
+++ b/sound/ppc/Kconfig
@@ -52,4 +52,17 @@ config SND_PS3_DEFAULT_START_DELAY
 	int "Startup delay time in ms"
 	depends on SND_PS3
 	default "2000"
+
+config SND_ML403_AC97CR
+       tristate "Xilinx ML403 AC97 Controller Reference"
+       depends on SND && XILINX_VIRTEX
+       select SND_AC97_CODEC
+       help
+         Say Y here to include support for the
+         opb_ac97_controller_ref_v1_00_a ip core found in Xilinx' ML403
+         reference design.
+
+         To compile this driver as a module, choose M here: the module
+         will be called snd-ml403_ac97cr.
+
 endmenu
diff --git a/sound/ppc/Makefile b/sound/ppc/Makefile
index eacee2d..827f2f5 100644
--- a/sound/ppc/Makefile
+++ b/sound/ppc/Makefile
@@ -4,7 +4,9 @@
 #
 
 snd-powermac-objs := powermac.o pmac.o awacs.o burgundy.o daca.o tumbler.o keywest.o beep.o
+snd-ml403_ac97cr-objs := ml403_ac97cr.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_POWERMAC)	+= snd-powermac.o
 obj-$(CONFIG_SND_PS3)		+= snd_ps3.o
+obj-$(CONFIG_SND_ML403_AC97CR)	+= snd-ml403_ac97cr.o
diff --git a/sound/ppc/ml403_ac97cr.c b/sound/ppc/ml403_ac97cr.c
new file mode 100644
index 0000000..99791d7
--- /dev/null
+++ b/sound/ppc/ml403_ac97cr.c
@@ -0,0 +1,1274 @@
+
+/*  ALSA driver for Xilinx ML403 AC97 Controller Reference
+ *    IP: opb_ac97_controller_ref_v1_00_a (EDK 8.1i)
+ *    IP: opb_ac97_controller_ref_v1_00_a (EDK 9.1i)
+ *
+ *  Copyright (c) by 2007  Joachim Foerster <JOFT@gmx.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+
+#include <linux/platform_device.h>
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <linux/interrupt.h>
+
+/* HZ */
+#include <linux/param.h>
+/* jiffies, time_*() */
+#include <linux/jiffies.h>
+/* schedule_timeout*() */
+#include <linux/sched.h>
+/* spin_lock*() */
+#include <linux/spinlock.h>
+
+/* snd_printk(), snd_printd() */
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/ac97_codec.h>
+
+
+#define SND_ML403_AC97CR_DRIVER "ml403_ac97cr"
+
+MODULE_AUTHOR("Joachim Foerster <JOFT@gmx.de>");
+MODULE_DESCRIPTION("Xilinx ML403 AC97 Controller Reference");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{Xilinx,ML403 AC97 Controller Reference}}");
+MODULE_VERSION("0.0.1-pre2");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for ML403 AC97 Controller Reference.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for ML403 AC97 Controller Reference.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable this ML403 AC97 Controller Reference.");
+
+/* Special feature options */
+/*#define CODEC_WRITE_CHECK_RAF*/ /* don't return after a write to a codec
+				   * register, while RAF bit is not set
+				   */
+/* Debug options for code which may be removed completely in a final version */
+#ifdef CONFIG_SND_DEBUG
+/*#define CODEC_STAT*/            /* turn on some minimal "statistics"
+				   * about codec register usage
+				   */
+#define SND_PCM_INDIRECT2_STAT    /* turn on some "statistics" about the
+				   * process of copying bytes from the
+				   * intermediate buffer to the hardware
+				   * fifo and the other way round
+				   */
+#endif
+
+#include "pcm-indirect2.h"
+
+/* Definition of a "level/facility dependent" printk(); may be removed
+ * completely in a final version
+ */
+#undef PDEBUG
+#ifdef CONFIG_SND_DEBUG
+/* "facilities" for PDEBUG */
+#define UNKNOWN       (1<<0)
+#define CODEC_SUCCESS (1<<1)
+#define CODEC_FAKE    (1<<2)
+#define INIT_INFO     (1<<3)
+#define INIT_FAILURE  (1<<4)
+#define WORK_INFO     (1<<5)
+#define WORK_FAILURE  (1<<6)
+
+#define PDEBUG_FACILITIES (UNKNOWN | INIT_FAILURE | WORK_FAILURE)
+
+#define PDEBUG(fac, fmt, args...) if (fac & PDEBUG_FACILITIES) \
+		snd_printd(KERN_DEBUG SND_ML403_AC97CR_DRIVER ": " fmt, ##args)
+#else
+#define PDEBUG(fac, fmt, args...) /* nothing */
+#endif
+
+
+
+/* Defines for "waits"/timeouts (portions of HZ=250 on arch/ppc by default) */
+#define CODEC_TIMEOUT_ON_INIT       5	/* timeout for checking for codec
+					 * readiness (after insmod)
+					 */
+#ifndef CODEC_WRITE_CHECK_RAF
+#define CODEC_WAIT_AFTER_WRITE    100	/* general, static wait after a write
+					 * access to a codec register, may be
+					 * 0 to completely remove wait
+					 */
+#else
+#define CODEC_TIMEOUT_AFTER_WRITE   5	/* timeout after a write access to a
+					 * codec register, if RAF bit is used
+					 */
+#endif
+#define CODEC_TIMEOUT_AFTER_READ    5	/* timeout after a read access to a
+					 * codec register (checking RAF bit)
+					 */
+
+/* Infrastructure for codec register shadowing */
+#define LM4550_REG_DONEREAD  (1<<0)   /* read register once, value should be the
+				       * same currently in the register
+				       */
+#define LM4550_REG_NOSAVE    (1<<1)   /* values written to this register will
+				       * not be saved in the register
+				       */
+#define LM4550_REG_NOSHADOW  (1<<2)   /* don't do register shadowing, use plain
+				       * hardware access
+				       */
+#define LM4550_REG_READONLY  (1<<3)   /* register is read only */
+#define LM4550_REG_FAKEPROBE (1<<4)   /* fake write _and_ read actions during
+				       * probe() correctly
+				       */
+#define LM4550_REG_FAKEREAD  (1<<5)   /* fake read access, always return default
+				       * value
+				       */
+#define LM4550_REG_ALLFAKE   (LM4550_REG_FAKEREAD | LM4550_REG_FAKEPROBE)
+
+struct lm4550_reg {
+	u16 reg;
+	u16 value;
+	u16 flag;
+	u16 wmask;
+	u16 def;
+};
+
+struct lm4550_reg lm4550_regfile[64] = {
+	{.reg = 0x00,
+	 .flag = LM4550_REG_NOSAVE | LM4550_REG_FAKEREAD,
+	 .def = 0x0D50},
+	{.reg = 0x02,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x9F1F,
+	 .def = 0x8000},
+	{.reg = 0x04,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x9F1F,
+	 .def = 0x8000},
+	{.reg = 0x06,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x801F,
+	 .def = 0x8000},
+	{},
+	{.reg = 0x0A,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x801E,
+	 .def = 0x0},
+	{.reg = 0x0C,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x801F,
+	 .def = 0x8008},
+	{.reg = 0x0E,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x805F,
+	 .def = 0x8008},
+	{.reg = 0x10,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x9F1F,
+	 .def = 0x8808},
+	{.reg = 0x12,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x9F1F,
+	 .def = 0x8808},
+	{.reg = 0x14,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x9F1F,
+	 .def = 0x8808},
+	{.reg = 0x16,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x9F1F,
+	 .def = 0x8808},
+	{.reg = 0x18,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x9F1F,
+	 .def = 0x8008},
+	{.reg = 0x1A,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x707,
+	 .def = 0x0},
+	{.reg = 0x1C,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .wmask = 0x8F0F,
+	 .def = 0x8000},
+	{},
+	{.reg = 0x20,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .def = 0x0,
+	 .wmask = 0xA380},
+	{.reg = 0x22,
+	 .flag = LM4550_REG_FAKEREAD | LM4550_REG_READONLY,
+	 .def = 0x0101},
+	{},
+	{.reg = 0x26,
+	 .flag = LM4550_REG_NOSHADOW | LM4550_REG_NOSAVE,
+	 .wmask = 0xFF00}, /* may not write ones to REF/ANL/DAC/ADC bits
+			    * FIXME: Is this ok?
+			    */
+	{.reg = 0x28,
+	 .flag = LM4550_REG_FAKEREAD | LM4550_REG_READONLY,
+	 .def = 0x0201}, /* primary codec */
+	{.reg = 0x2A,
+	 .flag = LM4550_REG_NOSHADOW | LM4550_REG_NOSAVE,
+	 .wmask = 0x1},
+	{.reg = 0x2C,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .def = 0xBB80,
+	 .wmask = 0xFFFF},
+	{}, {},
+	{.reg = 0x32,
+	 .flag = LM4550_REG_FAKEPROBE,
+	 .def = 0xBB80,
+	 .wmask = 0xFFFF},
+	{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
+	{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},	{}, {}, {}, {}, {}, {},
+	{.reg = 0x7C,
+	 .flag = LM4550_REG_READONLY | LM4550_REG_FAKEREAD,
+	 .def = 0x4E53},
+	{.reg = 0x7E,
+	 .flag = LM4550_REG_READONLY | LM4550_REG_FAKEREAD,
+	 .def = 0x4350}
+};
+
+#define LM4550_RF_OK(reg)    ((lm4550_regfile[reg / 2].reg != 0) \
+			      || (lm4550_regfile[reg / 2].flag != 0))
+#define LM4550_RF_FLAG(reg)  lm4550_regfile[reg / 2].flag
+#define LM4550_RF_VAL(reg)   lm4550_regfile[reg / 2].value
+#define LM4550_RF_DEF(reg)   lm4550_regfile[reg / 2].def
+#define LM4550_RF_WMASK(reg) lm4550_regfile[reg / 2].wmask
+
+static void lm4550_regfile_init(void)
+{
+	int i;
+	for (i = 0; i < 128; i = i + 2)
+		if (LM4550_RF_FLAG(i) & LM4550_REG_FAKEPROBE)
+			LM4550_RF_VAL(i) = LM4550_RF_DEF(i);
+}
+
+static void lm4550_regfile_write_values_after_init(struct snd_ac97 *ac97)
+{
+	int i;
+	for (i = 0; i < 128; i = i + 2)
+		if ((LM4550_RF_FLAG(i) & LM4550_REG_FAKEPROBE) &&
+		    (LM4550_RF_VAL(i) != LM4550_RF_DEF(i))) {
+			PDEBUG(CODEC_FAKE, "lm4550_regfile_write_values_after_"
+			       "init(): reg=0x%x value=0x%x / %d is different "
+			       "from def=0x%x / %d\n",
+			       i, LM4550_RF_VAL(i), LM4550_RF_VAL(i),
+			       LM4550_RF_DEF(i), LM4550_RF_DEF(i));
+			snd_ac97_write(ac97, i, LM4550_RF_VAL(i));
+			LM4550_RF_FLAG(i) |= LM4550_REG_DONEREAD;
+		}
+}
+
+
+/* direct registers */
+#define CR_REG(ml403_ac97cr,x) ((ml403_ac97cr)->port + CR_REG_##x)
+
+#define CR_REG_PLAYFIFO         0x00
+#define   CR_PLAYDATA(a)        ((a) & 0xFFFF)
+
+#define CR_REG_RECFIFO          0x04
+#define   CR_RECDATA(a)         ((a) & 0xFFFF)
+
+#define CR_REG_STATUS           0x08
+#define   CR_RECOVER            (1<<7)
+#define   CR_PLAYUNDER          (1<<6)
+#define   CR_CODECREADY         (1<<5)
+#define   CR_RAF                (1<<4)
+#define   CR_RECEMPTY           (1<<3)
+#define   CR_RECFULL            (1<<2)
+#define   CR_PLAYHALF           (1<<1)
+#define   CR_PLAYFULL           (1<<0)
+
+#define CR_REG_RESETFIFO        0x0C
+#define   CR_RECRESET           (1<<1)
+#define   CR_PLAYRESET          (1<<0)
+
+#define CR_REG_CODEC_ADDR       0x10
+/* UG082 says:
+ * #define   CR_CODEC_ADDR(a)  ((a) << 1)
+ * #define   CR_CODEC_READ     (1<<0)
+ * #define   CR_CODEC_WRITE    (0<<0)
+ */
+/* RefDesign example says: */
+#define   CR_CODEC_ADDR(a)      ((a) << 0)
+#define   CR_CODEC_READ         (1<<7)
+#define   CR_CODEC_WRITE        (0<<7)
+
+#define CR_REG_CODEC_DATAREAD   0x14
+#define   CR_CODEC_DATAREAD(v)  ((v) & 0xFFFF)
+
+#define CR_REG_CODEC_DATAWRITE  0x18
+#define   CR_CODEC_DATAWRITE(v) ((v) & 0xFFFF)
+
+#define CR_FIFO_SIZE            32
+
+struct snd_ml403_ac97cr {
+	spinlock_t reg_lock;
+
+	int irq; /* for playback */
+	int enable_irq;	/* for playback */
+
+	int capture_irq;
+	int enable_capture_irq;
+
+	struct resource *res_port;
+	void *port;
+
+	struct snd_ac97 *ac97;
+	int ac97_fake;
+#ifdef CODEC_STAT
+	int ac97_read;
+	int ac97_write;
+#endif
+
+	struct platform_device *pfdev;
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	struct snd_pcm_substream *playback_substream;
+	struct snd_pcm_substream *capture_substream;
+
+	struct snd_pcm_indirect2 ind_rec; /* for playback */
+	struct snd_pcm_indirect2 capture_ind2_rec;
+};
+
+static struct snd_pcm_hardware snd_ml403_ac97cr_playback = {
+	.info =	            (SNDRV_PCM_INFO_MMAP |
+		             SNDRV_PCM_INFO_INTERLEAVED |
+		             SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =          SNDRV_PCM_FMTBIT_S16_BE,
+	.rates =	    (SNDRV_PCM_RATE_CONTINUOUS |
+			     SNDRV_PCM_RATE_8000_48000 |
+			     SNDRV_PCM_RATE_KNOT),
+	.rate_min =	    4000,
+	.rate_max =	    48000,
+	.channels_min =     2,
+	.channels_max =     2,
+	.buffer_bytes_max = (128*1024),
+	.period_bytes_min = CR_FIFO_SIZE/2,
+	.period_bytes_max = (64*1024),
+	.periods_min =      2,
+	.periods_max =      (128*1024)/(CR_FIFO_SIZE/2),
+	.fifo_size =	    0,
+};
+
+static struct snd_pcm_hardware snd_ml403_ac97cr_capture = {
+	.info =	            (SNDRV_PCM_INFO_MMAP |
+			     SNDRV_PCM_INFO_INTERLEAVED |
+			     SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =          SNDRV_PCM_FMTBIT_S16_BE,
+	.rates =            (SNDRV_PCM_RATE_CONTINUOUS |
+			     SNDRV_PCM_RATE_8000_48000 |
+			     SNDRV_PCM_RATE_KNOT),
+	.rate_min =         4000,
+	.rate_max =         48000,
+	.channels_min =     2,
+	.channels_max =     2,
+	.buffer_bytes_max = (128*1024),
+	.period_bytes_min = CR_FIFO_SIZE/2,
+	.period_bytes_max = (64*1024),
+	.periods_min =      2,
+	.periods_max =      (128*1024)/(CR_FIFO_SIZE/2),
+	.fifo_size =	    0,
+};
+
+static size_t
+snd_ml403_ac97cr_playback_ind2_zero(struct snd_pcm_substream *substream,
+				    struct snd_pcm_indirect2 *rec)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	int copied_words = 0;
+	u32 full = 0;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+
+	spin_lock(&ml403_ac97cr->reg_lock);
+	while ((full = (in_be32(CR_REG(ml403_ac97cr, STATUS)) &
+			CR_PLAYFULL)) != CR_PLAYFULL) {
+		out_be32(CR_REG(ml403_ac97cr, PLAYFIFO), 0);
+		copied_words++;
+	}
+	rec->hw_ready = 0;
+	spin_unlock(&ml403_ac97cr->reg_lock);
+
+	return (size_t) (copied_words * 2);
+}
+
+static size_t
+snd_ml403_ac97cr_playback_ind2_copy(struct snd_pcm_substream *substream,
+				    struct snd_pcm_indirect2 *rec, size_t bytes)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	u16 *src;
+	int copied_words = 0;
+	u32 full = 0;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+	src = substream->runtime->dma_area + rec->sw_data;
+
+	spin_lock(&ml403_ac97cr->reg_lock);
+	while (((full = (in_be32(CR_REG(ml403_ac97cr, STATUS)) &
+			 CR_PLAYFULL)) != CR_PLAYFULL) && (bytes > 1)) {
+		out_be32(CR_REG(ml403_ac97cr, PLAYFIFO),
+			 CR_PLAYDATA(src[copied_words]));
+		copied_words++;
+		bytes = bytes - 2;
+	}
+	if (full != CR_PLAYFULL)
+		rec->hw_ready = 1;
+	else
+		rec->hw_ready = 0;
+	spin_unlock(&ml403_ac97cr->reg_lock);
+
+	return (size_t) (copied_words * 2);
+}
+
+static size_t
+snd_ml403_ac97cr_capture_ind2_null(struct snd_pcm_substream *substream,
+				   struct snd_pcm_indirect2 *rec)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	int copied_words = 0;
+	u32 empty = 0;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+
+	spin_lock(&ml403_ac97cr->reg_lock);
+	while ((empty = (in_be32(CR_REG(ml403_ac97cr, STATUS)) &
+			 CR_RECEMPTY)) != CR_RECEMPTY) {
+		volatile u32 trash;
+
+		trash = CR_RECDATA(in_be32(CR_REG(ml403_ac97cr, RECFIFO)));
+		/* Hmmmm, really necessary? */
+		++trash;
+		copied_words++;
+	}
+	rec->hw_ready = 0;
+	spin_unlock(&ml403_ac97cr->reg_lock);
+
+	return (size_t) (copied_words * 2);
+}
+
+static size_t
+snd_ml403_ac97cr_capture_ind2_copy(struct snd_pcm_substream *substream,
+				   struct snd_pcm_indirect2 *rec, size_t bytes)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	u16 *dst;
+	int copied_words = 0;
+	u32 empty = 0;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+	dst = substream->runtime->dma_area + rec->sw_data;
+
+	spin_lock(&ml403_ac97cr->reg_lock);
+	while (((empty = (in_be32(CR_REG(ml403_ac97cr, STATUS)) &
+			  CR_RECEMPTY)) != CR_RECEMPTY) && (bytes > 1)) {
+		dst[copied_words] = CR_RECDATA(in_be32(CR_REG(ml403_ac97cr,
+							      RECFIFO)));
+		copied_words++;
+		bytes = bytes - 2;
+	}
+	if (empty != CR_RECEMPTY)
+		rec->hw_ready = 1;
+	else
+		rec->hw_ready = 0;
+	spin_unlock(&ml403_ac97cr->reg_lock);
+
+	return (size_t) (copied_words * 2);
+}
+
+static snd_pcm_uframes_t
+snd_ml403_ac97cr_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	struct snd_pcm_indirect2 *ind2_rec = NULL;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+
+	if (substream == ml403_ac97cr->playback_substream)
+		ind2_rec = &ml403_ac97cr->ind_rec;
+	if (substream == ml403_ac97cr->capture_substream)
+		ind2_rec = &ml403_ac97cr->capture_ind2_rec;
+
+	if (ind2_rec != NULL)
+		return snd_pcm_indirect2_pointer(substream, ind2_rec);
+	return (snd_pcm_uframes_t) 0;
+}
+
+static int
+snd_ml403_ac97cr_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	int err = 0;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (substream == ml403_ac97cr->playback_substream) {
+			PDEBUG(WORK_INFO, "trigger(playback): START\n");
+			ml403_ac97cr->ind_rec.hw_ready = 1;
+
+			/* clear play FIFO */
+			out_be32(CR_REG(ml403_ac97cr, RESETFIFO), CR_PLAYRESET);
+
+			/* enable play irq */
+			ml403_ac97cr->enable_irq = 1;
+			enable_irq(ml403_ac97cr->irq);
+		}
+		if (substream == ml403_ac97cr->capture_substream) {
+			PDEBUG(WORK_INFO, "trigger(capture): START\n");
+			ml403_ac97cr->capture_ind2_rec.hw_ready = 0;
+
+			/* clear record FIFO */
+			out_be32(CR_REG(ml403_ac97cr, RESETFIFO), CR_RECRESET);
+
+			/* enable record irq */
+			ml403_ac97cr->enable_capture_irq = 1;
+			enable_irq(ml403_ac97cr->capture_irq);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (substream == ml403_ac97cr->playback_substream) {
+			PDEBUG(WORK_INFO, "trigger(playback): STOP\n");
+			ml403_ac97cr->ind_rec.hw_ready = 0;
+#ifdef SND_PCM_INDIRECT2_STAT
+			snd_pcm_indirect2_stat(substream,
+					       &ml403_ac97cr->ind_rec);
+#endif
+			/* disable play irq */
+			disable_irq_nosync(ml403_ac97cr->irq);
+			ml403_ac97cr->enable_irq = 0;
+		}
+		if (substream == ml403_ac97cr->capture_substream) {
+			PDEBUG(WORK_INFO, "trigger(capture): STOP\n");
+			ml403_ac97cr->capture_ind2_rec.hw_ready = 0;
+#ifdef SND_PCM_INDIRECT2_STAT
+			snd_pcm_indirect2_stat(substream,
+					       &ml403_ac97cr->capture_ind2_rec);
+#endif
+			/* disable capture irq */
+			disable_irq_nosync(ml403_ac97cr->capture_irq);
+			ml403_ac97cr->enable_capture_irq = 0;
+		}
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+	PDEBUG(WORK_INFO, "trigger(): (done)\n");
+	return err;
+}
+
+static int snd_ml403_ac97cr_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	struct snd_pcm_runtime *runtime;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+	runtime = substream->runtime;
+
+	if (substream == ml403_ac97cr->playback_substream) {
+		PDEBUG(WORK_INFO,
+		       "prepare(): period_bytes=%d, minperiod_bytes=%d\n",
+		       snd_pcm_lib_period_bytes(substream), CR_FIFO_SIZE / 2);
+
+		/* set sampling rate */
+		snd_ac97_set_rate(ml403_ac97cr->ac97, AC97_PCM_FRONT_DAC_RATE,
+				  runtime->rate);
+		PDEBUG(WORK_INFO, "prepare(): rate=%d\n", runtime->rate);
+
+		/* init struct for intermediate buffer */
+		memset(&ml403_ac97cr->ind_rec, 0,
+		       sizeof(struct snd_pcm_indirect2));
+		ml403_ac97cr->ind_rec.hw_buffer_size = CR_FIFO_SIZE;
+		ml403_ac97cr->ind_rec.sw_buffer_size =
+		    snd_pcm_lib_buffer_bytes(substream);
+		ml403_ac97cr->ind_rec.min_periods = -1;
+		ml403_ac97cr->ind_rec.min_multiple =
+		    snd_pcm_lib_period_bytes(substream) / (CR_FIFO_SIZE / 2);
+		PDEBUG(WORK_INFO, "prepare(): hw_buffer_size=%d, "
+		       "sw_buffer_size=%d, min_multiple=%d\n",
+		       CR_FIFO_SIZE, ml403_ac97cr->ind_rec.sw_buffer_size,
+		       ml403_ac97cr->ind_rec.min_multiple);
+	}
+	if (substream == ml403_ac97cr->capture_substream) {
+		PDEBUG(WORK_INFO, "prepare(capture): period_bytes=%d, "
+		       "minperiod_bytes=%d\n",
+		       snd_pcm_lib_period_bytes(substream), CR_FIFO_SIZE / 2);
+
+		/* set sampling rate */
+		snd_ac97_set_rate(ml403_ac97cr->ac97, AC97_PCM_LR_ADC_RATE,
+				  runtime->rate);
+		PDEBUG(WORK_INFO, "prepare(capture): rate=%d\n", runtime->rate);
+
+		/* init struct for intermediate buffer */
+		memset(&ml403_ac97cr->capture_ind2_rec, 0,
+		       sizeof(struct snd_pcm_indirect2));
+		ml403_ac97cr->capture_ind2_rec.hw_buffer_size = CR_FIFO_SIZE;
+		ml403_ac97cr->capture_ind2_rec.sw_buffer_size =
+		    snd_pcm_lib_buffer_bytes(substream);
+		ml403_ac97cr->capture_ind2_rec.min_multiple =
+		    snd_pcm_lib_period_bytes(substream) / (CR_FIFO_SIZE / 2);
+		PDEBUG(WORK_INFO, "prepare(capture): hw_buffer_size=%d, "
+		       "sw_buffer_size=%d, min_multiple=%d\n", CR_FIFO_SIZE,
+		       ml403_ac97cr->capture_ind2_rec.sw_buffer_size,
+		       ml403_ac97cr->capture_ind2_rec.min_multiple);
+	}
+	return 0;
+}
+
+static int snd_ml403_ac97cr_hw_free(struct snd_pcm_substream *substream)
+{
+	PDEBUG(WORK_INFO, "hw_free()\n");
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int
+snd_ml403_ac97cr_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *hw_params)
+{
+	PDEBUG(WORK_INFO, "hw_params(): desired buffer bytes=%d, desired "
+	       "period bytes=%d\n",
+	       params_buffer_bytes(hw_params), params_period_bytes(hw_params));
+	/* check period bytes, has to be multiple of CR_FIFO_SIZE / 2, don't
+	 * know if ALSA takes multiples of period_bytes_min _only_ ...?!
+	 */
+	if (params_period_bytes(hw_params) % (CR_FIFO_SIZE / 2) != 0) {
+		snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+			   "hw_params(): period bytes (%d) are not a multiple "
+			   "of %d bytes!\n",
+			   params_period_bytes(hw_params), CR_FIFO_SIZE / 2);
+		return -EINVAL;
+	}
+	return snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+}
+
+static int snd_ml403_ac97cr_playback_open(struct snd_pcm_substream *substream)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	struct snd_pcm_runtime *runtime;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+	runtime = substream->runtime;
+
+	PDEBUG(WORK_INFO, "open(playback)\n");
+	ml403_ac97cr->playback_substream = substream;
+	runtime->hw = snd_ml403_ac97cr_playback;
+	return 0;
+}
+
+static int snd_ml403_ac97cr_capture_open(struct snd_pcm_substream *substream)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	struct snd_pcm_runtime *runtime;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+	runtime = substream->runtime;
+
+	PDEBUG(WORK_INFO, "open(capture)\n");
+	ml403_ac97cr->capture_substream = substream;
+	runtime->hw = snd_ml403_ac97cr_capture;
+	return 0;
+}
+
+static int snd_ml403_ac97cr_playback_close(struct snd_pcm_substream *substream)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+
+	PDEBUG(WORK_INFO, "close(playback)\n");
+	ml403_ac97cr->playback_substream = NULL;
+	return 0;
+}
+
+static int snd_ml403_ac97cr_capture_close(struct snd_pcm_substream *substream)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+
+	ml403_ac97cr = snd_pcm_substream_chip(substream);
+
+	PDEBUG(WORK_INFO, "close(capture)\n");
+	ml403_ac97cr->capture_substream = NULL;
+	return 0;
+}
+
+struct snd_pcm_ops snd_ml403_ac97cr_playback_ops = {
+	.open = snd_ml403_ac97cr_playback_open,
+	.close = snd_ml403_ac97cr_playback_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_ml403_ac97cr_hw_params,
+	.hw_free = snd_ml403_ac97cr_hw_free,
+	.prepare = snd_ml403_ac97cr_pcm_prepare,
+	.trigger = snd_ml403_ac97cr_pcm_trigger,
+	.pointer = snd_ml403_ac97cr_pcm_pointer,
+};
+
+static struct snd_pcm_ops snd_ml403_ac97cr_capture_ops = {
+	.open = snd_ml403_ac97cr_capture_open,
+	.close = snd_ml403_ac97cr_capture_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_ml403_ac97cr_hw_params,
+	.hw_free = snd_ml403_ac97cr_hw_free,
+	.prepare = snd_ml403_ac97cr_pcm_prepare,
+	.trigger = snd_ml403_ac97cr_pcm_trigger,
+	.pointer = snd_ml403_ac97cr_pcm_pointer,
+};
+
+irqreturn_t snd_ml403_ac97cr_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	struct platform_device *pfdev;
+	int cmp_irq;
+
+	if ((ml403_ac97cr = (struct snd_ml403_ac97cr *)dev_id) == NULL)
+		return IRQ_NONE;
+
+	pfdev = ml403_ac97cr->pfdev;
+
+	/* playback interrupt */
+	cmp_irq = platform_get_irq(pfdev, 0);
+	if (irq == cmp_irq) {
+		if (ml403_ac97cr->enable_irq) {
+			snd_pcm_indirect2_playback_interrupt(
+				ml403_ac97cr->playback_substream,
+				&ml403_ac97cr->ind_rec,
+				snd_ml403_ac97cr_playback_ind2_copy,
+				snd_ml403_ac97cr_playback_ind2_zero);
+		} else
+			goto __disable_irq;
+	} else {
+		/* record interrupt */
+		cmp_irq = platform_get_irq(pfdev, 1);
+		if (irq == cmp_irq) {
+			if (ml403_ac97cr->enable_capture_irq) {
+				snd_pcm_indirect2_capture_interrupt(
+					ml403_ac97cr->capture_substream,
+					&ml403_ac97cr->capture_ind2_rec,
+					snd_ml403_ac97cr_capture_ind2_copy,
+					snd_ml403_ac97cr_capture_ind2_null);
+			} else {
+				goto __disable_irq;
+			}
+		} else {
+			return IRQ_NONE;
+		}
+	}
+	return IRQ_HANDLED;
+
+      __disable_irq:
+	PDEBUG(INIT_INFO, "irq(): irq %d is meant to be disabled! So, now try "
+	       "to disable it _really_!\n", irq);
+	disable_irq_nosync(irq);
+	return IRQ_HANDLED;
+}
+
+static unsigned short
+snd_ml403_ac97cr_codec_read(struct snd_ac97 *ac97, unsigned short reg)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr = ac97->private_data;
+#ifdef CODEC_STAT
+	u32 stat, rafaccess = 0;
+#endif
+	unsigned long end_time;
+	u16 value = 0;
+
+	if (!LM4550_RF_OK(reg)) {
+		snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+			   "access to unknown/unused codec register 0x%x "
+			   "ignored!\n", reg);
+		return 0;
+	}
+	/* check if we can fake/answer this access from our shadow register */
+	if ((LM4550_RF_FLAG(reg) &
+	     (LM4550_REG_DONEREAD | LM4550_REG_ALLFAKE)) &&
+	    !(LM4550_RF_FLAG(reg) & LM4550_REG_NOSHADOW)) {
+		if (LM4550_RF_FLAG(reg) & LM4550_REG_FAKEREAD) {
+			PDEBUG(CODEC_FAKE, "codec_read(): faking read from "
+			       "reg=0x%x, val=0x%x / %d\n",
+			       reg, LM4550_RF_DEF(reg), LM4550_RF_DEF(reg));
+			return LM4550_RF_DEF(reg);
+		} else if ((LM4550_RF_FLAG(reg) & LM4550_REG_FAKEPROBE) &&
+			   ml403_ac97cr->ac97_fake) {
+			PDEBUG(CODEC_FAKE, "codec_read(): faking read from "
+			       "reg=0x%x, val=0x%x / %d (probe)\n",
+			       reg, LM4550_RF_VAL(reg), LM4550_RF_VAL(reg));
+			return LM4550_RF_VAL(reg);
+		} else {
+#ifdef CODEC_STAT
+			PDEBUG(CODEC_FAKE, "codec_read(): read access "
+			       "answered by shadow register 0x%x (value=0x%x "
+			       "/ %d) (cw=%d cr=%d)\n",
+			       reg, LM4550_RF_VAL(reg), LM4550_RF_VAL(reg),
+			       ml403_ac97cr->ac97_write,
+			       ml403_ac97cr->ac97_read);
+#else
+			PDEBUG(CODEC_FAKE, "codec_read(): read access "
+			       "answered by shadow register 0x%x (value=0x%x "
+			       "/ %d)\n",
+			       reg, LM4550_RF_VAL(reg), LM4550_RF_VAL(reg));
+#endif
+			return LM4550_RF_VAL(reg);
+		}
+	}
+	/* if we are here, we _have_ to access the codec really, no faking */
+	spin_lock(&ml403_ac97cr->reg_lock);
+#ifdef CODEC_STAT
+	ml403_ac97cr->ac97_read++;
+#endif
+	out_be32(CR_REG(ml403_ac97cr, CODEC_ADDR),
+		 CR_CODEC_ADDR(reg) | CR_CODEC_READ);
+	end_time = jiffies + (HZ / CODEC_TIMEOUT_AFTER_READ);
+	do {
+#ifdef CODEC_STAT
+		rafaccess++;
+		if (((stat = in_be32(CR_REG(ml403_ac97cr, STATUS))) &
+		     CR_RAF) == CR_RAF) {
+			value = CR_CODEC_DATAREAD(
+				in_be32(CR_REG(ml403_ac97cr, CODEC_DATAREAD)));
+			PDEBUG(CODEC_SUCCESS, "codec_read(): (done) reg=0x%x, "
+			       "value=0x%x / %d (STATUS=0x%x)\n",
+			       reg, value, value, stat);
+#else
+		if ((in_be32(CR_REG(ml403_ac97cr, STATUS)) &
+		     CR_RAF) == CR_RAF) {
+			value = CR_CODEC_DATAREAD(
+				in_be32(CR_REG(ml403_ac97cr, CODEC_DATAREAD)));
+			PDEBUG(CODEC_SUCCESS, "codec_read(): (done) "
+			       "reg=0x%x, value=0x%x / %d\n",
+			       reg, value, value);
+#endif
+			lm4550_regfile[reg / 2].value = value;
+			lm4550_regfile[reg / 2].flag |= LM4550_REG_DONEREAD;
+			spin_unlock(&ml403_ac97cr->reg_lock);
+			return value;
+		}
+		schedule_timeout_uninterruptible(1);
+	} while (time_after(end_time, jiffies));
+	value =
+	    CR_CODEC_DATAREAD(in_be32(CR_REG(ml403_ac97cr, CODEC_DATAREAD)));
+#ifdef CODEC_STAT
+	snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+		   "timeout while codec read! "
+		   "(reg=0x%x, last STATUS=0x%x, DATAREAD=0x%x / %d, %d) "
+		   "(cw=%d, cr=%d)\n",
+		   reg, stat, value, value, rafaccess, ml403_ac97cr->ac97_write,
+		   ml403_ac97cr->ac97_read);
+#else
+	snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+		   "timeout while codec read! (reg=0x%x, DATAREAD=0x%x / %d)\n",
+		   reg, value, value);
+#endif
+	/* BUG: This is PURE speculation! But after _most_ read timeouts the
+	 * value in the register is ok!
+	 */
+	lm4550_regfile[reg / 2].value = value;
+	lm4550_regfile[reg / 2].flag |= LM4550_REG_DONEREAD;
+	spin_unlock(&ml403_ac97cr->reg_lock);
+	return value;
+}
+
+static void
+snd_ml403_ac97cr_codec_write(struct snd_ac97 *ac97, unsigned short reg,
+			     unsigned short val)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr = ac97->private_data;
+
+#ifdef CODEC_STAT
+	u32 stat, rafaccess = 0;
+#endif
+#ifdef CODEC_WRITE_CHECK_RAF
+	unsigned long end_time;
+#endif
+
+	if (!LM4550_RF_OK(reg)) {
+		snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+			   "access to unknown/unused codec register 0x%x "
+			   "ignored!\n", reg);
+		return;
+	}
+	if (LM4550_RF_FLAG(reg) & LM4550_REG_READONLY) {
+		snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+			   "write access to read only codec register 0x%x "
+			   "ignored!\n", reg);
+		return;
+	}
+	if ((val & LM4550_RF_WMASK(reg)) != val) {
+		snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+			   "write access to codec register 0x%x with bad value "
+			   "0x%x / %d!\n",
+			   reg, val, val);
+		val = val & LM4550_RF_WMASK(reg);
+	}
+	if (((LM4550_RF_FLAG(reg) & LM4550_REG_FAKEPROBE) &&
+	     ml403_ac97cr->ac97_fake) &&
+	    !(LM4550_RF_FLAG(reg) & LM4550_REG_NOSHADOW)) {
+		PDEBUG(CODEC_FAKE, "codec_write(): faking write to reg=0x%x, "
+		       "val=0x%x / %d\n", reg, val, val);
+		LM4550_RF_VAL(reg) = (val & LM4550_RF_WMASK(reg));
+		return;
+	}
+	spin_lock(&ml403_ac97cr->reg_lock);
+#ifdef CODEC_STAT
+	ml403_ac97cr->ac97_write++;
+#endif
+	out_be32(CR_REG(ml403_ac97cr, CODEC_DATAWRITE),
+		 CR_CODEC_DATAWRITE(val));
+	out_be32(CR_REG(ml403_ac97cr, CODEC_ADDR),
+		 CR_CODEC_ADDR(reg) | CR_CODEC_WRITE);
+#ifdef CODEC_WRITE_CHECK_RAF
+	/* check CR_CODEC_RAF bit to see if write access to register is done;
+	 * loop until bit is set or timeout happens
+	 */
+	end_time = jiffies + HZ / CODEC_TIMEOUT_AFTER_WRITE;
+	do {
+#ifdef CODEC_STAT
+		rafaccess++;
+		if (((stat = in_be32(CR_REG(ml403_ac97cr, STATUS))) &
+		     CR_RAF) == CR_RAF) {
+#else
+		if ((in_be32(CR_REG(ml403_ac97cr, STATUS)) &
+		     CR_RAF) == CR_RAF) {
+#endif
+			PDEBUG(CODEC_SUCCESS, "codec_write(): (done) reg=0x%x, "
+			       "value=%d / 0x%x\n", reg, val, val);
+			if (!(LM4550_RF_FLAG(reg) & LM4550_REG_NOSHADOW) &&
+			    !(LM4550_RF_FLAG(reg) & LM4550_REG_NOSAVE))
+				lm4550_regfile[reg / 2].value = val;
+			lm4550_regfile[reg / 2].flag |= LM4550_REG_DONEREAD;
+			spin_unlock(&ml403_ac97cr->reg_lock);
+			return;
+		}
+		schedule_timeout_uninterruptible(1);
+	} while (time_after(end_time, jiffies));
+#ifdef CODEC_STAT
+	snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+		   "timeout while codec write "
+		   "(reg=0x%x, val=0x%x / %d, last STATUS=0x%x, %d) "
+		   "(cw=%d, cr=%d)\n",
+		   reg, val, val, stat, rafaccess, ml403_ac97cr->ac97_write,
+		   ml403_ac97cr->ac97_read);
+#else
+	snd_printk(KERN_WARNING SND_ML403_AC97CR_DRIVER ": "
+		   "timeout while codec write (reg=0x%x, val=0x%x / %d)\n",
+		   reg, val, val);
+#endif
+#else				/* CODEC_WRITE_CHECK_RAF */
+#if CODEC_WAIT_AFTER_WRITE > 0
+	/* officially, in AC97 spec there is no possibility for a AC97
+	 * controller to determine, if write access is done or not - so: How
+	 * is Xilinx able to provide a RAF bit for write access?
+	 * => very strange, thus just don't check RAF bit (compare with
+	 * Xilinx's example app in EDK 8.1i) and wait
+	 */
+	schedule_timeout_uninterruptible(HZ / CODEC_WAIT_AFTER_WRITE);
+#endif
+	PDEBUG(CODEC_SUCCESS, "codec_write(): (done) reg=0x%x, value=%d / 0x%x "
+	       "(no RAF check)\n",
+	       reg, val, val);
+#endif
+	spin_unlock(&ml403_ac97cr->reg_lock);
+	return;
+}
+
+static int snd_ml403_ac97cr_chip_init(struct snd_ml403_ac97cr *ml403_ac97cr)
+{
+	unsigned long end_time;
+	PDEBUG(INIT_INFO, "chip_init():\n");
+	end_time = jiffies + HZ / CODEC_TIMEOUT_ON_INIT;
+	do {
+		if (in_be32(CR_REG(ml403_ac97cr, STATUS)) & CR_CODECREADY) {
+			/* clear both hardware FIFOs */
+			out_be32(CR_REG(ml403_ac97cr, RESETFIFO),
+				 CR_RECRESET | CR_PLAYRESET);
+			PDEBUG(INIT_INFO, "chip_init(): (done)\n");
+			return 0;
+		}
+		schedule_timeout_uninterruptible(1);
+	} while (time_after(end_time, jiffies));
+	snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
+		   "timeout while waiting for codec, "
+		   "not ready!\n");
+	return -EBUSY;
+}
+
+static int snd_ml403_ac97cr_free(struct snd_ml403_ac97cr *ml403_ac97cr)
+{
+	PDEBUG(INIT_INFO, "free():\n");
+	/* irq release */
+	if (ml403_ac97cr->irq >= 0)
+		free_irq(ml403_ac97cr->irq, ml403_ac97cr);
+	if (ml403_ac97cr->capture_irq >= 0)
+		free_irq(ml403_ac97cr->capture_irq, ml403_ac97cr);
+	/* give back "port" */
+	if (ml403_ac97cr->port != NULL)
+		iounmap(ml403_ac97cr->port);
+	kfree(ml403_ac97cr);
+	PDEBUG(INIT_INFO, "free(): (done)\n");
+	return 0;
+}
+
+static int snd_ml403_ac97cr_dev_free(struct snd_device *snddev)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr = snddev->device_data;
+	PDEBUG(INIT_INFO, "dev_free():\n");
+	return snd_ml403_ac97cr_free(ml403_ac97cr);
+}
+
+static int __init
+snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
+			struct snd_ml403_ac97cr **rml403_ac97cr)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr;
+	int err;
+	static struct snd_device_ops ops = {
+		.dev_free = snd_ml403_ac97cr_dev_free,
+	};
+	struct resource *resource;
+	int irq;
+
+	*rml403_ac97cr = NULL;
+	ml403_ac97cr = kzalloc(sizeof(*ml403_ac97cr), GFP_KERNEL);
+	if (ml403_ac97cr == NULL) {
+		return -ENOMEM;
+	}
+	spin_lock_init(&ml403_ac97cr->reg_lock);
+	ml403_ac97cr->card = card;
+	ml403_ac97cr->pfdev = pfdev;
+	ml403_ac97cr->irq = -1;
+	ml403_ac97cr->enable_irq = 0;
+	ml403_ac97cr->capture_irq = -1;
+	ml403_ac97cr->enable_capture_irq = 0;
+	ml403_ac97cr->port = NULL;
+	ml403_ac97cr->res_port = NULL;
+
+	PDEBUG(INIT_INFO, "Trying to reserve resources now ...\n");
+	resource = platform_get_resource(pfdev, IORESOURCE_MEM, 0);
+	/* get "port" */
+	ml403_ac97cr->port = ioremap_nocache(resource->start,
+					     (resource->end) -
+					     (resource->start) + 1);
+	if (ml403_ac97cr->port == NULL) {
+		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
+			   "unable to remap memory region (%x to %x)\n",
+			   resource->start, resource->end);
+		snd_ml403_ac97cr_free(ml403_ac97cr);
+		return -EBUSY;
+	}
+	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
+		   "remap controller memory region to "
+		   "0x%x done\n", (unsigned int)ml403_ac97cr->port);
+	/* get irq */
+	irq = platform_get_irq(pfdev, 0);
+	if (request_irq(irq, snd_ml403_ac97cr_irq, IRQF_DISABLED,
+			pfdev->dev.bus_id, (void *)ml403_ac97cr)) {
+		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
+			   "unable to grab IRQ %d\n",
+			   irq);
+		snd_ml403_ac97cr_free(ml403_ac97cr);
+		return -EBUSY;
+	}
+	ml403_ac97cr->irq = irq;
+	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
+		   "request (playback) irq %d done\n",
+		   ml403_ac97cr->irq);
+	irq = platform_get_irq(pfdev, 1);
+	if (request_irq(irq, snd_ml403_ac97cr_irq, IRQF_DISABLED,
+			pfdev->dev.bus_id, (void *)ml403_ac97cr)) {
+		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
+			   "unable to grab IRQ %d\n",
+			   irq);
+		snd_ml403_ac97cr_free(ml403_ac97cr);
+		return -EBUSY;
+	}
+	ml403_ac97cr->capture_irq = irq;
+	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
+		   "request (capture) irq %d done\n",
+		   ml403_ac97cr->capture_irq);
+
+	if ((err = snd_ml403_ac97cr_chip_init(ml403_ac97cr)) < 0) {
+		snd_ml403_ac97cr_free(ml403_ac97cr);
+		return err;
+	}
+
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ml403_ac97cr, &ops);
+	if (err < 0) {
+		PDEBUG(INIT_FAILURE, "probe(): snd_device_new() failed!\n");
+		snd_ml403_ac97cr_free(ml403_ac97cr);
+		return err;
+	}
+
+	snd_card_set_dev(card, &pfdev->dev);
+
+	*rml403_ac97cr = ml403_ac97cr;
+	return 0;
+}
+
+static void snd_ml403_ac97cr_mixer_free(struct snd_ac97 *ac97)
+{
+	struct snd_ml403_ac97cr *ml403_ac97cr = ac97->private_data;
+	PDEBUG(INIT_INFO, "mixer_free():\n");
+	ml403_ac97cr->ac97 = NULL;
+	PDEBUG(INIT_INFO, "mixer_free(): (done)\n");
+}
+
+static int __init snd_ml403_ac97cr_mixer(struct snd_ml403_ac97cr *ml403_ac97cr)
+{
+	struct snd_ac97_bus *bus;
+	struct snd_ac97_template ac97;
+	int err;
+	static struct snd_ac97_bus_ops ops = {
+		.write = snd_ml403_ac97cr_codec_write,
+		.read = snd_ml403_ac97cr_codec_read,
+	};
+	PDEBUG(INIT_INFO, "mixer():\n");
+	if ((err = snd_ac97_bus(ml403_ac97cr->card, 0, &ops, NULL, &bus)) < 0)
+		return err;
+
+	memset(&ac97, 0, sizeof(ac97));
+	ml403_ac97cr->ac97_fake = 1;
+	lm4550_regfile_init();
+#ifdef CODEC_STAT
+	ml403_ac97cr->ac97_read = 0;
+	ml403_ac97cr->ac97_write = 0;
+#endif
+	ac97.private_data = ml403_ac97cr;
+	ac97.private_free = snd_ml403_ac97cr_mixer_free;
+	ac97.scaps = AC97_SCAP_AUDIO | AC97_SCAP_SKIP_MODEM |
+	    AC97_SCAP_NO_SPDIF;
+	err = snd_ac97_mixer(bus, &ac97, &ml403_ac97cr->ac97);
+	ml403_ac97cr->ac97_fake = 0;
+	lm4550_regfile_write_values_after_init(ml403_ac97cr->ac97);
+	PDEBUG(INIT_INFO, "mixer(): (done) snd_ac97_mixer()=%d\n", err);
+	return err;
+}
+
+static int __init
+snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device,
+		     struct snd_pcm **rpcm)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	if (rpcm)
+		*rpcm = NULL;
+	if ((err = snd_pcm_new(ml403_ac97cr->card, "ML403AC97CR/1", device, 1,
+			       1, &pcm)) < 0)
+		return err;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_ml403_ac97cr_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_ml403_ac97cr_capture_ops);
+	pcm->private_data = ml403_ac97cr;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "ML403AC97CR DAC/ADC");
+	ml403_ac97cr->pcm = pcm;
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+					  snd_dma_continuous_data(GFP_KERNEL),
+					  64 * 1024,
+					  128 * 1024);
+	if (rpcm)
+		*rpcm = pcm;
+	return 0;
+}
+
+static int __init snd_ml403_ac97cr_probe(struct platform_device *pfdev)
+{
+	struct snd_card *card;
+	struct snd_ml403_ac97cr *ml403_ac97cr = NULL;
+	int err;
+	int dev = pfdev->id;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev])
+		return -ENOENT;
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (card == NULL)
+		return -ENOMEM;
+	if ((err = snd_ml403_ac97cr_create(card, pfdev, &ml403_ac97cr)) < 0) {
+		PDEBUG(INIT_FAILURE, "probe(): create failed!\n");
+		snd_card_free(card);
+		return err;
+	}
+	PDEBUG(INIT_INFO, "probe(): create done\n");
+	card->private_data = ml403_ac97cr;
+	if ((err = snd_ml403_ac97cr_mixer(ml403_ac97cr)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	PDEBUG(INIT_INFO, "probe(): mixer done\n");
+	if ((err = snd_ml403_ac97cr_pcm(ml403_ac97cr, 0, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	PDEBUG(INIT_INFO, "probe(): PCM done\n");
+	strcpy(card->driver, SND_ML403_AC97CR_DRIVER);
+	strcpy(card->shortname, "ML403 AC97 Controller Reference");
+	sprintf(card->longname, "%s %s at 0x%lx, irq %i & %i, device %i",
+		card->shortname, card->driver,
+		(unsigned long)ml403_ac97cr->port, ml403_ac97cr->irq,
+		ml403_ac97cr->capture_irq, dev + 1);
+
+	if ((err = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	platform_set_drvdata(pfdev, card);
+	PDEBUG(INIT_INFO, "probe(): (done)\n");
+	return 0;
+}
+
+static int snd_ml403_ac97cr_remove(struct platform_device *pfdev)
+{
+	snd_card_free(platform_get_drvdata(pfdev));
+	platform_set_drvdata(pfdev, NULL);
+	return 0;
+}
+
+static struct platform_driver snd_ml403_ac97cr_driver = {
+	.probe = snd_ml403_ac97cr_probe,
+	.remove = snd_ml403_ac97cr_remove,
+	.driver = {
+		.name = SND_ML403_AC97CR_DRIVER,
+	},
+};
+
+static int __init alsa_card_ml403_ac97cr_init(void)
+{
+	return platform_driver_register(&snd_ml403_ac97cr_driver);
+}
+
+static void __exit alsa_card_ml403_ac97cr_exit(void)
+{
+	platform_driver_unregister(&snd_ml403_ac97cr_driver);
+}
+
+module_init(alsa_card_ml403_ac97cr_init)
+module_exit(alsa_card_ml403_ac97cr_exit)
diff --git a/sound/ppc/pcm-indirect2.h b/sound/ppc/pcm-indirect2.h
new file mode 100644
index 0000000..c7fe74f
--- /dev/null
+++ b/sound/ppc/pcm-indirect2.h
@@ -0,0 +1,658 @@
+/*
+ * Helper functions for indirect PCM data transfer to a simple FIFO in
+ * hardware (small, no possibility to read "hardware io position",
+ * updating position done by interrupt, ...)
+ *
+ *  Copyright (c) by 2007  Joachim Foerster <JOFT@gmx.de>
+ *
+ *  Based on "pcm-indirect.h" (alsa-driver-1.0.13) by
+ *
+ *  Copyright (c) by Takashi Iwai <tiwai@suse.de>
+ *                   Jaroslav Kysela <perex@suse.cz>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __SOUND_PCM_INDIRECT2_H
+#define __SOUND_PCM_INDIRECT2_H
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+
+/* jiffies */
+#include <linux/jiffies.h>
+
+struct snd_pcm_indirect2 {
+	unsigned int hw_buffer_size;  /* Byte size of hardware buffer */
+	int hw_ready;		      /* playback: 1 = hw fifo has room left,
+				       * 0 = hw fifo is full
+				       */
+	unsigned int min_multiple;
+	int min_periods;	      /* counts number of min. periods until
+				       * min_multiple is reached
+				       */
+	int min_period_count;	      /* counts bytes to count number of
+				       * min. periods
+				       */
+
+	unsigned int sw_buffer_size;  /* Byte size of software buffer */
+
+	/* sw_data: position in intermediate buffer, where we will read (or
+	 *          write) from/to next time (to transfer data to/from HW)
+	 */
+	unsigned int sw_data;         /* Offset to next dst (or src) in sw
+				       * ring buffer
+				       */
+	/* easiest case (playback):
+	 * sw_data is nearly the same as ~ runtime->control->appl_ptr, with the
+	 * exception that sw_data is "behind" by the number if bytes ALSA wrote
+	 * to the intermediate buffer last time.
+	 * A call to ack() callback synchronizes both indirectly.
+	 */
+
+	/* We have no real sw_io pointer here. Usually sw_io is pointing to the
+	 * current playback/capture position _inside_ the hardware. Devices
+	 * with plain FIFOs often have no possibility to publish this position.
+	 * So we say: if sw_data is updated, that means bytes were copied to
+	 * the hardware, we increase sw_io by that amount, because there have
+	 * to be as much bytes which were played. So sw_io will stay behind
+	 * sw_data all the time and has to converge to sw_data at the end of
+	 * playback.
+	 */
+	unsigned int sw_io;           /* Current software pointer in bytes */
+
+	/* sw_ready: number of bytes ALSA copied to the intermediate buffer, so
+	 * it represents the number of bytes which wait for transfer to the HW
+	 */
+	int sw_ready;		  /* Bytes ready to be transferred to/from hw */
+
+	/* appl_ptr: last known position of ALSA (where ALSA is going to write
+	 * next time into the intermediate buffer
+	 */
+	snd_pcm_uframes_t appl_ptr;   /* Last seen appl_ptr */
+
+	unsigned int bytes2hw;
+	int check_alignment;
+
+#ifdef SND_PCM_INDIRECT2_STAT
+	unsigned int zeros2hw;
+	unsigned int mul_elapsed;
+	unsigned int mul_elapsed_real;
+	unsigned long firstbytetime;
+	unsigned long lastbytetime;
+	unsigned long firstzerotime;
+	unsigned int byte_sizes[64];
+	unsigned int zero_sizes[64];
+	unsigned int min_adds[8];
+	unsigned int mul_adds[8];
+	unsigned int zero_times[3750];	/* = 15s */
+	unsigned int zero_times_saved;
+	unsigned int zero_times_notsaved;
+	unsigned int irq_occured;
+	unsigned int pointer_calls;
+	unsigned int lastdifftime;
+#endif
+};
+
+typedef size_t(*snd_pcm_indirect2_copy_t) (struct snd_pcm_substream * substream,
+					   struct snd_pcm_indirect2 * rec,
+					   size_t bytes);
+typedef size_t(*snd_pcm_indirect2_zero_t) (struct snd_pcm_substream * substream,
+					   struct snd_pcm_indirect2 * rec);
+
+#ifdef SND_PCM_INDIRECT2_STAT
+static inline void snd_pcm_indirect2_stat(struct snd_pcm_substream *substream,
+					  struct snd_pcm_indirect2 *rec)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int i, j, k;
+	int seconds = (rec->lastbytetime - rec->firstbytetime) / HZ;
+
+	snd_printk(KERN_DEBUG "STAT: mul_elapsed: %u, mul_elapsed_real: %d, "
+		   "irq_occured: %d\n",
+		   rec->mul_elapsed, rec->mul_elapsed_real, rec->irq_occured);
+	snd_printk(KERN_DEBUG "STAT: min_multiple: %d (irqs/period)\n",
+		   rec->min_multiple);
+	snd_printk(KERN_DEBUG "STAT: firstbytetime: %lu, lastbytetime: %lu, "
+		   "firstzerotime: %lu\n",
+		 rec->firstbytetime, rec->lastbytetime, rec->firstzerotime);
+	snd_printk(KERN_DEBUG "STAT: bytes2hw: %u Bytes => (by runtime->rate) "
+		   "length: %d s\n",
+		 rec->bytes2hw, rec->bytes2hw / 2 / 2 / runtime->rate);
+	snd_printk(KERN_DEBUG "STAT: (by measurement) length: %d => "
+		   "rate: %d Bytes/s = %d Frames/s|Hz\n",
+		   seconds, rec->bytes2hw / seconds,
+		   rec->bytes2hw / 2 / 2 / seconds);
+	snd_printk(KERN_DEBUG
+		   "STAT: zeros2hw: %u = %d ms ~ %d * %d zero copies\n",
+		   rec->zeros2hw, ((rec->zeros2hw / 2 / 2) * 1000) /
+		   runtime->rate,
+		   rec->zeros2hw / (rec->hw_buffer_size / 2),
+		   (rec->hw_buffer_size / 2));
+	snd_printk(KERN_DEBUG "STAT: pointer_calls: %u, lastdifftime: %u\n",
+		   rec->pointer_calls, rec->lastdifftime);
+	snd_printk(KERN_DEBUG "STAT: sw_io: %d, sw_data: %d\n", rec->sw_io,
+		   rec->sw_data);
+	snd_printk(KERN_DEBUG "STAT: byte_sizes[]:\n");
+	k = 0;
+	for (j = 0; j < 8; j++) {
+		for (i = j * 8; i < (j + 1) * 8; i++)
+			if (rec->byte_sizes[i] != 0) {
+				snd_printk(KERN_DEBUG "%u: %u",
+					   i, rec->byte_sizes[i]);
+				k++;
+			}
+		if (((k % 8) == 0) && (k != 0)) {
+			snd_printk(KERN_DEBUG "\n");
+			k = 0;
+		}
+	}
+	snd_printk(KERN_DEBUG "\n");
+	snd_printk(KERN_DEBUG "STAT: zero_sizes[]:\n");
+	for (j = 0; j < 8; j++) {
+		k = 0;
+		for (i = j * 8; i < (j + 1) * 8; i++)
+			if (rec->zero_sizes[i] != 0)
+				snd_printk(KERN_DEBUG "%u: %u",
+					   i, rec->zero_sizes[i]);
+			else
+				k++;
+		if (!k)
+			snd_printk(KERN_DEBUG "\n");
+	}
+	snd_printk(KERN_DEBUG "\n");
+	snd_printk(KERN_DEBUG "STAT: min_adds[]:\n");
+	for (j = 0; j < 8; j++) {
+		if (rec->min_adds[j] != 0)
+			snd_printk(KERN_DEBUG "%u: %u", j, rec->min_adds[j]);
+	}
+	snd_printk(KERN_DEBUG "\n");
+	snd_printk(KERN_DEBUG "STAT: mul_adds[]:\n");
+	for (j = 0; j < 8; j++) {
+		if (rec->mul_adds[j] != 0)
+			snd_printk(KERN_DEBUG "%u: %u", j, rec->mul_adds[j]);
+	}
+	snd_printk(KERN_DEBUG "\n");
+	snd_printk(KERN_DEBUG
+		   "STAT: zero_times_saved: %d, zero_times_notsaved: %d\n",
+		   rec->zero_times_saved, rec->zero_times_notsaved);
+	/* snd_printk(KERN_DEBUG "STAT: zero_times[]\n");
+	i = 0;
+	for (j = 0; j < 3750; j++) {
+		if (rec->zero_times[j] != 0) {
+			snd_printk(KERN_DEBUG "%u: %u", j, rec->zero_times[j]);
+			i++;
+		}
+		if (((i % 8) == 0) && (i != 0))
+			snd_printk(KERN_DEBUG "\n");
+	}
+	snd_printk(KERN_DEBUG "\n"); */
+	return;
+}
+#endif
+
+/*
+ * _internal_ helper function for playback/capture transfer function
+ */
+static inline void
+snd_pcm_indirect2_increase_min_periods(struct snd_pcm_substream *substream,
+				       struct snd_pcm_indirect2 *rec,
+				       int isplay, int iscopy,
+				       unsigned int bytes)
+{
+	if (rec->min_periods >= 0) {
+		if (iscopy) {
+			rec->sw_io += bytes;
+			if (rec->sw_io >= rec->sw_buffer_size)
+				rec->sw_io -= rec->sw_buffer_size;
+		} else if (isplay) {
+			/* If application does not write data in multiples of
+			 * a period, move sw_data to the next correctly aligned
+			 * position, so that sw_io can converge to it (in the
+			 * next step).
+			 */
+			if (!rec->check_alignment) {
+				if (rec->bytes2hw %
+				    snd_pcm_lib_period_bytes(substream)) {
+					unsigned bytes2hw_aligned =
+					    (1 +
+					     (rec->bytes2hw /
+					      snd_pcm_lib_period_bytes
+					      (substream))) *
+					    snd_pcm_lib_period_bytes(substream);
+					rec->sw_data =
+					    bytes2hw_aligned %
+					    rec->sw_buffer_size;
+#ifdef SND_PCM_INDIRECT2_STAT
+					snd_printk(KERN_DEBUG
+						   "STAT: @re-align: aligned "
+						   "bytes2hw to next period "
+						   "size boundary: %d "
+						   "(instead of %d)\n",
+						   bytes2hw_aligned,
+						   rec->bytes2hw);
+					snd_printk(KERN_DEBUG
+						   "STAT: @re-align: sw_data "
+						   "moves to: %d\n",
+						   rec->sw_data);
+#endif
+				}
+				rec->check_alignment = 1;
+			}
+			/* We are at the end and are copying zero into the fifo.
+			 * Now, we have to make sure that sw_io is increased
+			 * until the position of sw_data: Filling the fifo with
+			 * the first zeros means, the last bytes were played.
+			 */
+			if (rec->sw_io != rec->sw_data) {
+				unsigned int diff;
+				if (rec->sw_data > rec->sw_io)
+					diff = rec->sw_data - rec->sw_io;
+				else
+					diff =
+					    (rec->sw_buffer_size - rec->sw_io) +
+					    rec->sw_data;
+				if (bytes >= diff)
+					rec->sw_io = rec->sw_data;
+				else {
+					rec->sw_io += bytes;
+					if (rec->sw_io >= rec->sw_buffer_size)
+						rec->sw_io -=
+						    rec->sw_buffer_size;
+				}
+			}
+		}
+		rec->min_period_count += bytes;
+		if (rec->min_period_count >= (rec->hw_buffer_size / 2)) {
+			rec->min_periods +=
+			    (rec->min_period_count / (rec->hw_buffer_size / 2));
+#ifdef SND_PCM_INDIRECT2_STAT
+			if ((rec->min_period_count /
+			     (rec->hw_buffer_size / 2)) > 7)
+				snd_printk(KERN_DEBUG
+					   "STAT: more than 7 (%d) min_adds at "
+					   "once - too big to save!\n",
+					   (rec->min_period_count /
+					    (rec->hw_buffer_size / 2)));
+			else
+				rec->min_adds[(rec->min_period_count /
+					       (rec->hw_buffer_size / 2))]++;
+#endif
+			rec->min_period_count =
+			    (rec->min_period_count % (rec->hw_buffer_size / 2));
+		}
+	} else if (isplay && iscopy)
+		rec->min_periods = 0;
+}
+
+/*
+ * helper function for playback/capture pointer callback
+ */
+static inline snd_pcm_uframes_t
+snd_pcm_indirect2_pointer(struct snd_pcm_substream *substream,
+			  struct snd_pcm_indirect2 *rec)
+{
+#ifdef SND_PCM_INDIRECT2_STAT
+	rec->pointer_calls++;
+#endif
+	return bytes_to_frames(substream->runtime, rec->sw_io);
+}
+
+/*
+ * helper function for playback ack callback
+ */
+static inline void
+snd_pcm_indirect2_playback_transfer(struct snd_pcm_substream *substream,
+				    struct snd_pcm_indirect2 *rec,
+				    snd_pcm_indirect2_copy_t copy,
+				    snd_pcm_indirect2_zero_t zero)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
+
+	/* runtime->control->appl_ptr: position where ALSA will write next time
+	 * rec->appl_ptr: position where ALSA was last time
+	 * diff: obviously ALSA wrote that much bytes into the intermediate
+	 * buffer since we checked last time
+	 */
+	snd_pcm_sframes_t diff = appl_ptr - rec->appl_ptr;
+
+	if (diff) {
+#ifdef SND_PCM_INDIRECT2_STAT
+		rec->lastdifftime = jiffies;
+#endif
+		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
+			diff += runtime->boundary;
+		/* number of bytes "added" by ALSA increases the number of bytes
+		 * which are ready to "be transfered to HW"/"played"
+		 * Then, set rec->appl_ptr to not count bytes twice next time.
+		 */
+		rec->sw_ready += (int)frames_to_bytes(runtime, diff);
+		rec->appl_ptr = appl_ptr;
+	}
+	if (rec->hw_ready && (rec->sw_ready <= 0)) {
+		unsigned int bytes;
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		if (rec->firstzerotime == 0) {
+			rec->firstzerotime = jiffies;
+			snd_printk(KERN_DEBUG
+				   "STAT: @firstzerotime: mul_elapsed: %d, "
+				   "min_period_count: %d\n",
+				   rec->mul_elapsed, rec->min_period_count);
+			snd_printk(KERN_DEBUG
+				   "STAT: @firstzerotime: sw_io: %d, "
+				   "sw_data: %d, appl_ptr: %u\n",
+				   rec->sw_io, rec->sw_data,
+				   (unsigned int)appl_ptr);
+		}
+		if ((jiffies - rec->firstzerotime) < 3750) {
+			rec->zero_times[(jiffies - rec->firstzerotime)]++;
+			rec->zero_times_saved++;
+		} else
+			rec->zero_times_notsaved++;
+#endif
+		bytes = zero(substream, rec);
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		rec->zeros2hw += bytes;
+		if (bytes < 64)
+			rec->zero_sizes[bytes]++;
+		else
+			snd_printk(KERN_DEBUG
+				   "STAT: %d zero Bytes copied to hardware at "
+				   "once - too big to save!\n",
+				   bytes);
+#endif
+		snd_pcm_indirect2_increase_min_periods(substream, rec, 1, 0,
+						       bytes);
+		return;
+	}
+	while (rec->hw_ready && (rec->sw_ready > 0)) {
+		/* sw_to_end: max. number of bytes that can be read/take from
+		 * the current position (sw_data) in _one_ step
+		 */
+		unsigned int sw_to_end = rec->sw_buffer_size - rec->sw_data;
+
+		/* bytes: number of bytes we have available (for reading) */
+		unsigned int bytes = rec->sw_ready;
+
+		if (sw_to_end < bytes) {
+			bytes = sw_to_end;
+		}
+		if (!bytes)
+			break;
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		if (rec->firstbytetime == 0)
+			rec->firstbytetime = jiffies;
+		rec->lastbytetime = jiffies;
+#endif
+		/* copy bytes from intermediate buffer position sw_data to the
+		 * HW and return number of bytes actually written
+		 * Furthermore, set hw_ready to 0, if the fifo isn't empty
+		 * now => more could be transfered to fifo
+		 */
+		bytes = copy(substream, rec, bytes);
+		rec->bytes2hw += bytes;
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		if (bytes < 64)
+			rec->byte_sizes[bytes]++;
+		else
+			snd_printk(KERN_DEBUG
+				   "STAT: %d Bytes copied to hardware at once "
+				   "- too big to save!\n",
+				   bytes);
+#endif
+		/* increase sw_data by the number of actually written bytes
+		 * (= number of taken bytes from intermediate buffer)
+		 */
+		rec->sw_data += bytes;
+		if (rec->sw_data == rec->sw_buffer_size)
+			rec->sw_data = 0;
+		/* now sw_data is the position where ALSA is going to write
+		 * in the intermediate buffer next time = position we are going
+		 * to read from next time
+		 */
+
+		snd_pcm_indirect2_increase_min_periods(substream, rec, 1, 1,
+						       bytes);
+
+		/* we read bytes from intermediate buffer, so we need to say
+		 * that the number of bytes ready for transfer are decreased
+		 * now
+		 */
+		rec->sw_ready -= bytes;
+	}
+	return;
+}
+
+/*
+ * helper function for playback interrupt routine
+ */
+static inline void
+snd_pcm_indirect2_playback_interrupt(struct snd_pcm_substream *substream,
+				     struct snd_pcm_indirect2 *rec,
+				     snd_pcm_indirect2_copy_t copy,
+				     snd_pcm_indirect2_zero_t zero)
+{
+#ifdef SND_PCM_INDIRECT2_STAT
+	rec->irq_occured++;
+#endif
+	/* hardware played some bytes, so there is room again (in fifo) */
+	rec->hw_ready = 1;
+
+	/* don't call ack() now, instead call transfer() function directly
+	 * (normally called by ack() )
+	 */
+	snd_pcm_indirect2_playback_transfer(substream, rec, copy, zero);
+
+	if (rec->min_periods >= rec->min_multiple) {
+#ifdef SND_PCM_INDIRECT2_STAT
+		if ((rec->min_periods / rec->min_multiple) > 7)
+			snd_printk(KERN_DEBUG
+				   "STAT: more than 7 (%d) mul_adds - too big "
+				   "to save!\n",
+				   (rec->min_periods / rec->min_multiple));
+		else
+			rec->mul_adds[(rec->min_periods / rec->min_multiple)]++;
+		rec->mul_elapsed_real += (rec->min_periods / rec->min_multiple);
+		rec->mul_elapsed++;
+#endif
+		rec->min_periods = 0;
+		snd_pcm_period_elapsed(substream);
+	}
+}
+
+/*
+ * helper function for capture ack callback
+ */
+static inline void
+snd_pcm_indirect2_capture_transfer(struct snd_pcm_substream *substream,
+				   struct snd_pcm_indirect2 *rec,
+				   snd_pcm_indirect2_copy_t copy,
+				   snd_pcm_indirect2_zero_t null)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
+	snd_pcm_sframes_t diff = appl_ptr - rec->appl_ptr;
+
+	if (diff) {
+#ifdef SND_PCM_INDIRECT2_STAT
+		rec->lastdifftime = jiffies;
+#endif
+		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
+			diff += runtime->boundary;
+		rec->sw_ready -= frames_to_bytes(runtime, diff);
+		rec->appl_ptr = appl_ptr;
+	}
+	/* if hardware has something, but the intermediate buffer is full
+	 * => skip contents of buffer
+	 */
+	if (rec->hw_ready && (rec->sw_ready >= (int)rec->sw_buffer_size)) {
+		unsigned int bytes;
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		if (rec->firstzerotime == 0) {
+			rec->firstzerotime = jiffies;
+			snd_printk(KERN_DEBUG "STAT: (capture) @firstzerotime: "
+				   "mul_elapsed: %d, min_period_count: %d\n",
+				   rec->mul_elapsed, rec->min_period_count);
+			snd_printk(KERN_DEBUG "STAT: (capture) @firstzerotime: "
+				   "sw_io: %d, sw_data: %d, appl_ptr: %u\n",
+				   rec->sw_io, rec->sw_data,
+				   (unsigned int)appl_ptr);
+		}
+		if ((jiffies - rec->firstzerotime) < 3750) {
+			rec->zero_times[(jiffies - rec->firstzerotime)]++;
+			rec->zero_times_saved++;
+		} else
+			rec->zero_times_notsaved++;
+#endif
+		bytes = null(substream, rec);
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		rec->zeros2hw += bytes;
+		if (bytes < 64)
+			rec->zero_sizes[bytes]++;
+		else
+			snd_printk(KERN_DEBUG
+				   "STAT: (capture) %d zero Bytes copied to "
+				   "hardware at once - too big to save!\n",
+				   bytes);
+#endif
+		snd_pcm_indirect2_increase_min_periods(substream, rec, 0, 0,
+						       bytes);
+		/* report an overrun */
+		rec->sw_io = SNDRV_PCM_POS_XRUN;
+		return;
+	}
+	while (rec->hw_ready && (rec->sw_ready < (int)rec->sw_buffer_size)) {
+		/* sw_to_end: max. number of bytes that we can write to the
+		 *  intermediate buffer (until it's end)
+		 */
+		size_t sw_to_end = rec->sw_buffer_size - rec->sw_data;
+
+		/* bytes: max. number of bytes, which may be copied to the
+		 *  intermediate buffer without overflow (in _one_ step)
+		 */
+		size_t bytes = rec->sw_buffer_size - rec->sw_ready;
+
+		/* limit number of bytes (for transfer) by available room in
+		 * the intermediate buffer
+		 */
+		if (sw_to_end < bytes)
+			bytes = sw_to_end;
+		if (!bytes)
+			break;
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		if (rec->firstbytetime == 0)
+			rec->firstbytetime = jiffies;
+		rec->lastbytetime = jiffies;
+#endif
+		/* copy bytes from the intermediate buffer (position sw_data)
+		 * to the HW at most and return number of bytes actually copied
+		 * from HW
+		 * Furthermore, set hw_ready to 0, if the fifo is empty now.
+		 */
+		bytes = copy(substream, rec, bytes);
+		rec->bytes2hw += bytes;
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		if (bytes < 64)
+			rec->byte_sizes[bytes]++;
+		else
+			snd_printk(KERN_DEBUG
+				   "STAT: (capture) %d Bytes copied to "
+				   "hardware at once - too big to save!\n",
+				   bytes);
+#endif
+		/* increase sw_data by the number of actually copied bytes from
+		 * HW
+		 */
+		rec->sw_data += bytes;
+		if (rec->sw_data == rec->sw_buffer_size)
+			rec->sw_data = 0;
+
+		snd_pcm_indirect2_increase_min_periods(substream, rec, 0, 1,
+						       bytes);
+
+		/* number of bytes in the intermediate buffer, which haven't
+		 * been fetched by ALSA yet.
+		 */
+		rec->sw_ready += bytes;
+	}
+	return;
+}
+
+/*
+ * helper function for capture interrupt routine
+ */
+static inline void
+snd_pcm_indirect2_capture_interrupt(struct snd_pcm_substream *substream,
+				    struct snd_pcm_indirect2 *rec,
+				    snd_pcm_indirect2_copy_t copy,
+				    snd_pcm_indirect2_zero_t null)
+{
+#ifdef SND_PCM_INDIRECT2_STAT
+	rec->irq_occured++;
+#endif
+	/* hardware recorded some bytes, so there is something to read from the
+	 * record fifo:
+	 */
+	rec->hw_ready = 1;
+
+	/* don't call ack() now, instead call transfer() function directly
+	 * (normally called by ack() )
+	 */
+	snd_pcm_indirect2_capture_transfer(substream, rec, copy, null);
+
+	if (rec->min_periods >= rec->min_multiple) {
+
+#ifdef SND_PCM_INDIRECT2_STAT
+		if ((rec->min_periods / rec->min_multiple) > 7)
+			snd_printk(KERN_DEBUG
+				   "STAT: more than 7 (%d) mul_adds - "
+				   "too big to save!\n",
+				   (rec->min_periods / rec->min_multiple));
+		else
+			rec->mul_adds[(rec->min_periods / rec->min_multiple)]++;
+		rec->mul_elapsed_real += (rec->min_periods / rec->min_multiple);
+		rec->mul_elapsed++;
+
+		if (!(rec->mul_elapsed % 4)) {
+			struct snd_pcm_runtime *runtime = substream->runtime;
+			unsigned int appl_ptr =
+			    frames_to_bytes(runtime,
+					    (unsigned int)runtime->control->
+					    appl_ptr) % rec->sw_buffer_size;
+			int diff = rec->sw_data - appl_ptr;
+			if (diff < 0)
+				diff += rec->sw_buffer_size;
+			snd_printk(KERN_DEBUG
+				   "STAT: mul_elapsed: %d, sw_data: %u, "
+				   "appl_ptr (bytes): %u, diff: %d\n",
+				   rec->mul_elapsed, rec->sw_data, appl_ptr,
+				   diff);
+		}
+#endif
+		rec->min_periods = 0;
+		snd_pcm_period_elapsed(substream);
+	}
+}
+
+#endif /* __SOUND_PCM_INDIRECT2_H */
-- 
1.5.2.4
