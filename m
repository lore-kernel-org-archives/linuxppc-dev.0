Message-Id: <m132xT5-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Problem compiling arch/ppc/kernel/ppc_ksyms.c with Linux 2.4.0-test1-ac18
To: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com
Date: Fri, 16 Jun 2000 10:51:35 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To: linuxppc-embedded@lists.linuxppc.org,dan_malek@mvista.com

Problem compiling arch/ppc/kernel/ppc_ksyms.c:

Linux: 2.4.0-test1-ac18

gmake -C  arch/ppc/kernel
gmake[1]: Entering directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'
multiple -mstring -S mk_defs.c
cp ppc_defs.head ppc_defs.h
chmod u+w ppc_defs.h
grep '^#define' mk_defs.s >> ppc_defs.h
rm mk_defs.s
multiple -mstring -D__ASSEMBLY__ -c head.S -o head.o
multiple -mstring   -DEXPORT_SYMTAB -c ppc_ksyms.c
ppc_ksyms.c:86: `isa_io_base' undeclared here (not in a function)
ppc_ksyms.c:86: initializer element is not constant
ppc_ksyms.c:86: (near initialization for `__ksymtab_isa_io_base.value')
ppc_ksyms.c:87: `isa_mem_base' undeclared here (not in a function)
ppc_ksyms.c:87: initializer element is not constant
ppc_ksyms.c:87: (near initialization for `__ksymtab_isa_mem_base.value')
ppc_ksyms.c:88: `pci_dram_offset' undeclared here (not in a function)
ppc_ksyms.c:88: initializer element is not constant
ppc_ksyms.c:88: (near initialization for `__ksymtab_pci_dram_offset.value')
gmake[1]: *** [ppc_ksyms.o] Error 1
gmake[1]: Leaving directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'
gmake: *** [_dir_arch/ppc/kernel] Error 2

Here is the .config file I am using:

# grep -v '^#' .config | uniq | grep -v MBXBOOT_

CONFIG_EXPERIMENTAL=y

CONFIG_PPC=y
CONFIG_8260=y
CONFIG_6xx=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_EST8260=y
CONFIG_MACH_SPECIFIC=y

CONFIG_MODULES=y
CONFIG_KMOD=y

CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_MISC=y

CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_ALIAS=y

CONFIG_NETDEVICES=y

CONFIG_NET_ETHERNET=y

CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y

CONFIG_MSDOS_PARTITION=y

CONFIG_SCC_ENET=y
CONFIG_SCC1_ENET=y

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
