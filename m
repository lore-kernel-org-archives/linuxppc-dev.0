From: Ernst Persson <ernstp@mac.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] Burgundy Auto-Mute problem
Date: Thu, 17 Jul 2003 17:16:35 +0200
Cc: alsa-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
References: <200307171108.03928.ernstp@mac.com> <s5hn0fdzcml.wl@alsa2.suse.de>
In-Reply-To: <s5hn0fdzcml.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307171716.35610.ernstp@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you add an #include <linux/delay.h> the patch works and everything runs
fine, even with
PMAC_SUPPORT_AUTOMUTE enabled.

But now that I can run the drivers, I discover that I can't change any of the
mixer controls. (as root:)
	amixer sset Master 100
Simple mixer control 'Master',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 100 [100%]
  Front Right: Playback 100 [100%]
	amixer sget Master
Simple mixer control 'Master',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]

What's wrong now?

//ernie

torsdagen den 17 juli 2003 12.11 skrev Takashi Iwai:
> At Thu, 17 Jul 2003 11:08:03 +0200,
>
> Ernst Persson wrote:
> > Hi all!
> >
> > Now that the 2.6.0 kernel is out I'm trying to get ALSA working on my
> > iMac 266, since it's the default sound system now (and dmasound doesn't
> > compile).
> >
> > The first problem was that everything locked up when the ALSA drivers
> > loaded. No error message, no kernel panic, just dead. And compiling ALSA
> > with debug didn't help either.
> >
> > After some debugging I found out that the driver crashed here, in
> > sound/ppc/burgundy.c    in   int __init snd_pmac_burgundy_init(pmac_t
> > *chip)
> >
> > #ifdef PMAC_SUPPORT_AUTOMUTE
> >
> > 	printk(KERN_INFO "Automute Enabled.\n");
> >
> > 	if ((err = snd_pmac_add_automute(chip)) < 0)
> > 		return err;
> >
> > 	chip->detect_headphone = snd_pmac_burgundy_detect_headphone;
> > 	chip->update_automute = snd_pmac_burgundy_update_automute;
> > 	snd_pmac_burgundy_update_automute(chip, 0); /* update the status only */
> > #endif
> > So I commented out //#define PMAC_SUPPORT_AUTOMUTE in pmac.h and after
> > that the driver loaded without problems.
> >
> > But as soon as I touch any mixer (both the oss-emulated or with
> > alsamixer) everything locks up again, in exactly the same way.
>
> it seems that extend extend_wait() function waits for an infinite
> loop.  could you try the attached patch?
>
>
> Takashi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
