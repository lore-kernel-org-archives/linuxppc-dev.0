Message-ID: <38EFCCD9.6263E7F9@denise.shiny.it>
Date: Sat, 08 Apr 2000 20:20:41 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: DeRobertis <derobert@erols.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: stty crtscts < /dev/ttyS1
References: <l03130302b4fd80d3a908@[216.164.130.191]>
	 <l03130304b50c8e1b783f@[216.164.131.253]> <l03130302b5145fe8d18f@[209.122.247.115]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >What is connected to the serial port ?  When I enable RTS/CTS on ttyS1
> >and there is my Epson 740 attached, the whole system freezed.
>
> Same thing attached.

It could be a bug in the serial driver, but I don't think so. BeOS hangs
same way (although it's likely Be people "ported" Linux code into BeOS...).
I spent a couple of days around the serial driver and I didn't find any bug.
BTW under MacOS it works fine :-/  so what ???

> >I don't
> >know why this happen exactly. It seems that the printer changes continuosly
> >with very high frequency  the state of CTS, which cause the serial driver
> >to loop indefinitely.
>
> Ouch! Broken hardware... how can I document this is happening, so that
> I can demand an answer from Epson ?

To print under Linux I wrote a small prg which sends data to the printer very
slowly bacause I couldn't find a way to know when the printer buffer gets
filled. Somewhere at Epson (about older printers) I read that it should use
starndard rts/cts flow control.
Ah, I send data at 230400bps 8N2 (*2* stop bits) because the printer don't
seem to be able to receive data so quickly (again, no problems with 8N1
under MacOS).

> Or maybe I should just hack the serial driver to ignore this.

:-6

> And WTF
> is the serial driver doing looking at CTS on a port with no data?!

CTS changes cause and interrupt.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
