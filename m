Date: Thu, 13 May 1999 10:44:30 +0200 (MEST)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: compile troubles in 2.2.8
Message-ID: <Pine.LNX.4.04.9905131041210.12269-100000@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

i had troubles getting 2.2.8(vanilla) to compile. It took the following
patch. There seams to be at least one genuine bug.

Oliver Neukum

PS: Is there really a PPC-machine with an isa-bus?

diff -u --recursive linux/arch/ppc/kernel/pmac_setup.c /usr/src/linux/arch/ppc/kernel/pmac_setup.c
--- linux/arch/ppc/kernel/pmac_setup.c	Thu May 13 10:02:13 1999
+++ /usr/src/linux/arch/ppc/kernel/pmac_setup.c	Thu May 13 09:29:26 1999
@@ -556,9 +556,11 @@
 	/* isa_io_base gets set in pmac_find_bridges */
 	isa_mem_base = PMAC_ISA_MEM_BASE;
 	pci_dram_offset = PMAC_PCI_DRAM_OFFSET;
+#if 0
 	ISA_DMA_THRESHOLD = ~0L;
 	DMA_MODE_READ = 1;
 	DMA_MODE_WRITE = 2;
+#endif
 
 	ppc_md.setup_arch     = pmac_setup_arch;
 	ppc_md.setup_residual = NULL;
diff -u --recursive linux/arch/ppc/kernel/syscalls.c /usr/src/linux/arch/ppc/kernel/syscalls.c
--- linux/arch/ppc/kernel/syscalls.c	Thu May 13 10:02:13 1999
+++ /usr/src/linux/arch/ppc/kernel/syscalls.c	Thu May 13 09:50:00 1999
@@ -33,6 +33,7 @@
 #include <linux/sys.h>
 #include <linux/ipc.h>
 #include <linux/utsname.h>
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
