Message-ID: <885489B3B89FB6449F93E525DF78777F064522@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: "'Joe Hamman'" <joe.hamman@embeddedspecialties.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MMU on the power pc 860 
Date: Thu, 2 Jan 2003 10:10:32 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


which version of the visionClick you are using?  My vision click is version
7.4A, and the firware version for the visionICE II is vn1.5a. When I enter
the command you have recommended, I got syntax error

>BKM>CF MMU LINUX
!ERROR! - [msg31000] Syntax error in message cf mmu linux
>BKM>cf mmua
!ERROR! - [msg31000] Syntax error in message cf mmua
>BKM>
!ABORT! - [msg72000] User Command Abort
>BKM>

Thanks

Cecilia

-----Original Message-----
From: Joe Hamman [mailto:joe.hamman@embeddedspecialties.com]
Sent: Sunday, December 22, 2002 8:01 PM
To: Muaddi, Cecilia
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MMU on the power pc 860


Hi Cecilia,

The comment on the Vision* tools' MMU support is incorrect.  The visionICE
II and visionPROBE II support up to four regions of
translation.  You need to enter the details manually:

BKM>CF MMU LINUX
BKM>CF MMUA C0000000 0 FF000000

Use the CF MMUL to list the translation table entries currently defined in
the tool.  You can get the details from WRS.  This will
allow you to use visionCLICK (or SingleStep w/vision) to debug anything
statically linked into the kernel, from address 0 through
init.

Unless you have specific reasons not to switch, I recommend using the U-Boot
bootloader.

Regards,
Joe


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
Denk
Sent: Saturday, December 21, 2002 2:59 PM
To: Muaddi, Cecilia
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: MMU on the power pc 860



Dear Cecilia,

in message <885489B3B89FB6449F93E525DF78777F06451E@srvnt506.ALLOPTIC.COM>
you wrote:
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

> I was able to use the VisionICE BDM to single step, and see it does jump
to
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
