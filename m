Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F359DDF95
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 02:20:29 +1100 (EST)
Subject: DMA take 4
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 7 Mar 2007 07:20:25 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A18B@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Swarthout Edward L-SWARTHOU" <ed.swarthout@freescale.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have gotten to the point where u-boot performs dma transactions
repeatedly and reliably with the 8541 and have moved back to my Linux
driver.

When I complete the DMA transaction in the Linux driver, the SR0
registers tends to have 0x00000024 in it, meaning SR0[CH] & SR0[CB] are
both set and MR0[CS] is set.

I start out with:

Set SR0   to 0xFFFF_FFFF
Set SATR0 to 0x0005_0000
Set DATR0 to 0x0005_0000
Set MR0   to 0x0F03_C404
Set SAR0 to the physical address in local memory
Set DAR0 to the physical address of the PCI window at 0x8800_0000 which
is been previously setup with POTAR2, POWAR2 & POWBAR2.

It seems that the DMA transaction in Linux, using the same 8541 register
settings as are in u-boot is not completing.

So, this leads me to wondering about ioremap_nocache() perhaps. Although
here, I think I want physical addresses for the source and destination
of the DMA.

What other things can I look into to understand why a DMA in Linux using
the 8541 is going awry?

Charles
