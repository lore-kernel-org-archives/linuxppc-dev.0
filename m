Date: Tue, 27 Mar 2001 10:32:35 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage
In-Reply-To: <20010327151406.ED3212EFCB@apollo.valhalla.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010327100613.81484A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Mar 2001, Iain Sandoe wrote:

> >  while (write_sq.active > 0) {
> >   ...
> >   if ((stat & ACTIVE) == 0) {
> >    if (cp == bus_to_virt(in_le32(&awacs_txdma->cmdptr)))
>
> this would not work on dmasound because it is possible to get interrupts
> when blocks are still in progress without requiring error handling (e.g. a
> dbdma FLUSH command).

I agree that it doesn't help the PowerComputing problem, but I do think
that just checking xfer_status is not very reliable on DBDMA.

> we need to detect "DEAD" status for the PowerComputing problem.

Ok, ok, this is a totally different problem then.  In the case of bmac,
the packet had been transmitted without an error, and DBDMA had moved on
to subsequent commands (if any).  It's just that "xfer_status" field was
not written out by DBDMA for some reason.  I have seen similar phenomenun
on Plan B DBDMA implementation, so I wasn't too surprised to see that on
bmac.

Now, I see that awacs driver never checks DBDMA controller's status, and
that can't be good..  I wonder why the sound problem doesn't occur under
Mac OS, or does it?  I suppose you could use TB or something and
recalculate how many bytes out of residual to send to mostly stay in sync.

> I've got as fix coded which uses an 'emergency' dbdma block to retry the
> command (but with adjusted pointers and count to reflect what is left).

Is it not possible to "fix" the command in place and let DBDMA go?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
