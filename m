Return-Path: <stelian@popies.net>
Received: from sd291.sivit.org (sd291.sivit.org [194.146.225.122])
	by ozlabs.org (Postfix) with ESMTP id CD9A9681BD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 21:35:43 +1100 (EST)
Subject: [PATCH] sound/ppc/pmac.c typo.
From: Stelian Pop <stelian@popies.net>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 20 Jan 2006 11:35:38 +0100
Message-Id: <1137753338.5050.8.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In 2.6.16-rc1 there is a small typo introduced by the 'Remove device_node addrs/n_addr' changes
which prevents my Powerbook G4 sound from working:

	Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
	snd: can't request rsrc  0 (Sound Control: 0x80000000:80004fff)
	ALSA device list:
	   No soundcards found.

The patch below fixes it. Of course, the patch fixing the i2c issues 
('i2c_smbus_write_i2c_block_data' patch) needs to be applied to in order for
the sound to completly work.
 
Signed-off-by: Stelian Pop <stelian@popies.net>

diff -r ad1abd4058ea sound/ppc/pmac.c
--- a/sound/ppc/pmac.c	Fri Jan 20 11:02:26 2006 +0100
+++ b/sound/ppc/pmac.c	Fri Jan 20 11:13:55 2006 +0100
@@ -1217,7 +1217,7 @@
 			goto __error;
 		}
 		for (i = 0; i < 3; i ++) {
-			if (of_address_to_resource(np->parent, i,
+			if (of_address_to_resource(np, i,
 						   &chip->rsrc[i])) {
 				printk(KERN_ERR "snd: can't translate rsrc "
 				       " %d (%s)\n", i, rnames[i]);


-- 
Stelian Pop <stelian@popies.net>
