To: "Dejan Jovanovic" <dejanj@erlangtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8260 serial on SCC support 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Oct 2002 10:58:12 CDT."
             <006c01c27aac$fda185e0$db00000a@dejanj>
Date: Wed, 23 Oct 2002 19:44:26 +0200
Message-Id: <20021023174431.DC9601014B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <006c01c27aac$fda185e0$db00000a@dejanj> you wrote:
>
> > > Is there support for serial console on SCC for MPC8260 in latest kernel
> > > distributions included in the ELDK or kernel version on the
> ftp://ftp.denx.de?
> >
> > Yes, of course. See arch/ppc/8260_io/uart.c
>
> Serial is configured once I configured CONFIG_CPU86.

Keep in mind that this is a  board-specific  configuration  which  is
intended  for  the MicroSys CPU86 board only. If it actually works on
your hardware you are really, really lucky.

> After the 'starting xinetd' is completed sucessfuly, my serial output is stuck.
> However I can telnet to my board.
> This means that there is some problem with the serial? (maybe 'getc' or
> something like this).

Usually it just means that your console is not where  you  configured
it. For example, on the CPU86 board you include this code:

...
#elif   defined(CONFIG_CPU86)
#define CONFIG_SERIAL_CONSOLE_PORT      2
#else
...

which maps to SCC2. Do you really have your console port on SCC2?


I think it is generally a BAD idea to copy some  board-specific  code
without  checking CAREFULLY what you're doing. You tried, and you got
what you deserved: a non-working system ;-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Weekends were made for programming.                 - Karl Lehenbauer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
