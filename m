To: "Doug Hubbard" <dhubbard@scires.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Downloading and Debugging linux / programs via BDM 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Aug 2001 18:27:28 EDT."
             <sb781c1a.090@mail.scires.com>
Date: Tue, 14 Aug 2001 00:37:07 +0200
Message-Id: <20010813223713.09EAE10CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <sb781c1a.090@mail.scires.com> you wrote:
>
> I am fairly new to embedded Linux.

Welcome.

> 7.0 and I am using the tools provided with the RH EDK along with the
> BDM dongle and software from Macraigor Systems.

AFAIK the Macraigor dongle does not support the MMU; you  cannot  use
it to debug Linux.

> What is the procedure for getting Linux downloaded to the board
> (via BDM) and started, then getting my program(s) downloaded and
> started and attaching the debugger (ddd/gdb) to the desired program?

You should be aware that you cannot simply download  a  Linux  kernel
image  to  some  board  and  run  it. Linux expects a lot of hardware
initialization to be done before it runs, and some parameters  passed
to it.

> The initial target is a Motorola MBX board with an MPC860 ppc processor,
> the ultimate target is a custom board utilizing the same processor.

First, get a BDM debugger that understands to use the MMU,  and  that
can  be used in a Linux environment. My recommendation is the BDI2000
by Abatron. See http://www.abatron.ch

Then,  install  some  Linux-friendly  firmware  on  your  board.   My
recommendation  is  PPCBoot.  See  http://ppcboot.sourceforge.net and
ftp://ftp.denx.de/pub/ppcboot/ . The  MBX860  board  is  one  of  the
standard configurations of PPCBoot and should run out of the box.

Finally, use PPCboot to load the kernel image and start it  with  the
right  parameters,  and  use GDB to connect to your BDI2000 and debug
the running Linux kernel.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have the simplest tastes.  I am always satisfied with the best.
                                                       -- Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
