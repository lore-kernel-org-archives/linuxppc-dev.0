From: Ernst Persson <ernstp@mac.com>
Subject: Burgundy Auto-Mute problem
Date: Thu, 17 Jul 2003 11:08:03 +0200
To: alsa-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307171108.03928.ernstp@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all!

Now that the 2.6.0 kernel is out I'm trying to get ALSA working on my iMac
266, since it's the default sound system now (and dmasound doesn't compile).

The first problem was that everything locked up when the ALSA drivers loaded.
No error message, no kernel panic, just dead. And compiling ALSA with debug
didn't help either.

After some debugging I found out that the driver crashed here, in
sound/ppc/burgundy.c    in   int __init snd_pmac_burgundy_init(pmac_t *chip)

#ifdef PMAC_SUPPORT_AUTOMUTE

	printk(KERN_INFO "Automute Enabled.\n");

	if ((err = snd_pmac_add_automute(chip)) < 0)
		return err;

	chip->detect_headphone = snd_pmac_burgundy_detect_headphone;
	chip->update_automute = snd_pmac_burgundy_update_automute;
	snd_pmac_burgundy_update_automute(chip, 0); /* update the status only */
#endif
So I commented out //#define PMAC_SUPPORT_AUTOMUTE in pmac.h and after that
the driver loaded without problems.

But as soon as I touch any mixer (both the oss-emulated or with alsamixer)
everything locks up again, in exactly the same way.

Any clues?

regards
//ernie


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
