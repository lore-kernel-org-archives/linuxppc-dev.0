Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id BAB18B7CB6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 09:14:28 +1100 (EST)
Message-ID: <4B85A4C2.6090007@mlbassoc.com>
Date: Wed, 24 Feb 2010 15:14:26 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>
	<4B85746F.3020200@freescale.com>	<4B857AA8.9000208@mlbassoc.com>
	<4B857EA1.6030605@freescale.com>	<4B858243.8010908@mlbassoc.com>
	<4B858B6C.4020809@freescale.com>
	<20100224205159.GA6555@oksana.dev.rtsoft.ru>
In-Reply-To: <20100224205159.GA6555@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2010 01:51 PM, Anton Vorontsov wrote:
> On Wed, Feb 24, 2010 at 02:26:20PM -0600, Scott Wood wrote:
>> Gary Thomas wrote:
>>> Yes, I'm using the exact same kernel with these two different PCI
>>> setups (done by the boot loader).
>>>
>>> Restricting the memory via mem=128M has no effect - the PCI layout
>>> is the same.
>>>
>>> I think the outbound window size is required because of how the Linux PCI
>>> remaps the space (note in my dumps that it put the MMIO of the
>>> boards starting
>>> at 0xD0000000 when the inbound window is 0x10000000)
>>
>> I see where the amount of RAM is mattering -- Linux is assigning
>> outbound I/O space to the PCI controller itself (device 00:00.0) and
>> the amount that it asks for seems to differ based on memory size.
>> Linux ought to skip that device when assigning resources.  Some
>> platforms do this (search for pci_exclude_device), but it seems to
>> be missing on 83xx.
>
> Actually, 83xx had these exclude_device hooks, but they were removed:
>
> commit d8f1324a5063c833862328ceafabc53ac3cc4f71
> Author: Kumar Gala<galak@kernel.crashing.org>
> Date:   Wed Sep 12 22:14:10 2007 -0500
>
>      [POWERPC] 83xx: Removed PCI exclude of PHB
>
>      Now that the generic code doesn't assign resources for Freescale
>      PHBs we dont have to explicitly exclude it.
>
>      Signed-off-by: Kumar Gala<galak@kernel.crashing.org>
>
>
> May be the generic code started to assign the resources again?
>

That cracked it; I re-enabled the exclusion of the bridge and now
it's all working fine.

Thanks for the help

Note: I'm working with a fairly old kernel, so these results would
have to be reworked against the latest.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
