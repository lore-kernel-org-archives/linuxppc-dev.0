Message-ID: <39F00B8C.3FB89991@agelectronics.co.uk>
Date: Fri, 20 Oct 2000 10:08:28 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Neil Russell <caret@c-side.com>
CC: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc_ide_md.insw
References: <39EEECA5.459D0C93@agelectronics.co.uk> <20001020013135.I21761@lx.c-side.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Neil Russell wrote:

> They are used by macros in include/asm-ppc/ide.h called "insw" and "outsw".
> I know they are called because I have traced them.  You can just fix the
> versions in the arch/ppc/kernel directory to do what you want.

I'm using the 2.2 bitkeeper kernel, and there are no macros in
include/asm-ppc/ide.h:
~/linux-bk/linuxppc_2_2> grep insw include/asm-ppc/*
grep: include/asm-ppc/SCCS: Is a directory
include/asm-ppc/ide.h:        void        (*insw)(ide_ioreg_t port, void
*buf, int ns);
include/asm-ppc/ide.h:void ide_insw(ide_ioreg_t port, void *buf, int
ns);
include/asm-ppc/io.h:#define insw(port, buf, ns)	_insw_ns((unsigned
short *)((port)+_IO_BASE), (buf), (ns))
include/asm-ppc/io.h:extern void _insw(volatile unsigned short *port,
void *buf, int ns);
include/asm-ppc/io.h:#define insw_ns(port, buf, ns)	_insw_ns((unsigned
short *)((port)+_IO_BASE), (buf), (ns))
include/asm-ppc/io.h:extern void _insw_ns(volatile unsigned short *port,
void *buf, int ns);

> Normally, there is logic to convert 16-bit accesses from a CPU into a pair
> of 8-bit accesses for IDE (a hangover from the ISA bus).  Our hardware does
> this but I'm not entirely convinced that this is necessary.  Anyhow, if you
> are using one of the PPCs in the 8xx family, or the 8260 you can define a
> chip select line for IDE that has an 8-bit bus width, obviating any need
> to change software.

I've got a CF card on PortX of an MPC107. The MPC107 breaks the 16-bit
read into two 8-bit reads, in the wrong order. This is not a simple
endianness problem, as this ordering doesn't correctly advance the
internal counter of the CF card.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
