Date: Sun, 26 Mar 2000 15:53:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: dmasound module on PowerBook
Message-ID: <Pine.LNX.4.05.10003261553160.2552-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In arch/ppc/kernel/feature.c, we have

    #ifdef CONFIG_PMAC_PBOOK
    #ifdef CONFIG_DMASOUND_MODULE
	    /* On PowerBooks, we disable the sound chip when dmasound is a module
	     * */
	    if (controller_count && find_devices("via-pmu") != NULL) {
		    feature_clear(controllers[0].device, FEATURE_Sound_power);
		    feature_clear(controllers[0].device, FEATURE_Sound_CLK_enable);
	    }
    #endif
    #endif

Shouldn't the sound chip be disabled if dmasound is not compiled at all, i.e.
#if defined(CONFIG_PMAC_PBOOK) && !defined(CONFIG_DMASOUND)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
