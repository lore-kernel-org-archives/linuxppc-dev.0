Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E5B49B7147
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:25 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 28/33] sound/ps3: Correct existing and add missing annotations
Date: Wed, 10 Jun 2009 16:39:03 +0200
Message-Id: <1244644748-24211-29-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-28-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
	<1244644748-24211-28-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

probe functions should be __devinit

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/ppc/snd_ps3.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index cd9109a..53c81a5 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -785,7 +785,7 @@ static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
 };
 
 
-static int snd_ps3_map_mmio(void)
+static int __devinit snd_ps3_map_mmio(void)
 {
 	the_card.mapped_mmio_vaddr =
 		ioremap(the_card.ps3_dev->m_region->bus_addr,
@@ -807,7 +807,7 @@ static void snd_ps3_unmap_mmio(void)
 	the_card.mapped_mmio_vaddr = NULL;
 }
 
-static int snd_ps3_allocate_irq(void)
+static int __devinit snd_ps3_allocate_irq(void)
 {
 	int ret;
 	u64 lpar_addr, lpar_size;
@@ -865,7 +865,7 @@ static void snd_ps3_free_irq(void)
 	ps3_irq_plug_destroy(the_card.irq_no);
 }
 
-static void snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
+static void __devinit snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
 {
 	uint64_t val;
 	int ret;
@@ -881,7 +881,7 @@ static void snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
 			ret);
 }
 
-static void snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
+static void __devinit snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
 {
 	/*
 	 * avsetting driver seems to never change the followings
@@ -905,7 +905,7 @@ static void snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
 		   PS3_AUDIO_AO_3WMCTRL_ASOPLRCK_DEFAULT);
 }
 
-static int snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
+static int __devinit snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
 {
 	int ret;
 	pr_debug("%s: start\n", __func__);
@@ -927,7 +927,7 @@ static int snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
 	return ret;
 }
 
-static int __init snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
+static int __devinit snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 {
 	int i, ret;
 	u64 lpar_addr, lpar_size;
-- 
1.6.2.4
