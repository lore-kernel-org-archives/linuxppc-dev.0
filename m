Date: Sun, 8 Apr 2001 15:28:17 -0700
From: David Schleef <ds@schleef.org>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bugfix patch to arch/ppc/8260_io/fcc_enet.c
Message-ID: <20010408152817.A5105@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
References: <20010406071644.A2517@stm.lbl.gov> <3AD01011.A8FAB831@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AD01011.A8FAB831@mvista.com>; from dan@mvista.com on Sun, Apr 08, 2001 at 03:15:29AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Apr 08, 2001 at 03:15:29AM -0400, Dan Malek wrote:
>
> David Schleef wrote:
> >
> > The attached patch fixes a bug with 8260 fcc_enet driver that
> > is related to when the TX buffer becomes full.
>
> Well, you need to prove to me you don't have a wrap-around
> problem.  The line:
> 	if(cep->skb_cur - cep->skb_dirty >= TX_RING_SIZE){
>
> is in big trouble, and I suspect you changed these from shorts
> to ints because it didn't work right.  I suspect all you did
> was postpone the problem until you hit 4G of packets instead of 64K.

Check again.  The unsigned arithmetic works correctly.

The change from ushort to uint was a completely unnecessary change
that was based on prior experience with compilers generating bad
code for unsigned shorts.  After checking, I noticed that the
powerpc is actually completely sane in this respect.


> > ..... Currently,
> > the driver relies on the BD_ENET_TX_READY for determining if
> > a ring slot is available for a tx buffer.  This is not a
> > valid criterion, because the interrupt handler may not have
> > cleared the slot from a previous tx buffer.
>
> I beg to differ.  It is a valid criterion because the interrupt
> handler isn't responsible for clearing the flag.  The transmit
> function sets it, and the CPM will clear it when it is done sending
> the buffer.

(Sorry if I was being unclear.  It made sense to me... =) )

There are two possible sequences of events that I think is
occuring.  The one I was trying to explain, which isn't very
likely:

  (starting with a full queue)

  - tx slot N BD_ENET_TX_READY is cleared by the CPM

  - [before the interrupt is dispatched,] fcc_enet_start_xmit()
    sees the "empty" slot and stuffs a new buffer into it,
    overwriting the old buffer that hasn't been cleaned up.

  - interrupt handler is dispatched, and frees the new buffer
    instead of the old buffer.

  - kernel gets confused when the interrupt handler eventually
    tries to free the buffer for the second time.

The other (and more likely) is:

  - fcc_enet_start_xmit() fills up the TX ring, thus cep->skb_cur
    == cep->skb->dirty.

  - an interrupt occurs because TX is complete.  The interrupt
    handler doesn't clear the slot or restart the net device queue,
    because it fails on the test.

	if(cep->skb_cur == cep->skb_dirty)break;

  - the net device watchdog eventually realizes that something is
    wrong, and tries to reset the device, which doesn't work because
    fcc_enet_timeout doesn't do anything.





dave...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
