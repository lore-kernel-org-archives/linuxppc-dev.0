Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A9A467A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 03:18:58 +1100 (EST)
In-Reply-To: <1143446542.24304.8.camel@lamorak.int.avalon.com.au>
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
	<1143446542.24304.8.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <43A30583-5E99-46A8-B419-1AEAB8440840@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Memory mapping PCI memory region to user space
Date: Mon, 27 Mar 2006 10:18:50 -0600
To: Phil.Nitschke@avalon.com.au
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


On Mar 27, 2006, at 2:02 AM, Phil Nitschke wrote:

> On Thu, 2006-03-23 at 09:44 -0600, Kumar Gala wrote:
>> On Mar 23, 2006, at 8:21 AM, Wyse, Chris wrote:
>>
>>> Hi,
>>>
>>> I'm trying to map a PCI memory region 1 into user space from my
>>> driver (PPC440GX, Linux 2.6.10).  Here's the mmap routine of the
>>> driver that I'm using:
>>
>> Why don't use the mmap file exposed by sysfs so you dont have to
>> write your own code?
>>
>> See Documentation/filesystems/sysfs-pci.txt.  But effectively down
>> under /sys/bus/pci/devices/[domain:bus:dev:func]/ you will get
>> resource[0..N-1] that corresponds to each BAR on the device.  This is
>> a mmap file to access that region.
>
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

Nothing special beyond normal unix perms on the resource[0..n] files  
to my knowledge.  When you say you get a read error what exactly does  
that mean?

- kumar
