Date: Fri, 24 Mar 2000 09:58:46 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet
In-Reply-To: <Pine.LNX.4.05.10003240806290.5355-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10003240956310.17333-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Any ideas here?  Do we need something like an engine reset or flush in
> > aty128fb_set_var?
>
> No, when !(accel_flags & ACCELF_TEXT), aty128fb must not touch the accel
> engine, and accel engine has to be done by the application (i.e. the X server).
> Only if (accel_flags & ACCELF_TEXT), aty128fb has to set up the accel engine.

And the X server does clear that bit in accel_flags (see the fbdevhw
mmap_mmio function) when taking over the console, hence the X server
should handle the engine reset/flush. XFree bug.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
