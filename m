Message-ID: <412F3CB3.7070002@ru.mvista.com>
Date: Fri, 27 Aug 2004 17:52:51 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Patrick Huesmann <tricknology@gmx.de>
Cc: Mark Chambers <markc@mail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel oops when initializing ethernet driver
References: <003901c48c34$6e73fe20$0301a8c0@chuck2> <3987.1093611999@www44.gmx.net>
In-Reply-To: <3987.1093611999@www44.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Patrick,

Patrick Huesmann wrote:
> Hi,
>
>
>>>Interestingly, the kernel only crashes when accessing that one
>>
>>particular
>>
>>>register (at offset 0x0040). Every other register in that range can be
>>>written to and read from w/o problems.
>>
>>So that sounds like a hardware problem, doesn't it.  This is one of those
>>things where the FPGA has a hard PPC core and a bunch of VHDL
>>peripherals?
>
>
> Yes, exactly. The peripherals are connected to the PPC core via the OPB
> (on-chip peripheral bus) and now I must assume that the address decode /
> "chip" select logic within that OPB is buggy or not configured right.
>

AFAIK Xilinx recommends to use PLB version of the ethernet controller.
For performance reasons at least.

>
>>The good thing there is that the VHDL isn't much harder
>>to fix than C code.  That would be my wild guess - the VHDL is not
>>decoding the address correctly.
>
>
> I don't even know if we have the VHDL source - the peripherals are
> ready-to-go logic units that are just inserted in the FPGA design.
>
Do you use EDK to build your design?
>
>>However, also check that you are not accidentally writing past 0x0040.
>>For instance, if 0x0040 is a byte address and you write 16 bits you'll
>>be writing to 0x0040 and 0x0041.
>
>
> It is a 32-bit access at 0x0040.
>
> Thanks,
> Patrick
>

In your kernel boot messages do you see a line similar to:

eth0: Xilinx EMAC #0 at 0x60000000 mapped to 0xC9015000, irq=30

Is the physical address in your log the one you expect?


Best regards,
Andrei


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
