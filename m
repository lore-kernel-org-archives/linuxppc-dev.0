MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: Losing my console messages !!
Date: Tue, 6 Apr 2004 10:28:08 +0100
Message-ID: <85E6ED5B5EC32F439702305CC417E12D9E2A64@email.3il.fr>
From: =?Windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Andrei for you help!
But do you know what are the point of those 2 different variables BASE_BAUD and SERIAL_BAUD ?
Furthermore, I tried to contact the PowerPc support to get the figure oh the ppcNPE405L clocking but I'm still waiting for their answer (in fact I have two very different figures for that clocking and I don't know which one is the right one)... How can I obtain the right value for my board? (remember that my uart is internally clocked thing that was not true in the original LSP design. Are there some specific sources for the external clock managing?)
My bootrom set those parameters:
-CPU freq = 200Mhz
-PLB freq = 50Mhz
To communicate with my bootrom, I used the minicom with 38400 701.
I'd like to get my console at 38400 8n1 when the Linux bootloader and Linux kernel are executing.

That's it...


-----Original Message-----
From: Andrei Konovalov [mailto:akonovalov@ru.mvista.com]
Sent: Mon 4/5/2004 5:50 PM
To: Garcia Jérémie
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Losing my console messages !!

Garcia Jérémie wrote:
... skipped ...
> I noticed the presence of two "#define" which seem to be important but it's hard to me to understand how they really act:
> include/asm-ppc/pc_serial.h -->   #define BASE_BAUD ( 1843200 / 16 )
> arch/ppc/boot/common/ns16550.c--> #define SERIAL_BAUD 9600
>

Not sure if you should use pc_serial.h. If you look at include/asm-ppc/serial.h many boards
use their own definitions for this stuff. But probably this is OK for ceder.

Anyway,
#define BASE_BAUD ( 1843200 / 16 )
assumes that you use 1.843200 MHz clock for your UARTs.
As this is not the case for your custom board, you should change BASE_BAUD properly.
For this you could create your own header file and include it from include/asm-ppc/serial.h
(I don't think modifying pc_serial.h is a good idea).

Best regards,
Andrei


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
