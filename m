In-Reply-To: <v04003a04b3e7e12ecd82@[216.81.20.86]>
Date: Tue, 24 Aug 1999 11:06:02 +0200
To: Tony Mantler <eek@escape.ca>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Performa 5200
Message-Id: <19990824110602.000653@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 24, 1999, Tony Mantler <eek@escape.ca> wrote:

>I recently obtained for myself up a Performa 5200, and I've been playing
>with trying to hack linux into shape on it. (I'm usually a Mac68k guy)
>
>I compiled a kernel from a stock 2.2.10 tree that I have laying around
>(from ftp.kernel.org, most every config option turned off, booting with
>BootX) and, after sprinkling around a bit of debug code, found that it
>makes it past the prom.c code where it draws the "Welcome to linux
>[blahblah] booting...", but doesn't make it to start_kernel after that.
>
>I'm not particularily fluent in PPC ASM, so head.S makes fairly opaque
>reading for me. I'm wondering if someone might have some pointers to where
>this would likely be dying, so I have good a place to start?

is this a NuBus class machine or a PCI based one ? If it's a NuBus one,
then you are out of luck, or if you have time to spend, you can begin
porting linux/ppc to those beasts. (Basically, RAM is not contiguous and
you cannot rely in the kernel beeing loaded at physical 0, since the
frame buffer may be hard coded at physical 1Mb). Look at the various
parameters BootX pass for a NuBus machine (using the latest 2.1.12 kernel
from vger or Paul's rsync, you should have the latest bootx.h).


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
