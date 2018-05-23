Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0121.hostedemail.com
 [216.40.44.121])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rj6f0QySzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 05:21:12 +1000 (AEST)
From: Joe Perches <joe@perches.com>
To: Vinod Koul <vkoul@kernel.org>, Clemens Ladisch <clemens@ladisch.de>,
 Brian Austin <brian.austin@cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] sound: Use octal not symbolic permissions
Date: Wed, 23 May 2018 12:20:59 -0700
Message-Id: <b32d7b5f7827cc3283e4e46c3135144373404621.1527103197.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert the S_<FOO> symbolic permissions to their octal equivalents as
using octal and not symbolic permissions is preferred by many as more
readable.

see: https://lkml.org/lkml/2016/8/2/1945

Done with automated conversion via:
$ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>

Miscellanea:

o Wrapped one multi-line call to a single line

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/core/compress_offload.c             |  2 +-
 sound/core/info.c                         |  6 +++---
 sound/core/init.c                         |  4 ++--
 sound/core/oss/mixer_oss.c                |  2 +-
 sound/core/oss/pcm_oss.c                  |  2 +-
 sound/core/pcm.c                          | 10 +++++-----
 sound/core/pcm_memory.c                   |  2 +-
 sound/drivers/dummy.c                     |  2 +-
 sound/drivers/mts64.c                     |  6 +++---
 sound/drivers/opl4/opl4_proc.c            |  2 +-
 sound/drivers/portman2x4.c                |  6 +++---
 sound/firewire/bebob/bebob_proc.c         |  2 +-
 sound/firewire/dice/dice-proc.c           |  2 +-
 sound/firewire/digi00x/digi00x-proc.c     |  2 +-
 sound/firewire/fireface/ff-proc.c         |  2 +-
 sound/firewire/fireworks/fireworks_proc.c |  2 +-
 sound/firewire/motu/motu-proc.c           |  2 +-
 sound/firewire/oxfw/oxfw-proc.c           |  2 +-
 sound/firewire/tascam/tascam-proc.c       |  2 +-
 sound/isa/msnd/msnd_pinnacle.c            | 32 +++++++++++++++----------------
 sound/pci/ac97/ac97_proc.c                |  4 ++--
 sound/pci/asihpi/asihpi.c                 | 12 ++++++------
 sound/pci/asihpi/hpioctl.c                |  4 ++--
 sound/pci/ca0106/ca0106_proc.c            |  6 +++---
 sound/pci/cs46xx/cs46xx_lib.c             |  2 +-
 sound/pci/cs46xx/dsp_spos.c               | 14 +++++++-------
 sound/pci/cs46xx/dsp_spos_scb_lib.c       |  2 +-
 sound/pci/ctxfi/cttimer.c                 |  2 +-
 sound/pci/ctxfi/xfi.c                     |  4 ++--
 sound/pci/emu10k1/emu10k1x.c              |  2 +-
 sound/pci/emu10k1/emuproc.c               | 22 ++++++++++-----------
 sound/pci/hda/patch_hdmi.c                |  2 +-
 sound/pci/ice1712/pontis.c                |  2 +-
 sound/pci/ice1712/prodigy_hifi.c          |  2 +-
 sound/pci/lola/lola_proc.c                |  2 +-
 sound/pci/pcxhr/pcxhr.c                   |  2 +-
 sound/soc/codecs/cs43130.c                |  8 ++++----
 sound/soc/codecs/wm_adsp.c                | 11 +++++------
 sound/soc/fsl/fsl_ssi_dbg.c               |  2 +-
 sound/sound_core.c                        |  6 +++---
 sound/sparc/dbri.c                        |  2 +-
 41 files changed, 102 insertions(+), 103 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 4563432badba..4b01a37c836e 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1001,7 +1001,7 @@ static int snd_compress_proc_init(struct snd_compr *compr)
 					   compr->card->proc_root);
 	if (!entry)
 		return -ENOMEM;
