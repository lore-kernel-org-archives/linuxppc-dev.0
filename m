Message-ID: <3AD1F7F0.23C8BA38@mvista.com>
Date: Mon, 09 Apr 2001 13:57:04 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Schleef <ds@schleef.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bugfix patch to arch/ppc/8260_io/fcc_enet.c
References: <20010406071644.A2517@stm.lbl.gov> <3AD01011.A8FAB831@mvista.com> <20010408152817.A5105@stm.lbl.gov>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Schleef wrote:

> Check again.  The unsigned arithmetic works correctly.

OK.


>   (starting with a full queue)

This one can't happen because of the race conditions are avoided
by the use of cep->lock.

> The other (and more likely) is:
>
>   - fcc_enet_start_xmit() fills up the TX ring, thus cep->skb_cur
>     == cep->skb->dirty.


What driver are you using?  That line of code hasn't been in a driver
for a very long time.  This was a very obvious bug that has been
corrected long ago.  You should be using the FSM Labs linuxppc_2_5
bitkeeper tree for any of the 8xx/82xx development.  There are lots
of things that were placed in the 2_5 tree when the 2.4 tree was frozen.
We are now trying to merge them back, but there are still some pieces
left to go.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
