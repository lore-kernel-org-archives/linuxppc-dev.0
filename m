Message-ID: <38C3564E.4A46F577@amberdata.demon.co.uk>
Date: Mon, 06 Mar 2000 06:55:10 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: userland port io - how do we do it on PReP?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Hope this isn't an FAQ.

I've struck a problem in the X server world - I can't seem to get port
IO (ie inb()) to work.

There are two problems - one is that there doesn't seem to be an
equivalent to ioperm() or iopl() to enable access to the IO ports.
Second is that for MBX and APUS machines the offset to the io port space
appear to be constants, but for other systems we seem to have an
external variables isa_io_base, isa_mem_base and pci_dram_offset. Does
that really mean that programs which do port IO on these systems must
declare and initialize these varibles before doing port IO? And that
MBX, APUS and other systems need different binaries as a result? And
that if /usr/include/linux/autoconfig.h doesn't match the target system
bad things will happen?

The following program doesn't work on my IBM 850:

#include <stdio.h>
#include <asm/io.h>

unsigned long isa_io_base = PREP_ISA_IO_BASE;

main()
{
        int x;

        x = inb(0x3CC);

        printf("x = 0x%02x\n");
}

It just dumps core.

Help?

Cheers,

        David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
