Date: Wed, 26 Sep 2001 16:24:58 -0600 (MDT)
From: Jeff Studer <jstuder@aquilagroup.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: undefined symbols configuring PCI for 8xx
Message-ID: <Pine.LNX.4.10.10109261555010.5312-100000@jeffs.aquilagroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

I'm using linux-2.4.2 from kernel.org for a custom 8xx board.
A grep of autoconf.h returns:

grep define include/linux/autoconf.h
#define AUTOCONF_INCLUDED
#define CONFIG_EXPERIMENTAL 1
#define CONFIG_PPC 1
#define CONFIG_8xx 1
#define CONFIG_SERIAL_CONSOLE 1
#define CONFIG_MACH_SPECIFIC 1
#define CONFIG_PCI_QSPAN 1
#define CONFIG_PCI 1
#define CONFIG_BINFMT_ELF 1
#define CONFIG_KERNEL_ELF 1
#define CONFIG_PCI_NAMES 1
#define CONFIG_EXT2_FS 1
#define CONFIG_PARTITION_ADVANCED 1

After updating the qspan_pci.c file based on the prep_pci.c, I got
undefined symbols related to the CONFIG_PCI code:

powerpc-linux-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head_8xx.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/pci/driver.o
arch/ppc/8xx_io/8xx_io.o \
        net/network.o \
        /mnt/euripedes/powerpc/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `make_one_node_map':
arch/ppc/kernel/kernel.o(.text+0x7bfc): undefined reference to
`get_property'
arch/ppc/kernel/kernel.o(.text+0x7bfc): relocation truncated to fit:
R_PPC_REL24 get_property
arch/ppc/kernel/kernel.o(.text+0x7c54): undefined reference to
`get_property'
arch/ppc/kernel/kernel.o(.text+0x7c54): relocation truncated to fit:
R_PPC_REL24 get_property
arch/ppc/kernel/kernel.o(.text+0x7c98): undefined reference to
`get_property'
arch/ppc/kernel/kernel.o(.text+0x7c98): relocation truncated to fit:
R_PPC_REL24 get_property
arch/ppc/kernel/kernel.o: In function `pcibios_make_OF_bus_map':
arch/ppc/kernel/kernel.o(.text+0x7da4): undefined reference to
`find_path_device'
arch/ppc/kernel/kernel.o(.text+0x7da4): relocation truncated to fit:
R_PPC_REL24 find_path_device
arch/ppc/kernel/kernel.o(.text+0x7db4): undefined reference to
`get_property'
arch/ppc/kernel/kernel.o(.text+0x7db4): relocation truncated to fit:
R_PPC_REL24 get_property
arch/ppc/kernel/kernel.o: In function `scan_OF_childs_for_device':
arch/ppc/kernel/kernel.o(.text+0x7e68): undefined reference to
`get_property'
arch/ppc/kernel/kernel.o(.text+0x7e68): relocation truncated to fit:
R_PPC_REL24 get_property
arch/ppc/kernel/kernel.o(.text+0x7ea4): undefined reference to
`get_property'
arch/ppc/kernel/kernel.o(.text+0x7ea4): relocation truncated to fit:
R_PPC_REL24 get_property
make: *** [vmlinux] Error 1

The above mentioned functions are all in arch/ppc/kernel/pci.c

Is there a proper resolution to these undefineds?  I found the definitions
in prom.c, but after seeing some static globals in find_path_device, I'm
not sure I just want to include that file in the make.  Of course, I
tried, and ended up with a:

Kernel panic: Attempted to kill init!

The only idea I have know is to #ifdef out the call to find_path_device in
arch/ppc/kernel/pci.c and to not compile in prom.c, but to copy
get_property() to my xxx_setup.c with an "#include <asm/prom.h>" there.

Thanks for your help, in advance.

Jeff Studer
Software Engineer
Aquila Technologies Groups, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
