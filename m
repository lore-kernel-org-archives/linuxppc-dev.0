Return-Path: <Hans.Thielemans@metris.com>
Received: from kryp01.krypton.be (mail.krypton.be [62.58.105.205])
	by ozlabs.org (Postfix) with ESMTP id 88E04DDF06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 17:32:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC5200 ethernet communication stops unexpected
Date: Wed, 16 May 2007 09:29:25 +0200
Message-ID: <80AD928CDD8C8C469A1357A9C7B7657FF72E33@kryp01.krypton.be>
From: "Hans Thielemans" <Hans.Thielemans@metris.com>
To: "Sylvain Munaut" <tnt@246tNt.com>,
	"David Kanceruk" <david.kanceruk@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Sylvain and David

I think it is a more basic problem then just cache. The setup is using
the psc2 and
psc3 in codec32 mode to communicate with a DSP. Because the MPC5200 had
problems with
the frame in slave mode (anomaly list), it is used in master mode, and
sends empty packets=20
of 256 bytes to keep the link active, so the DSP can send the data. This
because the send and
receive clocks and frames are the same on the mpc5200 side.

The empty packet is a fixed packet in memory, so it is never overwritten
by the mpc5200 once
the driver is initialized. So I can not believe in a cache problem. The
problem is always in the
last 32 bit word or last 4 bytes in the package. The error rate seems to
be influenced by cpu activity
and bus priorities.=20

I have now changed the protocol to send 260 bytes and just drop the last
4 bytes at the receiver.
This way I had it running this night, transmitting 50 GB without a
single error.

I would assume it has something to do with the bastcomm engine tasks at
the end of a dma block.
And probably something with the bus access. I tried several settings for
the arbiter and bus configurations
by changing the registers from within the bdi2000 debugger. Changing
behavior but no solution.

In the full system there are 6 bestcomm tasks active: fec rx and tx,
psc2 rx and tx and psc3 rx and tx.

Regards

Hans



-----Original Message-----
From: Sylvain Munaut [mailto:tnt@246tNt.com]=20
Sent: woensdag 16 mei 2007 8:57
To: David Kanceruk
Cc: Hans Thielemans; linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 ethernet communication stops unexpected

David Kanceruk wrote:
> Hello Hans,
>
>      Our problem was with the FEC sending data with one or two=20
> incorrect bytes when we switched from the MPC5200 to the MPC5200B. The

> byte positions were always the same. The socket buffer has the correct

> data before and after the DMA engine runs but the FEC TxFIFO does not=20
> always match.
>
> One solution to our problem was to make the following call prior to=20
> starting the DMA:
>
> flush_dcache_range((unsigned long)skb->data, (unsigned long)skb->data
> + skb->len);
>
> The other solution was to set the BSDIS bit in the XLB config register

> during initialization as follows:
>
>   xlb =3D (struct mpc52xx_xlb *)MPC5xxx_XLB;
>   out_be32(&xlb->config,  in_be32(&xlb->config) |=20
> MPC52xx_XLB_CFG_BSDIS);
>
> Either solution works for us. The BSDIS bit is a new feature in the=20
> MPC5200B. The MPC5200 did not have this bit.
>
> According to the Freescale documentation, (Application note AN3045,=20
> for instance) setting this bit is supposed to "disable" BestComm bus=20
> snooping. However, I have reason to believe the documentation is in=20
> error. Everything I have observed seems to indicate that in the=20
> MPC5200 BestComm bus snooping was always enabled or enabled via some=20
> other means. In the MPC5200B it appears to be "disabled" at reset (not

> "enabled" as the documentation states). This is why flushing the cache

> manually is one solution. Since setting the BSDIS bit also fixes the=20
> problem, it suggests that this actually "enables" BestComm bus=20
> snooping instead of disabling it. In my mind, it could all boil down=20
> to a simple documentation error.
>  =20
That problem is _very_ weird ...

>From what I understand, Bestcomm XLB snooping means that when the
BestComm engine has some data cached internally and that it detects a
write to the address from where those data comes, he will invalidate his
cache.

But when the kernel writes data to the skb buffer, they may partially
stay in cache so there won't be any transaction at all on the xlb bus.
It's when
bestcomm will read the skb, that the core will snoop the bus, detects
there is a read request for some data he has in cache, force a retry of
the bestcomm read, write the data to memory (via xlb), and finally let
bestcomm retry the transaction to fetch the good data.

So I guess what "could" happen is that :
 - The kernel allocate a skb, but it ends up being as the same memory
location
    as a "previous" one. (or maybe in a directly following position
because of
    prefetch).
 - You submit it to bestcomm
 - When bestcomm does the read, since the skb was used "just before",
the line is still in cache but with the wrong data. Since the kernel
just wrote the data, there was not yet a xlb transaction because the
data are still in cpu cache.
Bestcomm think he has the data (no xlb write so it's cache was not
invalidated), so he doesn't generate a xlb read. But if there is no xlb
read the core doesn't get a chance to snoop it and doesn't flush it's
cache ...

Although that doesn't explain why setting BSDIS high solve the problem,
nor why there is only 1 byte wrong ...

Have you checked your XLB snoop window setting ? And that core snooping
is enabled ? Also that you don't use the "nap" power saving feature of
the core ? (it disables snooping altogether ...).


    Sylvain

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________
