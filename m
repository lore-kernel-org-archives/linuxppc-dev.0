To: Kapil Konde <kapilkk@yahoo.com>
Cc: linuxppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Error loading kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 08 Aug 2001 19:35:39 +0530."
             <3B714732.E4D67708@yahoo.com>
Date: Wed, 08 Aug 2001 16:17:34 +0200
Message-Id: <20010808141739.A3A1410CB9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3B714732.E4D67708@yahoo.com> you wrote:
>
>         When I load the rtlinux kernel on my mpc860 mdppro board using
> debugger and try to boot kernel it gives me error "bad gzipped data".
> Can anybody please tell me what is this error. And what I may be doing
> wrong.

You cannot just load and run the kernel in the debugger.

The kernel, when started, expects  that  certain  hardware  initiali-
zation has been performed, and certain parameters are being passed to
it. You _can_ do this with the debugger, but you have to know EXACTLY
what you're doing.

IMHO it's much easier to let your firmware (PPCBoot ?) load and start
the kernel. Only then take over control with the  debugger.  An  easy
way to do this is to set a breakpoint on the address range 0xC0000000
... 0xD0000000. That way the debugger will halt the execution as soon
as the kernel has turned on the MMU.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
He'd heard her use that sweet, innocent  tone  of  voice  before.  It
meant that, pretty soon, there was going to be trouble.
                                        - Terry Pratchett, _Truckers_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
