Message-ID: <20020606210240.49267.qmail@web11108.mail.yahoo.com>
Date: Thu, 6 Jun 2002 14:02:40 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: Sungem bug or something else?
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: roger blofeld <blofeldus@yahoo.com>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <D1467143-798D-11D6-8CF5-0003938E434C@ivey.uwo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin,
 That is a good thought. After getting everything
working, I get:

# mii-tool eth0
eth0: autonegotiation failed, link ok

so I require the maximum timeout.
-roger
--- "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
wrote:
> Hi,
>
> Does sungem use autonegotiate to determine its
> interface type and speed
> (like some  of the more advanced interface drivers)
> or does it look at
> the rom or use a table?
>
> If it autonegotiates, does the driver actually wait
> long enough for the
> autonegotiation to fully complete before returning
> the first time?
>
> Under some tulip drivers, I noticed something very
> similar (but no oops,
> just a inability to use the driver until I rmmod and
> then insmod it
> once).  I think it happens because the the
> autonegotiation results where
> handled asynchronously and the main driver routine
> simply started it and
> returned before the auonegotiation actually
> completed and the interface
> and speed were properly determined.  The problem was
> right after
> bringing up the network in the boot sequence things
> tried to use it (the
> appletalk drivers, etc).  So if I waited to insert
> the module for the
> driver until after everything else was started (at
> the end of the
> bootsequence) all was well.
>
> This is all just a wag, but it is something to look
> at.
>
> Kevin
>
> On Thursday, June 6, 2002, at 03:45  PM, Benjamin
> Herrenschmidt wrote:
>
> >
> >> I encounter an oops during boot bringing up a
> sungem
> >> interface. (smp g4 450/gcc 3.1/glibc 2.2.5) If I
> defer
> >> bringing up the network at boot, I can
> successfully
> >> start eth0 (sungem) if I start eth1 (tulip)
> first, so
> >> it may not be the sungem driver itself. This
> happens
> >> on benh 2.4.19-Bpre10, and pre9.
> >
> > What kind of error is it ? A Machine Check ?
> >
> > Looking at your backtrace, it looks like the
> driver is
> > trying to access the PHY chip. That can sometimes
> happen
> > if you have some tool like miitool or ethtool
> trying to
> > get at the link status while the chip isn't
> powered up.
> >
> > The problem here is that sungem on Apple HW only
> powers
> > the chip when the interface is brought up, and
> powers it
> > down about 10 seconds after bringing the interface
> down.
> >
> > This improve power management, but kills link
> monitoring
> > tools.
> >
> > There may be also a bug in the driver causing it
> to try
> > to access the PHY registers when the chip is in
> down
> > mode & getting the ethtool ioctl's
> >
> > Ben.
> >
> >
> >
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
