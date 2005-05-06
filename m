Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A379F679A6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2005 15:15:21 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keenan Pepper <keenanpepper@gmail.com>
In-Reply-To: <427AE616.1030908@gmail.com>
References: <42784801.7080105@gmail.com> <1115251597.7567.163.camel@gaston>
	<427AE616.1030908@gmail.com>
Content-Type: text/plain
Date: Fri, 06 May 2005 15:15:11 +1000
Message-Id: <1115356511.28075.5.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Oops in snd-powermac on powerbook 3400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-05 at 23:35 -0400, Keenan Pepper wrote:
> I fixed it!
> 
> I changed it to use the same device node for sound as for chip->node, 
> and it started beeping at me! Apparently sometime between 2.6.8 and 
> 2.6.12-rc3 the KIOCSOUND ioctl was implemented, because it sure didn't 
> beep before.
> 
> BTW, this is the first time I've ever fixed a kernel bug.

Ok, I think your patch was whitespace damaged, so I re-did it by hand ;)

Here's the result. Please test. Also, other people around, please test
if with this patch, snd-powermac works, especially on oldworld machines!

I'll submit upstream tomorrow hopefully.

Ben.

Index: linux-work/sound/ppc/pmac.c
===================================================================
--- linux-work.orig/sound/ppc/pmac.c	2005-05-02 10:51:00.000000000 +1000
+++ linux-work/sound/ppc/pmac.c	2005-05-06 15:13:22.000000000 +1000
@@ -876,7 +876,7 @@
  */
 static int __init snd_pmac_detect(pmac_t *chip)
 {
-	struct device_node *sound;
+	struct device_node *sound = NULL;
 	unsigned int *prop, l;
 	struct macio_chip* macio;
 
@@ -906,20 +906,22 @@
 		chip->is_pbook_G3 = 1;
 	chip->node = find_devices("awacs");
 	if (chip->node)
-		return 0; /* ok */
+		sound = chip->node;
 
 	/*
 	 * powermac G3 models have a node called "davbus"
 	 * with a child called "sound".
 	 */
-	chip->node = find_devices("davbus");
+	if (!chip->node)
+		chip->node = find_devices("davbus");
 	/*
 	 * if we didn't find a davbus device, try 'i2s-a' since
 	 * this seems to be what iBooks have
 	 */
 	if (! chip->node) {
 		chip->node = find_devices("i2s-a");
-		if (chip->node && chip->node->parent && chip->node->parent->parent) {
+		if (chip->node && chip->node->parent &&
+		    chip->node->parent->parent) {
 			if (device_is_compatible(chip->node->parent->parent,
 						 "K2-Keylargo"))
 				chip->is_k2 = 1;
@@ -928,9 +930,11 @@
 	if (! chip->node)
 		return -ENODEV;
 
-	sound = find_devices("sound");
-	while (sound && sound->parent != chip->node)
-		sound = sound->next;
+	if (!sound) {
+		sound = find_devices("sound");
+		while (sound && sound->parent != chip->node)
+			sound = sound->next;
+	}
 	if (! sound)
 		return -ENODEV;
 	prop = (unsigned int *) get_property(sound, "sub-frame", NULL);
@@ -1019,7 +1023,8 @@
 		}
 	}
 	if (chip->pdev == NULL)
-		printk(KERN_WARNING "snd-powermac: can't locate macio PCI device !\n");
+		printk(KERN_WARNING "snd-powermac: can't locate macio PCI"
+		       " device !\n");
 
 	detect_byte_swap(chip);
 
@@ -1027,7 +1032,8 @@
 	   are available */
 	prop = (unsigned int *) get_property(sound, "sample-rates", &l);
 	if (! prop)
-		prop = (unsigned int *) get_property(sound, "output-frame-rates", &l);
+		prop = (unsigned int *) get_property(sound,
+						     "output-frame-rates", &l);
 	if (prop) {
 		int i;
 		chip->freqs_ok = 0;
@@ -1054,7 +1060,8 @@
 /*
  * exported - boolean info callbacks for ease of programming
  */
-int snd_pmac_boolean_stereo_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+int snd_pmac_boolean_stereo_info(snd_kcontrol_t *kcontrol,
+				 snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 2;
@@ -1063,7 +1070,8 @@
 	return 0;
 }
 
-int snd_pmac_boolean_mono_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+int snd_pmac_boolean_mono_info(snd_kcontrol_t *kcontrol,
+			       snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
