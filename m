Date: Mon, 21 Aug 2000 13:25:11 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Lanners <mlan@cpu.lu>, dmj+@andrew.cmu.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
In-Reply-To: <Pine.LNX.4.10.10008191410200.525-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10008211320490.11699-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > That's what I was thinking about. However, I'm not sure that XFree
> > supports a display with discontiguous lines in video memory. I think I
> > read that somewhere in some mailing list or X doc... Can any of the
> > XFree specialists confirm?
>
> I can speak for XFree86 3.x only, not for 4.x.
>
> The only way to work with this is to make xres_virtual = xres+0x20. But then
> XFree86 will draw into the cursor region, too.

I think it used to work without such a hack - some old m68k Macs had the
video scan lines start every 1024 bytes but the actual xres was smaller.
I'll have to look at the macfb code to see what xres_virtual was set to.
I'm sure the X server didn't draw to the offscreen region as that would
have caused a bus error (at least the earlier 3.3.x versions didn't.
Later X versions drawing beyond xres would in fact explain bus errors
some people saw ...).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
