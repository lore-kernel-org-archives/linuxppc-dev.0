Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 181B667A45
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 06:45:43 +1000 (EST)
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 8xx spi completion sometime doesn't generate an interrupt 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Jun 2006 17:08:48 +0200."
	<200606021708.48814.antonio.dibacco@aruba.it>
Date: Fri, 02 Jun 2006 22:45:40 +0200
Sender: wd@denx.de
Message-Id: <20060602204540.BE50D353A57@atlas.denx.de>
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

In message <200606021708.48814.antonio.dibacco@aruba.it> you wrote:
> As far I understood the spi bus device of mpc8xx works independently from the 
> attached device (in my case a dataflash m25pe80). Thus I don't understand why 
> sometime when I start an SPI transfer I don't receive an interrupt for the 
> completion of this operation. I wait 50 ms for this interrupt and sometime it 
> doesn't happen. Anyone had a similar problem?

Yes, this is known problem, especially if you are runnign the SPI bus
with higher data transfer rates and/or high CPM load. Check  the  FSL
knowledge base; it contains pretty clear statements about what SPI is
*not*  designed  for  - especially, it was not designed for any high-
bandwidth data transfers.

See for example  FAQ-8992:

        The physical clocking speed of the SPI can be up to 12 MHz.
        However, it only has a 16-bit holding register. Thus, the 12
        Mbit/sec rate can only be sustained for 16 bits. If you need
        to transmit more than 2-bytes of data at that clocking rate,
        you must put the data into separate BDs and set the data
        length to 2 and set the L bit in each BD. If you are using a
        character length of 16-bits, the maximum clocking rate is 3.1
        Mbit/sec. If you are using a character length of 8 bits, the
        maximum is 500 Kbits/sec. Note that 500 Kbits/sec is the
        maximum throughput when no other peripherals (SCCs, SMCs) are
        being used. Load on those peripherals will further reduce the
        maximum data rate through the SPI. See the question in the
        SCC area related to maximum data rate calculations.

 
Ok, this was for a 25 MHz (?) 68360 so you get somewhat better  rates
with an 8xx at higher CPU/CPM clocks - but the problem is essentially
still present.

See also FAQ-10566. And especially FAQ-10335, which comes to a point:

        The SPI data rate is based upon the load of the CPM. The SPI
        was not designed to be a high-bandwidth channel. It can run
	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        very quickly for bursts of up to 16-bits. But the peripheral
        has no FIFO and low priority in the MPC860 and thus you
        cannot burst lots of data quickly through the interface.


Been there before, and yes, we've been bitten, too. No way to fix.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In a business, marketroids, salespukes, and  lawyers  have  different
goals from those who actually do work and produce something. Usually,
is  is the former who triumph over the latter, due to the simple rule
that those who print the money make the rules.
         -- Tom Christiansen in <5jdcls$b04$2@csnews.cs.colorado.edu>
