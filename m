Message-Id: <200003261756.TAA00447@piglet.grunz.lu>
Date: Sun, 26 Mar 2000 19:56:11 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: dmasound module on PowerBook
To: geert@linux-m68k.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.10003261553160.2552-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  26 Mar, this message from Geert Uytterhoeven echoed through cyberspace:
>
> In arch/ppc/kernel/feature.c, we have
>
>     #ifdef CONFIG_PMAC_PBOOK
>     #ifdef CONFIG_DMASOUND_MODULE
> 	    /* On PowerBooks, we disable the sound chip when dmasound is a module
> 	     * */
> 	    if (controller_count && find_devices("via-pmu") != NULL) {
> 		    feature_clear(controllers[0].device, FEATURE_Sound_power);
> 		    feature_clear(controllers[0].device, FEATURE_Sound_CLK_enable);
> 	    }
>     #endif
>     #endif
>
> Shouldn't the sound chip be disabled if dmasound is not compiled at all, i.e.
> #if defined(CONFIG_PMAC_PBOOK) && !defined(CONFIG_DMASOUND)?

or rather

#if defined(CONFIG_PMAC_PBOOK) && !(defined(CONFIG_DMASOUND_AMIGA)||defined(CONFIG_DMASOUND_.. others))

since CONFIG_DMASOUND is gone...

And anyhow, CONFIG_DMASOUND_MODULE needs to be replaced with something
else, since it seems to be gone as well?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
