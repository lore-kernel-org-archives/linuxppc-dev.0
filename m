Date: Tue, 27 Mar 2001 14:41:41 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage
In-Reply-To: <20010327175442.839792F002@apollo.valhalla.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010327141455.85236B-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Tue, 27 Mar 2001, Iain Sandoe wrote:

> Well, when I first started "looking after" the driver I though this too.
>
> but... the status in the controller relates to the currently active dbdma
> command (I believe - please correct me if you know better ;-).
>
> When we get the IRQ for the command completion - a new chained cmd may (in
> fact *should* if sound is not to have breaks)  have started.
>
> Therefore we *must* look at the stored result - because the one in the chip
> doesn't have any relationship to the IRQ we are handling.
>
> The same would apply to *any* dbdma work that involved chained commands
> AFAICT.

Yes, in theory  :)  It doesn't apply to bmac case as I noted previously.
I think it's better to check cmdptr register of dbdma channel for finding
out how far ahead dbdma is.

As for the "DEAD" status, doesn't the dbdma stop right there?  I'd think
looking at "status" register would suffice.  Is "xfer_status" field
serving any other purpose in your fix possibly?

> MacOS had the problem and PowerComputing released an "extension" that fixes
> it (PCI timing bug fix-up).  It's still on the Apple support site (I
> downloaded it recently).

Ah, ok.

> Well, if we get horrendous IRQ hold-offs then maybe - but at the moment I
> think that the residue information stored in the dbdma command buffer will
> do.

There is usually a res_count register (not the dbdma_cmd one) associated
with each dbdma channel somewhere.  IIRC, unless dbdma is "FLUSH"ed, the
res_count value may be off a bit.

> > Is it not possible to "fix" the command in place and let DBDMA go?
>
> That was my original idea too... but...
>
> It gets messy to do that - because the buffer start addresses are assigned
> in XXXX_dbdma_setup()

What happes if you just issue (RUN|WAKE|PAUSE|DEAD)<<16|(RUN|WAKE) to
dbdma control register when DEAD condition is detected?  I wonder if it's
possible to let dbdma pick up where it left off without touching any dbdma
command..

> a spare dbdma command block costs 16 bytes of memory.

Not 32?  No branch back to original command table?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
