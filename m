To: "Jason Park" <jason@amadeus.kist.re.kr>
Cc: "LINUX MAILING LIST" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Still having problems trying to get it to boot: PPCBOOT, MPC8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Feb 2003 17:12:08 +0900."
             <000c01c2cc25$2ee65b20$5e207aa1@fish>
Date: Tue, 04 Feb 2003 09:29:05 +0100
Message-Id: <20030204082910.650EFC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000c01c2cc25$2ee65b20$5e207aa1@fish> you wrote:
>
> 2)unpacked the source for PPCBOOT, my board is specifically the ep8260.
> since it has a HRW set to boot from location 0xfff0000 in flash, i change
> the appropriate starting location in the config.mk file for PPCBOOT then I

Please explain what you changed; the config.mk for the  ep8260  board
reads "TEXT_BASE = 0xFFF00000" which looks OK to me.

> 4)at prompt, i type in "reset", then "go" and it throws me into debug mode.
> (or "go 0xfff00000")

Type "reset" and "info" and check where the PC is  pointing  to.  You
may  have  a  problem with your BDI's config file so the CPU does not
get stopped immediately after a reset, but  only  after  some  delay.
This  might explain that "reset" and "go" does not work. Also, please
note that  thge  reset  entry  point  is  at  offset  0x100,  so  "go
0xfff00000" is definitely wrong - try "go 0xfff00100" instead.

Another test: disconnect the BDI, and power-cycle the board.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Vor allem kein Gedanke! Nichts ist kompromittierender als ein  Gedan-
ke!            - Friedrich Wilhelm Nietzsche _Der Fall Wagner_ (1888)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
