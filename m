In-Reply-To: <Pine.LNX.4.05.10003261553160.2552-100000@callisto.of.borg>
Date: Mon, 27 Mar 2000 11:50:36 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: dmasound module on PowerBook
Message-Id: <20000327115036.017076@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 26, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>In arch/ppc/kernel/feature.c, we have
>
>    #ifdef CONFIG_PMAC_PBOOK
>    #ifdef CONFIG_DMASOUND_MODULE
>	    /* On PowerBooks, we disable the sound chip when dmasound is a module
>	     * */
>	    if (controller_count && find_devices("via-pmu") != NULL) {
>		    feature_clear(controllers[0].device, FEATURE_Sound_power);
>		    feature_clear(controllers[0].device, FEATURE_Sound_CLK_enable);
>	    }
>    #endif
>    #endif
>
>Shouldn't the sound chip be disabled if dmasound is not compiled at all, i.e.
>#if defined(CONFIG_PMAC_PBOOK) && !defined(CONFIG_DMASOUND)?

It need to be disabled when it's not compiled at all or when it's in a
module (the module knows how to power it back up when insmod'ed). So yes,
this code won't handle the case where it's not compiled at all and needs
fixing.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
