Message-Id: <m132yY0-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Problem compiling arch/ppc/kernel/setup.c, Linux 2.4.0-test1-ac18
To: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com
Date: Fri, 16 Jun 2000 12:00:44 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To: linuxppc-embedded@lists.linuxppc.org,dan_malek@mvista.com

Problem compiling arch/ppc/kernel/setup.c:

Linux: 2.4.0-test1-ac18

gmake -C  arch/ppc/kernel
gmake[1]: Entering directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'

/opt/hardhat/devkit/ppc/8xx/bin/powerpc-linux-gcc -D__KERNEL__
-I/usr/people/diekema/bk/linux-2.3/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
-mmultiple -mstring -DEXPORT_SYMTAB -c setup.c

setup.c: In function `identify_machine':
setup.c:573: warning: implicit declaration of function `m8260_init'
setup.c: In function `setup_arch':
setup.c:715: `dcache_bsize' undeclared (first use in this function)
setup.c:715: (Each undeclared identifier is reported only once
setup.c:715: for each function it appears in.)
setup.c:715: `icache_bsize' undeclared (first use in this function)
setup.c:718: `ucache_bsize' undeclared (first use in this function)
gmake[1]: *** [setup.o] Error 1
gmake[1]: Leaving directory `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'
gmake: *** [_dir_arch/ppc/kernel] Error 2


Patches to eliminate compile problems:


===== arch/ppc/kernel/ppc_ksyms.c 1.36 vs 1.37 =====
--- 1.36/arch/ppc/kernel/ppc_ksyms.c	Fri Jun 16 10:23:38 2000
+++ 1.37/arch/ppc/kernel/ppc_ksyms.c	Fri Jun 16 10:54:43 2000
@@ -82,7 +82,7 @@
 EXPORT_SYMBOL(kernel_flag);
 #endif /* CONFIG_SMP */

-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) && !defined(CONFIG_8260)
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);

===== arch/ppc/kernel/setup.c 1.36 vs 1.37 =====
--- 1.36/arch/ppc/kernel/setup.c	Fri Jun 16 02:39:12 2000
+++ 1.37/arch/ppc/kernel/setup.c	Fri Jun 16 11:13:44 2000
@@ -131,14 +131,6 @@
 };

 /*
- * These are used in binfmt_elf.c to put aux entries on the stack
- * for each elf executable being started.
- */
-int dcache_bsize;
-int icache_bsize;
-int ucache_bsize;
-
-/*
  * I really need to add multiple-console support... -- Cort
  */
 int __init pmac_display_supported(char *name)
@@ -166,6 +158,14 @@
 	16			/* orig-video-points */
 };
 #endif /* !CONFIG_4xx && !CONFIG_8xx */
+
+/*
+ * These are used in binfmt_elf.c to put aux entries on the stack
+ * for each elf executable being started.
+ */
+int dcache_bsize;
+int icache_bsize;
+int ucache_bsize;

 void machine_restart(char *cmd)
 {

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
