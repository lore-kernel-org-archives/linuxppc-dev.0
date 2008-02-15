Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E09A9DDF03
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 06:14:01 +1100 (EST)
Message-ID: <47B5E4B2.4050705@ru.mvista.com>
Date: Fri, 15 Feb 2008 22:14:58 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
References: <47B59631.10908@ru.mvista.com>	
	<fa686aa40802151038l7488293clb0c47da5b1b1e4fc@mail.gmail.com>	
	<47B5E042.9050805@ru.mvista.com>
	<fa686aa40802151102p7f540094j4fafcd5839381052@mail.gmail.com>
In-Reply-To: <fa686aa40802151102p7f540094j4fafcd5839381052@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

>> >> +      Xilinx uart 16550 device registers are compatible with all standard 16540
>> >> +      and 16550 UARTs.

>> > Not strictly true; the xilinx uart is *almost* compatible with the
>> > ns16550.  The same driver can be made to work, but it is not register
>> > level compatible so we cannot claim compatible="ns16550".

>>    How much incompatible it is with 16550? Does that only extend to register
>> stride of 4 instead of 1 -- if so, it should be considered compatible since
>> the same chip can be into address space mapped with stride of 1, 2, or 4, or
>> whatever power of 2. If it has some actual register difference, like e. g.
>> DLAB not existing and the divisor latch mapped to a separate register rather
>> than 0..1, then indeed, new compatible property must be defined.

> The definition of compatible (from the OpenFirmware) docs is that the
> *device* is register level compatible.   That includes register
> locations and offsets.

    I'd disagree here: register offsets are the function of the chip select, 
not a chip itself -- you can possible wire chip selects to 16550 so that the 
registers would be spaced by 4 bytes.

> The registers are not at the same location, therefore it is not compatible.

> However, the *driver* can be easily made compatible with the devices.
> We just teach the driver to bind against both "ns16550" and whatever
> value is chosen for these reg-shifted devices.  Not a big deal.

    You're going to "teach" 8250.c? Good luck. :-)
    IMO we can only teach a glue layer which "passes" UARTs to 8250.c via 
platform devices.

>> > We need a new compatible property for 16550 like devices with a reg shift and
>> > offset.

>>    No, we don't strictly need it if all incompatibilty is constrained to how
>> the same 16550 registers mapped to address space which is a function of the
>> address decoder, not the chip itself. Well, that's of course based in 8250.c's
>> ability to handle different strides -- an imaginary driver could only handle
>> 1:1 chip mapping.

> compatible also covers bus binding when it is a memory mapped device.
> Otherwise you need another node between the bus and the ns16550 type
> device that does translation from the wide stride (regshift=2) to the
> ns16550 register definitions (regshift=0).

    The chip can be connected to the bus (via chip select circuitry) in 
different ways, therefore we need a "glue" node for that circuitry?

>> > Instead of attempting to come up with a generic description
>> > of this, I recommend just naming it after the actual device instance;
>> > something like compatible="xlnx,opb-uart16550";

>>    Well, that means that we'll need a to add a code which "glues" the chip to
>> 8250.c driver... well, of_serial.c could be that glue layer if we add to it
>> the ability to recognize Xilinx UART... well, legacy_serial.c could be taught
>> that trick too...
>>    Well, we could also add the new compatible, but still claim "ns16550"
>> compatibility...

> No, we cannot because it is not register level compatible (and once
> again, that definition includes the stride between registers)

    Once again, I disagree. :-)

> Cheers,
> g.

WBR, Sergei
