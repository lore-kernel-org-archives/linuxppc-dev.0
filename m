Return-Path: <segher@kernel.crashing.org>
Received: from localhost.localdomain (adsl-63-203-10-66.dsl.lsan03.pacbell.net
	[63.203.10.66]) by ozlabs.org (Postfix) with SMTP id 369992BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 16:00:01 +1000 (EST)
Received: from [172.20.101.118] by localhost.localdomain for
	<linuxppc-embedded@ozlabs.org>; Tue, 28 Sep 2004 05:57:31 -7GMT
In-Reply-To: <20040927224825.B30772@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 28 Sep 2004 00:58:57 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Cc: David Gardiner <daveg@sonartech.com.au>, linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> PCI device IRQs are normally retrieved straight from the PCI device
>> itself.  Sounds like a firmware problem (or the bootloader, if that
>> sets up the PCI devices for you).
>
> This assumes a world where everything is managed by magic BIOS/OF
> initialization. That's not the case for this user's board port.

The OS (Linux, specifically) won't do it for you.  It has to be set up
beforehand.  Unless "embedded Linux" gets this the wrong way around
as well.

>> I believe Linux for PowerMac actually gets the IRQ number straight
>> from the device.  Some other routing might be gotten out of the OF
>> device-tree, yes.
>
> The interrupt line register is always programmed by firmware, bios,
> or an OS. It is a logical value that is dependent on the platform.

a) Don't pretend I don't know this; and b) it is wrong.  On the
majority of platforms, you can route any PCI IRQ to any number you want.
The firmware will tell you where it ends up (over PCI config space).

> The only thing statically available on a PCI device is the interrupt
> pin register value.

That only tells you whether the device has any IRQ at all.

> That combined with the platform-specific routing
> table is used to generate an arbitrary interrupt line value that
> is programmed into the PCI interrupt line register.

interrupt line == IRQ#?  That is set up _before_ Linux runs.


Segher
