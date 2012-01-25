Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
 by ozlabs.org (Postfix) with ESMTP id E6161B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 11:38:25 +1100 (EST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
 by duster.selinc.com (8.14.4/8.14.4) with ESMTP id q0P0BuSq015800
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 16:11:56 -0800
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: FSL SPI driver question
Message-ID: <OF74786861.90D91C05-ON8825798F.0083A71E-88257990.000118E7@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 24 Jan 2012 16:11:58 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Good afternoon,

I'm using the 3.0.3 kernel running on an MPC8308 and am trying to 
interface to a Cypress CY14B256Q2A non-volatile RAM via SPI.  I've got the 
SPI infrastructure, the Freescale SPI driver (drivers/spi/spi_fsl_spi.c), 
and spidev built into the kernel and everything on the user space/kernel 
side appears to be working correctly (at least when I try to read the 
NvRAM's config register all the right places in the kernel get hit and I 
see the SPI signals active with an o-scope).

I think what I'm hitting is a lack of understanding/documentation on the 
SPI controller in the 8308.  To read data from the NvRAM, the Master (the 
8308 in this case) needs to clock out a byte long "read" command, two 
bytes of address, and then clock in the data from the NvRAM.  However, I 
never get any data back.  I think the problem is that (direct quote from 
the 8308 reference manual) "SPICLK is a gated clock, active only during 
data transfers".  So once the read command and address are sent, the 8308 
considers the data transfer complete and gates off SPICLK.  Without 
SPICLK, the NvRAM has no way to clock out it's data.  I think it's ready 
to, it just can't.

So the question is, how do I use spidev (or any other means) to get the 
8308 SPI controller to keep SPICLK active so that the output data from the 
NvRAM gets clocked out to the 8308?

Thanks.

Bruce
