To: Julien Eyries <julien.eyries@thales-bm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX boot loader on a MPC8260 custom board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Mar 2002 11:53:23 +0100."
             <3C99BBA3.8090703@thales-bm.com>
Date: Thu, 21 Mar 2002 12:18:02 +0100
Message-Id: <20020321111807.9BC64109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Julien,

in message <3C99BBA3.8090703@thales-bm.com> you wrote:
>
> the kernel we have build is based on the ADS8260 board which is quite
> similar to our board.

Well, is your firmware also similar  to  that  on  the  ADS8260?  The
bootstrap loader provides the interface between firmware and kernel -
so it must match BOTH sides for a given board.

> the boot-loader we use is the "mbx" boot loader which come with the
> Linux kernel tree.

Ummm... did you adap this for your board?

> - at some point in this function "serial_init" , the PC (program
> counter) begins to count downwards !!! for exemple ( 0x400000 ...
> 0x3ffffc ... 0x3fff8 ...  )

This just means you crashed the CPU.

> another point is: when debugging C source code (in emacs + gdb),
> we can see that the programms jumps from one point to another (some
> times backward) , not following the logical flow of the C source code
> .Is that normal ????

With optimized code, yes.  The  compiler  does  several  things  when
optimizing  which  can change the order of the assembler instructions
from what you might expect when reading/writing  C  code.  The  "jump
around" is the consequence.

> what could be the reason of such behaviour ???

Optimization performed by the compiler.

> does someone here have an idea for our problem ?????

Well, my recommendation is to get rid of all this stuff in the mbxbot
directory and use PPCBoot as  firmware  instead;  but  I'm  obviously
biased, and YMMV.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"He was so narrow minded he could see through  a  keyhole  with  both
eyes ..."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
