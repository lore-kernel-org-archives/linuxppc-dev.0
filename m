Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F42AB70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 10:34:03 +1100 (EST)
Message-ID: <50748.84.105.60.153.1288222432.squirrel@gate.crashing.org>
In-Reply-To: <20101027225855.25345.qmail@kosh.dhis.org>
References: <20101027225855.25345.qmail@kosh.dhis.org>
Date: Thu, 28 Oct 2010 01:33:52 +0200 (CEST)
Subject: Re: Pegasos OHCI bug (was Re: PROBLEM: memory corrupting bug,
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: pacman@kosh.dhis.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> 1) Figure out what exactly is going on;
>
> I thought we were past that.

We are not.

> The startup sequence leaves the device in a
> bad
> state (writing 1000 times per second to memory that the kernel believes is
> not in use), so it needs to be given a reset command before the kernel
> tries
> to use that memory.

The question now is what causes the firmware to do that, and then
what is the best way to stop it from doing that.

>> > The big question that I'm still stumbling over is how to access the
>> device
>> > registers. The "reg" property looks like this:
>>
>> You should look at "assigned-addresses", not "reg".  Well,
>> you first need to look at "reg" to figure out what entry
>> in "assigned-addresses" to use.

Ignore this part, I was confused.

> The properties look like this:
>
> /pci@80000000/usb@5/assigned-addresses
>  02002810 00000000 80000000 00000000 00001000

Lovely, incorrect data (it should start with 82002810, i.e.,
not relocatable -- it is already an assigned address!).

This means: 32-bit MMIO address space for bus 0 dev 5 fn 0,
first BAR; assigned to address 80000000; size is 1000.

You could try a boot script like this:


dev /pci
0 ffff04 DO 0 i config-w! -100 +LOOP
device-end


which should disable all PCI devices on all busses, on that
PCI host bus (it disables every device behind pci-pci bridges
separately, as long as every such bridge has a higher secondary
bus number than primary bus number; if you only want to disable
everything on the root bus (which should be sufficient), use
ff04 instead of ffff04).


Segher
