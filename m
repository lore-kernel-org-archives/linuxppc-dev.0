To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory map with "holes"... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Aug 2003 14:32:09 +0200."
             <200308121432.09782.david.jander@protonic.nl>
Date: Tue, 12 Aug 2003 16:13:27 +0200
Message-Id: <20030812141332.496E2C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200308121432.09782.david.jander@protonic.nl> you wrote:
>
> We are designing a board based on the MPC852T (MPC866 serivate), and
> I want to make sure there is the possibility to mount different-size
> SDRAM chips on it, so I just connect the two bank-select pins to some
> higher address lines, leaving some out in between, in order to acomodate
> for bigger chips in the future. The bottom line is that I will get the
> memory map split up into 4 segments with vast holes between each segment
> that are undefined. What do I need to keep in mind regarding linux
> about this? I suppose it isn't an issue, but I want to be sure I don't

This is not an issue, as Linux does not care about  the  organization
of  your  memory.  It  just  expects some amount of contiguous memory
stating at address 0.

> get any trouble later. Any experience with memory holes? I suppose the
> boot-loader should tell the kernel about the memory-map, in a way just
> like lilo on an x86 machine, am I right? Does this work the same way on

No. There will not be any "holes". It is up  to  your  bootloader  to
program  the  memory controller of the MPC8xx such that there is just
one contiguous piece of memory. See U-Boot for example code how to do
that (including auto-sizing routines and all the rest).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Success in marriage is not so much finding the right person as it  is
being the right person.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
