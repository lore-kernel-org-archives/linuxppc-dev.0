Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 4528067A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 03:03:55 +1100 (EST)
Message-ID: <44280D45.7090103@ovro.caltech.edu>
Date: Mon, 27 Mar 2006 08:05:25 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Phil.Nitschke@avalon.com.au
Subject: Re: Memory mapping PCI memory region to user space
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
	<1143446542.24304.8.camel@lamorak.int.avalon.com.au>
In-Reply-To: <1143446542.24304.8.camel@lamorak.int.avalon.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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



> I have some custom hardware that appears on the PCI bus as follows:
> 
> bash-3.00# lspci -vv
> 00:01.0 Class 0680: 1172:0004 (rev 01)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 128, Cache Line Size 08
> 	Interrupt: pin A routed to IRQ 71
> 	Region 0: Memory at 000000009ffff000 (32-bit, non-prefetchable)
> [size=4K]
> 	Region 1: Memory at 000000009fc00000 (32-bit, non-prefetchable)
> [size=2M]
> 
> But when I try to access resource0 or resource1, I get a read error.
> What characteristic of the device or driver determines whether it will
> allow mmap-ing?
> 
> (I've written the driver for this device myself.)
> 

Hi Phil,

The board tells you you have 4K of non-prefetchable memory in two BAR
regions. Which is what you've already determined I am sure.

Try building an insmodding the pci_io driver I posted, it'll pick
up the two BAR regions and allow you to access them, and you can
add more debugging comments to that code fairly easily.

If things don't work then, you probably have a hardware error and
would benefit from looking at the PCI bus with a logic analyzer to
see if the device is generating an error.

http://www.ovro.caltech.edu/~dwh/pci_io.tar.gz

Regards,
Dave
