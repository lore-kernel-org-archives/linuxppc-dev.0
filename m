Date: Mon, 6 Mar 2000 08:25:49 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: userland port io - how do we do it on PReP?
In-Reply-To: <38C3564E.4A46F577@amberdata.demon.co.uk>
Message-ID: <Pine.LNX.4.05.10003060821360.19293-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 6 Mar 2000, David Monro wrote:
> Hope this isn't an FAQ.

Yes it is :-)

> I've struck a problem in the X server world - I can't seem to get port
> IO (ie inb()) to work.
>
> There are two problems - one is that there doesn't seem to be an
> equivalent to ioperm() or iopl() to enable access to the IO ports.
> Second is that for MBX and APUS machines the offset to the io port space
> appear to be constants, but for other systems we seem to have an
> external variables isa_io_base, isa_mem_base and pci_dram_offset. Does
> that really mean that programs which do port IO on these systems must
> declare and initialize these varibles before doing port IO? And that
> MBX, APUS and other systems need different binaries as a result? And
> that if /usr/include/linux/autoconfig.h doesn't match the target system
> bad things will happen?

That's all true, unfortunately.

> The following program doesn't work on my IBM 850:
>
> #include <stdio.h>
> #include <asm/io.h>
>
> unsigned long isa_io_base = PREP_ISA_IO_BASE;
>
> main()
> {
>         int x;
>
>         x = inb(0x3CC);
>
>         printf("x = 0x%02x\n");
> }
>
> It just dumps core.

It's even more complicated. You don't have to say

    unsigned long isa_io_base = PREP_ISA_IO_BASE;

only, you have to mmap the I/O port region at offset PREP_ISA_IO_BASE in
/dev/mem and store the resulting virtual addres in isa_io_base. After that
it'll work.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
