Date: Fri, 12 Oct 2001 11:13:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Message-ID: <20011012111320.B10280@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 12, 2001 at 05:32:34PM +1000, Paul Mackerras wrote:

> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:

All of the 7xx/74xx/8240 boards in _devel boot via zImage.<board> from
network/disk/flash, depending.

[snip]
> Along those lines, I have been thinking that it would be good if the
> wrapper built a data structure describing the hardware in the system,
> particularly things like:
>
> - the amount of RAM and any holes
> - type and register addresses for PCI host bus adaptors
> - ditto for interrupt controllers
> - interrupt mapping

One thing we have to keep in mind is what's required and what's
optional.  On some machines like pmac, we have a nice firmware that sets
everything up for us and is rather 'nice' to talk with.  On other boards
things are setup just enough by the firmware that we can load some bits
and with luck fix firmware 'issues' (see simple/head.S).  If we have to
find out things like RAM size from the piggyback loader, it's going to
bloat it a good deal.  We'd need, roughly to throw in mpc10x_common.c
into both the piggyback and the kernel.

If we want to keep all of this information around after init, it
wouldn't be hard to fill out the struct I suppose..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
