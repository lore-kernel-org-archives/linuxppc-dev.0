Date: Tue, 27 Mar 2001 16:14:09 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>
Cc: phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010327151406.ED3212EFCB@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Tue, Mar 27, 2001, Takashi Oe wrote:
> On Tue, 27 Mar 2001, Michael R. Zucca wrote:
>
>> I'd be willing to bet this is the dbdma bug Iain mentioned. Like the dma
>> controller's getting wedged and the driver waits and waits for it to
>> complete a transaction. I can wait for the fix.
>
> It sounds exactly like the bmac bug.  So changing pmac_awacs_tx_intr()
> from
>
>  while (write_sq.active > 0) {
>   ...
>   if ((stat & ACTIVE) == 0)
>    break; /* this frame is still going */
>   ...
>  }
>
> to
>
>  while (write_sq.active > 0) {
>   ...
>   if ((stat & ACTIVE) == 0) {
>    if (cp == bus_to_virt(in_le32(&awacs_txdma->cmdptr)))

this would not work on dmasound because it is possible to get interrupts
when blocks are still in progress without requiring error handling (e.g. a
dbdma FLUSH command).

we need to detect "DEAD" status for the PowerComputing problem.

>     break;
>   }
>   ...
>  }
>
> fixes it or something?

With ethernet it's OK to re-send a packet because the physical layer is
expected to be unreliable...

unfortunately it doesn't work for the sound devices...

This is because part of the dma block has already been sent - and if you
re-send that part is *really* messes the sound/sound sync up.

In fact, with the dmasound driver (on Power Compouting machines), you have
to detect the "DEAD" status on the controller - which seems to come up when
IDE interacts with sound.

I've got as fix coded which uses an 'emergency' dbdma block to retry the
command (but with adjusted pointers and count to reflect what is left).

Of course, the sound is affected a bit anyway - but (especially where sync
with video or something is important) - the 'emergency block' method is the
best we can do to maintain some smoothness.

I'll try and get this patch out ASAP.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
