To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PWM on the MPC850 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Dec 2002 14:55:42 +0100."
             <IGEFJKJNHJDCBKALBJLLAELKFIAA.joakim.tjernlund@lumentis.se>
Date: Wed, 11 Dec 2002 15:54:24 +0100
Message-Id: <20021211145429.18D5BC613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <IGEFJKJNHJDCBKALBJLLAELKFIAA.joakim.tjernlund@lumentis.se> you wrote:
>
> > But be warned: do NOT use any of the port B pins for I/O  in  such  a
> > setup. There is a race condition within all MPC8xx CPUs.
>
> hmm, we access a few port B I/O pins from user space. What/where is the
> race in kernel?

I should add that it is non-trivial to work around this issue. We had
a case where even the short spikes on the output caused by this  race
condition  were not acceptable. The only way to make this work was to
disable the PWM timers (and wait for them to shut  down  -  which  is
another  issue)  before moifying the port B data, and then start them
up again. Of course this is unacceptable when you need high precision
PWM signals (but the you would not use a MPC8xx RISC timer anyway).

My recommendation is: never, ever use the RISC timers if you need  to
know hwat's going on on port B.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Free markets select for winning solutions."        - Eric S. Raymond

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
