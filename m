To: ADharankar@attbi.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Relocating PPCBoot into SRAM 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 16 Feb 2003 12:54:35 EST."
             <200302161254.35753.ADharankar@ATTBI.Com>
Date: Sun, 16 Feb 2003 19:37:32 +0100
Message-Id: <20030216183737.ABAE0C5E20@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200302161254.35753.ADharankar@ATTBI.Com> you wrote:
>
> - On MPC75x and MPC7410 boards with MPC8260 in companion
>   mode, SRAM on 1M and 2M respectively are available.
>
> - Is it possible to relocate PPCBoot to this SRAM mapped
>   as private memory? Note that, this is a second relocation;
>   the first would already have occured when it is relocated
>   from Flash to SDRAM.

This makes little sense to me. If you want to run  U-Boot  /  PPCBoot
from SRAM, then relocate it to that memory in the first place.

> - And if this possible, a re-relocation from SRAM back to
>   SDRAM?

Well, _everything_ is possible. But it is not wise  to  do  (or  try)
everything.
>
> If this is possible, what needs to be done? The idea I
> would like to explore is to do a full memory test (walking
> bit, aligned/non-aligned access, refresh, alternating
> pattern, random pattern test - basically extensive testing)
> without executing PPCBoot in SDRAM.

You don't have to do is that complicated. There are many easier ways,
for ewxample: You can implement your memory  test  (which  should  be
non-destructive) as a U-Boot standalone application which gets loaded
into and started from SRAM. No nood to relocate U-Boot at all.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded World, Nuremberg, Feb 18-20, Hall 12.0 Booth 12-442

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
