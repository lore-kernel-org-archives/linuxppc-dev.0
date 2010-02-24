Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80537B7CB6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 09:25:59 +1100 (EST)
Subject: Re: PCI on 834x
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B85A4C2.6090007@mlbassoc.com>
Date: Wed, 24 Feb 2010 16:25:36 -0600
Message-Id: <A0F7894F-8B88-4646-8B81-830F67E39489@kernel.crashing.org>
References: <4B854A93.7030405@mlbassoc.com>
	<4B85746F.3020200@freescale.com>	<4B857AA8.9000208@mlbassoc.com>
	<4B857EA1.6030605@freescale.com>	<4B858243.8010908@mlbassoc.com>
	<4B858B6C.4020809@freescale.com>
	<20100224205159.GA6555@oksana.dev.rtsoft.ru>
	<4B85A4C2.6090007@mlbassoc.com>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 24, 2010, at 4:14 PM, Gary Thomas wrote:

> On 02/24/2010 01:51 PM, Anton Vorontsov wrote:
>> On Wed, Feb 24, 2010 at 02:26:20PM -0600, Scott Wood wrote:
>>> Gary Thomas wrote:
>>>> Yes, I'm using the exact same kernel with these two different PCI
>>>> setups (done by the boot loader).
>>>>=20
>>>> Restricting the memory via mem=3D128M has no effect - the PCI =
layout
>>>> is the same.
>>>>=20
>>>> I think the outbound window size is required because of how the =
Linux PCI
>>>> remaps the space (note in my dumps that it put the MMIO of the
>>>> boards starting
>>>> at 0xD0000000 when the inbound window is 0x10000000)
>>>=20
>>> I see where the amount of RAM is mattering -- Linux is assigning
>>> outbound I/O space to the PCI controller itself (device 00:00.0) and
>>> the amount that it asks for seems to differ based on memory size.
>>> Linux ought to skip that device when assigning resources.  Some
>>> platforms do this (search for pci_exclude_device), but it seems to
>>> be missing on 83xx.
>>=20
>> Actually, 83xx had these exclude_device hooks, but they were removed:
>>=20
>> commit d8f1324a5063c833862328ceafabc53ac3cc4f71
>> Author: Kumar Gala<galak@kernel.crashing.org>
>> Date:   Wed Sep 12 22:14:10 2007 -0500
>>=20
>>     [POWERPC] 83xx: Removed PCI exclude of PHB
>>=20
>>     Now that the generic code doesn't assign resources for Freescale
>>     PHBs we dont have to explicitly exclude it.
>>=20
>>     Signed-off-by: Kumar Gala<galak@kernel.crashing.org>
>>=20
>>=20
>> May be the generic code started to assign the resources again?
>>=20
>=20
> That cracked it; I re-enabled the exclusion of the bridge and now
> it's all working fine.
>=20
> Thanks for the help
>=20
> Note: I'm working with a fairly old kernel, so these results would
> have to be reworked against the latest.

Odd that the generic code isn't dealing with that for you.

- k=
