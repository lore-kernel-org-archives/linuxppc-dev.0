Date: Wed, 7 Jun 2000 17:20:54 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>, mlan@cpu.lu,
        schmitz@opal.biophys.uni-duesseldorf.de, daenzerm@student.ethz.ch,
        toe@unlserve.unl.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <Pine.GSO.4.10.10006071705280.652-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10006071715540.7397-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Now you understand the fix is very simple:
> > -		fPtr->fboff = fPtr->fix.smem_len & (PAGE_SIZE-1);
> > +		fPtr->fboff = fPtr->fix.smem_start & (PAGE_SIZE-1);
>
> That's not sufficient (perhaps it is in this case, though): both fix.smem_start
> and fix.smem_len may be not page aligned. To catch all cases, you have to use
> the formula from my previous posting.

Did that just get lost between XFree release 3 and 4, or did we have it
wrong all along? I wonder if that was what caused problems on some m68k
Mac video hardware ...

> > Yes, this is wrong as the authur noted, but interestingly this code spreads
> > over the all drivers supporting fbdev, though I can't distinguish which is
> > the original :^)  Maybe polite solution is to fix each driver, but quick
> > fix will be
> >
> > +	pScrn->displayWidth = fPtr->fix.line_width /
> > +				(fPtr->var.bits_per_pixel >> 3)
>
> Typo: the field is called `line_length', not `line_width'.
>
> And that formula is valid for chunky displays only, not for interleaved
> bitplanes (I suppose pScrn->displayWidth is the width of one line in memory,
> counted in pixel units?).
>
> If line_length is 0, you must fallback to xres_virtual / bytes_per_pixel.

Is the displayWidth / xres_virtual synonymous to the line length (offset
between start of subsequent lines), or might displayWidth be used for
something else altogether? displayWidth seems a misnomer (on some
hardware, there's no video RAM between the end of one scan line and the
probably page aligned start of the next ...)?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
