Date: Sun, 8 Feb 2004 13:59:18 -0800
From: Brad Boyer <flar@allandria.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208215918.GB13906@pants.nu>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <20040208205734.GA13906@pants.nu> <1076275785.885.94.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076275785.885.94.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 09, 2004 at 08:29:46AM +1100, Benjamin Herrenschmidt wrote:
> Ah, good to know, as I was about to do it too ! Though I don't
> fully agree with moving it to a new directory.
>
> > Seeing this makes me
> > wonder if that's what people think is the best idea. We could have
> > ADB support on non-Mac machines at some point.
>
> What for ? NeXT cubes ? :)

Honestly, I think the NeXT cubes will never be supported, but if
someone does get back into trying that, it might happen. The most
likely thing in my opinion is the iMate. Griffin Technology does
support using it (for keyboards/mice only) in Windows, so I think
it's a good idea to have Linux support for it, too.

> Well... via-pmu at least is a lot more than just an ADB host
> driver and should stay in drivers/macintosh. But if we go that way,
> then it make little sense to have via-pmu and via-cuda in different
> locations..

I've been thinking about splitting up the ADB and other functions
of the egret, cuda, and pmu. The abuse of adb_request for non-ADB
functionality should go away. With the new driver model, the ADB
bus will be represented as a generic bus and any request should
go to a specific bus or device. I don't want to have to assume
a single, global bus the way the current code does.

I would prefer to have ADB be really just for ADB. The power
management stuff should be a separate interface, and really
should be more generic across the different Mac power management
systems. Although the egret and cuda don't do as much as pmu,
they still manage poweroff, reset, and the PRAM/RTC. These are
totally unrelated to ADB, and that stuff I think should be left
in drivers/macintosh/.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
