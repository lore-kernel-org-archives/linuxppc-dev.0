Message-ID: <3B55BF9A.7020009@mvista.com>
Date: Wed, 18 Jul 2001 09:55:54 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Nguyen Trung Thanh <jari.nguyen@serialsystem.com.sg>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Nokia Cardphone 2.0 for MPC823
References: <3B52C152.F5FB58B7@genetel.co.kr> <000901c10df4$f1e85100$df0fa8c0@mystore> <3B532093.4010004@mvista.com> <003601c10e93$7f5a72e0$df0fa8c0@mystore>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nguyen Trung Thanh wrote:

> Hi Matthew Locke,
> Thank you very much for your reply.
>
> As you said, I moved to the newest version of Pcmcia Card Service which I
> could find from ftp.mvista.com
> Its version is 3.1.24.. I don't know it is good enough or not.
>
> Of course, I changed something to avoid conflicts between 8xx serial driver
> (uart.c) and serial.c.
> I mapped the _IO_BASE 0x80000000, hardcode irq = 9.
> Then it worked well with PCMCIA modem such as Xircom.
>
> Now I could use this version with Nokia Cardphone2.0, but the result is the
> same.
> I just wonder why this PCMCIA cardphone can run smoothly in a Sony VAIO
> laptop using this version of linux kernel 2.2.14 and pcmcia-3.1.24, but when
> I run it with my board, I must add some delay in function receive_chars in
> file: serial.c.
> Otherwise, I'd receive a lot of gabage charaters. For example:
> I wrote a string "ATZ" , and then received:
> "aATZOKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> instead of "ATZOK"???
>
> Would you pls tell me what is the problem here?
> I think that it is due to the timing of 16550A chip, is it right?
> Or it is due to the serial speed?


yeah, it could be some sort of timing issue, but I am not looking at the
specs for any of those parts.

> If you have any idea about my problem, pls tell me...
>
> Thanks for you kindness,
> Jari
>
>
>>Nguyen Trung Thanh wrote:
>>
>>
>>>Hi all,
>>>
>>>Pls help me, I'm stuck with this card.
>>>Now I used kernel Powerpc Hardhat 2.2.14,
>>>and pcmcia-cs-3.1.21 in a custom board using
>>>MPC823.
>>>
>>
>>You should consider moving to 3.1.26, many bugs have been fixed.
>>
>>
>>>I could dial up with this card, but it is not stable,
>>>and I could not transfer data such as ftp....
>>>
>>>Furthermore, I must set the maximum value for
>>>psst = 4, psht = 4, and psl = 20.
>>>and add some delay between each time I read from serial port ( in
>>>
> function
>
>>>receive_chars from file serial.c).
>>>
>>
>>In general, there are conflicts between 8xx serial driver (uart.c) and
>>serial.c.  They may be stepping on each other.
>>
>>
>>>Have anyone done it, before? Or you have any information about thi card
>>>phone, pls give me.
>>>
>>>Does this card use 16550A, and follow the standard of this chip?
>>>Is there any special thing about it spec, timing?
>>>
>>>Thanks very much,
>>>Jari
>>>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
