MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16202.58416.134657.827441@cargo.ozlabs.ibm.com>
Date: Tue, 26 Aug 2003 14:38:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: sound on dual G4 powermac
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been using this patch in 2.5/2.6 kernels on my dual G4 powermac
for some time.  Without it, I get no sound at all, even after
unmuting.  I don't know exactly why this fixes it, but this is what I
came up with in the process of doing a binary search between a kernel
that worked and one that didn't.

Paul.

diff -urN linux-2.5/sound/ppc/tumbler.c pmac-2.5/sound/ppc/tumbler.c
--- linux-2.5/sound/ppc/tumbler.c	2003-08-02 09:37:36.000000000 +1000
+++ pmac-2.5/sound/ppc/tumbler.c	2003-08-09 09:53:12.000000000 +1000
@@ -976,6 +976,9 @@
 	chip->mixer_data = mix;
 	chip->mixer_free = tumbler_cleanup;

+	if ((err = tumbler_init(chip)) < 0)
+		return err;
+
 	/* set up TAS */
 	tas_node = find_devices("deq");
 	if (tas_node == NULL)
@@ -1022,9 +1025,6 @@
 	if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 		return err;

-	if ((err = tumbler_init(chip)) < 0)
-		return err;
-
 #ifdef CONFIG_PMAC_PBOOK
 	chip->resume = tumbler_resume;
 #endif

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
