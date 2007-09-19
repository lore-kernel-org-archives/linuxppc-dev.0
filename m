Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1030DDDEC5
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 02:50:30 +1000 (EST)
In-Reply-To: <46F1299A.1000508@ru.mvista.com>
References: <20070917130005.GA29654@ru.mvista.com>
	<19e5f15308dfb8e60e2e49379666d00a@kernel.crashing.org>
	<46F1299A.1000508@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d0e5786123822b4d178932d9048f6a22@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] usb: ehci-ppc-of dts bindings.
Date: Wed, 19 Sep 2007 18:50:02 +0200
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +  Required properties:
>>> +  - device_type : should be "usb".
>> No device_type please.  The published USB binding doesn't define
>> one on purpose.
>
> Could you please, explain why?
> Sorry, I don't think I get the concept of device description here.

"device_type" is meant to be used only by OF for determining the OF
programming model for a device.  No such thing has been defined for
USB busses, so the USB binding does not define a "device_type" either.

Nothing in a flat device tree should ever define a device_type, except
perhaps for compatibility with legacy kernel code.

>>> +  - compatible : should be "ehci".
>> Just "ehci" isn't enough -- compare to OHCI, which is the name for
>> a kind of USB host controller as well as for a kind of Firewire
>> host controller.
>
> Actually, I though device type="usb" + compatible="ehci" would be 
> enough.

"compatible" values are their own namespace, you should in principle
be able to find a driver for a device with them without having to look
at other properties.

>> Maybe "usb-ehci" is best -- can anyone think of a better name?
>
> Again, why not type="usb", compatible="ehci"?

Because an OF client (i.e., the Linux kernel) is not supposed to use
"device_type" at all for its own driver matching.

>>> +  - interrupts : <a b> where a is the interrupt number and b is a
>>> +    field that represents an encoding of the sense and level
>>> +    information for the interrupt.
>> This is incorrect; not all interrupt domains use two cells, and
>> not all that do have this meaning for those cells.
>
> Well, this was just copied from other descriptions in 
> Documentation/powerpc/booting-without-of.txt
> Do we need to fix them all?

Sounds like it, yes.

>>> +  If device registers are implemented in big endian mode, the device
>>> +  node should have "big-endian" property.
>>> +  If controller implementation operates with big endian descriptors,
>>> +  compatible should also have "ehci-be-desc"
>> Ah, I understand what this is about, finally.
>> Don't put this in "compatible"; instead, do a "big-endian-descriptors"
>> property similar to the "big-endian" property.  That last one should
>> maybe be "big-endian-registers" here then, to avoid confusion.
>> Or make "big-endian" mean both big-endian registers *and* big-endian
>> descriptors.
>
> But doesn't "big-endian" property actually mean "big-endian-registers"?
> Do we have to overload property meaning in this case?

It doesn't *have* a standard meaning, it is defined per device binding
that uses it.  Just make it mean whatever is most logical for this
device.

>> I have no opinion which is best; it depends on what configurations
>> actually exist, and how popular those are.


Segher
