Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A4A3A1007E6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 22:47:40 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Fri, 9 Dec 2011 17:17:36 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB9BlYU74608016
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:17:34 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB9BlXIG025565
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:17:34 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v4 3/7] [ppc] Process dynamic relocations for kernel
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2011 17:17:32 +0530
Message-ID: <20111209114720.16360.9670.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
References: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch implements the dynamic relocation processing for
PPC32 kernel. relocate() accepts the target virtual address and relocates
 the kernel image to the same.

Currently the following relocation types are handled :

	R_PPC_RELATIVE
	R_PPC_ADDR16_LO
	R_PPC_ADDR16_HI
	R_PPC_ADDR16_HA

The last 3 relocations in the above list depends on value of Symbol indexed
whose index is encoded in the Relocation entry. Hence we need the Symbol
Table for processing such relocations.

Note: The GNU ld for ppc32 produces buggy relocations for relocation types
that depend on symbols. The value of the symbols with STB_LOCAL scope
should be assumed to be zero. - Alan Modra

Changes since V3:
 * Updated relocation types for ppc in arch/powerpc/relocs_check.pl

Changes since v2:
  * Flush the d-cache'd instructions and invalidate the i-cache to reflect
    the processed instructions.(Reported by: Josh Poimboeuf)

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Modra <amodra@au1.ibm.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig              |   42 ++++++++++++++++++++++---------------
 arch/powerpc/Makefile             |    6 +++--
 arch/powerpc/kernel/Makefile      |    2 ++
 arch/powerpc/kernel/vmlinux.lds.S |    8 ++++++-
 arch/powerpc/relocs_check.pl      |    7 ++++++
 5 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5eafe95..6936cb0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -843,23 +843,31 @@ config DYNAMIC_MEMSTART
 	  load address. When this option is enabled, the compile time physical 
 	  address CONFIG_PHYSICAL_START is ignored.
 
-# Mapping based RELOCATABLE is moved to DYNAMIC_MEMSTART
-# config RELOCATABLE
-#	bool "Build a relocatable kernel (EXPERIMENTAL)"
-#	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
-#	help
-#	  This builds a kernel image that is capable of running at the
-#	  location the kernel is loaded at, without any alignment restrictions.
-#
-#	  One use is for the kexec on panic case where the recovery kernel
-#	  must live at a different physical address than the primary
-#	  kernel.
-#
-#	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
-#	  it has been loaded at and the compile time physical addresses
-#	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
-#	  setting can still be useful to bootwrappers that need to know the
-#	  load location of the kernel (eg. u-boot/mkimage).
+	  This option is overridden by RELOCATABLE.
+
+config RELOCATABLE
+	bool "Build a relocatable kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM
+	select NONSTATIC_KERNEL
+	help
+	  This builds a kernel image that is capable of running at the
+	  location the kernel is loaded at, without any alignment restrictions.
+	  This feature is a superset of DYNAMIC_MEMSTART, and hence overrides 
+	  it.
+
+	  One use is for the kexec on panic case where the recovery kernel
+	  must live at a different physical address than the primary
+	  kernel.
+
+	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
+	  it has been loaded at and the compile time physical addresses
+	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
+	  setting can still be useful to bootwrappers that need to know the
+	  load address of the kernel (eg. u-boot/mkimage).
+
+config RELOCATABLE_PPC32
+	def_bool y
+	depends on PPC32 && RELOCATABLE
 
 config PAGE_OFFSET_BOOL
 	bool "Set custom page offset address"
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ffe4d88..b8b105c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -63,9 +63,9 @@ override CC	+= -m$(CONFIG_WORD_SIZE)
 override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
 endif
 
-LDFLAGS_vmlinux-yy := -Bstatic
-LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
-LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-yy)
+LDFLAGS_vmlinux-y := -Bstatic
+LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
 
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=no -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ce4f7f1..ee728e4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -85,6 +85,8 @@ extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
+obj-$(CONFIG_RELOCATABLE_PPC32)	+= reloc_32.o
+
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 920276c..710a540 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -170,7 +170,13 @@ SECTIONS
 	}
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(8);
-	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET) { *(.dynsym) }
+	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
+	{
+#ifdef CONFIG_RELOCATABLE_PPC32
+		__dynamic_symtab = .;
+#endif
+		*(.dynsym)
+	}
 	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
 	.dynamic : AT(ADDR(.dynamic) - LOAD_OFFSET)
 	{
diff --git a/arch/powerpc/relocs_check.pl b/arch/powerpc/relocs_check.pl
index d257109..71aeb03 100755
--- a/arch/powerpc/relocs_check.pl
+++ b/arch/powerpc/relocs_check.pl
@@ -32,8 +32,15 @@ while (<FD>) {
 	next if (!/\s+R_/);
 
 	# These relocations are okay
+	# On PPC64:
+	# 	R_PPC64_RELATIVE, R_PPC64_NONE, R_PPC64_ADDR64
+	# On PPC:
+	# 	R_PPC_RELATIVE, R_PPC_ADDR16_HI, 
+	# 	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO
 	next if (/R_PPC64_RELATIVE/ or /R_PPC64_NONE/ or
 	         /R_PPC64_ADDR64\s+mach_/);
+	next if (/R_PPC_ADDR16_LO/ or /R_PPC_ADDR16_HI/ or
+		 /R_PPC_ADDR16_HA/ or /R_PPC_RELATIVE/);
 
 	# If we see this type of relcoation it's an idication that
 	# we /may/ be using an old version of binutils.
