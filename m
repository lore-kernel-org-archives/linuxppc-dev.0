Date: Thu, 20 Feb 2003 15:09:24 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Brian Waite <waite@skycomputers.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Disable cache on 74xx
In-Reply-To: <1045749699.18487.7532.camel@hermes.chez-thomas.org>
Message-ID: <Pine.GSO.4.21.0302201507510.27212-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 20 Feb 2003, Gary Thomas wrote:
> On Thu, 2003-02-20 at 06:55, Brian Waite wrote:
> > According to The User's Manual, the data cache instructions become no-ops if
> > the data cache is disabled.
>
> There are "User Manuals" and then there is "Real Life".  My
> experience has been that trying to execute these instructions
> with the cache disabled was treated like an invalid instruction
> (hence causing a trap).  Maybe this isn't always true with all
> PowerPC processors, but I was just pointing out that you might
> run into trouble with it.

There may be a different behavior for `disabling the data cache globally' and
`using e.g. dcbf on uncached memory' (with the data cache enabled globally).

> > On Wednesday 19 February 2003 5:48 pm, Gary Thomas wrote:
> > > On Wed, 2003-02-19 at 14:07, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2003-02-19 at 21:52, Brian Waite wrote:
> > > > > Hi all,
> > > > > 	I am trying to hunt down a memory controller configuration problem and
> > > > > I have been asked to disable all caching so as to remove it from the
> > > > > equation. I can easl disable L2 but when I start ucking with the WIMG
> > > > > bits to set cache inhibit, The kernel panics with stack overflows. Does
> > > > > anyone know where or what I have to set to disable caching?
> > > >
> > > > Hrm... set L2 and L3 off, then hack HID0 to disable L1 ?
> > >
> > > There are other problems with this.  With the caches disabled
> > > (via HID0) all data cache instructions (like DCBF) will fail.
> > > There are some of these in the kernel itself, but beware that
> > > GLIBC has it's own set.
> > >
> > > ... totally disabling the data CACHE with Linux is non-trivial.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
