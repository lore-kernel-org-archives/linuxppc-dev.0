Return-Path: <dirk.brandewie@gmail.com>
From: dirk.brandewie@gmail.com
To: linux-serial@vger.kernel.org
Subject: [PATCH 1/4] of: Add support for linking device tree blobs into vmlinux
Date: Wed,  1 Dec 2010 11:41:32 -0800
Message-Id: <76a37fa459aeadce5d11db8a7cc044687a2e0e8c.1291231792.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1289943240.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1291231792.git.dirk.brandewie@gmail.com>
References: <cover.1291231792.git.dirk.brandewie@gmail.com>
Cc: linux-arch@vger.kernel.org, mmarek@suse.cz,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sodaville@linutronix.de,
	Dirk Brandewie <dirk.brandewie@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch adds support for linking device tree blob(s) into
vmlinux. Modifies asm-generic/vmlinux.lds.h to add linking
.dtb sections into vmlinux. To maintain compatiblity with the of/fdt
driver code platforms MUST copy the blob to a non-init memory location
before the kernel frees the .init.* sections in the image.

Modifies scripts/Makefile.lib to add a kbuild command to
compile DTS files to device tree blobs and a rule to create objects to
wrap the blobs for linking.

STRUCT_ALIGNMENT is defined in vmlinux.lds.h for use in the rule to
create wrapper objects for the dtb in Makefile.lib.  The
STRUCT_ALIGN() macro in vmlinux.lds.h is modified to use the
STRUCT_ALIGNMENT definition.

The DTB's are placed on 32 byte boundries to allow parsing the blob
with driver/of/fdt.c during early boot without having to copy the blob
to get the structure alignment GCC expects.

A DTB is linked in by adding the DTB object to the list of objects to
be linked into vmlinux in the archtecture specific Makefile using
   obj-y += foo.dtb.o

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 Documentation/kbuild/makefiles.txt |   15 +++++++++++++++
 include/asm-generic/vmlinux.lds.h  |   15 ++++++++++++---
 scripts/Makefile.lib               |   21 ++++++++++++++++++++-
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 0ef00bd..fc18bb1 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1136,6 +1136,21 @@ When kbuild executes, the following steps are followed (roughly):
 	      resulting in the target file being recompiled for no
 	      obvious reason.
 
+    dtc
+	Create flattend device tree blob object suitable for linking
+	into vmlinux. Device tree blobs linked into vmlinux are placed
+	in an init section in the image. Platform code *must* copy the
+	blob to non-init memory prior to calling unflatten_device_tree().
+
+	Example:
+		#arch/x86/platform/ce4100/Makefile
+		clean-files := *dtb.S
+
+		DTC_FLAGS := -p 1024
+		obj-y += foo.dtb.o
+
+		$(obj)/%.dtb: $(src)/%.dts
+			$(call if_changed,dtc)
 
 --- 6.7 Custom kbuild commands
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bd69d79..024d3b9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -23,7 +23,7 @@
  *	_etext = .;
  *
  *      _sdata = .;
- *	RO_DATA_SECTION(PAGE_SIZE)
+*	RO_DATA_SECTION(PAGE_SIZE)
  *	RW_DATA_SECTION(...)
  *	_edata = .;
  *
@@ -67,7 +67,8 @@
  * Align to a 32 byte boundary equal to the
  * alignment gcc 4.5 uses for a struct
  */
-#define STRUCT_ALIGN() . = ALIGN(32)
+#define STRUCT_ALIGNMENT 32
+#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
 
 /* The actual configuration determine if the init/exit sections
  * are handled as text/data or they can be discarded (which
@@ -146,6 +147,13 @@
 #define TRACE_SYSCALLS()
 #endif
 
+
+#define KERNEL_DTB()							\
+	STRUCT_ALIGN();							\
+	VMLINUX_SYMBOL(__dtb_start) = .;				\
+	*(.dtb.init.rodata)						\
+	VMLINUX_SYMBOL(__dtb_end) = .;
+
 /* .data section */
 #define DATA_DATA							\
 	*(.data)							\
@@ -468,7 +476,8 @@
 	MCOUNT_REC()							\
 	DEV_DISCARD(init.rodata)					\
 	CPU_DISCARD(init.rodata)					\
-	MEM_DISCARD(init.rodata)
+	MEM_DISCARD(init.rodata)					\
+	KERNEL_DTB()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4c72c11..937eabbb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -200,7 +200,26 @@ quiet_cmd_gzip = GZIP    $@
 cmd_gzip = (cat $(filter-out FORCE,$^) | gzip -f -9 > $@) || \
 	(rm -f $@ ; false)
 
-
+# DTC
+#  ---------------------------------------------------------------------------
+
+# Generate an assembly file to wrap the output of the device tree compiler
+$(obj)/%.dtb.S: $(obj)/%.dtb
+	@echo '#include <asm-generic/vmlinux.lds.h>' > $@
+	@echo '.section .dtb.init.rodata,"a"' >> $@
+	@echo '.balign STRUCT_ALIGNMENT' >> $@
+	@echo '.global __dtb_$(*F)_begin' >> $@
+	@echo '__dtb_$(*F)_begin:' >> $@
+	@echo '.incbin "$<" ' >> $@
+	@echo '__dtb_$(*F)_end:' >> $@
+	@echo '.global __dtb_$(*F)_end' >> $@
+	@echo '.balign STRUCT_ALIGNMENT' >> $@
+
+DTC = $(objtree)/scripts/dtc/dtc
+
+quiet_cmd_dtc = DTC $@
+      cmd_dtc = $(DTC) -O dtb -o $@ -b 0 $(DTC_FLAGS) $<
+ooo
 # Bzip2
 # ---------------------------------------------------------------------------
 
-- 
1.7.2.3
