To: Arun Dharankar <ADharankar@ATTBI.Com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial console ports on systems with no console connected. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 21 Jul 2002 15:10:36 EDT."
             <200207211510.36128.ADharankar@ATTBI.Com>
Date: Mon, 22 Jul 2002 09:03:50 +0200
Message-Id: <20020722070355.EC9F310874@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Arun,

in message <200207211510.36128.ADharankar@ATTBI.Com> you wrote:
>
> The conclusion for my case is that the RTS/CTS. DSR/DTR and
> DCD need to be null modem'd. Working around by ignoring the
> flow control  (as I mentioned in earlier port) also is workable for
> me because I know which port is the console, and we dont
> have a need for the other serial port for any other use.

This makes little sense to me.

You mentioned before that you're on a 8260, using SMC1 and  SCC4  for
serial ports:

> The board has SCC4 and SMC1 based serial ports. I have
> tried both of these as console ports under Linux and PPCBOOT.
> PPCBOOT code is unmodified (as it is from the distribution) for
> SCC4 and SMC1 code. The Linux code is unmodified for
> SMC1, and I see this behavior in case of both these serial
> ports.

Well, I don;t know what you did to support SCC4  in  the  Linux  UART
driver,  and  if you added HW flow control there. The standard driver
does not contain any HW flow control.

And the SMC port does not even provide a chance to implement HW  flow
control since it has no handshake signals at all.

How can you null modem RTS/CTS, DSR/DTR  and  DCD  signals  if  there
aren't any such signals on the port?

I'm confused.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I am a computer. I am dumber than any human and smarter than any  ad-
ministrator.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
