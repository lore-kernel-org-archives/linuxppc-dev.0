Date: Sun, 2 Dec 2001 09:35:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>,
	ajoshi@unixbox.com
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
Message-ID: <20011202093539.J7819@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.GSO.4.21.0111281012090.15842-100000@mullein.sonytel.be> <20011228112802.11352@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011228112802.11352@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 28, 2001 at 12:28:02PM +0100, Benjamin Herrenschmidt wrote:
> >
> >I _think_ the right solution is to hide the NVRAM vmode/cmode stuff in
> >macmodes.c, so all drivers will automagically use it for the default video
> >mode.
> >
> >The same with MAC monitor sense information, just pass it to mac_find_mode().
> >
> >So mac_find_mode() should do this:
> >
> >  - if default mode specified, try that
> >  - if MAC monitor sense specified, try that
> >  - if NVRAM, try that
> >  - fall back to default mode database walking
>
> No, the NVRAM stuff is driver dependant unfortunately. It's almost common
> among drivers for old stuffs like control, chips, etc..., but that is not
> the case for recent MacOS drivers. Apple no longer defines a single mode
> table, each video driver is now responsible to have it's own mecanism for
> that and for storing whatever proprety for saving the mode to nvram. In
> fact; the old nvram location is a hack that won't work in all cases as
> it's not in xpram any more, it's part of the "device tree extension" part
> of the nvram (persistent properties added to selected nodes of the
> device-tree).

Wasn't there a tool to fiddle and store the vmode/cmode stuff into NVRAM
tho which would probably work with all of the other cards?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
