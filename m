Date: Thu, 19 Aug 2004 12:42:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405GPr PCI target/host
Message-ID: <20040819194204.GA13576@gate.ebshome.net>
References: <D73A25AA6E54D511AD74009027B1110F5BB389@ORION>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F5BB389@ORION>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 19, 2004 at 02:28:00PM -0400, Steven Blakeslee wrote:
>
> I am trying to get an IBM 405GPr processor to work as a target/host on a PCI
> bus.  A PCI target can temporarily become a host on the PCI bus. Basically
> this means it needs to do everything the host currently does except
> assigning PCI memory space, the dedicated host is responsible for this.
>
> I saw a message concerning this on Tue 12/23/2003 4:20 PM, the questions was
> for "MPC7447(Dual CPU) + MV64360 based Processor PMC boards"  I only saw one
> response to this and it did not seem to be correct.
>
> I was wondering if anyone has done something like this, not necessarily with
> a 405, any processor experience will do.  I appreciate any help or advice.
>

Yes, it's possible. One of our systems has 440GX and 405GPr connected
through PCI bus. 440GX manages the bus (i.e. it has an arbiter, and
assigns resources). 405GPr even boots from PCI space. 440GX and
405GPr communicate using normal TCP/IP networking through
point-to-point custom driver which uses PCI memory-mapped accesses
(both CPUs have direct access to each other memory).

There are other PCI device connected to this bus (SCSI, crypto chip),
but they are accessed only from 440GX.

Here is a short list of what I did (hope I haven't forgot anything :)

1) 405GPr must use external arbiter

2) In the 405GPr kernel I enabled PCI support but hacked
ppc4xx_setup_arch() to not call ppc4xx_find_bridges()

3) in board_setup_arch() I configure PCI bridge manually (assign all
windows, BARs etc)

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
