To: BREUVART Jean-Charles <jean-charles.breuvart@airbus.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: building lilo, grub or PPCBoot for a custom board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Jan 2003 14:58:53 +0100."
             <36EB27C27D93D4119DE500508BDF85B30B2D7178@TOCOMEXC03>
Date: Fri, 17 Jan 2003 16:31:06 +0100
Message-Id: <20030117153111.89695C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jean-Charles,

in message <36EB27C27D93D4119DE500508BDF85B30B2D7178@TOCOMEXC03> you wrote:
>
> I' succedded in building denx-eldk from rpm packages on my RedHat 8.0
> (thanks wolfgang !), and then a 1st linux kernel that I'd like to download
> via the VME into the FLash ROM.

We didn't try to _build_ the ELDK under RH-8.0 yet. Did you encounter
any problems? All feedback about required changes for building  under
RH-8.0 etc. is welcome!

> So I'm trying to build a cute boot loader (for linux of course !) for my
> custom board :

As Jerry Van Baren already pointed out: use U-Boot :-)

>  - VME64x based
>  - PCC755 without L2 cache
>  - no PCI bus
>  - 2Mo Flash 29DL163 at 0xFFE00000
>  - 128 Mo SDRAM at 0x0000000
>  - a simple UART
>  - some analog I/Os

Should be pretty straightforward, it seems.

>  - where and how to introduce the arch dependent source code in the source
> tree of those boot loaders ?

In U-Boot you will create a board specific configuration file in  the
include/configs/  directory  and  board specific source files, linker
script etc. in a new directory board/<your_board_name>

>  - how to configure the Makefile to build a light exe ?

You can enable / disable features in the board specific config file.

>  - how to configure the linker command file or ld swithes for a particular
> mapping ?

See the existing linker scripts as a model. I guess the  easiest  way
to get started is to "clone" some similar board directory ...

See the README that comes with the source. If you have questions, ask
on the u-boot-users mailing list.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Where would we be without rhetorical questions?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
