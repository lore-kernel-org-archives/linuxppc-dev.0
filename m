Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E8FCDDF79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 09:23:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: DMA Puzzle
Date: Thu, 12 Apr 2007 16:23:00 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1D2@MERCURY.inside.istor.com>
In-Reply-To: <OF2330A747.4AF0C4FD-ON882572BB.0077B95A-882572BB.0078B180@selinc.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Randy Brown <rbrown@istor.com>, Vahid Fereydounkolahi <vahidf@istor.com>,
	Chris Carlson <ccarlson@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My apologies for the complexity of this e-mail but DMA seems to be a
complex subject. Thanks to Ed.S a while back, I have DMA working fine
from U-Boot, but I am having a problem in Linux with the 8541 processor
using the 2.6.17.11 kernel. I need to DMA through an outbound address
translation window setup at 0x8800_0000 and the chip I am DMA'ing to is
responding to 64bit DAC (Dual Address Cycles) and its memory is setup
beginning at 0x1_0000_0000.

It seems, that the MR0/SR0 indicate the DMA has stalled and I have not
figured out why yet. Here is the progression in the DMA driver in Linux

First obtain a pointer to my RAM buffer using pci_map_single. This
returns the buffer in kernel space at 0xC768_0000 (or thereabouts) to
0x07680000 and prepare to transfer 0x10000 (64K bytes) from 0x0_c7680000
to 0x1_0000_0000.

This is the first of several printk's in the DMA driver where the POTAR2
is being used to hold the hi part of the 64bit address.

a src_low_addr:07680000 winBase:00000000 POTAR2:00100000
newLowAddr:07680000 dir:1 size:00010000  =20

Next we write all f's to SR0 to clear it and here is the next printk.

z MR0:00000000 SR0:00000000 begin

Now we write the low part of the source address to LSAR0.=20
A constant value of 0x50000 to DATR0.
The size in bytes to the BCR (Byte Count Register) is next

Then set the MR0 to 0x0f03c404 indicating a)disable bandwidth sharing,
DAHTS & SAHTS both 8 bytes, SRW set & CDSM/SWSM cleared to indicate
start the DMA by writing the destination.

Lastly, we write the destination to the DAR0 register.

At this point, the next printk has a problem. The MR0 register has its
CS bit set and the SR0 register has its CB bit set. This indicates to me
that the channel is busy, it stalled and cannot continue.

 c MR0:0F03C405 SR0:00000004 SATR:00050000 DATR:00050000 dst_low_addr:0

Just for reference, here are two final printk's with some of the other
pertinent registers.

 d POTAR2:00100000 LSAR0:07690000 DAR0:88010000 BCR:0 DGSR:00000000
 e POTEAR2:00000000 POWBAR2:00088000 POWAR 0:80044019 1:8004401A
2:8004401B

So, the question becomes, "What is going awry here and where should I be
looking in order to understand how to close the DMA loop back to
Linux?".

Charles Krinke
