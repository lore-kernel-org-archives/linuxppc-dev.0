To: markc@mail.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Control-C in bash ??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Jan 2003 14:09:00 EST."
             <200301131409.00113.markc@mail.com>
Date: Mon, 13 Jan 2003 20:30:57 +0100
Message-Id: <20030113193102.E7B7CC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200301131409.00113.markc@mail.com> you wrote:
>
> I have an MPC860 running 2.4.19, with a mostly unmodified eldk distribution
> from Wolfgang Denx.  I did modify the init script to use /dev/console instead
> of /ttyx (standard driver using SMC1).  I'd not only like a solution, I want

This is the old ELDK, then? The current version includes

	3:2345:respawn:/sbin/mingetty --noclear console

and a fix for the ^C problem....

> to undertand how cancelling a shell command is supposed to work  - I've poked
> around and I can't figure out what's supposed to happen - Does the shell
> generate a SIGINT, or the uart driver, or what?  Any enlightenment will be
> greatly appreciated...

You need a controlling terminal. We modified  login:  to  set  it  as
needed.  See  the previous thread ("RAMDISK IMAGES(2): ash has no job
control").

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are three principal ways to lose money: wine, women,  and  en-
gineers.  While  the first two are more pleasant, the third is by far
the more certain."                      -- Baron Rothschild, ca. 1800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
