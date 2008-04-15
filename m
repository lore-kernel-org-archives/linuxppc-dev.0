Return-Path: <tnt@246tnt.com>
Received: from mailrelay010.isp.belgacom.be (mailrelay010.isp.belgacom.be
	[195.238.6.177]) by ozlabs.org (Postfix) with ESMTP id 956ACDE169
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:20:21 +1000 (EST)
Message-ID: <4804D5C2.3050104@246tnt.com>
Date: Tue, 15 Apr 2008 18:20:18 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Cees van Teylingen <cees.van.teylingen@chess.nl>
Subject: Re: BestComm/FEC Linux system crash
References: <4804CE5F.8050907@chess.nl>
In-Reply-To: <4804CE5F.8050907@chess.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, dve@chess.nl, Rob Broersen <rob.broersen@chess.nl>,
	Nathan Huizinga <nathan.huizinga@chess.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi
> I hereby take the liberty to contact you regarding an issue we
> experience with the
> MPC5200 BestComm/FEC in our system. I found that you are the writer of
> the drivers
> for these, so apparently with a lot of experience with these devices.
> I hope you can find
> the time and inspiration to look into our case.
Well, feel free to CC me to bring my attention to it, but such question
should still go to the list.
It's been a while since I worked on the 5200 and some other people might
have more recent expertise than I do.

Plus, it's actually Domen Puncer who reworked a lot of the network
driver code quite recently ...

> We are running a Lunix based system based on a MPC5200
Need more precision.
- 5200 or 5200B ?
- What kernel version (version ?, where did you get it ?, external patch
applied ?)

> This process dies after several minutes due to a FEC RxFifo overflow
> interrupt. This interrupt
> now causes the FEC to be re-initialized, but for some reason the
> receiver channel still does
> not work properly, causing the RxFifo overflow to occur nearly
> immediately again, causing
> a subsequent FEC re-init again, again resulting in failing receiver
> channel, causing another
> RxFifo overflow interrupt etc etc etc......
Huh ... you transmit lots of data ... and it's the RX fifo that overlow ...

> In the FEC driver we stumbled upon the following code:
>
> static irqreturn_t fec_rx_interrupt(int irq, void *dev_id)
> {
>    struct net_device *dev = dev_id;
>    struct fec_priv *priv = (struct fec_priv *)dev->priv;
>
>    for (;;) {
>        struct sk_buff *skb;
>        struct sk_buff *rskb;
>        struct bcom_fec_bd *bd;
>        u32 status;
>
>        if (!bcom_buffer_done(priv->rx_dmatsk))
>            break;
>
> [...snipped...]
> Now what we see is that the statement in the FEC interrupt handler
>
>        if (!bcom_buffer_done(priv->rx_dmatsk))
>            break;
>
> is executed frequently.
>
> Can you explain why this statement is there? 
Well ... that test is inside an infinite loop ( for(;;) ... ), so yes,
hopefully it will be 'break' at some point ...
What we do here is that we try to process as much receive buffer as
possible ... So we loop indefinitly until no more buffers are ready ...

> During debug, after receiving the first RxFifo overflow interrupt, we
> suspended all further FEC processing and dumped
> various system status, of which the BestComm receiver descriptors.
> Here we found that always all but one were initialized
> to 0x4000005f2, but the different one to 0x08000040.
Theses are Receive Buffer descriptor. So it the BCOM_BD_READY bit is
_set_, that means, that they're _not_ done (i.e. they are ready for
bestcomm to fill).
If you check the definition of bcom_buffer_done, you'll see that we
check if the bit is _cleared_

So the situation you are describing is essentially :
 - One of the buffer is filled with some received packet (length = 0x40)
 - All the other buffers are ready for bestcomm and they can contain at
maximum 1522 bytes (0x5f2)

There is nothing 'wrong' about this situation.

> This all directs us somewhat to the believe that the following is
> occurring:
>
> For some reason the BestComm gets confused during FEC reception
> causing a descriptor not to be handled properly, which
> causes its status never to be set to 'ready' (BCOM_BD_READY
> 0x40000000ul).  Eventually, because of all receiving
> traffic to be ceased, the RxFifo will overflow causing the described
> interrupt and following re-initialization actions. But the
> BestComm FEC receiver channel fails to re-initialize (or even does not
> get re-initialized at all) and/or the BestComm FEC
> receiver descriptor table does not get re-initialized, causing the
> 0x08000040 status to remain in there. So either BestComm
> fails to work at all for the FEC Receiver channel and/or BestComm
> eventually stumbles upon the 'incorrect' descriptor causing
> the FEC receiver to stall again causing an RxFifo overflow again etc
> etc etc.
Well, given you misunderstood the meaning of BCOM_BD_READY, this theory
doesn't make much sense sorry ...

The re-initialize process should work however ... there is a bug there.

> This all seems plausible for what we experience so far, but does get
> confirmed by any data we can find in datasheets and
> hard-/software descriptions. The FEC receiver has the highest priority
> within BestComm and thus should always get serviced.
> The thing we can not find however is what system impact the PCI DMA by
> the PLX9056 is causing on the BestComm
> performance. 
The only interference I see would be contention on the XLB bus ... Maybe
you can try to play with the xlb priority and give a higher one to
bestcomm or a lower one to the PCI.
Look in the platform setup there is some code setting xlb priorities.
And refer to the 'XLB arbiter' section of the manual for the registers
to tweak.

What kind of bandwidth are you using for RX/TX on ethernet and PCI ?
Does your PCI card do _very_ long bursts without releasing the bus
(locking the xlb for a long time), or _very_ short burst causing big
overhead ?

You can also try playing the FEC RX fifo alarm levels.

> We can imagine that it disrupts 'normal' BestComm performance i.e.
> Ethernet traffic, but then again the overflow
> interrupt should take care of a proper re-initialization of all hard-
> and software, allowing the TCP/IP stack to subsequently
> handle correct transfer of missing packets.
The overflow should still not happen ... that's a pretty serious error
imho.


Sylvain
