From: jlhagen@collins.rockwell.com
Subject: can't compile 2.4.0-testx kernels on G4 YDL C.S. 1.2.1
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 9 Nov 2000 16:27:51 -0600
Message-ID: <OFCAAE7FC7.CA1D180E-ON86256992.007AC859@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,,

I definitely have a problem compiling any of the 2.4.0-testx kernels on a
G4 box. gcc -v  Reading specs from
/usr/lib/gcc-lib/ppc-yellowdog-linux/2.95.2/specs gcc version 2.95.2
19991024 (release/franzo).

I have compiled a clean 2.2.17 just earlier this morning and was going to
try the test kernels but can't get past the following errors:

building 2.4.0-test1

make[1]: Leaving directory
`/home/vista/Builds/vme/linux-2.4.0-test1/linux/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o
        --start-group \
       arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc        drivers/block/block.a
drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/parport/
drivers/pci/pci.a drivers/macintosh/macintosh.o drivers/video/video.o \
       net/network.a \
       /home/vista/Builds/vme/linux-2.4.0-test1/linux/lib/lib.a \
       --end-group \
       -o vmlinux
arch/ppc/kernel/kernel.o: In function `pmac_restart':
arch/ppc/kernel/kernel.o(.text+0x85d8): undefined reference to
`pmac_nvram_update'
arch/ppc/kernel/kernel.o(.text+0x85d8): relocation truncated to fit:
R_PPC_REL24 pmac_nvram_update
arch/ppc/kernel/kernel.o: In function `pmac_power_off':
arch/ppc/kernel/kernel.o(.text+0x85f8): undefined reference to
`pmac_nvram_update'
arch/ppc/kernel/kernel.o(.text+0x85f8): relocation truncated to fit:
R_PPC_REL24 pmac_nvram_update
arch/ppc/kernel/kernel.o(__ksymtab+0x3a0): undefined reference to
`debugger'
arch/ppc/kernel/kernel.o(__ksymtab+0x3a8): undefined reference to
`debugger_bpt'
arch/ppc/kernel/kernel.o(__ksymtab+0x3b0): undefined reference to
`debugger_sstep'
arch/ppc/kernel/kernel.o(__ksymtab+0x3b8): undefined reference to
`debugger_iabr_match'
arch/ppc/kernel/kernel.o(__ksymtab+0x3c0): undefined reference to
`debugger_dabr_match'
arch/ppc/kernel/kernel.o(__ksymtab+0x3c8): undefined reference to
`debugger_fault_handler'
drivers/video/video.o: In function `mac_find_mode':
drivers/video/video.o(.text.init+0x47c): undefined reference to
`fb_find_mode'
drivers/video/video.o(.text.init+0x47c): relocation truncated to fit:
R_PPC_REL24 fb_find_mode
make: *** [vmlinux] Error 1

building 2.4.0-test5

make[1]: Leaving directory
`/home/vista/Builds/vme/linux-2.4.0-test5/linux/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/parport/parport.a  drivers/pci/pci.a
drivers/macintosh/macintosh.o drivers/video/video.o \
        net/network.o \
        /home/vista/Builds/vme/linux-2.4.0-test5/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `pmac_restart':
arch/ppc/kernel/kernel.o(.text+0x86ec): undefined reference to
`pmac_nvram_update'
arch/ppc/kernel/kernel.o(.text+0x86ec): relocation truncated to fit:
R_PPC_REL24 pmac_nvram_update
arch/ppc/kernel/kernel.o: In function `pmac_power_off':
arch/ppc/kernel/kernel.o(.text+0x870c): undefined reference to
`pmac_nvram_update'
arch/ppc/kernel/kernel.o(.text+0x870c): relocation truncated to fit:
R_PPC_REL24 pmac_nvram_update
arch/ppc/kernel/kernel.o: In function `pmac_set_rtc_time':
arch/ppc/kernel/kernel.o(.text+0x87ac): undefined reference to
`cuda_request'
arch/ppc/kernel/kernel.o(.text+0x87ac): relocation truncated to fit:
R_PPC_REL24 cuda_request
arch/ppc/kernel/kernel.o(.text+0x87bc): undefined reference to `cuda_poll'
arch/ppc/kernel/kernel.o(.text+0x87bc): relocation truncated to fit:
R_PPC_REL24 cuda_poll
arch/ppc/kernel/kernel.o(.text+0x8804): undefined reference to
`pmu_request'
arch/ppc/kernel/kernel.o(.text+0x8804): relocation truncated to fit:
R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text+0x8814): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o(.text+0x8814): relocation truncated to fit:
R_PPC_REL24 pmu_poll
drivers/video/video.o: In function `mac_find_mode':
drivers/video/video.o(.text.init+0x47c): undefined reference to
`fb_find_mode'
drivers/video/video.o(.text.init+0x47c): relocation truncated to fit:
R_PPC_REL24 fb_find_mode
                                   make: *** [vmlinux] Error 1

Any clues as to what I'm running into??  I can send the .config file if
someone wants a peek at it. I'm building for an mvme card that doesn't have
a lot of items on it so the config is pretty small.

Thanks,
JH


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
