Message-Id: <200406141752.AZK02995@sentinel.ucr.edu>
From: "Steve Kaiser" <steven.kaiser@ucr.edu>
To: "'saurosalomoni'" <saurosalomoni@bol.com.br>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Lite5200 from RS232 to RS485
Date: Mon, 14 Jun 2004 10:53:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <HZ5CEE$AB58D6D6E1D4B27E5EB20145E6922465@bol.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I need to switch between RS232 and RS485 in my Lite5200,
>  but I realized it's a little bit more dificult than I
> thought at first...
> Well,  as far as I'm concerned, I can do that just by
> controling the RTS pin of my ttyS0 device to activate
> the 485 module (is it 100% right?).

There are ways to enable an RS485 transceiver without the extra I/O
control line.  The transceiver needs to be enabled only during
transmission (i.e from your Lite5200 to the outside world), and if your
output differential pair is pulled up (normally the case I believe),
then only during a transmission of a zero as well.

The way to accomplish this is with a one-shot and a diode.  Use the xmt
line to low-active trigger the one-shot, and (via the diode) also pull
the one-shot's threshold low, effectively holding the output high.  Set
the timing of the one-shot for 1/2 the maximum bit time you need (ex: at
115.2 baud, set it to 56us).  The one-shot output then is an inverted
and extended version of your xmt line, and perfect for enabling the
transceiver.  Also perfect for disabling the receiver at the same time.

See B&B Electronics [ http://www.bb-elec.com/ ] as one place I know of
that sells RS232 - RS485 coverters off-the-shelf using this method if
you don't want to build your own.  There are schematics on their site
from which you can glean more info to build your own.  If am not a fan
of one-shots, but in this case they are suitable.

Steve Kaiser
UCR Chem Electronics Shop


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
