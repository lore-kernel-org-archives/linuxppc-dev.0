Date: Fri, 29 Sep 2000 23:18:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Jon Erick Ween <jween@som.llu.edu>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, toe@unlserve.unl.edu
Subject: Re: [linux-fbdev] Re: Xfree86-4.0.1, Lombard, Mach64 driver
In-Reply-To: <8876DA34084@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10009292312220.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Sep 2000, Petr Vandrovec wrote:
> On 29 Sep 00 at 13:05, Geert Uytterhoeven wrote:
> > The main thing we need to be careful about is that the xor mask is different
> > for truecolor and directcolor visuals: truecolor needs an `all ones' mask,
> > while directcolor needs `15' for each color component (drivers that incorrectly
> > report a directcolor instead of truecolor visual will easily be identified).
>
> What about killing directcolor completely, and using directcolor capable
> hardware as truecolor one with per-fb global gamma correction table?
> (as windows do...)

That's another possibility...

The advantage of using the directcolor features by storing the console palette
in the color LUT, is that the console behaves more like the original VGA text
console: if you change one console palette entry, all characters drawn in that
color will change as well.

Besides, if you have e.g. 32 bpp hardware that uses XRGB 8888, with X
specifying some special features, you don't want to xor with 0xffffffff
neither, but with a fbdev specific value. Another reason for using the 17th
entry as the xor mask.

> List of modified files is shorter then ;-)

Yes, but the changes to the drivers that we do have to update (the ones
supporting directcolor) are more complex:

  - When in truecolor mode, the gamma correction table must be loaded
  - Setcolreg() should update dispsw_data[i] when in truecolor mode, instead
    of changing the color LUT

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