-	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	entry->mode = S_IFDIR | 0555;
 	if (snd_info_register(entry) < 0) {
 		snd_info_free_entry(entry);
 		return -ENOMEM;
diff --git a/sound/core/info.c b/sound/core/info.c
index 4b36767af9e1..fe502bc5e6d2 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -454,7 +454,7 @@ static struct snd_info_entry *create_subdir(struct module *mod,
 	entry = snd_info_create_module_entry(mod, name, NULL);
 	if (!entry)
 		return NULL;
-	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	entry->mode = S_IFDIR | 0555;
 	if (snd_info_register(entry) < 0) {
 		snd_info_free_entry(entry);
 		return NULL;
@@ -470,7 +470,7 @@ int __init snd_info_init(void)
 	snd_proc_root = snd_info_create_entry("asound", NULL);
 	if (!snd_proc_root)
 		return -ENOMEM;
-	snd_proc_root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	snd_proc_root->mode = S_IFDIR | 0555;
 	snd_proc_root->p = proc_mkdir("asound", NULL);
 	if (!snd_proc_root->p)
 		goto error;
@@ -716,7 +716,7 @@ snd_info_create_entry(const char *name, struct snd_info_entry *parent)
 		kfree(entry);
 		return NULL;
 	}
-	entry->mode = S_IFREG | S_IRUGO;
+	entry->mode = S_IFREG | 0444;
 	entry->content = SNDRV_INFO_CONTENT_TEXT;
 	mutex_init(&entry->access);
 	INIT_LIST_HEAD(&entry->children);
diff --git a/sound/core/init.c b/sound/core/init.c
index 79b4df1c1dc7..4849c611c0fe 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -703,7 +703,7 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(id, S_IRUGO | S_IWUSR, card_id_show_attr, card_id_store_attr);
+static DEVICE_ATTR(id, 0644, card_id_show_attr, card_id_store_attr);
 
 static ssize_t
 card_number_show_attr(struct device *dev,
@@ -713,7 +713,7 @@ card_number_show_attr(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%i\n", card->number);
 }
 
-static DEVICE_ATTR(number, S_IRUGO, card_number_show_attr, NULL);
+static DEVICE_ATTR(number, 0444, card_number_show_attr, NULL);
 
 static struct attribute *card_dev_attrs[] = {
 	&dev_attr_id.attr,
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 379bf486ccc7..64d904bee8bb 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1247,7 +1247,7 @@ static void snd_mixer_oss_proc_init(struct snd_mixer_oss *mixer)
 	if (! entry)
 		return;
 	entry->content = SNDRV_INFO_CONTENT_TEXT;
-	entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+	entry->mode = S_IFREG | 0644;
 	entry->c.text.read = snd_mixer_oss_proc_read;
 	entry->c.text.write = snd_mixer_oss_proc_write;
 	entry->private_data = mixer;
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 1980f68246cb..905a53c1cde5 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -3045,7 +3045,7 @@ static void snd_pcm_oss_proc_init(struct snd_pcm *pcm)
 			continue;
 		if ((entry = snd_info_create_card_entry(pcm->card, "oss", pstr->proc_root)) != NULL) {
 			entry->content = SNDRV_INFO_CONTENT_TEXT;
-			entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+			entry->mode = S_IFREG | 0644;
 			entry->c.text.read = snd_pcm_oss_proc_read;
 			entry->c.text.write = snd_pcm_oss_proc_write;
 			entry->private_data = pstr;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 66ac89aad681..c352bfb973cc 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -530,7 +530,7 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 					   pcm->card->proc_root);
 	if (!entry)
 		return -ENOMEM;
-	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	entry->mode = S_IFDIR | 0555;
 	if (snd_info_register(entry) < 0) {
 		snd_info_free_entry(entry);
 		return -ENOMEM;
@@ -552,7 +552,7 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 	if (entry) {
 		entry->c.text.read = snd_pcm_xrun_debug_read;
 		entry->c.text.write = snd_pcm_xrun_debug_write;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->private_data = pstr;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -590,7 +590,7 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 					   substream->pstr->proc_root);
 	if (!entry)
 		return -ENOMEM;
-	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	entry->mode = S_IFDIR | 0555;
 	if (snd_info_register(entry) < 0) {
 		snd_info_free_entry(entry);
 		return -ENOMEM;
@@ -647,7 +647,7 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 		entry->private_data = substream;
 		entry->c.text.read = NULL;
 		entry->c.text.write = snd_pcm_xrun_injection_write;
-		entry->mode = S_IFREG | S_IWUSR;
+		entry->mode = S_IFREG | 0200;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
 			entry = NULL;
@@ -1087,7 +1087,7 @@ static ssize_t show_pcm_class(struct device *dev,
         return snprintf(buf, PAGE_SIZE, "%s\n", str);
 }
 
-static DEVICE_ATTR(pcm_class, S_IRUGO, show_pcm_class, NULL);
+static DEVICE_ATTR(pcm_class, 0444, show_pcm_class, NULL);
 static struct attribute *pcm_dev_attrs[] = {
 	&dev_attr_pcm_class.attr,
 	NULL
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index ae33e456708c..4b5356a10315 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -201,7 +201,7 @@ static inline void preallocate_info_init(struct snd_pcm_substream *substream)
 	if ((entry = snd_info_create_card_entry(substream->pcm->card, "prealloc", substream->proc_root)) != NULL) {
 		entry->c.text.read = snd_pcm_lib_preallocate_proc_read;
 		entry->c.text.write = snd_pcm_lib_preallocate_proc_write;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->private_data = substream;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 8fb9a54fe8ba..9af154db530a 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1042,7 +1042,7 @@ static void dummy_proc_init(struct snd_dummy *chip)
 	if (!snd_card_proc_new(chip->card, "dummy_pcm", &entry)) {
 		snd_info_set_text_ops(entry, chip, dummy_proc_read);
 		entry->c.text.write = dummy_proc_write;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->private_data = chip;
 	}
 }
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index f32e81342247..b68e71ca7abd 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -41,11 +41,11 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 static struct platform_device *platform_devices[SNDRV_CARDS]; 
 static int device_count;
 
-module_param_array(index, int, NULL, S_IRUGO);
+module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
-module_param_array(id, charp, NULL, S_IRUGO);
+module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, S_IRUGO);
+module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 
 MODULE_AUTHOR("Matthias Koenig <mk@phasorlab.de>");
diff --git a/sound/drivers/opl4/opl4_proc.c b/sound/drivers/opl4/opl4_proc.c
index cd2c07fa2ef4..16b24091d799 100644
--- a/sound/drivers/opl4/opl4_proc.c
+++ b/sound/drivers/opl4/opl4_proc.c
@@ -104,7 +104,7 @@ int snd_opl4_create_proc(struct snd_opl4 *opl4)
 	if (entry) {
 		if (opl4->hardware < OPL3_HW_OPL4_ML) {
 			/* OPL4 can access 4 MB external ROM/SRAM */
-			entry->mode |= S_IWUSR;
+			entry->mode |= 0200;
 			entry->size = 4 * 1024 * 1024;
 		} else {
 			/* OPL4-ML has 1 MB internal ROM */
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index ec8a94325ef6..3cdf0a88d71b 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -60,11 +60,11 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 static struct platform_device *platform_devices[SNDRV_CARDS]; 
 static int device_count;
 
-module_param_array(index, int, NULL, S_IRUGO);
+module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
-module_param_array(id, charp, NULL, S_IRUGO);
+module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, S_IRUGO);
+module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 
 MODULE_AUTHOR("Levent Guendogdu, Tobias Gehrig, Matthias Koenig");
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
index ec24f96794f5..8096891af913 100644
--- a/sound/firewire/bebob/bebob_proc.c
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -183,7 +183,7 @@ void snd_bebob_proc_init(struct snd_bebob *bebob)
 					  bebob->card->proc_root);
 	if (root == NULL)
 		return;
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/firewire/dice/dice-proc.c b/sound/firewire/dice/dice-proc.c
index faf8c854d256..bb870fc73f99 100644
--- a/sound/firewire/dice/dice-proc.c
+++ b/sound/firewire/dice/dice-proc.c
@@ -305,7 +305,7 @@ void snd_dice_create_proc(struct snd_dice *dice)
 					  dice->card->proc_root);
 	if (!root)
 		return;
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/firewire/digi00x/digi00x-proc.c b/sound/firewire/digi00x/digi00x-proc.c
index a1d601f31165..6996d5a6ff5f 100644
--- a/sound/firewire/digi00x/digi00x-proc.c
+++ b/sound/firewire/digi00x/digi00x-proc.c
@@ -79,7 +79,7 @@ void snd_dg00x_proc_init(struct snd_dg00x *dg00x)
 	if (root == NULL)
 		return;
 
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
index 69441d121f71..40ccbfd8ef89 100644
--- a/sound/firewire/fireface/ff-proc.c
+++ b/sound/firewire/fireface/ff-proc.c
@@ -52,7 +52,7 @@ void snd_ff_proc_init(struct snd_ff *ff)
 					  ff->card->proc_root);
 	if (root == NULL)
 		return;
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/firewire/fireworks/fireworks_proc.c b/sound/firewire/fireworks/fireworks_proc.c
index 9c21f31b8b21..779ecec5af62 100644
--- a/sound/firewire/fireworks/fireworks_proc.c
+++ b/sound/firewire/fireworks/fireworks_proc.c
@@ -219,7 +219,7 @@ void snd_efw_proc_init(struct snd_efw *efw)
 					  efw->card->proc_root);
 	if (root == NULL)
 		return;
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/firewire/motu/motu-proc.c b/sound/firewire/motu/motu-proc.c
index 4edc064999ed..ab6830a6d242 100644
--- a/sound/firewire/motu/motu-proc.c
+++ b/sound/firewire/motu/motu-proc.c
@@ -107,7 +107,7 @@ void snd_motu_proc_init(struct snd_motu *motu)
 					  motu->card->proc_root);
 	if (root == NULL)
 		return;
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/firewire/oxfw/oxfw-proc.c b/sound/firewire/oxfw/oxfw-proc.c
index 8ba4f9f262b8..27dac071bc73 100644
--- a/sound/firewire/oxfw/oxfw-proc.c
+++ b/sound/firewire/oxfw/oxfw-proc.c
@@ -103,7 +103,7 @@ void snd_oxfw_proc_init(struct snd_oxfw *oxfw)
 					  oxfw->card->proc_root);
 	if (root == NULL)
 		return;
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/firewire/tascam/tascam-proc.c b/sound/firewire/tascam/tascam-proc.c
index bfd4a4c06914..fee3bf32a0da 100644
--- a/sound/firewire/tascam/tascam-proc.c
+++ b/sound/firewire/tascam/tascam-proc.c
@@ -78,7 +78,7 @@ void snd_tscm_proc_init(struct snd_tscm *tscm)
 					  tscm->card->proc_root);
 	if (root == NULL)
 		return;
