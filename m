Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A01C1DE077
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 04:50:41 +1000 (EST)
Message-ID: <470E703C.4090301@ru.mvista.com>
Date: Thu, 11 Oct 2007 22:49:32 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PowerPC: Fix find_legacy_serial_ports on OPB.
References: <20071011152609.GA10320@ru.mvista.com>
	<200710111750.41852.arnd@arndb.de>
In-Reply-To: <200710111750.41852.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 11 October 2007, Valentine Barshak wrote:
>> Currently find_legacy_serial_ports() can find no serial ports on the OPB.
>> Thus no legacy boot console can be initialized. Just the early udbg console
>> works, which is initialized with udbg_init_44x_as1() on the UART's physical
>> address specified in kernel config. This happens because we look for ns16750
>> and higher serial devices only and expect opb node to have a device type
>> property. This patch makes it look for ns16550 compatible devices and use
>> of_device_is_compatible() for opb instead of checking device type.
>> Lack of legacy serial ports found causes problems for KGDB over serial.
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> The patch would make sense if we were only dealing with flattened device
> tree systems at this point. Unfortunately, IBM is shipping hardware that
> encodes the serial port in exactly the way that find_legacy_serial_ports
> is looking for (parent->type == "opb", compatible = "ns16750" "ns16550"
> "ns16450" i8250").
> 
> Changing the search for ns16750 to ns16550 should be fine, but unnecessary
> because AFAIK, all OPB serial imlpementations are actually ns16750 and
> should have that in the device tree as well.

This is a bit odd. The docs say that uart chips on the ppc44x processors 
are registry-compatible to 16750, but have 16-byte FIFO's.
This is OK for legacy serial stuff (since it really needs the chip to be 
16550-compatible), but the 8250 driver expects 64-byte FIFO size for 16750.
I guess that's why 44x uart dts entries don't have 16750 compatible 
property.

> 
> For the device type of the bus, please check for both compatible and
> type, so that it still works on machines that are missing the compatible
> property.
> 
> 	Arnd <><
