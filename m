From: Brian Waite <waite@skycomputers.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: 2nd time Annc: Marvell DB64360 platform support patches available
Date: Thu, 25 Sep 2003 09:24:06 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <200309180953.20633.waite@skycomputers.com> <3F72531C.6060000@mvista.com>
In-Reply-To: <3F72531C.6060000@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309250924.06627.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark,
	Thanks for responding. I will start looking into all of this soon. I'll start
feeding updated patches to the ftp site and ask if you could take a second
look at them when I do.

Thank You for your time
Brian

On Wednesday 24 September 2003 10:29 pm, Mark A. Greer wrote:
> Brian,
>
> I have a few comments:
>
> 1) The 64360 support in the galileo tree is based on a fairly old
> version of th 64260 code.  That tree has long since been dead but we
> keep it around b/c it has code that hasn't made it to _devel, etc.
> (e.g., Rabeeh's 64360 port).  Several things have changed in the 64260
> code since then that should be reflected in the 64360 code.  You can
> look in the linuxppc_2_4_devel tree for the most recent 64260 code (not
> that its perfect).  Here are some some items that should be updated:
I will bring the code up to date.

> a) arch/ppc/config.in should move the ethernet related options to
> drivers/net/Config.in and the MPSC related options should go to
> drivers/char/Config.in.  Looks like some of that was moved but not all.
	OK

> b) A lot of code in arch/ppc/kernel/mv64360_common.c & friends should be
> updated to be more like the gt64260 equivalents.  Also, an equivalent to
> gt64260_dbg.c should be created to enable KGDB.
	OK

> c) arch/ppc/platforms/db64360_*.c should be updated to be more like
> ev64260.c (and combined like that file) and made to work with your
> changes in b).
	OK

> d) It looks like drivers/char/mv64360_mpsc.c is pretty much a clone of
> the gt64260_mpsc.c driver.  This too, should be updated with the latest
> changes to the 64260 one to add KGDB support.  Also, you could consider
> removing the 'MIRROR' stuff since that was necessary in the 64260 b/c of
> errata.  Even better, it probably wouldn't be too hard to combine the
> two drivers (obviously, you'd have to leave the MIRROR stuff in there
> then).  Would you consider taking a look to evaluate the work?
Are you sure you were looking at the patches I posted? I thought I removed all
the MIRROR code. I'll take anouther look.

I will look at merging the 64260 and 64360 drivers.

> e) Since you did such a good job with the 64360 enet driver, want to do
> the same with the 64260 driver??  ;)  (I didn't really look at your
> driver but I'm assuming that its fine since Jeff G. gave his blessing)
That is definately do-able. I want to talk more with Jeff on the 64360 driver
first. He said he had a few other cleanup things he would like to see but it
was good enough to go in. I'd like to clean up those bits before I replicate
them.

> 2) In arch/ppc/boot/simple/Makefile, you may want to add a
> CACHEFLAG/clear.S line
OK

> 3) In arch/ppc/boot/simple/misc-db64360.S you still have 64260 #ifdef's
> 4) Since AFAIK the 64360 doesn't have the errata about reading the MPSC,
> et. al. regs, you can greatly simplify the driver to not use the SDMA
> (in arch/ppc/boot/simple/mv64360_tty.c).  A polled, PIO driver is really
> simple for the MPSC.  There was even a patch for this posted several
> months ago (for the 64260).  Also, you still have 64260 references in
> there.
I will clean up the 260-isms. I will also put in the polled MPSC driver.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