-	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	root->mode = S_IFDIR | 0555;
 	if (snd_info_register(root) < 0) {
 		snd_info_free_entry(root);
 		return;
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 45e561c425bf..6c584d9b6c42 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -757,9 +757,9 @@ static int snd_msnd_pinnacle_cfg_reset(int cfg)
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 
-module_param_array(index, int, NULL, S_IRUGO);
+module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for msnd_pinnacle soundcard.");
-module_param_array(id, charp, NULL, S_IRUGO);
+module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for msnd_pinnacle soundcard.");
 
 static long io[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
@@ -801,22 +801,22 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(INITCODEFILE);
 MODULE_FIRMWARE(PERMCODEFILE);
 
-module_param_hw_array(io, long, ioport, NULL, S_IRUGO);
+module_param_hw_array(io, long, ioport, NULL, 0444);
 MODULE_PARM_DESC(io, "IO port #");
-module_param_hw_array(irq, int, irq, NULL, S_IRUGO);
-module_param_hw_array(mem, long, iomem, NULL, S_IRUGO);
-module_param_array(write_ndelay, int, NULL, S_IRUGO);
-module_param(calibrate_signal, int, S_IRUGO);
+module_param_hw_array(irq, int, irq, NULL, 0444);
+module_param_hw_array(mem, long, iomem, NULL, 0444);
+module_param_array(write_ndelay, int, NULL, 0444);
+module_param(calibrate_signal, int, 0444);
 #ifndef MSND_CLASSIC
-module_param_array(digital, int, NULL, S_IRUGO);
-module_param_hw_array(cfg, long, ioport, NULL, S_IRUGO);
-module_param_array(reset, int, 0, S_IRUGO);
-module_param_hw_array(mpu_io, long, ioport, NULL, S_IRUGO);
-module_param_hw_array(mpu_irq, int, irq, NULL, S_IRUGO);
-module_param_hw_array(ide_io0, long, ioport, NULL, S_IRUGO);
-module_param_hw_array(ide_io1, long, ioport, NULL, S_IRUGO);
-module_param_hw_array(ide_irq, int, irq, NULL, S_IRUGO);
-module_param_hw_array(joystick_io, long, ioport, NULL, S_IRUGO);
+module_param_array(digital, int, NULL, 0444);
+module_param_hw_array(cfg, long, ioport, NULL, 0444);
+module_param_array(reset, int, 0, 0444);
+module_param_hw_array(mpu_io, long, ioport, NULL, 0444);
+module_param_hw_array(mpu_irq, int, irq, NULL, 0444);
+module_param_hw_array(ide_io0, long, ioport, NULL, 0444);
+module_param_hw_array(ide_io1, long, ioport, NULL, 0444);
+module_param_hw_array(ide_irq, int, irq, NULL, 0444);
+module_param_hw_array(joystick_io, long, ioport, NULL, 0444);
 #endif
 
 
diff --git a/sound/pci/ac97/ac97_proc.c b/sound/pci/ac97/ac97_proc.c
index 6320bf084e47..e120a11c69e8 100644
--- a/sound/pci/ac97/ac97_proc.c
+++ b/sound/pci/ac97/ac97_proc.c
@@ -448,7 +448,7 @@ void snd_ac97_proc_init(struct snd_ac97 * ac97)
 	if ((entry = snd_info_create_card_entry(ac97->bus->card, name, ac97->bus->proc)) != NULL) {
 		snd_info_set_text_ops(entry, ac97, snd_ac97_proc_regs_read);
 #ifdef CONFIG_SND_DEBUG
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->c.text.write = snd_ac97_proc_regs_write;
 #endif
 		if (snd_info_register(entry) < 0) {
@@ -474,7 +474,7 @@ void snd_ac97_bus_proc_init(struct snd_ac97_bus * bus)
 
 	sprintf(name, "codec97#%d", bus->num);
 	if ((entry = snd_info_create_card_entry(bus->card, name, bus->card->proc_root)) != NULL) {
-		entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+		entry->mode = S_IFDIR | 0555;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
 			entry = NULL;
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 720361455c60..64e0961f93ba 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -69,27 +69,27 @@ static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 static bool enable_hpi_hwdep = 1;
 
-module_param_array(index, int, NULL, S_IRUGO);
+module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "ALSA index value for AudioScience soundcard.");
 
-module_param_array(id, charp, NULL, S_IRUGO);
+module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ALSA ID string for AudioScience soundcard.");
 
-module_param_array(enable, bool, NULL, S_IRUGO);
+module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "ALSA enable AudioScience soundcard.");
 
-module_param(enable_hpi_hwdep, bool, S_IRUGO|S_IWUSR);
+module_param(enable_hpi_hwdep, bool, 0644);
 MODULE_PARM_DESC(enable_hpi_hwdep,
 		"ALSA enable HPI hwdep for AudioScience soundcard ");
 
 /* identify driver */
 #ifdef KERNEL_ALSA_BUILD
 static char *build_info = "Built using headers from kernel source";
-module_param(build_info, charp, S_IRUGO);
+module_param(build_info, charp, 0444);
 MODULE_PARM_DESC(build_info, "Built using headers from kernel source");
 #else
 static char *build_info = "Built within ALSA source";
-module_param(build_info, charp, S_IRUGO);
+module_param(build_info, charp, 0444);
 MODULE_PARM_DESC(build_info, "Built within ALSA source");
 #endif
 
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index b1a2a7ea4172..7d049569012c 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -46,14 +46,14 @@ MODULE_FIRMWARE("asihpi/dsp8900.bin");
 #endif
 
 static int prealloc_stream_buf;
-module_param(prealloc_stream_buf, int, S_IRUGO);
+module_param(prealloc_stream_buf, int, 0444);
 MODULE_PARM_DESC(prealloc_stream_buf,
 	"Preallocate size for per-adapter stream buffer");
 
 /* Allow the debug level to be changed after module load.
  E.g.   echo 2 > /sys/module/asihpi/parameters/hpiDebugLevel
 */
-module_param(hpi_debug_level, int, S_IRUGO | S_IWUSR);
+module_param(hpi_debug_level, int, 0644);
 MODULE_PARM_DESC(hpi_debug_level, "debug verbosity 0..5");
 
 /* List of adapters found */
diff --git a/sound/pci/ca0106/ca0106_proc.c b/sound/pci/ca0106/ca0106_proc.c
index 9b2b8b38122f..a2c85cc37972 100644
--- a/sound/pci/ca0106/ca0106_proc.c
+++ b/sound/pci/ca0106/ca0106_proc.c
@@ -431,7 +431,7 @@ int snd_ca0106_proc_init(struct snd_ca0106 *emu)
 	if(! snd_card_proc_new(emu->card, "ca0106_reg32", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read32);
 		entry->c.text.write = snd_ca0106_proc_reg_write32;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if(! snd_card_proc_new(emu->card, "ca0106_reg16", &entry))
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read16);
@@ -440,12 +440,12 @@ int snd_ca0106_proc_init(struct snd_ca0106 *emu)
 	if(! snd_card_proc_new(emu->card, "ca0106_regs1", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read1);
 		entry->c.text.write = snd_ca0106_proc_reg_write;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if(! snd_card_proc_new(emu->card, "ca0106_i2c", &entry)) {
 		entry->c.text.write = snd_ca0106_proc_i2c_write;
 		entry->private_data = emu;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if(! snd_card_proc_new(emu->card, "ca0106_regs2", &entry)) 
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read2);
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 0020fd0efc46..ed1251c5f449 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2849,7 +2849,7 @@ static int snd_cs46xx_proc_init(struct snd_card *card, struct snd_cs46xx *chip)
 			entry->private_data = chip;
 			entry->c.ops = &snd_cs46xx_proc_io_ops;
 			entry->size = region->size;
-			entry->mode = S_IFREG | S_IRUSR;
+			entry->mode = S_IFREG | 0400;
 		}
 	}
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index aa61615288ff..c44eadef64ae 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -798,7 +798,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 
 	if ((entry = snd_info_create_card_entry(card, "dsp", card->proc_root)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
-		entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+		entry->mode = S_IFDIR | 0555;
       
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -814,7 +814,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if ((entry = snd_info_create_card_entry(card, "spos_symbols", ins->proc_dsp_dir)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
-		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+		entry->mode = S_IFREG | 0644;
 		entry->c.text.read = cs46xx_dsp_proc_symbol_table_read;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -826,7 +826,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if ((entry = snd_info_create_card_entry(card, "spos_modules", ins->proc_dsp_dir)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
-		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+		entry->mode = S_IFREG | 0644;
 		entry->c.text.read = cs46xx_dsp_proc_modules_read;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -838,7 +838,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if ((entry = snd_info_create_card_entry(card, "parameter", ins->proc_dsp_dir)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
-		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+		entry->mode = S_IFREG | 0644;
 		entry->c.text.read = cs46xx_dsp_proc_parameter_dump_read;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -850,7 +850,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if ((entry = snd_info_create_card_entry(card, "sample", ins->proc_dsp_dir)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
-		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+		entry->mode = S_IFREG | 0644;
 		entry->c.text.read = cs46xx_dsp_proc_sample_dump_read;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -862,7 +862,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if ((entry = snd_info_create_card_entry(card, "task_tree", ins->proc_dsp_dir)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
-		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+		entry->mode = S_IFREG | 0644;
 		entry->c.text.read = cs46xx_dsp_proc_task_tree_read;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -874,7 +874,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if ((entry = snd_info_create_card_entry(card, "scb_info", ins->proc_dsp_dir)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
-		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+		entry->mode = S_IFREG | 0644;
 		entry->c.text.read = cs46xx_dsp_proc_scb_read;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index 7488e1b7a770..abb01ce66983 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -271,7 +271,7 @@ void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
       
 			entry->content = SNDRV_INFO_CONTENT_TEXT;
 			entry->private_data = scb_info;
-			entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
+			entry->mode = S_IFREG | 0644;
       
 			entry->c.text.read = cs46xx_dsp_proc_scb_info_read;
       
diff --git a/sound/pci/ctxfi/cttimer.c b/sound/pci/ctxfi/cttimer.c
index 08e874e9a7f6..2099e9ce441a 100644
--- a/sound/pci/ctxfi/cttimer.c
+++ b/sound/pci/ctxfi/cttimer.c
@@ -17,7 +17,7 @@
 
 static bool use_system_timer;
 MODULE_PARM_DESC(use_system_timer, "Force to use system-timer");
-module_param(use_system_timer, bool, S_IRUGO);
+module_param(use_system_timer, bool, 0444);
 
 struct ct_timer_ops {
 	void (*init)(struct ct_timer_instance *);
diff --git a/sound/pci/ctxfi/xfi.c b/sound/pci/ctxfi/xfi.c
index f2f32779de98..b2874220be1b 100644
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -26,9 +26,9 @@ MODULE_SUPPORTED_DEVICE("{{Creative Labs, Sound Blaster X-Fi}");
 static unsigned int reference_rate = 48000;
 static unsigned int multiple = 2;
 MODULE_PARM_DESC(reference_rate, "Reference rate (default=48000)");
-module_param(reference_rate, uint, S_IRUGO);
+module_param(reference_rate, uint, 0444);
 MODULE_PARM_DESC(multiple, "Rate multiplier (default=2)");
-module_param(multiple, uint, S_IRUGO);
+module_param(multiple, uint, 0444);
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 2c2b12a06177..611589cbdad6 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1070,7 +1070,7 @@ static int snd_emu10k1x_proc_init(struct emu10k1x *emu)
 	if(! snd_card_proc_new(emu->card, "emu10k1x_regs", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu10k1x_proc_reg_read);
 		entry->c.text.write = snd_emu10k1x_proc_reg_write;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->private_data = emu;
 	}
 	
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index bde0d1954f56..dc3d3512154f 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -574,32 +574,32 @@ int snd_emu10k1_proc_init(struct snd_emu10k1 *emu)
 	if (! snd_card_proc_new(emu->card, "io_regs", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_io_reg_read);
 		entry->c.text.write = snd_emu_proc_io_reg_write;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs00a", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read00a);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs00b", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read00b);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs20a", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20a);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs20b", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20b);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs20c", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20c);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 #endif
 	
@@ -621,35 +621,35 @@ int snd_emu10k1_proc_init(struct snd_emu10k1 *emu)
 	if (! snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
-		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
+		entry->mode = S_IFREG | 0444 /*| S_IWUSR*/;
 		entry->size = emu->audigy ? A_TOTAL_SIZE_GPR : TOTAL_SIZE_GPR;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_tram_data", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
-		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
+		entry->mode = S_IFREG | 0444 /*| S_IWUSR*/;
 		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_DATA : TOTAL_SIZE_TANKMEM_DATA ;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_tram_addr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
-		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
+		entry->mode = S_IFREG | 0444 /*| S_IWUSR*/;
 		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_ADDR : TOTAL_SIZE_TANKMEM_ADDR ;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_code", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
-		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
+		entry->mode = S_IFREG | 0444 /*| S_IWUSR*/;
 		entry->size = emu->audigy ? A_TOTAL_SIZE_CODE : TOTAL_SIZE_CODE;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_acode", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = emu;
-		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
+		entry->mode = S_IFREG | 0444 /*| S_IWUSR*/;
 		entry->c.text.read = snd_emu10k1_proc_acode_read;
 	}
 	return 0;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7d7eb1354eee..8840daf9c6a3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -510,7 +510,7 @@ static int eld_proc_new(struct hdmi_spec_per_pin *per_pin, int index)
 
 	snd_info_set_text_ops(entry, per_pin, print_eld_info);
 	entry->c.text.write = write_eld_info;
-	entry->mode |= S_IWUSR;
+	entry->mode |= 0200;
 	per_pin->proc_entry = entry;
 
 	return 0;
diff --git a/sound/pci/ice1712/pontis.c b/sound/pci/ice1712/pontis.c
index 5101f40f6fbd..93b8cfc6636f 100644
--- a/sound/pci/ice1712/pontis.c
+++ b/sound/pci/ice1712/pontis.c
@@ -662,7 +662,7 @@ static void wm_proc_init(struct snd_ice1712 *ice)
 	struct snd_info_entry *entry;
 	if (! snd_card_proc_new(ice->card, "wm_codec", &entry)) {
 		snd_info_set_text_ops(entry, ice, wm_proc_regs_read);
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->c.text.write = wm_proc_regs_write;
 	}
 }
diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 8dabd4d0211d..d7366ade5a25 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -926,7 +926,7 @@ static void wm_proc_init(struct snd_ice1712 *ice)
 	struct snd_info_entry *entry;
 	if (!snd_card_proc_new(ice->card, "wm_codec", &entry)) {
 		snd_info_set_text_ops(entry, ice, wm_proc_regs_read);
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->c.text.write = wm_proc_regs_write;
 	}
 }
diff --git a/sound/pci/lola/lola_proc.c b/sound/pci/lola/lola_proc.c
index c241dc06dd92..904e3c4f4dfe 100644
--- a/sound/pci/lola/lola_proc.c
+++ b/sound/pci/lola/lola_proc.c
@@ -214,7 +214,7 @@ void lola_proc_debug_new(struct lola *chip)
 		snd_info_set_text_ops(entry, chip, lola_proc_codec_read);
 	if (!snd_card_proc_new(chip->card, "codec_rw", &entry)) {
 		snd_info_set_text_ops(entry, chip, lola_proc_codec_rw_read);
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 		entry->c.text.write = lola_proc_codec_rw_write;
 	}
 	if (!snd_card_proc_new(chip->card, "regs", &entry))
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index f9ae72f28ddc..e57da4036231 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1465,7 +1465,7 @@ static void pcxhr_proc_init(struct snd_pcxhr *chip)
 	    !snd_card_proc_new(chip->card, "gpio", &entry)) {
 		snd_info_set_text_ops(entry, chip, pcxhr_proc_gpio_read);
 		entry->c.text.write = pcxhr_proc_gpo_write;
-		entry->mode |= S_IWUSR;
+		entry->mode |= 0200;
 	}
 	if (!snd_card_proc_new(chip->card, "ltc", &entry))
 		snd_info_set_text_ops(entry, chip, pcxhr_proc_ltc);
diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index feca0a672976..80dc42197154 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1733,10 +1733,10 @@ static ssize_t cs43130_show_ac_r(struct device *dev,
 	return cs43130_show_ac(dev, buf, HP_RIGHT);
 }
 
-static DEVICE_ATTR(hpload_dc_l, S_IRUGO, cs43130_show_dc_l, NULL);
-static DEVICE_ATTR(hpload_dc_r, S_IRUGO, cs43130_show_dc_r, NULL);
-static DEVICE_ATTR(hpload_ac_l, S_IRUGO, cs43130_show_ac_l, NULL);
-static DEVICE_ATTR(hpload_ac_r, S_IRUGO, cs43130_show_ac_r, NULL);
+static DEVICE_ATTR(hpload_dc_l, 0444, cs43130_show_dc_l, NULL);
+static DEVICE_ATTR(hpload_dc_r, 0444, cs43130_show_dc_r, NULL);
+static DEVICE_ATTR(hpload_ac_l, 0444, cs43130_show_ac_l, NULL);
+static DEVICE_ATTR(hpload_ac_r, 0444, cs43130_show_ac_r, NULL);
 
 static struct reg_sequence hp_en_cal_seq[] = {
 	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b7b914963c62..2175dccdf388 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -627,22 +627,21 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
 	if (!root)
 		goto err;
 
-	if (!debugfs_create_bool("booted", S_IRUGO, root, &dsp->booted))
+	if (!debugfs_create_bool("booted", 0444, root, &dsp->booted))
 		goto err;
 
-	if (!debugfs_create_bool("running", S_IRUGO, root, &dsp->running))
+	if (!debugfs_create_bool("running", 0444, root, &dsp->running))
 		goto err;
 
-	if (!debugfs_create_x32("fw_id", S_IRUGO, root, &dsp->fw_id))
+	if (!debugfs_create_x32("fw_id", 0444, root, &dsp->fw_id))
 		goto err;
 
-	if (!debugfs_create_x32("fw_version", S_IRUGO, root,
-				&dsp->fw_id_version))
+	if (!debugfs_create_x32("fw_version", 0444, root, &dsp->fw_id_version))
 		goto err;
 
 	for (i = 0; i < ARRAY_SIZE(wm_adsp_debugfs_fops); ++i) {
 		if (!debugfs_create_file(wm_adsp_debugfs_fops[i].name,
-					 S_IRUGO, root, dsp,
+					 0444, root, dsp,
 					 &wm_adsp_debugfs_fops[i].fops))
 			goto err;
 	}
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 1bacfa24ba7f..1255dfe19eef 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -142,7 +142,7 @@ int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 	if (!ssi_dbg->dbg_dir)
 		return -ENOMEM;
 
-	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO,
+	ssi_dbg->dbg_stats = debugfs_create_file("stats", 0444,
 						 ssi_dbg->dbg_dir, ssi_dbg,
 						 &fsl_ssi_stats_ops);
 	if (!ssi_dbg->dbg_stats) {
diff --git a/sound/sound_core.c b/sound/sound_core.c
index b4efb22db561..40ad000c2e3c 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -413,7 +413,7 @@ int register_sound_special_device(const struct file_operations *fops, int unit,
 		break;
 	}
 	return sound_insert_unit(&chains[chain], fops, -1, unit, max_unit,
-				 name, S_IRUSR | S_IWUSR, dev);
+				 name, 0600, dev);
 }
  
 EXPORT_SYMBOL(register_sound_special_device);
@@ -440,7 +440,7 @@ EXPORT_SYMBOL(register_sound_special);
 int register_sound_mixer(const struct file_operations *fops, int dev)
 {
 	return sound_insert_unit(&chains[0], fops, dev, 0, 128,
-				 "mixer", S_IRUSR | S_IWUSR, NULL);
+				 "mixer", 0600, NULL);
 }
 
 EXPORT_SYMBOL(register_sound_mixer);
@@ -468,7 +468,7 @@ EXPORT_SYMBOL(register_sound_mixer);
 int register_sound_dsp(const struct file_operations *fops, int dev)
 {
 	return sound_insert_unit(&chains[3], fops, dev, 3, 131,
-				 "dsp", S_IWUSR | S_IRUSR, NULL);
+				 "dsp", 0600, NULL);
 }
 
 EXPORT_SYMBOL(register_sound_dsp);
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index f0e713527e91..7609eceba1a2 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2518,7 +2518,7 @@ static void snd_dbri_proc(struct snd_card *card)
 #ifdef DBRI_DEBUG
 	if (!snd_card_proc_new(card, "debug", &entry)) {
 		snd_info_set_text_ops(entry, dbri, dbri_debug_read);
-		entry->mode = S_IFREG | S_IRUGO;	/* Readable only. */
+		entry->mode = S_IFREG | 0444;	/* Readable only. */
 	}
 #endif
 }
-- 
2.15.0
