Date: Wed, 31 Jul 2002 16:11:24 +0200 (CEST)
From: Christian Pellegrin <chri@infis.univ.trieste.it>
To: howard.gray@matrix-vision.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re. Davicom DM9102A Network Problems
In-Reply-To: <200207311550.02892.ppclist@matrix-vision.de>
Message-ID: <Pine.LNX.4.44.0207311607420.23220-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 31 Jul 2002, Howard Gray wrote:

>
> Howard Gray wrote....
> >> How can the tulip driver work with the DM9102A at all if the transmit
> >> buffers are not guaranteed to be correctly aligned ?
>
> But my question still remains: How can I get a double word aligned transmit
> buffer using the network core's sk_buff mechanism ? If I can't do that I'll
> have to rewrite the driver to use use my own aligned buffers and copy the
> sk_buff data to them. It's a pity because then it doesn't make much sense to
> follow that with a DMA transfer....
>

>From Alex Zeffertt mpc860sar.c (in this case 16-byte aligned, just change
to 16 to 4 and 15 to 3):


        // Allocate a socket buffer
        newskb = dev_alloc_skb(mtu_ + 15);

        if (newskb) {
          // Make sure that newskb->data gives a burst-aligned
          // pointer (divisible by 16)
          if ((len = (ulong)newskb->data & (ulong)0x0f)){
            skb_reserve(newskb, 16 - len);
          }

hth
Bye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
