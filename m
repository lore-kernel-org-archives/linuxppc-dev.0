Date: Sun, 26 Mar 2000 20:22:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound module on PowerBook
In-Reply-To: <200003261756.TAA00447@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.05.10003262021070.3263-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 26 Mar 2000, Michel Lanners wrote:
> On  26 Mar, this message from Geert Uytterhoeven echoed through cyberspace:
> > In arch/ppc/kernel/feature.c, we have
> >
> >     #ifdef CONFIG_PMAC_PBOOK
> >     #ifdef CONFIG_DMASOUND_MODULE
> > 	    /* On PowerBooks, we disable the sound chip when dmasound is a module
> > 	     * */
> > 	    if (controller_count && find_devices("via-pmu") != NULL) {
> > 		    feature_clear(controllers[0].device, FEATURE_Sound_power);
> > 		    feature_clear(controllers[0].device, FEATURE_Sound_CLK_enable);
> > 	    }
> >     #endif
> >     #endif
> >
> > Shouldn't the sound chip be disabled if dmasound is not compiled at all, i.e.
> > #if defined(CONFIG_PMAC_PBOOK) && !defined(CONFIG_DMASOUND)?
>
> or rather
>
> #if defined(CONFIG_PMAC_PBOOK) && !(defined(CONFIG_DMASOUND_AMIGA)||defined(CONFIG_DMASOUND_.. others))

Why the others? They don't matter for PowerBook anyway.

> since CONFIG_DMASOUND is gone...
>
> And anyhow, CONFIG_DMASOUND_MODULE needs to be replaced with something
> else, since it seems to be gone as well?

The *_MODULE defines are derived from the * defines. Hence it's
CONFIG_DMASOUND_AWACS_MODULE now.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
