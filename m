Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 005DAB7D04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 07:27:30 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1OKRSYh000027
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 13:27:28 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o1OKXwcS013322
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 14:33:58 -0600 (CST)
Message-ID: <4B858B6C.4020809@freescale.com>
Date: Wed, 24 Feb 2010 14:26:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>
	<4B85746F.3020200@freescale.com>	<4B857AA8.9000208@mlbassoc.com>
	<4B857EA1.6030605@freescale.com> <4B858243.8010908@mlbassoc.com>
In-Reply-To: <4B858243.8010908@mlbassoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gary Thomas wrote:
> Yes, I'm using the exact same kernel with these two different PCI
> setups (done by the boot loader).
> 
> Restricting the memory via mem=128M has no effect - the PCI layout is 
> the same.
> 
> I think the outbound window size is required because of how the Linux PCI
> remaps the space (note in my dumps that it put the MMIO of the boards 
> starting
> at 0xD0000000 when the inbound window is 0x10000000)

I see where the amount of RAM is mattering -- Linux is assigning 
outbound I/O space to the PCI controller itself (device 00:00.0) and the 
amount that it asks for seems to differ based on memory size.  Linux 
ought to skip that device when assigning resources.  Some platforms do 
this (search for pci_exclude_device), but it seems to be missing on 83xx.

>> Are there any errors indicated in the device, the PCI controller, the 
>> arbiter, etc?
> 
> None that are obvious to me.
> 
> To be clear, here are my observations:
> 
> * total memory 128MB (or less), inbound window 128MB, outbound window 128MB
>   ==> device is happy
> * total memory 256MB, inbound window 128MB, outbound window 128MB
>   ==> device hangs, unable to access RAM (Linux handed it something 
> higher than 128MB)

Linux gets its idea of how much space there is to allocate from the 
ranges property of the pci node in the device tree -- this should be 
made to match what u-boot configures in PIWARn.

> * total memory 256MB, inbound window 256MB, outbound window 128MB
>   ==> segmentation violation when accessing device MMIO space
> * total memory 256MB, inbound window 256MB, outbound window 256MB
>   ==> access to MMIO space fails (Linux can't find device).  In this 
> case, the SATA_SIL reports
>          ata1: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
>          ata2: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
>       which implies that the driver get's junk when accessing the device 
> MMIO space

Are there any other relevant messages earlier in boot, perhaps from the 
PCI code failing to assign a resource?

-Scott
