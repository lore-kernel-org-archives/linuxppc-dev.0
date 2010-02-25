Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 4F098B7CFA
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 08:11:52 +1100 (EST)
Message-ID: <4B86E794.6020403@mlbassoc.com>
Date: Thu, 25 Feb 2010 14:11:48 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>	<4B85746F.3020200@freescale.com>		<4B857AA8.9000208@mlbassoc.com>	<4B857EA1.6030605@freescale.com>		<4B858243.8010908@mlbassoc.com>	<4B858B6C.4020809@freescale.com>		<20100224205159.GA6555@oksana.dev.rtsoft.ru>		<4B85A4C2.6090007@mlbassoc.com>		<A0F7894F-8B88-4646-8B81-830F67E39489@kernel.crashing.org>		<4B85B182.2030508@mlbassoc.com>
	<4B86886B.5000304@mlbassoc.com>	<1267130982.23523.1728.camel@pasglop>
	<4B86E5A7.9090607@freescale.com>
In-Reply-To: <4B86E5A7.9090607@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: avorontsov@ru.mvista.com, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/25/2010 02:03 PM, Scott Wood wrote:
> Benjamin Herrenschmidt wrote:
>> On Thu, 2010-02-25 at 07:25 -0700, Gary Thomas wrote:
>>> I may have been too hasty pronouncing this fixed. Indeed, the
>>> SATA interface now works, but my video card (Fujitsu Coral-P)
>>> does not work when it's mapped at the bottom of the PCI space :-(
>>>
>>> With the bridge mapped, the video ends up at a non-zero address
>>> (0xC8000000..0xCFFFFFFF). If it gets mapped to 0xC0000000, it
>>> fails to respond to MMIO accesses.
>>>
>>> Any ideas how I might get around this? Is there a way to force
>>> the PCI allocator to start somewhere other than [relative] zero?
>>
>> I'm not familiar with the way the FSL bridge works, but it would
>> be possible to invert MMIO and DMA on your PCI bus. IE. Have MMIO go
>> from 0....2G and DMA from 2G..4G for example. Provided the FSL bridge
>> can offset the DMA back down to 0 (memory). Can it ?
>
> It can, but I don't see how that would help, if the problem is that the video card doesn't like the low 30 bits of its MMIO address being zero.
>
> Gary, can you check that the MMIO addresses are going to the PCI bus as-is, and aren't being translated down to zero? I.e. POTARn should equal POBARn, and likewise in the device
> tree's pci node's ranges.

Hmm, that doesn't match with how I've always had this setup.  I have:
   POTAR0 = 0x00000000
   POTBR0 = 0x000C0000        (0xC0000000 >> 12)

My device tree mappings are:
   ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x10000000
             0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>

n.b. I don't run U-Boot on these platforms (being the author
of RedBoot and all... :-)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
