Return-Path: <davidw@orthanc.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3310967CB8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jul 2005 01:17:59 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j6FFNYM6026971 for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 08:23:34 -0700 (MST)
Received: from orthanc.am.freescale.net (orthanc.am.freescale.net
	[10.81.111.105])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j6FFMDUS003188
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 10:22:14 -0500 (CDT)
Date: Fri, 15 Jul 2005 10:17:56 -0500
From: David Wolfe <david.wolfe@freescale.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050715151756.GA16256@orthanc.am.freescale.net>
References: <20050715122030.13663.qmail@web8506.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050715122030.13663.qmail@web8506.mail.in.yahoo.com>
Subject: Re: MPC5200B boot failure help needed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[ Susheel Raj writes: ]
> now the problem is that if i use MPC5200 Rev A then
> the kernel boots without any problem and gets into the
> command 
> 
> but when i am using MPC5200 Rev B it shows like this

If you're using rev.B1 silicon (mask M08A), you'll need to set the as
of yet undocumented TXW_MASK bit (13 in PPC bit ordering) in the Rx
FIFO control register (MBAR + 0x318c). Thus, set &fec->rfifo_cntrl to
0x0f040000 in mpc5xxx_fec_setup().

Rev.B2 (mask M62C) forces TXW_MASK to zero, but also masks the TXW
interrupt (0x40000000) in the status register resulting in no change
from rev.A (L25R) silicon.

If you're still having problems with Ethernet, I would suggest debugging
it with a root file system on something other than NFS. E.g. ramdisk,
MTD or ATA.

-- 
David Wolfe
Infotainment, Multimedia and Telematics Division
Freescale Semiconductor
