Date: Thu, 2 Oct 2003 08:12:01 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stuart Vivian <stuartvivian@domo.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2_4_devel kernel hangs after control transferred from u-boot
Message-ID: <20031002081201.A2929@home.com>
References: <A4EB77D93A60F347A518AC05291647D9032E5E@domosvr1.domo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A4EB77D93A60F347A518AC05291647D9032E5E@domosvr1.domo.local>; from stuartvivian@domo.co.uk on Thu, Oct 02, 2003 at 02:29:18PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 02, 2003 at 02:29:18PM +0100, Stuart Vivian wrote:
>
> Hi all,
>
> I am trying to get a linux kernel to build and run on a Cogent CSB272
> (IBM PPC 405GP processor) running a U-boot 0.4.0 bootloader. I can tftp
> a uImage into ram and it passes check, but when I run bootm it
> uncompresses the kernel and hangs after it starts executing the kernel
> at address 0x00000000.
>
> I was given a hardhat vmlinux elf file that I can package to a uImage
> and run (although it stops at the Calibrating Delay loop... Stage, but
> that's another issue). I need to be able to recompile a kernel for the
> board and downloaded linuxppc_2_4_devel from mvista. This compiles fine
> and produces a new vmlinux. I've started off by using the walnut 405
> config file to build the kernel, since they're pretty similar.

Hrm, it used to be that everybody said their board was "just like
a Sandpoint".  I guess walnut is like that in the 4xx world. :)

At any rate, you need to "port" the kernel to your specific board.
There are many board-specific parameters/devices that have to be
accounted for.  The first thing that you are running into is that
a Walnut kernel has code to set clocking to use the external clock,
in addition it expects to get it's timer frequencies passed into the
kernel in the board info pointer...are you providing the correct
info?  See arch/ppc/kernel/ppc4xx_setup.c and
arch/ppc/platforms/walnut.c...then go from there.

> Any ideas where to start debugging this? I'm relatively new in embedded
> stuff and linux in general, so it might be something simple, but don't
> know where to start. Have a BDI2000 but no gdb driver yet, so can't put
> in breakpoints etc.

For early bringup, it's far easier to just use the telnet interface
and keep a window or two handy to look at the vmlinux disassembly
and grep for important symbol addresses like log_buf.  Every developer
I work with does new board bringup and they never use gdb on top of
the BDI.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
