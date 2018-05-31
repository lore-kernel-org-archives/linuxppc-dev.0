Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF444PgFzDrnR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:44 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc: Add support for adding an ESM blob to the zImage
 wrapper
Date: Thu, 31 May 2018 14:34:17 +1000
Message-Id: <20180531043417.25073-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For secure VMs, the signing tool will create a ticket called
the "ESM blob" with the signatures of the kernel and initrd
among other things.

This adds support to the wrapper script for adding that
blob via the "-e" option to the zImage.pseries.

It also adds code to the zImage wrapper itself to
retrieve and if necessary relocate the blob, and pass
its address to Linux via the device-tree, to be later
consumed by prom_init.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/boot/main.c       | 41 ++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ops.h        |  2 ++
 arch/powerpc/boot/wrapper      | 24 +++++++++++++++++---
 arch/powerpc/boot/zImage.lds.S |  8 +++++++
 4 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 78aaf4ffd7ab..2e818ed4a9ef 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -150,6 +150,46 @@ static struct addr_range prep_initrd(struct addr_range vmlinux, void *chosen,
 	return (struct addr_range){(void *)initrd_addr, initrd_size};
 }
 
+#ifdef __powerpc64__
+static void prep_esm_blob(struct addr_range vmlinux, void *chosen)
+{
+	unsigned long esm_blob_addr, esm_blob_size;
+
+	/* Do we have a blob ? */
+	if (_esm_blob_end <= _esm_blob_start)
+		return;
+
+	printf("Attached ESM blob at 0x%p-0x%p\n\r",
+	       _esm_blob_start, _esm_blob_end);
+	esm_blob_addr = (unsigned long)_esm_blob_start;
+	esm_blob_size = _esm_blob_end - _esm_blob_start;
+
+	/*
+	 * If the initrd is too low it will be clobbered when the
+	 * kernel relocates to its final location.  In this case,
+	 * allocate a safer place and move it.
+	 */
+	if (esm_blob_addr < vmlinux.size) {
+		void *old_addr = (void *)esm_blob_addr;
+
+		printf("Allocating 0x%lx bytes for esm_blob ...\n\r",
+		       esm_blob_size);
+		esm_blob_addr = (unsigned long)malloc(esm_blob_size);
+		if (!esm_blob_addr)
+			fatal("Can't allocate memory for ESM blob !\n\r");
+		printf("Relocating ESM blob 0x%lx <- 0x%p (0x%lx bytes)\n\r",
+		       esm_blob_addr, old_addr, esm_blob_size);
+		memmove((void *)esm_blob_addr, old_addr, esm_blob_size);
+	}
+
+	/* Tell the kernel initrd address via device tree */
+	setprop_val(chosen, "linux,esm-blob-start", (u32)(esm_blob_addr));
+	setprop_val(chosen, "linux,esm-blob-end", (u32)(esm_blob_addr+esm_blob_size));
+}
+#else
+static inline void prep_esm_blob(struct addr_range vmlinux, void *chosen) { }
+#endif
+
 /* A buffer that may be edited by tools operating on a zImage binary so as to
  * edit the command line passed to vmlinux (by setting /chosen/bootargs).
  * The buffer is put in it's own section so that tools may locate it easier.
@@ -218,6 +258,7 @@ void start(void)
 	vmlinux = prep_kernel();
 	initrd = prep_initrd(vmlinux, chosen,
 			     loader_info.initrd_addr, loader_info.initrd_size);
+	prep_esm_blob(vmlinux, chosen);
 	prep_cmdline(chosen);
 
 	printf("Finalizing device tree...");
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index fad1862f4b2d..1212aca660f2 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -252,6 +252,8 @@ extern char _initrd_start[];
 extern char _initrd_end[];
 extern char _dtb_start[];
 extern char _dtb_end[];
+extern char _esm_blob_start[];
+extern char _esm_blob_end[];
 
 static inline __attribute__((const))
 int __ilog2_u32(u32 n)
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index f9141eaec6ff..36b2ad6cd5b7 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -14,6 +14,7 @@
 # -i initrd	specify initrd file
 # -d devtree	specify device-tree blob
 # -s tree.dts	specify device-tree source file (needs dtc installed)
+# -e esm_blob   specify ESM blob for secure images
 # -c		cache $kernel.strip.gz (use if present & newer, else make)
 # -C prefix	specify command prefix for cross-building tools
 #		(strip, objcopy, ld)
@@ -38,6 +39,7 @@ platform=of
 initrd=
 dtb=
 dts=
+esm_blob=
 cacheit=
 binary=
 compression=.gz
@@ -60,9 +62,9 @@ tmpdir=.
 
 usage() {
     echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
-    echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
-    echo '       [-D datadir] [-W workingdir] [-Z (gz|xz|none)]' >&2
-    echo '       [--no-compression] [vmlinux]' >&2
+    echo '       [-d devtree] [-s tree.dts] [-e esm_blob]' >&2
+    echo '       [-c] [-C cross-prefix] [-D datadir] [-W workingdir]' >&2
+    echo '       [-Z (gz|xz|none)] [--no-compression] [vmlinux]' >&2
     exit 1
 }
 
@@ -105,6 +107,11 @@ while [ "$#" -gt 0 ]; do
 	[ "$#" -gt 0 ] || usage
 	dtb="$1"
 	;;
+    -e)
+	shift
+	[ "$#" -gt 0 ] || usage
+	esm_blob="$1"
+	;;
     -s)
 	shift
 	[ "$#" -gt 0 ] || usage
@@ -211,9 +218,16 @@ objflags=-S
 tmp=$tmpdir/zImage.$$.o
 ksection=.kernel:vmlinux.strip
 isection=.kernel:initrd
+esection=.kernel:esm_blob
 link_address='0x400000'
 make_space=y
 
+
+if [ -n "$esm_blob" -a "$platform" != "pseries" ]; then
+    echo "ESM blob not support on non-pseries platforms" >&2
+    exit 1
+fi
+
 case "$platform" in
 of)
     platformo="$object/of.o $object/epapr.o"
@@ -463,6 +477,10 @@ if [ -n "$dtb" ]; then
     fi
 fi
 
+if [ -n "$esm_blob" ]; then
+    addsec $tmp "$esm_blob" $esection
+fi
+
 if [ "$platform" != "miboot" ]; then
     if [ -n "$link_address" ] ; then
         text_start="-Ttext $link_address"
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 4ac1e36edfe7..a21f3a76e06f 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -68,6 +68,14 @@ SECTIONS
     _initrd_end =  .;
   }
 
+  . = ALIGN(4096);
+  .kernel:esm_blob :
+  {
+    _esm_blob_start =  .;
+    *(.kernel:esm_blob)
+    _esm_blob_end =  .;
+  }
+
 #ifdef CONFIG_PPC64_BOOT_WRAPPER
   . = ALIGN(256);
   .got :
-- 
2.17.0
