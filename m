Return-Path: <clark@esteem.com>
Received: from forward.hsphere.cc (forward-dummy3.hsphere.cc [216.157.144.3])
	by ozlabs.org (Postfix) with SMTP id D2A43682FA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 03:18:01 +1000 (EST)
Message-ID: <4332E61D.2050104@esteem.com>
Date: Thu, 22 Sep 2005 10:13:01 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Andy Hawkins <a.hawkins@cabletime.com>
References: <003401c5becc$6795bf00$153335bf@cabletime.com>
In-Reply-To: <003401c5becc$6795bf00$153335bf@cabletime.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Slow read performance of NAND flash on PPC 405EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy Hawkins wrote:
> Hi,
> 
> We have a custom PPC-405EP based board, with a Samsumg 8Gbit flash
> (K9W8G08U1M) attached via EBC bank 2. When we read from this flash, we are
> only getting data rates of around 20 MBits/sec (this is using 'dd' to read
> direct from the linux /dev/mtd/x device). Our estimates show that the device
> should be capable of something like 100 MBits/sec.
> 
> The EBC bank is set up as follows:
> 
> #define CFG_EBC_PB2AP           0x8a015480
> #define CFG_EBC_PB2CR           0xFF458000  /*
> BAS=0xFF4,BS=4MB,BU=R/W,BW=8bit */
> 
> The EBC bus is running at 54 MHz. We were originally running this bus at 27
> MHz, and this speed increase doesn't appear to have done an awful lot for
> us. By looking at the timings of various signals on an oscilloscope, we
> adjusted the PB2AP register to that shown above, in an attempt to remove as
> many of the wait states as possible.
> 

It would be nice if you would break out the fields in the PB2AP control 
word. This is what I came up with.

BME = 1, burst mode enabled
FWT = 2, 3 wait states
BWT = 4, 5 wait states
CSN = 0, 0 clock cycles before CS asserted
OEN = 1, 1 clock cycle before the PerOE is asserted
WBN = 1, 1 clock cycle delay until the first PerW line assertion after CS
WBF = 1, 1 clock cycle delay
TH  = 2, 2 clock cycles in between each burst
RE  = 0, PerREADY line disabled
SOR = 1, no effect
BME = 0


So you are reading things in burst mode. I have no experience doing 
things in burst mode so I'm not going to be much help. I would look at 
your timing diagrams again. Try changing the TH to 1 or 0 and see what 
happens.

> However, during a read, we are seeing that each byte read cycle takes around
> 220 nSec (this is taken between the times when the #PERCS2 line for the
> device goes low). A significant portion (about 6 clock periods) of this
> time, the device appears to be doing nothing (i.e. the chip select line is
> inactive). The code in the linux kernel to read a page of data from the
> flash is very simple:
> 
> static void nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
> {
>         int i;
>         struct nand_chip *this = mtd->priv;
> 
>         for (i=0; i<len; i++)
>                 buf[i] = readb(this->IO_ADDR_R);
> }
> 
> readb maps to a call to in_8(FLASH_BASE_ADDRESS). The in_8 function does
> contain what appear to be un-necessary calls to twi and isync, but removing
> these calls does not alter the cycle time significantly.
> 
> Is there some setup of the EBC (or other component in the processor) that we
> have incorrect that could be affecting the throughput?
> 
> Any advice you can offer would be greatly appreciated.
> 
> Thanks
> 
> Andy
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

Good Luck

-- Conn Clark

*****************************************************************
Blessed be the heretic, for he causes some to think and unites
the rest against him.
*****************************************************************

Conn Clark
Engineering Assistant                clark@esteem.com
Electronic Systems Technology Inc.        www.esteem.com

Stock Ticker Symbol                ELST
