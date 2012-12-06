Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/20] ALSA: sound/ps3: remove __dev* attributes
Date: Thu,  6 Dec 2012 12:35:22 -0500
Message-Id: <1354815329-20221-14-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
References: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
Cc: cbe-oss-dev@lists.ozlabs.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 perex@perex.cz, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: cbe-oss-dev@lists.ozlabs.org
---
 sound/ppc/snd_ps3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 9b18b52..8c7dcbe 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -786,7 +786,7 @@ static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
 };
 
 
-static int __devinit snd_ps3_map_mmio(void)
+static int snd_ps3_map_mmio(void)
 {
 	the_card.mapped_mmio_vaddr =
 		ioremap(the_card.ps3_dev->m_region->bus_addr,
@@ -808,7 +808,7 @@ static void snd_ps3_unmap_mmio(void)
 	the_card.mapped_mmio_vaddr = NULL;
 }
 
-static int __devinit snd_ps3_allocate_irq(void)
+static int snd_ps3_allocate_irq(void)
 {
 	int ret;
 	u64 lpar_addr, lpar_size;
@@ -866,7 +866,7 @@ static void snd_ps3_free_irq(void)
 	ps3_irq_plug_destroy(the_card.irq_no);
 }
 
-static void __devinit snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
+static void snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
 {
 	uint64_t val;
 	int ret;
@@ -882,7 +882,7 @@ static void __devinit snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
 			ret);
 }
 
-static void __devinit snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
+static void snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
 {
 	/*
 	 * avsetting driver seems to never change the followings
@@ -906,7 +906,7 @@ static void __devinit snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
 		   PS3_AUDIO_AO_3WMCTRL_ASOPLRCK_DEFAULT);
 }
 
-static int __devinit snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
+static int snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
 {
 	int ret;
 	pr_debug("%s: start\n", __func__);
@@ -928,7 +928,7 @@ static int __devinit snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
 	return ret;
 }
 
-static int __devinit snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
+static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 {
 	int i, ret;
 	u64 lpar_addr, lpar_size;
-- 
1.8.0.1
