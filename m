Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13A14DDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 00:43:27 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J25OP-0007uf-8N
	for linuxppc-embedded@ozlabs.org; Tue, 11 Dec 2007 05:43:25 -0800
Message-ID: <14274105.post@talk.nabble.com>
Date: Tue, 11 Dec 2007 05:43:25 -0800 (PST)
From: WITTROCK <jwittrock@maginst.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: LPC burst accesses
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB027FEAA7@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <DD39B5C3F4963040ADC9768BE7E430CB027FEAA7@is-hdq-exchange.marel.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I remember doing something like this a while back.  I ended up not
implementing it in my project for other reasons, but here is some
correspondence I had with Freescale:


The question
---------------------------------------------------------------------
I am using the LocalPlus bus and BestComm on a MPC5200B to communicate with
an external FPGA.

I am currently using CS2 as the chip select for the FPGA.  If I configure
the chip select 2 configuration register for a 16bit address width and 2
byte bus width then all works well (MBAR + 0x0308 = 0x00003500).

I am now trying to configure CS2 to operate in LargeFlash mode with 2 byte
bus width and 26bit address (MBAR + 0x0308 = 0x00003D00) in order to support
a burst read.  I have configured the Chip Select Burst Control Register
(BRE2=1), and ensured that PCI is disabled, however I do not see a burst
read performed on the bus.

Before I investigate any further, should it be possible to use the LP in
LargeFlash mode together with its assosciated FIFO and BestComm to perform a
burst read?


The Reply
Local Plus controller performs burst read from LargeFlash or MostGraphic
memory only if an XLB master (CPU) or SCLPC interface initiates burst
access.

In the case of CPU, you should enable cache for Local Plus memory.
In the case of SCLPC, you should define BPT=8 in the SCLPC Control Register
(MBAR + 0x3C08).

Other configurations doesn't force bursting.

Thank you for your interest in Freescale Semiconductor products and for the
opportunity to serve you.
Should you need to contact us with regard to this message, please see the
notes below.

I hope its of some use.

-WITTROCK



-- 
View this message in context: http://www.nabble.com/LPC-burst-accesses-tp14270986p14274105.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
