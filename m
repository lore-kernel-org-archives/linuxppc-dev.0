Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B629768A1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 09:28:34 +1100 (EST)
Message-ID: <43E91ED1.2090400@ovro.caltech.edu>
Date: Tue, 07 Feb 2006 14:27:29 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Artesyn Processor PMC 'Host Bridge' has no IRQ assigned?
References: <43C7051D.8000001@ovro.caltech.edu>	<43C7AA6D.5060206@sandburst.com>	<43C7DA97.30505@ovro.caltech.edu>
	<43C7DD1D.20804@ovro.caltech.edu>
In-Reply-To: <43C7DD1D.20804@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Travis B. Sawyer" <tsawyer@sandburst.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I mentioned a few weeks back that I had found some
Artesyn PrPMC boards on eBay for about $50 ea.
I purchased a couple of the boards, I have booted
one on a PMC site on a x86 compact PCI host CPU board.

 From the x86 host, if I perform lspci on the
board, its recognized as a 'Host Bridge';

# lspci -s 02:03.0 -vv
02:03.0 Host bridge: Artesyn Communication Products PM/PPC (rev 01)
         Subsystem: Unknown device 00f9:1014
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Region 1: Memory at f4000000 (32-bit, prefetchable) [size=64M]
         Region 2: Memory at f0700000 (32-bit, prefetchable) [size=4K]

What appears strange to me is that there is no IRQ assigned.
How then would one write a driver on the PMC board that
could interrupt the x86 Host CPU??

I haven't used PrPMC boards before, so perhaps this
is normal.

Travis, you mentioned you'd used this board before. Do you
recall if this 'feature' is configurable, i.e., can I enable
an interrupt. I'll also take a look in the IBM CPC700 bridge
data sheet and see if I can see anything in there.

I checked the mode of the PMC board using the monitor program.
It says its in non-Monarch mode, so it is correctly configuring
itself as a PCI peripheral.

My objective for the board is to put U-Boot on it (Travis mentioned
the Artesyn board is supported), boot Linux, and then write
drivers for communicating over PCI to an x86 host (much as
I plan to do with the 440EP processor).

Anyway, comments welcome!

Dave
