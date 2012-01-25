Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
 by ozlabs.org (Postfix) with ESMTP id 0A14EB6F67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 06:49:40 +1100 (EST)
In-Reply-To: <4F2004B1.5030607@aimvalley.nl>
References: <OF74786861.90D91C05-ON8825798F.0083A71E-88257990.000118E7@selinc.com>
 <4F2004B1.5030607@aimvalley.nl>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
Subject: Re: FSL SPI driver question
Message-ID: <OF248EC14B.3E5BA3A6-ON88257990.006C779B-88257990.006CE971@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 25 Jan 2012 11:49:36 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Norbert,

> >
> > So the question is, how do I use spidev (or any other means) to get 
the
> > 8308 SPI controller to keep SPICLK active so that the output data from 
the
> > NvRAM gets clocked out to the 8308?
> >
> 
> Did you see Documentation/spi/spidev_fdx.c:do_msg ?
> it perform a full-duplex (actually half-duplex) 1 byte transfer.
> 
> In your case you need a transfer that outputs 3 bytes (read cmd + 
address)
> and inputs 1? byte.
> 
> If you do it this way I would expect the SPICLK to be active
> during the 2nd part of the transfer (whenever the CPU "reads" the
> data from SPI client).
> 

Thanks for the reply.  Yes I did find spidev_fdx.c and in fact copied it 
for my tests.  I still see SPICLK active only during the time the 8308 is 
sending data (read cmd + address).  Nothing happens with the clock after 
that when the NvRAM is ready to send data.

Bruce
