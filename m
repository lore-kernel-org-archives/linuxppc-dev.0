Message-ID: <38D8236B.C27DE94B@huawei.com.cn>
Date: Wed, 22 Mar 2000 09:35:39 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Does mpc8xx-2.2.13 support "Enable loadable module support"?
References: <NCBBKJKKGDLPHKDPAFFMMEIPCDAA.jsw-embedded@mindspring.com> <38D6E781.884AA846@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
     I have a question as the subject asks:
    Notes that I disable "pci support" and "Qscan pci" in both cases which  I
describe below.
     If I compile the kernel without "Enable loadable module support" , then it
works successfully. But if  I do again with "Enable loadable module support", then
some errors occur:
Does someone know why?

##################################################
 powerpc-linux-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
 --start-group \
 arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
 fs/filesystems.a \
 net/network.a \
 drivers/block/block.a drivers/char/char.a drivers/misc/misc.a drivers/net/net.a
drivers/macintosh/macintosh.a arch/ppc/8xx_io/8xx_io.a drivers/net/net.a \
 /usr/src/linux/lib/lib.a \
 --end-group \
 -o vmlinux
drivers/macintosh/macintosh.a(adb.o): In function `adbdev_init':
adb.o(.text+0xfa8): multiple definition of `adbdev_init'
arch/ppc/kernel/kernel.o(.text.init+0x31c): first defined here
powerpc-linux-ld: Warning: size of symbol `adbdev_init' changed from 4 to 116 in
adb.o
arch/ppc/kernel/kernel.o(__ksymtab+0x90): undefined reference to `isa_io_base'
arch/ppc/kernel/kernel.o(__ksymtab+0x98): undefined reference to `isa_mem_base'
arch/ppc/kernel/kernel.o(__ksymtab+0xa0): undefined reference to `pci_dram_offset'

arch/ppc/kernel/kernel.o(__ksymtab+0xc0): undefined reference to `_prep_type'
arch/ppc/kernel/kernel.o(__ksymtab+0xc8): undefined reference to `ucSystemType'
arch/ppc/kernel/kernel.o(__ksymtab+0x308): undefined reference to `find_devices'
arch/ppc/kernel/kernel.o(__ksymtab+0x310): undefined reference to
`find_type_devices'
arch/ppc/kernel/kernel.o(__ksymtab+0x318): undefined reference to
`find_compatible_devices'
arch/ppc/kernel/kernel.o(__ksymtab+0x320): undefined reference to
`find_path_device'
arch/ppc/kernel/kernel.o(__ksymtab+0x328): undefined reference to `find_phandle'
arch/ppc/kernel/kernel.o(__ksymtab+0x330): undefined reference to `get_property'
arch/ppc/kernel/kernel.o(__ksymtab+0x338): undefined reference to `pci_io_base'
arch/ppc/kernel/kernel.o(__ksymtab+0x340): undefined reference to `pci_device_loc'

arch/ppc/kernel/kernel.o(__ksymtab+0x348): undefined reference to `feature_set'
arch/ppc/kernel/kernel.o(__ksymtab+0x350): undefined reference to `feature_clear'
arch/ppc/kernel/kernel.o(__ksymtab+0x358): undefined reference to `feature_test'
arch/ppc/kernel/kernel.o(__ksymtab+0x370): undefined reference to
`device_is_compatible'
make: *** [vmlinux] Error 1
#############################


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
