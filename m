Return-Path: <a.hawkins@cabletime.com>
Received: from anchor-fallback-94.mail.demon.net
	(anchor-fallback-94.mail.demon.net [194.217.242.94])
	by ozlabs.org (Postfix) with ESMTP id 08181682FF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Sep 2005 03:59:31 +1000 (EST)
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:1163 "EHLO
	anchor-post-33.mail.demon.net") by anchor-fallback-94.mail.demon.net
	with ESMTP id S1344342AbVIUQtY (ORCPT
	<rfc822;linuxppc-embedded@ozlabs.org>);
	Wed, 21 Sep 2005 17:49:24 +0100
Received: from mailgate.cabletime.com ([80.177.138.66] helo=cabletime.com)
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1EI7ma-000Bwp-A9
	for linuxppc-embedded@ozlabs.org; Wed, 21 Sep 2005 16:49:21 +0000
Received: from adh.cabletime.com ([191.53.51.21] helo=adh)
	by cabletime.com with smtp (Exim 3.35 #1 (Debian))
	id 1EI7mQ-00013w-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Sep 2005 17:49:10 +0100
From: "Andy Hawkins" <a.hawkins@cabletime.com>
To: <support@mvista.com>, <linux-mtd@lists.infradead.org>,
	<linuxppc-embedded@ozlabs.org>
Date: Wed, 21 Sep 2005 17:49:15 +0100
Message-ID: <003501c5becc$67f2ac10$153335bf@cabletime.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0036_01C5BED4.C9B71410"
Subject: Slow read performance of NAND flash on PPC 405EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0036_01C5BED4.C9B71410
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

We have a custom PPC-405EP based board, with a Samsumg 8Gbit flash
(K9W8G08U1M) attached via EBC bank 2. When we read from this flash, we are
only getting data rates of around 20 MBits/sec (this is using 'dd' to read
direct from the linux /dev/mtd/x device). Our estimates show that the device
should be capable of something like 100 MBits/sec.

The EBC bank is set up as follows:

#define CFG_EBC_PB2AP           0x8a015480
#define CFG_EBC_PB2CR           0xFF458000  /*
BAS=0xFF4,BS=4MB,BU=R/W,BW=8bit */

The EBC bus is running at 54 MHz. We were originally running this bus at 27
MHz, and this speed increase doesn't appear to have done an awful lot for
us. By looking at the timings of various signals on an oscilloscope, we
adjusted the PB2AP register to that shown above, in an attempt to remove as
many of the wait states as possible.

However, during a read, we are seeing that each byte read cycle takes around
220 nSec (this is taken between the times when the #PERCS2 line for the
device goes low). A significant portion (about 6 clock periods) of this
time, the device appears to be doing nothing (i.e. the chip select line is
inactive). The code in the linux kernel to read a page of data from the
flash is very simple:

static void nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
{
        int i;
        struct nand_chip *this = mtd->priv;

        for (i=0; i<len; i++)
                buf[i] = readb(this->IO_ADDR_R);
}

readb maps to a call to in_8(FLASH_BASE_ADDRESS). The in_8 function does
contain what appear to be un-necessary calls to twi and isync, but removing
these calls does not alter the cycle time significantly.

Is there some setup of the EBC (or other component in the processor) that we
have incorrect that could be affecting the throughput?

Any advice you can offer would be greatly appreciated.

Thanks

Andy

------=_NextPart_000_0036_01C5BED4.C9B71410
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
0QWw7yuTL0MFoDB1YQEgK6GH5aMlgSiBZ2hwYYA/HSruQVKRJRAv83kIYDDRTIH7kxEFwHcwZgnB
IuAm4UbhXyuRBzBOATNdJAFzlJxkCnkdJH2bQAADAAlZAQAAAAsAAIAIIAYAAAAAAMAAAAAAAABG
AAAAAAOFAAAAAAAAAwAPgAggBgAAAAAAwAAAAAAAAEYAAAAAAYUAAAAAAAADAByACCAGAAAAAADA
AAAAAAAARgAAAAAQhQAAAAAAAAMAHYAIIAYAAAAAAMAAAAAAAABGAAAAAFKFAABzeQEAHgAegAgg
BgAAAAAAwAAAAAAAAEYAAAAAVIUAAAEAAAAEAAAAOS4wAAsAH4AIIAYAAAAAAMAAAAAAAABGAAAA
AAaFAAAAAAAACwAggAggBgAAAAAAwAAAAAAAAEYAAAAADoUAAAAAAAADACGACCAGAAAAAADAAAAA
AAAARgAAAAARhQAAAAAAAAMAIoAIIAYAAAAAAMAAAAAAAABGAAAAABiFAAAAAAAAAgH4DwEAAAAQ
AAAA+Ll3UzCf+0yJl+aXVlIs8wIB+g8BAAAAEAAAAPi5d1Mwn/tMiZfml1ZSLPMCAfsPAQAAAG4A
AAAAAAAAOKG7EAXlEBqhuwgAKypWwgAAbXNwc3QuZGxsAAAAAABOSVRB+b+4AQCqADfZbgAAAEM6
XERvY3VtZW50cyBhbmQgU2V0dGluZ3NcYW5keWhcTXkgRG9jdW1lbnRzXG1haWxib3gucHN0AAAA
AwD+DwUAAAADAA00/TcAAAIBfwABAAAAMQAAADAwMDAwMDAwRjhCOTc3NTMzMDlGRkI0Qzg5OTdF
Njk3NTY1MjJDRjNFNDEwQUMwMQAAAAADAAYQQYJxxwMABxCmBQAAAwAQEAAAAAADABEQAAAAAB4A
CBABAAAAZQAAAEhJLFdFSEFWRUFDVVNUT01QUEMtNDA1RVBCQVNFREJPQVJELFdJVEhBU0FNU1VN
RzhHQklURkxBU0goSzlXOEcwOFUxTSlBVFRBQ0hFRFZJQUVCQ0JBTksyV0hFTldFUkVBREYAAAAA
77k=

------=_NextPart_000_0036_01C5BED4.C9B71410--
