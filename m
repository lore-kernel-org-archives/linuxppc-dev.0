Date: Wed, 15 Mar 2000 21:15:29 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Tom Rini <trini@kernel.crashing.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        linux-m68k@phil.uni-sb.de
Subject: Re: dmasound split
In-Reply-To: <Pine.LNX.4.05.10003152052130.6999-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10003152114030.30330-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > No comments whether it works on PowerMac and Atari?
> >
> > Ah, right.  I tried it out on a 9600 and it worked, and seemingly better than
> > before (no loud hiss when insmod'ed).  Only sugjestion I would make is to
> > follow the trend of drivers/XXX/bigdriver/xxx.c instead of dmasound_*.c
>
> Wonderfull. Usually drivers don't work anymore when you split them in parts,
> while the split dmasound seems to work better than the old one on both PowerMac
> and Amiga :-)

Untested yet on the Lombard, but here's another small patch (to get it
cmpiled in, not as a module).

	Michael

--- drivers/sound/dmasound_core.c.org	Wed Mar 15 21:14:14 2000
+++ drivers/sound/dmasound_core.c	Wed Mar 15 21:12:34 2000
@@ -1357,7 +1357,9 @@

 EXPORT_SYMBOL(dmasound);
 EXPORT_SYMBOL(dmasound_init);
+#ifdef MODULE
 EXPORT_SYMBOL(dmasound_deinit);
+#endif
 EXPORT_SYMBOL(dmasound_write_sq);
 #ifdef HAS_RECORD
 EXPORT_SYMBOL(dmasound_read_sq);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
