Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB206DDE46
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 09:02:26 +1100 (EST)
Message-ID: <478FD066.5000803@freescale.com>
Date: Thu, 17 Jan 2008 16:02:14 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Problems with PCI on 8280
References: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D4@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D4@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Our problem is that we can only access the first 128MB of the 
> prefetchable area.
> an access to 0x87ff_ffff works (after ioremap), while an access to 
> 0x8800_0000 causes an bus error.
> 
> trying to access 0x87FFFFFC -> 0x00000000
> trying to access 0x88000000 ->Machine check in kernel mode.
> Caused by (from SRR1=49030): Transfer error ack signal
> 
> It is like the prefetch area is not set up correctly for ioremap.
> 
> The PCI registers are set up correctly in u-boot, and we can access the 
> whole prefetch area in u-boot without any problems.

Are you using cuImage, or a regular uImage with a device-tree-aware 
u-boot?  If the former, try commenting out the call to fixup_pci() in 
arch/powerpc/boot/cuboot-pq2.c and let me know if that changes anything.

Otherwise, are you sure the kernel didn't move BARs around such that 
there's no longer a PCI device mapped at 0x88000000 (or that the device 
that is there has been disabled)?

Can you show the contents of the following big endian registers:
TESCR1 (0x10040), TESCR2 (0x10044), PCIBRx (0x101ac, 0x101b0), and 
PCIMSKx (0x101c4, 0x101c8)

and the following little endian registers:
POTARx (0x10800, 0x10818, 0x10830), POBARx (0x10808, 0x10820, 0x10838), 
POCMRx (0x10810, 0x10828, 0x10840), POESR (0x10084), PCI_EACR (0x10890), 
and PCI_ECCR (0x108a0)

after the machine check happens?

-Scott
