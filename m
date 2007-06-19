Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04ABBDDEEA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 14:37:45 +1000 (EST)
Subject: [PATCH] fix snd-powermac refounting bugs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 14:37:39 +1000
Message-Id: <1182227860.26853.308.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The old snd-powermac driver has some serious refcounting issues when
initialisation fails, which is the case on all new machines with
a layout-id since those are handled by the new snd-powermac driver.

Some of those bugs seem to have been under the radar for some time
(like double pci_dev_put), but one was actually added in 2.6.22 with
Stephen attempt at teaching refcounting to the driver which didn't
do it at all.

This patch fixes both, thus removing all sort of kref errors that
would happen if that driver gets loaded on a G5 machine or a recent
PowerBook due to OF nodes left around with a 0 refcount.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/sound/ppc/pmac.c
===================================================================
--- linux-work.orig/sound/ppc/pmac.c	2007-06-19 14:18:09.000000000 +1000
+++ linux-work/sound/ppc/pmac.c	2007-06-19 14:27:08.000000000 +1000
@@ -775,7 +775,8 @@ static int snd_pmac_free(struct snd_pmac
 		out_le32(&chip->awacs->control, in_le32(&chip->awacs->control) & 0xfff);
 	}
 
-	snd_pmac_sound_feature(chip, 0);
+	if (chip->node)
+		snd_pmac_sound_feature(chip, 0);
 
 	/* clean up mixer if any */
 	if (chip->mixer_free)
@@ -925,6 +926,7 @@ static int __init snd_pmac_detect(struct
 	}
 	if (! sound) {
 		of_node_put(chip->node);
+		chip->node = NULL;
 		return -ENODEV;
 	}
 	prop = of_get_property(sound, "sub-frame", NULL);
@@ -937,7 +939,9 @@ static int __init snd_pmac_detect(struct
 		printk(KERN_INFO "snd-powermac no longer handles any "
 				 "machines with a layout-id property "
 				 "in the device-tree, use snd-aoa.\n");
+		of_node_put(sound);
 		of_node_put(chip->node);
+		chip->node = NULL;
 		return -ENODEV;
 	}
 	/* This should be verified on older screamers */
@@ -1297,8 +1301,6 @@ int __init snd_pmac_new(struct snd_card 
 	return 0;
 
  __error:
-	if (chip->pdev)
-		pci_dev_put(chip->pdev);
 	snd_pmac_free(chip);
 	return err;
 }
