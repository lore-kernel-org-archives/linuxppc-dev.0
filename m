Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 90928DDFEE
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:55:07 +1100 (EST)
Message-ID: <47B5E042.9050805@ru.mvista.com>
Date: Fri, 15 Feb 2008 21:56:02 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
References: <47B59631.10908@ru.mvista.com>
	<fa686aa40802151038l7488293clb0c47da5b1b1e4fc@mail.gmail.com>
In-Reply-To: <fa686aa40802151038l7488293clb0c47da5b1b1e4fc@mail.gmail.com>
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

>>Add uart 16550 properties description to Xilinx portion of booting-without-of.txt

>> Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
>> ---
>>  Documentation/powerpc/booting-without-of.txt |   16 ++++++++++++++--
>>  1 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
>> index 7b4e8a7..dd77bbc 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -2575,10 +2575,22 @@ platforms are moved over to use the flattened-device-tree model.
>>
>>       Xilinx uartlite devices are simple fixed speed serial ports.
>>
>> -      Requred properties:
>> +      Required properties:
>>        - current-speed : Baud rate of uartlite
>>
>> -      v) Xilinx hwicap
>> +      v) Xilinx Uart 16550
>> +
>> +      Xilinx uart 16550 device registers are compatible with all standard 16540
>> +      and 16550 UARTs.


> Not strictly true; the xilinx uart is *almost* compatible with the
> ns16550.  The same driver can be made to work, but it is not register
> level compatible so we cannot claim compatible="ns16550".

    How much incompatible it is with 16550? Does that only extend to register 
stride of 4 instead of 1 -- if so, it should be considered compatible since
the same chip can be into address space mapped with stride of 1, 2, or 4, or 
whatever power of 2. If it has some actual register difference, like e. g. 
DLAB not existing and the divisor latch mapped to a separate register rather 
than 0..1, then indeed, new compatible property must be defined.

> We need a new compatible property for 16550 like devices with a reg shift and
> offset.

    No, we don't strictly need it if all incompatibilty is constrained to how 
the same 16550 registers mapped to address space which is a function of the 
address decoder, not the chip itself. Well, that's of course based in 8250.c's 
ability to handle different strides -- an imaginary driver could only handle 
1:1 chip mapping.

> Instead of attempting to come up with a generic description
> of this, I recommend just naming it after the actual device instance;
> something like compatible="xlnx,opb-uart16550";

    Well, that means that we'll need a to add a code which "glues" the chip to 
8250.c driver... well, of_serial.c could be that glue layer if we add to it 
the ability to recognize Xilinx UART... well, legacy_serial.c could be taught 
that trick too...
    Well, we could also add the new compatible, but still claim "ns16550" 
compatibility...

> Cheers,
> g.

WBR, Sergei
