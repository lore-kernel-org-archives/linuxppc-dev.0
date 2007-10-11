Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0F5F8DE1D2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 03:27:30 +1000 (EST)
Message-ID: <470E5CBC.9040604@ru.mvista.com>
Date: Thu, 11 Oct 2007 21:26:20 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC: Fix find_legacy_serial_ports on OPB.
References: <20071011152609.GA10320@ru.mvista.com>	<200710111750.41852.arnd@arndb.de>
	<1192118028.5534.123.camel@localhost.localdomain>
In-Reply-To: <1192118028.5534.123.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 2007-10-11 at 17:50 +0200, Arnd Bergmann wrote:
>> On Thursday 11 October 2007, Valentine Barshak wrote:
>>> Currently find_legacy_serial_ports() can find no serial ports on the OPB.
>>> Thus no legacy boot console can be initialized. Just the early udbg console
>>> works, which is initialized with udbg_init_44x_as1() on the UART's physical
>>> address specified in kernel config. This happens because we look for ns16750
>>> and higher serial devices only and expect opb node to have a device type
>>> property. This patch makes it look for ns16550 compatible devices and use
>>> of_device_is_compatible() for opb instead of checking device type.
>>> Lack of legacy serial ports found causes problems for KGDB over serial.
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> The patch would make sense if we were only dealing with flattened device
>> tree systems at this point. Unfortunately, IBM is shipping hardware that
>> encodes the serial port in exactly the way that find_legacy_serial_ports
>> is looking for (parent->type == "opb", compatible = "ns16750" "ns16550"
>> "ns16450" i8250").
>>
>> Changing the search for ns16750 to ns16550 should be fine, but unnecessary
>> because AFAIK, all OPB serial imlpementations are actually ns16750 and
>> should have that in the device tree as well.
>>
>> For the device type of the bus, please check for both compatible and
>> type, so that it still works on machines that are missing the compatible
>> property.
> 
> Wait, no.  We already had this discussion months ago when David was
> working on the original Ebony port.  It was declared that legacy_serial
> is not how serial should be done on 4xx and the serial_of driver was
> supposed to be used instead.
> 
> Have we changed our stance on that?  If not, then perhaps KGDB should be
> fixed to work with serial_of.

Actually I don't see any reason not to use legacy_serial stuff for early 
console. We could split the kernel configured very early debug output, 
which uses  PPC_EARLY_DEBUG_44x_PHYSLOW/PHYSHIGH (since it's really 
dangerous) and early console things by using legacy serial. We could use 
  early boot console without PPC_EARLY_DEBUG_44x.
Thanks,
Valentine.

> 
> josh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
