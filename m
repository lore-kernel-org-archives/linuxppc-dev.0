Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE047B7C33
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 10:49:55 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1PNnqlq004574
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 16:49:52 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o1PNuOow016986
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 17:56:24 -0600 (CST)
Message-ID: <4B870C9F.5060308@freescale.com>
Date: Thu, 25 Feb 2010 17:49:51 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>	<4B85746F.3020200@freescale.com>		<4B857AA8.9000208@mlbassoc.com>	<4B857EA1.6030605@freescale.com>		<4B858243.8010908@mlbassoc.com>	<4B858B6C.4020809@freescale.com>		<20100224205159.GA6555@oksana.dev.rtsoft.ru>		<4B85A4C2.6090007@mlbassoc.com>		<A0F7894F-8B88-4646-8B81-830F67E39489@kernel.crashing.org>		<4B85B182.2030508@mlbassoc.com>	<4B86886B.5000304@mlbassoc.com>	<1267130982.23523.1728.camel@pasglop>	<4B86E5A7.9090607@freescale.com>	<4B86E794.6020403@mlbassoc.com>
	<4B86EAA3.8000301@freescale.com> <4B870B17.7080701@mlbassoc.com>
In-Reply-To: <4B870B17.7080701@mlbassoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gary Thomas wrote:
> On 02/25/2010 02:24 PM, Scott Wood wrote:
>> Gary Thomas wrote:
>>> On 02/25/2010 02:03 PM, Scott Wood wrote:
>>>> Gary, can you check that the MMIO addresses are going to the PCI bus 
>>>> as-is, and aren't being translated down to zero? I.e. POTARn should 
>>>> equal POBARn, and likewise in the device
>>>> tree's pci node's ranges.
>>>
>>> Hmm, that doesn't match with how I've always had this setup. I have:
>>> POTAR0 = 0x00000000
>>> POTBR0 = 0x000C0000 (0xC0000000 >> 12)
>>>
>>> My device tree mappings are:
>>> ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x10000000
>>> 0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>
>>
>> That ranges property says that host address 0xc0000000 maps to PCI 
>> address 0xc0000000, so Linux will program the BAR to 0xc0000000, but 
>> the actual accesses will go elsewhere
>> because POTAR0 is zero.
>>
>> Setting POTAR to zero is also a bad idea because it's aliasing your 
>> DMA window (it may work in certain situations based on who's 
>> initiating the transaction, but it seems like it's
>> asking for trouble), plus it seems some cards just don't like address 
>> zero.
>>
>> Try setting POTAR0 to 0x000c0000 and see what happens.
> 
> Sadly, that doesn't work at all - neither RedBoot nor Linux
> can talk to any of the PCI devices.

Make sure that whatever is doing the PCI enumeration is allocating MMIO 
addresses starting at 0xc0000000.  That anything worked at all before 
indicates that something was probably allocating from zero, despite 
what's in the device tree.

-Scott
