Date: Mon, 3 Dec 2001 08:09:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Martin Costabel <costabel@wanadoo.fr>,
	Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
Message-ID: <20011203080956.R7819@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C0AA2AF.97E7FCB4@wanadoo.fr> <Pine.GSO.4.21.0112031415170.5519-100000@mullein.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0112031415170.5519-100000@mullein.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 03, 2001 at 02:16:04PM +0100, Geert Uytterhoeven wrote:
> On Sun, 2 Dec 2001, Martin Costabel wrote:
> > Paul Mackerras wrote:
> > > Martin Costabel writes:
> > > > For the valkyriefb driver on my Pmac 6400, I can confirm from a first
> > > > short test that it still works. This is with your patch applied to
> > > > today's 2.4.17-pre1-ben0 kernel.
> > >
> > > Do you still have macos on the 6400?  If so can you confirm whether,
> >
> > Yes, I still have MacOS 8.6. No 9.x, though.
> >
> > > if you set the screen resolution and colour depth in macos, that the
> > > value you have set in macos is the default that linux will use?
> >
> > I did some tests with the 2 useful modes of the 6400: 1024x768x8bit at
> > 72Hz (vmode 15, cmode 8) and 800x600x16bit at 60Hz (vmode 10, cmode 16).
> >
> > The results, with or without Tom's patch, were the same as they always
> > were:
> > The vmode of MacOS is used by the Linux console; the cmode 16 is not
> > recognized, so instead of vmode 10 16 one always gets vmode 10 8 as
> > default. The log says
> >
> > kernel: Monitor sense value = 0x62b, <6>using video mode 10 and color
> > mode 0
>
> <video/macmodes.h>:
>
> | #define CMODE_8                 0       /* 8 bits/pixel */
> | #define CMODE_16                1       /* 16 (actually 15) bits/pixel */
> | #define CMODE_32                2       /* 32 (actually 24) bits/pixel */
>
> So please try `cmode 1' instead of `cmode 16'.

These bits of code are always different still I think.  Valkyriefb for
example parses 'cmode:{8,15,16}' and does CMODE_8 or CMODE_16.  I
_think_ the userland tools did both 0/1/2 and 8/15/16/32 (24?).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
