Date: Sat, 5 Aug 2000 21:22:24 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: dri-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kind of success! (r128 on PPC (Re: LinuxPPC X Server))
In-Reply-To: <398ADB57.9ABEDC6F@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0008041831040.29474-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Michel [iso-8859-1] Dänzer wrote:

>
> [For the linuxppc-dev people: this is about the DRI CVS trunk]
>
> Kostas Gewrgiou wrote:
>
> > > GL clients even seem to attempt direct rendering now, however I get one of
> > > two different errors every time:
> > >
> > > Error: Rage 128 timed out... exiting
> > >
> > > Error: Could not submit packet... exiting
> >
> >   From what i see the problem is probably in the R128_READ/WRITE macros in
> > r128_drv.h you need byteswapping functions there (and memory barriers as
> > usual).
>
> That did it, thanks! I changed those macros to use the same inline functions
> which are used for MMIO_{IN,OUT} on PPC, and here we go!
>

Great news :)

> The remaining problems are:
>
> 16 bit doesn't work neither with fbdev (colors completely off - does aty128fb
> still use 15 bit in fact?) nor without (at least the grey tones are right
> there - wrong endianness?)

Yes aty128fb still doesn't support 16 bit, you could run the r128 driver
without fbdev to get 16 bits, but the code to switch the framebuffer to do
byteswapping is missing so the colors will be wrong (easy to add though).

> At 32 bit, it flickers badly on my Pismo, probably because it only has 8 megs
> of VRAM. (These messages appear in the log:
> (EE) r128(0): Unable to reserve depth buffer
> (EE) r128(0): Unable to reserve texture space in frame buffer
> ) Curious how it works out for people with more...

Not enough memory for all the buffers indeed, you could try with a lower
res (if prismo allows that) to save some memory.

>
> About performance: It's much better than software rendering (at least for big
> windows) of course, however not too fast with lots of polygons. AGP GART would
> definitely be a good thing I guess (Ben: hint, hint :)
>

Do you have any numbers from gears, glquake etc ??

   Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
