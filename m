To: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial line bug? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Sep 2002 17:01:24 +0200."
             <CA78D1B723D8D411AF0300508BDCF74FDEFF5C@NTCORREO>
Date: Sat, 28 Sep 2002 11:56:08 +0200
Message-Id: <20020928095613.A1AE9FA8F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

since you haven't received any better replies yet, I'll try  to  jump
in:

In message <CA78D1B723D8D411AF0300508BDCF74FDEFF5C@NTCORREO> you wrote:
>
> We have configured the kernel to have those two serial lines, ttyS0 on SMC1
> using BRG1 and ttyS1 on SCC2 using BRG2. Doing this, ttsyS1 doesn't work.

The serial port configuration is pretty ugly; you may either have  to
edit  uart.c and adjust rs_table[] manually, or you have to keep smc2
enabled and access scc1 as ttyS2.

> This has a terrible efect:  m8xx_cpm_setbrg function does a 0 division
> operation and modifies brgc2 value to 0x3ffff.
>
> We have done the following modification in the m8xx_cpm_setbrg function

Thanks for pointing this out.

> Also, we have realized that changing the BRG number of first serial line,
> that we use as system console, from BRG1 to BRG2 or BRG3, the kernel
> crashes.

The BRG table and the rs_table[] must always kept in sync; as  stated
before, serial port configuration is ugly.

> We have a last question. Our board has Ethernet on the SCC3, and this is not
> compatible with the SMC1. We know that we have to install SMC microcode
> patch.
>
> Do we have  to  modify the uart.c file to support the microcode patch? (we
> think yes, but we don't know how)

Yes - you have to adjust for the  modified  parameter  RAM  addresses
(offsets). We could help you with that if you have problems, but this
is  more work than we can offer for free, so feel free to let me know
if you're interested in a commercial quotation.

Best regards,

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Uncontrolled power will turn even saints into savages. And we can all
be counted on to live down to our lowest impulses.
	-- Parmen, "Plato's Stepchildren", stardate 5784.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
