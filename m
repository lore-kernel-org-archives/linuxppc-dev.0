Message-ID: <40718E56.9060503@ru.mvista.com>
Date: Mon, 05 Apr 2004 20:50:30 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: =?windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Losing my console messages !!
References: <85E6ED5B5EC32F439702305CC417E12D9E2A62@email.3il.fr>
In-Reply-To: <85E6ED5B5EC32F439702305CC417E12D9E2A62@email.3il.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Garcia Jérémie wrote:
... skipped ...
> I noticed the presence of two "#define" which seem to be important but it's hard to me to understand how they really act:
> include/asm-ppc/pc_serial.h -->   #define BASE_BAUD ( 1843200 / 16 )
> arch/ppc/boot/common/ns16550.c--> #define SERIAL_BAUD	9600
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
