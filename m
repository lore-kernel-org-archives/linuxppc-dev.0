Date: Wed, 16 Jul 2003 13:07:21 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Brian Padalino <bpadalino@perigee.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Using gdb to load PPCBoot/U-Boot
Message-ID: <20030716180721.GA31881@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <DGEEIPOFGGPOACEFBGGCKEHGCAAA.bpadalino@perigee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DGEEIPOFGGPOACEFBGGCKEHGCAAA.bpadalino@perigee.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 16, 2003 at 01:17:52PM -0400, Brian Padalino wrote:
> Is it at all possible to use gdb to load the ppcboot/u-boot binary images to
> the flash?

Maybe in the realm of "all things possible" it is, but not normally.
The way that you typically program flash in circuit is to put the host
processor (the 440GP in your case) into slave mode and have it execute a
small stub of code that first erases the sectors that you want to write
to and then programs them with the new data.

The alternative is to pop the PQFP out of the socket and program it in
an external flash programmer.

> If it is possible, is there a general direction I should be looking at to
> accomplish this task?  Am I causing too much trouble for myself by not being
> able to afford a BDI2000?

JTAG is definitely the easiest way to do this, and yes, you are definitely
causing yourself lots of potential grief by not having a BDI2000.  If you
only intend to do userland development and never do anything more low level,
you can get by without one.  But for anything else, you definitely want one.
As far as JTAG debuggers go, they are very featured, pretty cheap (look at
the WindRiver VisionICE stuff for a comparison -- they want like $7-$10K per
target!) and definitely the most supported on this list.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
