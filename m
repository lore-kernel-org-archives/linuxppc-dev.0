To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MMU on the power pc 860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 Dec 2002 11:01:43 PST."
             <885489B3B89FB6449F93E525DF78777F06451E@srvnt506.ALLOPTIC.COM>
Date: Sat, 21 Dec 2002 21:59:00 +0100
Message-Id: <20021221205905.1518EC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Cecilia,

in message <885489B3B89FB6449F93E525DF78777F06451E@srvnt506.ALLOPTIC.COM> you wrote:
>
> I am porting the timeSys Linux to a custom Power PC 860 board.  Our board
> currently runs
> windRiver VxWorks.  I have modified the VxWorks bootrom to allow me to
> download a motorola
> hex record, and I have modified the timeSys bootcode
> arch/ppc/boot/mbx/misc.c:decompress_kernel

This is the generic Linux bootstrap loader, it has nothing to do with
TimeSys.

> loaded at:     00400000 0040C30C
> board data at: 004001C0 004001E4
> relocated to:  0040C0E8 0040C10C
> zimage at:     0040C30C 004BC440
> avail ram:     004BD000 00800000
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This loos strange to me. Didn't you map RAM to 0x0000?

> I was able to use the VisionICE BDM to single step, and see it does jump to
> the address 0, and
> begin execute the instruction in kernel/arch/ppc/kernel/head_8xx.S:_start

You will not get far  with  the  Vision*;  better  use  a  tool  that
understands the MMU, like the Abatron BDI2000.

> I think the MMU TLB setup I have is not exactly correct, since the vxWorks
> BOOTROM does not
> initialize any MMU registers.  Can someone tell me if I need to initialize
> the M_TWB register for the

MMU should be switched off when starting Linux.

> to be the value for this register?  My physical memory map consists of RAM
> at location 0 to 0x1ffffff

This is not what I see above.

> and my IMMR is set to 0x2b00 0000

And this is plain wrong. The IMMR _must_ be mapped above 0xF0000000.



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Use C++ to confuse your enemies; use C to produce stable code.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
