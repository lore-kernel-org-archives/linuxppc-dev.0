Message-ID: <3F72531C.6060000@mvista.com>
Date: Wed, 24 Sep 2003 19:29:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2nd time Annc: Marvell DB64360 platform support patches available
References: <200309180953.20633.waite@skycomputers.com>
In-Reply-To: <200309180953.20633.waite@skycomputers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian,

I have a few comments:

1) The 64360 support in the galileo tree is based on a fairly old
version of th 64260 code.  That tree has long since been dead but we
keep it around b/c it has code that hasn't made it to _devel, etc.
(e.g., Rabeeh's 64360 port).  Several things have changed in the 64260
code since then that should be reflected in the 64360 code.  You can
look in the linuxppc_2_4_devel tree for the most recent 64260 code (not
that its perfect).  Here are some some items that should be updated:
a) arch/ppc/config.in should move the ethernet related options to
drivers/net/Config.in and the MPSC related options should go to
drivers/char/Config.in.  Looks like some of that was moved but not all.
b) A lot of code in arch/ppc/kernel/mv64360_common.c & friends should be
updated to be more like the gt64260 equivalents.  Also, an equivalent to
gt64260_dbg.c should be created to enable KGDB.
c) arch/ppc/platforms/db64360_*.c should be updated to be more like
ev64260.c (and combined like that file) and made to work with your
changes in b).
d) It looks like drivers/char/mv64360_mpsc.c is pretty much a clone of
the gt64260_mpsc.c driver.  This too, should be updated with the latest
changes to the 64260 one to add KGDB support.  Also, you could consider
removing the 'MIRROR' stuff since that was necessary in the 64260 b/c of
errata.  Even better, it probably wouldn't be too hard to combine the
two drivers (obviously, you'd have to leave the MIRROR stuff in there
then).  Would you consider taking a look to evaluate the work?
e) Since you did such a good job with the 64360 enet driver, want to do
the same with the 64260 driver??  ;)  (I didn't really look at your
driver but I'm assuming that its fine since Jeff G. gave his blessing)
2) In arch/ppc/boot/simple/Makefile, you may want to add a
CACHEFLAG/clear.S line
3) In arch/ppc/boot/simple/misc-db64360.S you still have 64260 #ifdef's
4) Since AFAIK the 64360 doesn't have the errata about reading the MPSC,
et. al. regs, you can greatly simplify the driver to not use the SDMA
(in arch/ppc/boot/simple/mv64360_tty.c).  A polled, PIO driver is really
simple for the MPSC.  There was even a patch for this posted several
months ago (for the 64260).  Also, you still have 64260 references in there.

This is what I saw when I went over your patches.  I may have missed
something or you may have good reason for leaving some things are they
are.  I'm open to constructive debate.

Mark
--
Brian Waite wrote:

>Here again are that patches for the db64306. Jeff Garzik has worked with me to
>cleanup the ethenet driver and it has been put into the commit queue. I was
>wondering how I can get the rest of the support into the queue?
>
>Thanks
>Brian
>- -------
>I have finally been able to get a site to post the patches to (with special
>thanks to MontaVista and Dale Farnsworth for the space). Anyone interested
>please let me know of any problems/concerns. Hopefully thes can be
>incorporated soon.
>Patches wer generated from linuxppc_2_4_devel.
>
>ftp://source.mvista.com/pub/mv64360/
>
>Thanks
>Brian
>
>
>
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
