Message-ID: <001b01bff7e1$ab6b4720$640a0a0a@server>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: MPC8xx-2.2.13 kernel and Framebuffer support: cannot compile!
Date: Thu, 27 Jul 2000 17:43:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I trying to develop a simple framebuffer driver for my MPC823FADS Video
analog output, but when i modify the kernel to include the any frame buffer
device driver, the compilers reports me:

   powerpc-linux-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/Main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        arch/ppc/math-emu/math-emu.o fs/filesystem.a net/network.a
drivers/block/block.a drivers/char/char.a drivers/misc.misc.a \
        drivers/net/net.a drivers/machintosh/machintosh.a
arch/ppc/8xx_io/8xx_io.a drivers/net/net.a\
        LinuxPPC/mpc8xx-2.2.13/lib/lib.a --end-group -o vmlinux

    init/main.o(.data.init+0x64): undefined reference to 'video_setup'
    drivers/char/char.a(mem.o): In function 'chr_dev_init':
    mem.o(.text.init+0x40): undefined reference to 'fbmem_init'
    mem.o(.text.init+0x40): relocation truncated to fit R_PPC_REL24
fbmem_init
    make: *** [vmlinux]  Error 1

Why this?

I enabled the voice "General setup/Support for frame buffer devices" ,
enabled the voice "Console drivers/Virtual Frame Buffer support" and run
"make clean; make zImage".

Is it needed a patch to fix this? What can i do?
I cannot use other kernels because of my FADS board (not supported by
HardHat and similars).

Thanx in advance!

- MAY THE PINGUIN B WITH U -

Thanx,
Paolo Scaffardi
AIRVENT SAM s.p.a - RIMINI (ITALY)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
