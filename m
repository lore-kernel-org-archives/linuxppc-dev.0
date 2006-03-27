Return-Path: <philn@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 018DB679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 19:15:39 +1100 (EST)
Subject: Re: Memory mapping PCI memory region to user space
From: Phil Nitschke <philn@avalon.com.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 18:32:22 +1030
Message-Id: <1143446542.24304.8.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-23 at 09:44 -0600, Kumar Gala wrote:
> On Mar 23, 2006, at 8:21 AM, Wyse, Chris wrote:
> 
> > Hi,
> >
> > I'm trying to map a PCI memory region 1 into user space from my  
> > driver (PPC440GX, Linux 2.6.10).  Here's the mmap routine of the  
> > driver that I'm using:
> 
> Why don't use the mmap file exposed by sysfs so you dont have to  
> write your own code?
> 
> See Documentation/filesystems/sysfs-pci.txt.  But effectively down  
> under /sys/bus/pci/devices/[domain:bus:dev:func]/ you will get  
> resource[0..N-1] that corresponds to each BAR on the device.  This is  
> a mmap file to access that region.

I have some custom hardware that appears on the PCI bus as follows:

bash-3.00# lspci -vv
00:01.0 Class 0680: 1172:0004 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128, Cache Line Size 08
	Interrupt: pin A routed to IRQ 71
	Region 0: Memory at 000000009ffff000 (32-bit, non-prefetchable)
[size=4K]
	Region 1: Memory at 000000009fc00000 (32-bit, non-prefetchable)
[size=2M]

But when I try to access resource0 or resource1, I get a read error.
What characteristic of the device or driver determines whether it will
allow mmap-ing?

(I've written the driver for this device myself.)

-- 
Phil
