Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 69F9B67A0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 03:21:55 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id C53E08069799
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 13:21:35 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24406-03 for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 13:21:28 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id E56028069795
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 13:21:28 -0400 (EDT)
Subject: Re: IMAP_ADDR on PPC 8xx
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20060508224653.C4B48352B0C@atlas.denx.de>
References: <20060508224653.C4B48352B0C@atlas.denx.de>
Content-Type: text/plain
Date: Tue, 09 May 2006 13:14:39 -0400
Message-Id: <1147194879.2200.41.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

Thanks for you response, Wolfgang.


On Tue, 2006-05-09 at 00:46 +0200, Wolfgang Denk wrote:
> In message <1147108983.27101.63.camel@excalibur.timesys.com> you wrote:
> > 
> > In particular, I have an MPC885ADS board running "U-Boot 1.1.3 (Apr 19
> > 2005 - 13:39:58)".  It will boot neither 2.6.15 nor 2.6.16.11.  After
> > U-Boot decompresses the kernel, I get no kernel output at all; it just
> > hangs.
> 
> Probably you forgot to specify a correct  console  device  with  your
> boot arguments.

Excellent point, but unfortunately this (at least by itself) didn't
help.


> > After some debugging, I think things go awry when the code starts
> > dereferencing IMAP_ADDR as a direct pointer.  IMAP_ADDR is defined to be
> > 0xFF000000, but the MPC885ADS documentation says that the internal
> 
> Correct.
> 
> > memory map is supposed to at 0x22000000.  In addition, when I look at
> > the bd_t pointer from U-Boot, it's saying that 0x22000000 is the correct
> > address.
> 
> No. U-Boot uses 0xFF000000. At least the official U-Boot source  tree
> does. I don't know where you got yours from, or who might have broken
> it.
> 
> > Why is this a problem for us and apparently not for anyone else on this
> > list?  Is no one else using U-Boot?  Or does everyone else's U-Boot use
> > 0xFF000000 instead of 0x22000000?  Or do I have a different problem
> 
> Most probably everybody else who uses U-Boot uses a good version with
> a high mapping.

Interesting.  Thanks for the info.  I'm not certain where this U-Boot
came from -- it was already loaded onto the board when the board "landed
in my lap".  I suspect that this U-Boot may have come from Freescale.


> > While reading through the archives, I see that using IMAP_ADDR the way
> > it is currently used is somewhat frowned upon anyway.  Is this one of
> > those things that we (the PPC Linux community) should fix the "right
> > way" once and for all?  I'm happy to submit a patch once I understand
> > what the "right way" is...  :-)
> 
> The memory map requirements of PowerPC systems  have  been  explained
> many  times  before,  so a little search in the archives, HOWTOs etc.
> should point you quickly for good description why a low mapping  like
> 0x22000000 cannot work.

Thanks again for the advice.  Interestingly, I gave the wrong address
above.  It wasn't 0x22000000, it was 0x02200000 (i.e. even lower!).  And
yet with the "io_remap()'ed global variable" patch, 2.6.11.7 does indeed
work on this board with this U-Boot....  Perhaps this works because this
particular board only has 8MiB of RAM....

I'll definitely investigate switching to a U-Boot built from official
sources.

Interestingly, I ran into a similar problem on a completely different
Freescale board about a year ago.  We have an MPC8272ADS board that
definitely has a Freescale copy of U-Boot and it fails to boot vanilla
kernels due to different definitions for the BCSR addresses (which if I
recall correctly are within the internal memory map and thus controlled
by the IMMR register).  At that time, Kumar appealed to the community on
this mailing list to figure out the "right" solution to the discrepancy.
I didn't have time to do the "right" thing, so I merely #ifdef'd out the
offending code in the kernel and the problem magically went away (I
suspect that the Freescale U-Boot had already initialized things
sufficiently that it wasn't strictly _necessary_ for the kernel to
re-initialize the same registers (even if it might have been
_desired_)).

Bottom line: I'm wondering what the Linux PPC community thinks is the
correct long term solution to these discrepancies.  Should we the
community declare "Freescale U-Boots are considered harmful; never use
them; always use the official U-Boot sources" ???

Or should we create a kernel mechanism to automatically adapt to the
different U-Boot flavors?

In a related vein, as I alluded to in my previous email, there has been
previous discussion on this list about the fact that it is frowned upon
for device drivers to directly dereference IMAP_ADDR.  Instead, I've
seen a recommendation that each individual driver perform an io_remap()
operation on IMAP_ADDR and save the resulting kernel virtual address in
a driver-specific data structure.  Is this a universally-accepted
viewpoint?  Is this something that the community agrees "should be
fixed" and we're just waiting for someone (like me) to volunteer to fix
all the drivers?

Or are there arguments in favor of keeping the direct IMAP_ADDR
dereferences?  For example, if each driver performs its own separate
io_remap(), doesn't that have potentially negative consequences on the
VM system for some PPC implementations (e.g. increased contention for
TLB entries)?

Are these issues addressed by or otherwise impacted by other ongoing PPC
Linux work such as the "ppc" + "ppc64" --> "powerpc" effort / "flat
device tree" stuff???



> Best regards,
> 
> Wolfgang Denk



Thanks!!!

Walt Wimer
TimeSys Corporation
