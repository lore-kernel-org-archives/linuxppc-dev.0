Date: Thu, 28 Sep 2000 18:13:20 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Jon Erick Ween <jween@som.llu.edu>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
In-Reply-To: <Pine.LNX.4.10.10009281307020.3468-100000@cassiopeia.home>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000928174446.666M-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Sep 2000, Geert Uytterhoeven wrote:

> > My understanding is this:
> > Video console uses 16 colors, and it only initializes the cmap
> > corresponding to those 16 colors.  The other entries in cmap are up to
> > each individual fb driver or undefined as far as console is concerned.
> > For software cursor, driver specific (struct display_switch *)ops->revc()
> > is used to make the cursor blink.  For the generic fbcon_cfb{16,32}_revc,
> > it xors each pixel with masks 0xffff (depth 16) or 0xffffffff (depth 32).
> > For controlfb which I am very familiar with, the "correct" masks are
> > 0x3def for 555 and 0x0f0f0f0f for 8888.  That is, only 4 LSBs or low 16
> > for each red, green, and blue are xor'ed since cmap entries corresponding
> > to higher bits are undefined as far as fbcon support is concerned.
>
> In 2.5.x, we'll have a user-defined xor mask for the cursor as the 17th entry
> in the dispsw_data array.

Can we put it for 2.4?  As far as I can see, the actual size of
dispsw_data matters only between fb driver and fbcon-cfbxx.c, and the
changes required for each driver seem to be rather small.  Besides,
controlfb is not the only one which will benefit from this change.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
