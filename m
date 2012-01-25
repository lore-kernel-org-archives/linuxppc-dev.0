Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C6F6BB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 00:33:45 +1100 (EST)
Message-ID: <4F2004B1.5030607@aimvalley.nl>
Date: Wed, 25 Jan 2012 14:33:37 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: FSL SPI driver question
References: <OF74786861.90D91C05-ON8825798F.0083A71E-88257990.000118E7@selinc.com>
In-Reply-To: <OF74786861.90D91C05-ON8825798F.0083A71E-88257990.000118E7@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/12 01:11, Bruce_Leonard@selinc.com wrote:
> Good afternoon,
>
> I'm using the 3.0.3 kernel running on an MPC8308 and am trying to
> interface to a Cypress CY14B256Q2A non-volatile RAM via SPI.  I've got the
> SPI infrastructure, the Freescale SPI driver (drivers/spi/spi_fsl_spi.c),
> and spidev built into the kernel and everything on the user space/kernel
> side appears to be working correctly (at least when I try to read the
> NvRAM's config register all the right places in the kernel get hit and I
> see the SPI signals active with an o-scope).
>
> I think what I'm hitting is a lack of understanding/documentation on the
> SPI controller in the 8308.  To read data from the NvRAM, the Master (the
> 8308 in this case) needs to clock out a byte long "read" command, two
> bytes of address, and then clock in the data from the NvRAM.  However, I
> never get any data back.  I think the problem is that (direct quote from
> the 8308 reference manual) "SPICLK is a gated clock, active only during
> data transfers".  So once the read command and address are sent, the 8308
> considers the data transfer complete and gates off SPICLK.  Without
> SPICLK, the NvRAM has no way to clock out it's data.  I think it's ready
> to, it just can't.
>
> So the question is, how do I use spidev (or any other means) to get the
> 8308 SPI controller to keep SPICLK active so that the output data from the
> NvRAM gets clocked out to the 8308?
>
> Thanks.
>
> Bruce


Did you see Documentation/spi/spidev_fdx.c:do_msg ?
it perform a full-duplex (actually half-duplex) 1 byte transfer.

In your case you need a transfer that outputs 3 bytes (read cmd + address)
and inputs 1? byte.

If you do it this way I would expect the SPICLK to be active
during the 2nd part of the transfer (whenever the CPU "reads" the
data from SPI client).

hth.

---
NvBolhuis
