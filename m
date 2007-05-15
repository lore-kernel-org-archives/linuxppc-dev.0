Return-Path: <Hans.Thielemans@metris.com>
Received: from kryp01.krypton.be (mail.krypton.be [62.58.105.205])
	by ozlabs.org (Postfix) with ESMTP id DA35ADDE30
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 01:31:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC5200 ethernet communication stops unexpected
Date: Tue, 15 May 2007 17:16:13 +0200
Message-ID: <80AD928CDD8C8C469A1357A9C7B7657FF72DE0@kryp01.krypton.be>
From: "Hans Thielemans" <Hans.Thielemans@metris.com>
To: "David Kanceruk" <david.kanceruk@gmail.com>
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

Hello David,

In this case, I am flushing cache. And overall, these are empty packets
sent which are never changed.
The cpu creates this once and then this is always reused. It is received
maybe 100000 times correct and
then suddenly I see an error in the last word.=20

I also tried playing with the BSDIS and PLDIS bits, and with the bus
priorities. This influences the error rate,
but it is never really gone.=20

As a hack I have now added an extra word after the packet, and have the
receiver ignore it. This seems to help,
but I don't like it.

Regards

Hans

-----Original Message-----
From: David Kanceruk [mailto:david.kanceruk@gmail.com]=20
Sent: dinsdag 15 mei 2007 17:04
To: Hans Thielemans
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 ethernet communication stops unexpected

Hello Hans,

     Our problem was with the FEC sending data with one or two incorrect
bytes when we switched from the MPC5200 to the MPC5200B. The byte
positions were always the same. The socket buffer has the correct data
before and after the DMA engine runs but the FEC TxFIFO does not always
match.

One solution to our problem was to make the following call prior to
starting the DMA:

flush_dcache_range((unsigned long)skb->data, (unsigned long)skb->data
+ skb->len);

The other solution was to set the BSDIS bit in the XLB config register
during initialization as follows:

  xlb =3D (struct mpc52xx_xlb *)MPC5xxx_XLB;
  out_be32(&xlb->config,  in_be32(&xlb->config) |
MPC52xx_XLB_CFG_BSDIS);

Either solution works for us. The BSDIS bit is a new feature in the
MPC5200B. The MPC5200 did not have this bit.

According to the Freescale documentation, (Application note AN3045, for
instance) setting this bit is supposed to "disable" BestComm bus
snooping. However, I have reason to believe the documentation is in
error. Everything I have observed seems to indicate that in the MPC5200
BestComm bus snooping was always enabled or enabled via some other
means. In the MPC5200B it appears to be "disabled" at reset (not
"enabled" as the documentation states). This is why flushing the cache
manually is one solution. Since setting the BSDIS bit also fixes the
problem, it suggests that this actually "enables" BestComm bus snooping
instead of disabling it. In my mind, it could all boil down to a simple
documentation error.

Perhaps you are also experiencing a caching problem.

Best regards,

David Kanceruk

On 5/15/07, Hans Thielemans <hans.thielemans@metris.com> wrote:
> Hi David,
>
> I have a similar problem. I use the PSC for communication to a DSP.
> With the MPC5200 this has always worked. Now we got boards with the=20
> MCP5200B in place.
>
> The bestcomm dma seems to miss bits, bytes in the last word (32bit) of

> a dma block. Mostly it is one byte which becomes 0. The blocks are 256

> bytes and written/read by 32 bits.
> The behavior is influenced by cpu activity, bus priorities. So far I=20
> found no settings which have never errors.
>
> Did you have any further progress?
>
> Regards
>
> Hans Thielemans
>



--
David Kanceruk

"The generation of random numbers is far too important to be left to
chance."

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
