Date: Tue, 13 Nov 2001 15:59:56 -0800
From: Steven Mueller <diffusor@ugcs.caltech.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ppc 405 floating point math emulation
Message-ID: <20011113155956.B7553@spew.ugcs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I'm interested in building a kernel with math emulation enabled for an
embedded IBM ppc 405.  (It'd be nice to allow customers to run ppc
apps on our cards without having to recompile them with soft float
support.)  When I try this with an old Monta Vista kernel from April
12th (used in an a HardHat pre-release, but no longer available), the
compile eventually fails while linking and mentions some 8xx specific
symbols.  I assume this is leftovers from 2 years ago when there
appear to have been efforts to add math emulation support for the 8xx
chips?  Anyway, make says the following and stops:

make[2]: Leaving directory `/home/dank/ixia/Software/kernel-ppc/arch/ppc/math-emu'
make[1]: Leaving directory `/home/dank/ixia/Software/kernel-ppc/arch/ppc/math-emu'
/usr/local/ppc-old/bin/powerpc-linux-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head_4xx.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/math-emu/math-emu.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  \
        net/network.o \
        /home/dank/ixia/Software/kernel-ppc/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `Soft_emulate_8xx':
/home/dank/ixia/Software/kernel-ppc/arch/ppc/kernel/softemu8xx.c:129: undefined reference to `print_8xx_pte'
/home/dank/ixia/Software/kernel-ppc/arch/ppc/kernel/softemu8xx.c:129: relocation truncated to fit: R_PPC_REL24 print_8xx_pte
/home/dank/ixia/Software/kernel-ppc/arch/ppc/kernel/softemu8xx.c:130: undefined reference to `get_8xx_pte'

If anyone has already developed a solution for this, would you please
consider posting the patch?  Thank you!

Steve

--
Steven Mueller
diffusor@ugcs.caltech.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
