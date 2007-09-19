Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6014CDDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 23:53:30 +1000 (EST)
Message-ID: <46F1299A.1000508@ru.mvista.com>
Date: Wed, 19 Sep 2007 17:52:26 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] usb: ehci-ppc-of dts bindings.
References: <20070917130005.GA29654@ru.mvista.com>
	<19e5f15308dfb8e60e2e49379666d00a@kernel.crashing.org>
In-Reply-To: <19e5f15308dfb8e60e2e49379666d00a@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +  l) USB EHCI controllers
>> +
>> +  Required properties:
>> +  - device_type : should be "usb".
> 
> No device_type please.  The published USB binding doesn't define
> one on purpose.
> 

Could you please, explain why?
Sorry, I don't think I get the concept of device description here.

>> +  - compatible : should be "ehci".
> 
> Just "ehci" isn't enough -- compare to OHCI, which is the name for
> a kind of USB host controller as well as for a kind of Firewire
> host controller.

Actually, I though device type="usb" + compatible="ehci" would be enough.

> 
> Maybe "usb-ehci" is best -- can anyone think of a better name?

Again, why not type="usb", compatible="ehci"?

> 
>> +  - reg : Offset and length of the register set for the device
> 
> Address and length.  You also should declare here how the optional
> EHCI register blocks should be encoded (the USB debug port, etc.)
> 
>> +  - interrupts : <a b> where a is the interrupt number and b is a
>> +    field that represents an encoding of the sense and level
>> +    information for the interrupt.
> 
> This is incorrect; not all interrupt domains use two cells, and
> not all that do have this meaning for those cells.

Well, this was just copied from other descriptions in 
Documentation/powerpc/booting-without-of.txt
Do we need to fix them all?

> 
> Instead, you should just say how many interrupts should be here,
> and which is which in the EHCI standard.
> 
>> +  - interrupt-parent : the phandle for the interrupt controller that
>> +    services interrupts for this device.
> 
> Not every EHCI node needs this; just don't mention this at all,
> interrupt mapping is fully defined for all devices elsewhere
> already (in the "interrupt mapping" recommended practice).
> 
>> +  If device registers are implemented in big endian mode, the device
>> +  node should have "big-endian" property.
>> +  If controller implementation operates with big endian descriptors,
>> +  compatible should also have "ehci-be-desc"
> 
> Ah, I understand what this is about, finally.
> 
> Don't put this in "compatible"; instead, do a "big-endian-descriptors"
> property similar to the "big-endian" property.  That last one should
> maybe be "big-endian-registers" here then, to avoid confusion.
> 
> Or make "big-endian" mean both big-endian registers *and* big-endian
> descriptors.

But doesn't "big-endian" property actually mean "big-endian-registers"?
Do we have to overload property meaning in this case?

> 
> I have no opinion which is best; it depends on what configurations
> actually exist, and how popular those are.
> 
>> +    ehci@e0000300 {
>> +        device_type = "usb";
>> +        compatible = "ibm,ehci-440epx", "ehci-be-desc", "ehci";
>> +        interrupts = <1a 4>;
>> +        interrupt-parent = <&UIC0>;
>> +        reg = <0 e0000300 ff>;
> 
> Length should be 100 here.
> 
>> +        big-endian;
>> +    };
> 
> 
> Segher
> 

Thanks,
Valentine.
