Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2F4E67A2E
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Apr 2005 04:04:21 +1000 (EST)
Date: Thu, 21 Apr 2005 20:04:08 +0200
From: Colin Leroy <colin@colino.net>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050421200408.5361a5b3@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.12-rc3] pmac: save master volume on sleep
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Ben's patch that shutdowns master switch and restores it after
resume ("pmac: Improve sleep code of tumbler driver") isn't enough here
on an iBook (snapper chip).

The master switch is correctly saved and restored, but somehow
tumbler_put_master_volume() gets called just after
tumbler_set_master_volume() and sets mix->master_vol[*] to 0. So, on
resuming, the master switch is reenabled, but the volume is set to 0.

Here's a patch that also saves and restores master_vol.
Thanks,

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/sound/ppc/tumbler.c	2005-04-21 19:56:06.000000000 +0200
+++ b/sound/ppc/tumbler.c	2005-04-21 19:55:43.000000000 +0200
@@ -99,6 +99,7 @@
 	pmac_gpio_t hp_detect;
 	int headphone_irq;
 	int lineout_irq;
+	unsigned int save_master_vol[2];
 	unsigned int master_vol[2];
 	unsigned int save_master_switch[2];
 	unsigned int master_switch[2];
@@ -1128,6 +1129,8 @@
 		disable_irq(mix->lineout_irq);
 	mix->save_master_switch[0] = mix->master_switch[0];
 	mix->save_master_switch[1] = mix->master_switch[1];
+	mix->save_master_vol[0] = mix->master_vol[0];
+	mix->save_master_vol[1] = mix->master_vol[1];
 	mix->master_switch[0] = mix->master_switch[1] = 0;
 
 	tumbler_set_master_volume(mix);
@@ -1156,6 +1159,8 @@
 	mix->acs &= ~1;
 	mix->master_switch[0] = mix->save_master_switch[0];
 	mix->master_switch[1] = mix->save_master_switch[1];
+	mix->master_vol[0] = mix->save_master_vol[0];
+	mix->master_vol[1] = mix->save_master_vol[1];
 	tumbler_reset_audio(chip);
 	if (mix->i2c.client && mix->i2c.init_client) {
 		if (mix->i2c.init_client(&mix->i2c) < 0)
