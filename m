Message-Id: <200007190813.KAA26199@denx.local.net>
To: clark@esteem.com
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Do I shoot myself in the foot first or HEAD.S? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Jul 2000 18:19:45 PDT."
             <1.5.4.32.20000719011945.006845c0@pop.esteem.com>
Date: Wed, 19 Jul 2000 10:13:11 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Clark,

in message <1.5.4.32.20000719011945.006845c0@pop.esteem.com> you wrote:
>
>         Any tips for a new guy? I just about ready to start trying to port
> linux to our custom MPC850 board.

Welcome aboard :-)

> 1. Is there a FAQ or Doc on porting the kernel to a new design? (please mail
> or direct me to it)

You mean additional to the sources? :-) See the HOWTO at
http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

> 3. What do I need to do in the ROM before jumping to HEAD.S other than
> programming the ram timmings in the UPM( I assume HEAD.S is where everything
> starts )?

This depends on which head.S you mean. If you're talking about
arch/ppc/mbxboot/head.S, then you're right (do NOT modify
arch/ppc/kernel/head.S!)

Yoou will have to  modify  either  your  boot  ROM  or  the  code  in
arch/ppc/mbxboot/ to work with each other.

If you have the option to use a different firmware, and if you can wait a day
I'd suggest you have a look at PPCBOOT; see http://ppcboot.sourceforge.net/.

I have a completely new, redesigned version of PPCBOOT. Right now I'm
typing some documentation to the new code; I'll put  it  on  the  CVS
server later this day.

Major changes:

* All the code in arch/ppc/mbxboot/ is now  obsolete,  since  it  has
  been  integrated  in  PPCBOOT.  You  need  a  serial driver for the
  monitor anyway to provide some sort of console  interface,  so  why
  duplicate this work in the Linux boot loader code?

  Now we don't need to build  zImage's;  instead  we  use  the  "raw"
  (usually compressed) Linux kernel in arch/ppc/coffboot/vmlinux.gz .

  ["usually compressed" because you can trade time for space, and use
  an uncompressed kernel - this needs more Flash memory, but  boots  up
  faster. The same is true for initrd images.]

* Linux kernel and ramdisk images are kept separate. You  don't  have
  to  rebuild  a  Linux  kernel  image  just to change a file in your
  initrd image. You can  run  the  same  kernel  image  with  several
  versions  of  initrd images. If you're designing a field-upgradable
  system, you have separated packages, etc.


Of course this is work in progress, with lots of  things  missing  or
not  ready (booting over ethernet is in the works, PCMCIA/IDE support
will follow, etc.).


> 4. Has any one managed to get an EST VisionICE in circuit emulator to work
> with linuxPPc? If so How? Would I be better off using the GNU Debuger?

I think it VisionICE should work fine for the monitor and boot loader
code; I don't think it will be really useful  for  the  Linux  kernel
with MMU turned on (please correct me when I'm wrong).

I'm using the Abatron BDI200 because this  fits  really  well  in  my
Linux  environment:  it speaks GDB remote protocol over ethernet, and
it supports the MMU for LInux, so you can even debug the Linux kernel
with it. And yes, the price is competitive, too.

I also use  the  MPCBDM  which  provides  nearly  the  same  features
(restrictions  on  type and bus interface for flash chip programming,
attaches to the parallel port so you need a LInux PC  close  to  your
target)  -  let  me  know if you're interested in this tool but don't
feel like building one yourself.

Wolfgang

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Lack of skill dictates economy of style.                - Joey Ramone

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
