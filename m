Message-ID: <20031126181826.50858.qmail@web40911.mail.yahoo.com>
Date: Wed, 26 Nov 2003 10:18:26 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: RE: routing performance w/embedded linux on ppc?
To: linuxppc-embedded@lists.linuxppc.org
Cc: linuxppc@opqua.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The performance on 4xx is dependent on how much work
you want to do in the ethernet driver.

A (nearly) stock kernel will be able to forward 64
byte packets at around 15,000 pps on 200MHz 405GP.
The interrupts burn alot of CPU cycles.  If you
implement a timer-based interrupt mitigation scheme
using the FIT timer interrupt to clean out the RX and
TX rings, you will be able to hit about 35K to 40K
pps.  On top of that, you can implement
CONFIG_NET_FASTROUTE in the driver, bypassing most of
the IP stack.  After doing this you will get a maximum
sustained throughput of around 65K pps.

These numbers were measured on a 200MHz 405GP w/
100MHz SDRAM.  The on-chip ethernet was slightly
faster than the 82559.

Large packet performance is not an issue, and you
should be able to saturate the 100mbps link with 1500
byte packets.

Regards,
Brian


> -----Original Message-----
> From: linuxppc user [mailto:linuxppc@opqua.com]
> Sent: Tuesday, November 25, 2003 8:22 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: routing performance w/embedded linux on
ppc?
>
>
>
> Stephen,
>
> Thanks for the follow-up.  Do you have any numbers
for "lesser"
> processors than the 750, e.g. the 8245/8240 or the
405GP?
>
> Thanks again and regards.
>
>
>
> > We sustain ~71MB/s routing packets in the
following manner.
> >
> >
> >
=====[GbE]=====>[BCM5691]==[GbE]==>[MV64360/PPC750FX]
{routing here}
> >                                    ||
> >                                    || [GbE]
> >                 [BCM5691]<==========
> >                     ||
> >                     || [GbE]
> >                     ||
> >
===========>[MV64360/PPC750FX] {destination}
> >
> > If you want to see a P4@2GHz+ brought to it's
knees,
> perform a benchmark
> > such as nbench and throw 80B packets at it at
~100,000
> packets/s or so.
> >
> > An 800MHz PPC750FX/MV64360 combo barely even
showed a
> performance hit
> > whether the packets were incoming or not.
> >
> >
> > Stephen B. Johnson
> > Sr. Applications Engineer, Global Accounts
> > Artesyn Communication Products
> > 8310 Excelsior Drive
> > Madison, Wisconsin 53717
> >
> > phone  800-356-9602
> >
> > NASDAQ:  ATSN
> >
> >
> > -----Original Message-----
> >
> > Folks,
> >
> > There seems to be a plethora of data regarding
linux IP routing
> > performance (e.g., forwarding rate in packets per
sec) on x86
> > platforms.  This is likely because x86 boxen are
all that typical
> > university students have in front of them.  :*)
> >
> > I'm looking for some papers, pointers, or whatever
regarding linux
> > routing performance on midrange embedded ppc
hardware, for example
> > the moto8245 and ibm405GP (as used inside the
Xilinx Virtex II Pro).
> >
> > Basically our application boils down to a 4 port
router, and we'd
> > like to get a handle on what kind of aggregate
throughput and pps
> > we would be able to handle using these types of
ppc processors at
> > ~266/300 MHz.  Yes, the 8260, and 7xx, et al, are
faster, but our
> > equipment cost profile is very restrictive.
> >
> > example config:
> >
> >   i82559 | <- PCI -> [mpc8245 @ 300MHz]
> >   i82559 |
> >   i82559 |
> >   i82559 |
> >
> > There is other stuff hanging off of PortX and so
forth, but that's
> > what the datapath looks like.
> >
> > Thanks for any leads/hints/ideas/etc.  I'll
summarize back.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
