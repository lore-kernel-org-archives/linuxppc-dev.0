Message-ID: <3AD01011.A8FAB831@mvista.com>
Date: Sun, 08 Apr 2001 03:15:29 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Schleef <ds@schleef.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bugfix patch to arch/ppc/8260_io/fcc_enet.c
References: <20010406071644.A2517@stm.lbl.gov>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Schleef wrote:
>
> The attached patch fixes a bug with 8260 fcc_enet driver that
> is related to when the TX buffer becomes full.

Well, you need to prove to me you don't have a wrap-around
problem.  The line:
	if(cep->skb_cur - cep->skb_dirty >= TX_RING_SIZE){

is in big trouble, and I suspect you changed these from shorts
to ints because it didn't work right.  I suspect all you did
was postpone the problem until you hit 4G of packets instead of 64K.


> ..... Currently,
> the driver relies on the BD_ENET_TX_READY for determining if
> a ring slot is available for a tx buffer.  This is not a
> valid criterion, because the interrupt handler may not have
> cleared the slot from a previous tx buffer.

I beg to differ.  It is a valid criterion because the interrupt
handler isn't responsible for clearing the flag.  The transmit
function sets it, and the CPM will clear it when it is done sending
the buffer.

You are going to have big problems if you are writing into buffers
that have this flag set.

> ..... This bug is easy
> to generate by writing files over NFS with large wsize.

Then, there is some other bug that needs to be found and fixed.....



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
