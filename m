Return-Path: <tnt@246tNt.com>
Received: from mailgate102.isp.belgacom.be (mailgate102.isp.belgacom.be
	[195.238.6.83]) by ozlabs.org (Postfix) with ESMTP id 3F0E3DDED2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 16:56:15 +1000 (EST)
Message-ID: <464AAB39.4050003@246tNt.com>
Date: Wed, 16 May 2007 08:56:57 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: David Kanceruk <david.kanceruk@gmail.com>
Subject: Re: MPC5200 ethernet communication stops unexpected
References: <1179234357.1668.10.camel@pc-hans>
	<5b525e390705150803l516a5d9x9c214e2b4b00ea0e@mail.gmail.com>
In-Reply-To: <5b525e390705150803l516a5d9x9c214e2b4b00ea0e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Hans Thielemans <hans.thielemans@metris.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Kanceruk wrote:
> Hello Hans,
>
>      Our problem was with the FEC sending data with one or two
> incorrect bytes when we switched from the MPC5200 to the MPC5200B. The
> byte positions were always the same. The socket buffer has the correct
> data before and after the DMA engine runs but the FEC TxFIFO does not
> always match.
>
> One solution to our problem was to make the following call prior to
> starting the DMA:
>
> flush_dcache_range((unsigned long)skb->data, (unsigned long)skb->data
> + skb->len);
>
> The other solution was to set the BSDIS bit in the XLB config register
> during initialization as follows:
>
>   xlb = (struct mpc52xx_xlb *)MPC5xxx_XLB;
>   out_be32(&xlb->config,  in_be32(&xlb->config) | MPC52xx_XLB_CFG_BSDIS);
>
> Either solution works for us. The BSDIS bit is a new feature in the
> MPC5200B. The MPC5200 did not have this bit.
>
> According to the Freescale documentation, (Application note AN3045,
> for instance) setting this bit is supposed to "disable" BestComm bus
> snooping. However, I have reason to believe the documentation is in
> error. Everything I have observed seems to indicate that in the
> MPC5200 BestComm bus snooping was always enabled or enabled via some
> other means. In the MPC5200B it appears to be "disabled" at reset (not
> "enabled" as the documentation states). This is why flushing the cache
> manually is one solution. Since setting the BSDIS bit also fixes the
> problem, it suggests that this actually "enables" BestComm bus
> snooping instead of disabling it. In my mind, it could all boil down
> to a simple documentation error.
>   
That problem is _very_ weird ...

>From what I understand, Bestcomm XLB snooping means that when the
BestComm engine has some data cached internally and that it detects a write
to the address from where those data comes, he will invalidate his cache.

But when the kernel writes data to the skb buffer, they may partially
stay in cache so there won't be any transaction at all on the xlb bus.
It's when
bestcomm will read the skb, that the core will snoop the bus, detects
there is
a read request for some data he has in cache, force a retry of the
bestcomm read,
write the data to memory (via xlb), and finally let bestcomm retry the
transaction to fetch the good data.

So I guess what "could" happen is that :
 - The kernel allocate a skb, but it ends up being as the same memory
location
    as a "previous" one. (or maybe in a directly following position
because of
    prefetch).
 - You submit it to bestcomm
 - When bestcomm does the read, since the skb was used "just before", the
line is still in cache but with the wrong data. Since the kernel just
wrote the
data, there was not yet a xlb transaction because the data are still in
cpu cache.
Bestcomm think he has the data (no xlb write so it's cache was not
invalidated),
so he doesn't generate a xlb read. But if there is no xlb read the core
doesn't get
a chance to snoop it and doesn't flush it's cache ...

Although that doesn't explain why setting BSDIS high solve the problem, nor
why there is only 1 byte wrong ...

Have you checked your XLB snoop window setting ? And that core snooping
is enabled ? Also that you don't use the "nap" power saving feature of the
core ? (it disables snooping altogether ...).


    Sylvain
