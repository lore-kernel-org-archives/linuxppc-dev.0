Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 06A7BB7080
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 10:43:22 +1100 (EST)
Message-ID: <4B870B17.7080701@mlbassoc.com>
Date: Thu, 25 Feb 2010 16:43:19 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>	<4B85746F.3020200@freescale.com>		<4B857AA8.9000208@mlbassoc.com>	<4B857EA1.6030605@freescale.com>		<4B858243.8010908@mlbassoc.com>	<4B858B6C.4020809@freescale.com>		<20100224205159.GA6555@oksana.dev.rtsoft.ru>		<4B85A4C2.6090007@mlbassoc.com>		<A0F7894F-8B88-4646-8B81-830F67E39489@kernel.crashing.org>		<4B85B182.2030508@mlbassoc.com>	<4B86886B.5000304@mlbassoc.com>	<1267130982.23523.1728.camel@pasglop>	<4B86E5A7.9090607@freescale.com>
	<4B86E794.6020403@mlbassoc.com> <4B86EAA3.8000301@freescale.com>
In-Reply-To: <4B86EAA3.8000301@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/25/2010 02:24 PM, Scott Wood wrote:
> Gary Thomas wrote:
>> On 02/25/2010 02:03 PM, Scott Wood wrote:
>>> Gary, can you check that the MMIO addresses are going to the PCI bus as-is, and aren't being translated down to zero? I.e. POTARn should equal POBARn, and likewise in the device
>>> tree's pci node's ranges.
>>
>> Hmm, that doesn't match with how I've always had this setup. I have:
>> POTAR0 = 0x00000000
>> POTBR0 = 0x000C0000 (0xC0000000 >> 12)
>>
>> My device tree mappings are:
>> ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x10000000
>> 0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>
>
> That ranges property says that host address 0xc0000000 maps to PCI address 0xc0000000, so Linux will program the BAR to 0xc0000000, but the actual accesses will go elsewhere
> because POTAR0 is zero.
>
> Setting POTAR to zero is also a bad idea because it's aliasing your DMA window (it may work in certain situations based on who's initiating the transaction, but it seems like it's
> asking for trouble), plus it seems some cards just don't like address zero.
>
> Try setting POTAR0 to 0x000c0000 and see what happens.

Sadly, that doesn't work at all - neither RedBoot nor Linux
can talk to any of the PCI devices.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
