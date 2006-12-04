Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99FBD67B92
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 00:06:52 +1100 (EST)
In-Reply-To: <20061204125646.GA28600@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<20061204125646.GA28600@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F327897F-38A9-4FEF-9140-F623B0B70445@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 4 Dec 2006 14:05:22 +0100
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> --- a/arch/powerpc/kernel/pci_64.c
>>> +++ b/arch/powerpc/kernel/pci_64.c
>>> @@ -1234,6 +1234,14 @@ static void __devinit fixup_resource(str
>>> 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>>> 	unsigned long start, end, mask, offset;
>>>
>>> +	/*
>>> +	 * tell the core code that this ressource is unassigned
>>> +	 * fixes p630 winbond IDE with libata
>>> +	 */
>>> +	if (res->start == 0) {
>>> +		res->flags = 0;
>>> +		return;
>>> +	}
>>> 	if (res->flags & IORESOURCE_IO) {
>>> 		offset = (unsigned long)hose->io_base_virt - pci_io_base;
>>
>> Please make this run on pSeries only; on a PowerMac for
>
> I could just match for winbond an start == 0.

Why not fix it properly?  The "0 means unassigned" thing is
something this specific firmware does, it is not a standard
or anything, and certainly not a property of the winbond
hardware (it _will_ react to legacy I/O at address 0).

So make this new code only run when this firmware is used,
too (perhaps do a check in prom_init and remove this BAR
from the assigned addresses property?)


Segher
