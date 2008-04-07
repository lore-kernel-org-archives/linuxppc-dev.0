Return-Path: <risto.suominen@gmail.com>
Message-ID: <46e1c7760804070628t21277d6ake2d4887554a19f52@mail.gmail.com>
Date: Mon, 7 Apr 2008 16:28:27 +0300
From: "Risto Suominen" <risto.suominen@gmail.com>
To: perex@perex.cz
Subject: [PATCH 001/003] snd-powermac: enable headphone detection
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LinuxPPC-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Risto Suominen <Risto.Suominen@gmail.com>

Enable port change interrupt while initialising AWACS, Screamer, and
Burgundy chipsets.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/pmac.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/pmac.c	2008-04-07 12:18:47.503077312 +0300
@@ -214,7 +214,7 @@ static int snd_pmac_pcm_prepare(struct s
 	int rate_index;
 	long offset;
 	struct pmac_stream *astr;
-	
+
 	rec->dma_size = snd_pcm_lib_buffer_bytes(subs);
 	rec->period_size = snd_pcm_lib_period_bytes(subs);
 	rec->nperiods = rec->dma_size / rec->period_size;
@@ -643,7 +643,7 @@ static int snd_pmac_pcm_close(struct snd
 	/* reset constraints */
 	astr->cur_freqs = chip->freqs_ok;
 	astr->cur_formats = chip->formats_ok;
-	
+
 	return 0;
 }

@@ -1063,6 +1063,10 @@ static int __init snd_pmac_detect(struct
 	else {
 		struct pci_dev *pdev = NULL;

+#ifndef for_each_pci_dev
+#define for_each_pci_dev(d) \
+		while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
+#endif
 		for_each_pci_dev(pdev) {
 			struct device_node *np = pci_device_to_OF_node(pdev);
 			if (np && np == macio->of_node) {
@@ -1300,9 +1304,9 @@ int __init snd_pmac_new(struct snd_card

 	snd_pmac_sound_feature(chip, 1);

-	/* reset */
-	if (chip->model == PMAC_AWACS)
-		out_le32(&chip->awacs->control, 0x11);
+	/* reset & enable interrupts */
+	if (chip->model <= PMAC_BURGUNDY)
+		out_le32(&chip->awacs->control, chip->control_mask);

 	/* Powerbooks have odd ways of enabling inputs such as
 	   an expansion-bay CD or sound from an internal modem
