Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4A67B7CF4
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 08:03:39 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1PL3bhu027843
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 14:03:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o1PL3eQw026171
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 15:03:41 -0600 (CST)
Message-ID: <4B86E5A7.9090607@freescale.com>
Date: Thu, 25 Feb 2010 15:03:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>	<4B85746F.3020200@freescale.com>	
	<4B857AA8.9000208@mlbassoc.com>	<4B857EA1.6030605@freescale.com>	
	<4B858243.8010908@mlbassoc.com>	<4B858B6C.4020809@freescale.com>	
	<20100224205159.GA6555@oksana.dev.rtsoft.ru>	
	<4B85A4C2.6090007@mlbassoc.com>	
	<A0F7894F-8B88-4646-8B81-830F67E39489@kernel.crashing.org>	
	<4B85B182.2030508@mlbassoc.com> <4B86886B.5000304@mlbassoc.com>
	<1267130982.23523.1728.camel@pasglop>
In-Reply-To: <1267130982.23523.1728.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, avorontsov@ru.mvista.com,
	Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2010-02-25 at 07:25 -0700, Gary Thomas wrote:
>> I may have been too hasty pronouncing this fixed.  Indeed, the
>> SATA interface now works, but my video card (Fujitsu Coral-P)
>> does not work when it's mapped at the bottom of the PCI space :-(
>>
>> With the bridge mapped, the video ends up at a non-zero address
>> (0xC8000000..0xCFFFFFFF).  If it gets mapped to 0xC0000000, it
>> fails to respond to MMIO accesses.
>>
>> Any ideas how I might get around this?  Is there a way to force
>> the PCI allocator to start somewhere other than [relative] zero?
> 
> I'm not familiar with the way the FSL bridge works, but it would
> be possible to invert MMIO and DMA on your PCI bus. IE. Have MMIO go
> from 0....2G and DMA from 2G..4G for example. Provided the FSL bridge
> can offset the DMA back down to 0 (memory). Can it ?

It can, but I don't see how that would help, if the problem is that the 
video card doesn't like the low 30 bits of its MMIO address being zero.

Gary, can you check that the MMIO addresses are going to the PCI bus 
as-is, and aren't being translated down to zero?  I.e. POTARn should 
equal POBARn, and likewise in the device tree's pci node's ranges.

-Scott
