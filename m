Date: Mon, 09 Jun 2003 15:53:09 -0700
From: Ron Bianco <ronb@lcsaudio.com>
Subject: RE: Has anyone made the 8240 do burst reads from PCI memory?
In-reply-to: <5.0.2.1.0.20030609124155.024df050@10.2.0.2>
To: Jochen Roth <jochen@znyx.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <002801c32ed9$e5e22590$4d00a8c0@warp-speed>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Jochen Roth [mailto:jochen@znyx.com]
>
> At 12:50 PM 6/6/03 -0700, Ron Bianco wrote:
> >FYI, although not a PCI expert, I'm trying to determine if we need to upgrade
> >our CPLD code in order to successfully support memory read cycles with
> >more than
> >one data phase.
>
> It's been a while that I worked on this, but here are some things I remember:
>
> You implemented the PCI Read Line/Multiple commands in the CPLD, I assume.
> Check
> the PCI spec for details on the protocol.

Thanks for the reply.  Yes, it will respond to all 3 types.

> You then will have to set up things like the PCI command used by the 8240 and
> the PCI latency register.

Yup, checked.

> Check the DBAT settings used for accessing your CPLD memory space. If you
> use the
> generic MMIO mapping provided in the kernel, then caching is disabled
> for those
> accesses. If I remember correctly, the 603 core will not burst in that case.

Yeah, a couple years ago when I did the linux port, I was sure I had used an
unused DBAT to make sure no address translation would be done for the PCI mem
address range, but now I only see the default setup for the DBATs in 'our' code
base.
So I don't yet have a real explanation as to why the PCI mem space we're using
is marked cache inhibited, but it must be somewhere.  Prelim. examination of
DBAT registers with the BDI2000 doesn't seem to confirm it...sigh.   Another
confusing thing.

But anyway, in the 8240 chip errata #14, I see that prior to chip rev 1.2 , the
8240 corrupts inbound data/inst. when bursting into cache from PCI space and the
work around is to mark the PCI space as cache inhibited, which results in single
beat only PCI reads being initiated, and use DMA into main mem. if multi beat
reads are desired.   So the solution to the problem in our driver when needing
to read relatively lots of data and due to 'slow' single beat PCI read accesses,
for our existing customers ( using older chips ), will have to be usage of DMA
in our driver.

> Did you check the CBE lines for the PCI command issued by the 8240?
> If it was a
> generic single word read, then what you describe would be normal, I think.

Yeah, I guess if the 8240 is only driving binary 0110 ( read cmd ) on the CBE
lines during the address/cmd phase then that means only single word cycles are
done.  Mutil beat cycles require one of the other read cmds.  I got temp.
confused by the PCI doc and the fact that the 8240 has 8 words of
processor-to-PCI-read buffers.  So I figured maybe that even if the cache wasn't
involved that a multi-beat read with cmd 0110 might still be possible.

Thanks a lot.
FYI, for other users of the 8240, the errata is now more readily available than
in the past, and is downloadable from this page:

http://search.motorola.com/semiconductors/query.html?qt=MPC8240&Go.x=12&Go.y=9

which is a link I hope will work for anyone.
BTW, it would be great to be able to do a PCB rev and use the 8245 instead.

Cheers, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
