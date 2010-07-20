Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id A93061007F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 06:15:23 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2 6/7] Add support for reworking flat device tree support
Date: Tue, 20 Jul 2010 15:14:59 -0500
Message-ID: <1279656900-27458-6-git-send-email-msm@freescale.com>
In-Reply-To: <1279656900-27458-5-git-send-email-msm@freescale.com>
References: <1279656900-27458-1-git-send-email-msm@freescale.com>
	<1279656900-27458-2-git-send-email-msm@freescale.com>
	<1279656900-27458-3-git-send-email-msm@freescale.com>
	<1279656900-27458-4-git-send-email-msm@freescale.com>
	<1279656900-27458-5-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the device tree is passed as is. You can optionally
update the command line and specifically listed nodes but nothing
is updated automatically.

This patch updates the memreserve regions, memory node, initrd
nodes and attempts to make the device tree look as it should. Some
code is borrowed from the u-boot routines which do similiar things

Also, now if no flat device tree is passed to kexec it will attempt
to rebuild one from the /proc/device-tree file system to use for
the kexec'ed kernel for both uImage and elf formats

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/fixup_dtb.c        |  314 ++++++++++++++++++++++++++++++++++++-
 kexec/arch/ppc/fixup_dtb.h        |    6 +-
 kexec/arch/ppc/kexec-elf-ppc.c    |  148 +++++------------
 kexec/arch/ppc/kexec-ppc.h        |    1 +
 kexec/arch/ppc/kexec-uImage-ppc.c |   54 +++++--
 kexec/arch/ppc/ops.h              |    1 -
 6 files changed, 400 insertions(+), 124 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 40e9350..0f9238b 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -8,13 +8,36 @@
 #include <sys/stat.h>
 
 #include "../../kexec.h"
+#include "../../kexec-syscall.h"
 #include <libfdt.h>
 #include "ops.h"
 #include "page.h"
 #include "fixup_dtb.h"
+#include "kexec-ppc.h"
 
 const char proc_dts[] = "/proc/device-tree";
 
+#ifdef DEBUG
+static void print_fdt_reserve_regions(char *blob_buf)
+{
+	int i, num;
+
+	/* Print out a summary of the final reserve regions */
+	num =  fdt_num_mem_rsv(blob_buf);
+	printf ("reserve regions: %d\n", num);
+	for (i = 0; i < num; i++)
+	{
+		uint64_t offset, size;
+
+		if (fdt_get_mem_rsv(blob_buf, i, &offset, &size) == 0) {
+			printf("%d: offset: %llx, size: %llx\n", i, offset, size);
+		} else {
+			printf("Error retreiving reserved region\n");
+		}
+	}
+}
+#endif
+
 static void fixup_nodes(char *nodes[])
 {
 	int index = 0;
@@ -92,14 +115,303 @@ static void fixup_cmdline(const char *cmdline)
 	return;
 }
 
-char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline)
+#define EXPAND_GRANULARITY     1024
+
+static char *expand_buf(int minexpand, char *blob_buf, off_t *blob_size)
+{
+	int size = fdt_totalsize(blob_buf);
+	int rc;
+
+	size = _ALIGN(size + minexpand, EXPAND_GRANULARITY);
+	blob_buf = realloc(blob_buf, size);
+	if (!blob_buf)
+		fatal("Couldn't find %d bytes to expand device tree\n\r", size);
+	rc = fdt_open_into(blob_buf, blob_buf, size);
+	if (rc != 0)
+		fatal("Couldn't expand fdt into new buffer: %s\n\r",
+			fdt_strerror(rc));
+
+	*blob_size = fdt_totalsize(blob_buf);
+
+	return blob_buf;
+}
+
+static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf, off_t *blob_size)
+{
+	int ret, i;
+	int nodeoffset;
+
+	/* If this is a KEXEC kernel we add all regions since they will
+	 * all need to be saved */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		for (i = 0; i < info->nr_segments; i++)
+		{
+			uint64_t address = (unsigned long)info->segment[i].mem;
+			uint64_t size = info->segment[i].memsz;
+
+			/* We add all except the device tree because it's already added */
+			if (address == devicetree_base) continue;
+
+			while ((i+1) < info->nr_segments &&
+			      (address + size == (unsigned long)info->segment[i+1].mem))
+			{
+				/* We add all except the device tree because it's already added */
+				if ( (unsigned long)info->segment[i+1].mem == devicetree_base)
+					 continue;
+
+				size += info->segment[++i].memsz;
+			}
+
+			ret = fdt_add_mem_rsv(blob_buf, address, size);
+			if (ret) {
+				printf("%s: Error adding memory range to memreserve!\n",
+					fdt_strerror(ret));
+				goto out;
+			}
+		}
+	} else {
+		/* Otherwise we just add back the ramdisk and the device tree
+		 * is already in the list */
+		ret = fdt_add_mem_rsv(blob_buf, ramdisk_base, ramdisk_size);
+		if (ret) {
+			printf("%s: Unable to add new reserved memory for initrd flat device tree\n",
+				fdt_strerror(ret));
+			goto out;
+		}
+	}
+
+	/* Add reserve regions for cpu-release-addr */
+	nodeoffset = fdt_node_offset_by_prop_value(blob_buf, -1, "device_type", "cpu", 4);
+	while (nodeoffset != -FDT_ERR_NOTFOUND)
+	{
+		const void *buf;
+		int sz, ret;
+		u64 val = 0;
+
+		buf = fdt_getprop(blob_buf, nodeoffset, "cpu-release-addr", &sz);
+		if (sz == 4) {
+			val = *(u32 *)buf;
+		} else if (sz == 8) {
+			val = *(u64 *)buf;
+		}
+
+		if (val) {
+			ret = fdt_add_mem_rsv(blob_buf, PAGE_ALIGN(val-PAGE_SIZE), PAGE_SIZE);
+			if (ret)
+				printf("%s: Unable to add reserve for cpu-release-addr!\n",
+					fdt_strerror(ret));
+		}
+
+		nodeoffset = fdt_node_offset_by_prop_value(blob_buf, nodeoffset,
+				"device_type", "cpu", 4);
+	}
+
+out:	;
+
+#ifdef DEBUG
+	print_fdt_reserve_regions(blob_buf);
+#endif
+}
+
+static void fixup_memory(struct kexec_info *info, char *blob_buf)
 {
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		int nodeoffset, len = 0;
+		u8 tmp[16];
+		const unsigned long *addrcell, *sizecell;
+
+		nodeoffset = fdt_path_offset(blob_buf, "/memory");
+
+		if (nodeoffset < 0) {
+			printf("Error searching for memory node!\n");
+			return;
+		}
+
+		addrcell = fdt_getprop(blob_buf, 0, "#address-cells", NULL);
+		/* use shifts and mask to ensure endianness */
+		if ((addrcell) && (*addrcell == 2)) {
+			tmp[0] = (crash_base >> 56) & 0xff;
+			tmp[1] = (crash_base >> 48) & 0xff;
+			tmp[2] = (crash_base >> 40) & 0xff;
+			tmp[3] = (crash_base >> 32) & 0xff;
+			tmp[4] = (crash_base >> 24) & 0xff;
+			tmp[5] = (crash_base >> 16) & 0xff;
+			tmp[6] = (crash_base >>  8) & 0xff;
+			tmp[7] = (crash_base      ) & 0xff;
+			len = 8;
+		} else {
+			tmp[0] = (crash_base >> 24) & 0xff;
+			tmp[1] = (crash_base >> 16) & 0xff;
+			tmp[2] = (crash_base >>  8) & 0xff;
+			tmp[3] = (crash_base      ) & 0xff;
+			len = 4;
+		}
+
+		sizecell = fdt_getprop(blob_buf, 0, "#size-cells", NULL);
+		/* use shifts and mask to ensure endianness */
+		if ((sizecell) && (*sizecell == 2)) {
+			tmp[0+len] = (crash_size >> 56) & 0xff;
+			tmp[1+len] = (crash_size >> 48) & 0xff;
+			tmp[2+len] = (crash_size >> 40) & 0xff;
+			tmp[3+len] = (crash_size >> 32) & 0xff;
+			tmp[4+len] = (crash_size >> 24) & 0xff;
+			tmp[5+len] = (crash_size >> 16) & 0xff;
+			tmp[6+len] = (crash_size >>  8) & 0xff;
+			tmp[7+len] = (crash_size      ) & 0xff;
+			len += 8;
+		} else {
+			tmp[0+len] = (crash_size >> 24) & 0xff;
+			tmp[1+len] = (crash_size >> 16) & 0xff;
+			tmp[2+len] = (crash_size >>  8) & 0xff;
+			tmp[3+len] = (crash_size      ) & 0xff;
+			len += 4;
+		}
+
+		if (fdt_setprop(blob_buf, nodeoffset, "reg", tmp, len) != 0) {
+			printf ("Error setting memory node!\n");
+		}
+
+		fdt_delprop(blob_buf, nodeoffset, "linux,usable-memory");
+	}
+}
+
+/* removes crashkernel nodes if they exist and we are *rebooting*
+ * into a crashkernel. These nodes should not exist after we
+ * crash and reboot into a new kernel
+ */
+static void fixup_crashkernel(struct kexec_info *info, char *blob_buf)
+{
+	int nodeoffset;
+
+	nodeoffset = fdt_path_offset(blob_buf, "/chosen");
+
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+	{
+		if (nodeoffset < 0)
+		{
+			printf("fdt_crashkernel: %s\n", fdt_strerror(nodeoffset));
+			return;
+		}
+
+		fdt_delprop(blob_buf, nodeoffset, "linux,crashkernel-base");
+		fdt_delprop(blob_buf, nodeoffset, "linux,crashkernel-size");
+	}
+}
+/* remove the old chosen nodes if they exist and add correct chosen
+ * nodes if we have an initd
+ */
+static void fixup_initrd(char *blob_buf)
+{
+	int err, nodeoffset;
+	unsigned long tmp;
+
+	nodeoffset = fdt_path_offset(blob_buf, "/chosen");
+
+	if ((reuse_initrd || ramdisk) &&
+		((ramdisk_base != 0) && (ramdisk_size != 0)))
+	{
+		if (nodeoffset < 0)
+		{
+			printf("fdt_initrd: %s\n", fdt_strerror(nodeoffset));
+			return;
+		}
+
+		tmp = ramdisk_base;
+		err = fdt_setprop(blob_buf, nodeoffset,
+			"linux,initrd-start", &tmp, sizeof(tmp));
+		if (err < 0) {
+			printf("WARNING: "
+				"could not set linux,initrd-start %s.\n",
+				fdt_strerror(err));
+				return;
+		}
+
+		tmp = ramdisk_base + ramdisk_size + 1;
+		err = fdt_setprop(blob_buf, nodeoffset,
+			"linux,initrd-end", &tmp, sizeof(tmp));
+		if (err < 0) {
+			printf("WARNING: could not set linux,initrd-end %s.\n",
+				fdt_strerror(err));
+				return;
+		}
+	} else {
+		fdt_delprop(blob_buf, nodeoffset, "linux,initrd-start");
+		fdt_delprop(blob_buf, nodeoffset, "linux,initrd-end");
+	}
+}
+
+char *fixup_dtb_init(struct kexec_info *info, char *blob_buf, off_t *blob_size,
+			unsigned long hole_addr, unsigned long *dtb_addr)
+{
+	int ret, i, num = fdt_num_mem_rsv(blob_buf);
+
 	fdt_init(blob_buf);
 
+	/* Remove the existing reserve regions as they will no longer
+	 * be valid after we reboot */
+	for (i = num - 1; i >= 0; i--)
+	{
+		ret = fdt_del_mem_rsv(blob_buf, i);
+		if (ret) {
+			printf("%s: Error deleting memory reserve region %d from device tree!\n",
+					fdt_strerror(ret), i);
+		}
+	}
+
+	/* Pack the FDT first, so we don't grow excessively if there is already free space */
+	ret = fdt_pack(blob_buf);
+	if (ret)
+		printf("%s: Unable to pack flat device tree\n", fdt_strerror(ret));
+
+	/* info->nr_segments just a guide, will grow by at least EXPAND_GRANULARITY */
+	blob_buf = expand_buf(info->nr_segments, blob_buf, blob_size);
+
+	/* add reserve region for *THIS* fdt */
+	*dtb_addr = locate_hole(info, *blob_size, 0,
+				hole_addr, hole_addr+KERNEL_ACCESS_TOP, -1);
+	ret = fdt_add_mem_rsv(blob_buf, *dtb_addr, PAGE_ALIGN(*blob_size));
+	if (ret) {
+		printf("%s: Unable to add new reserved memory for the flat device tree\n",
+			fdt_strerror(ret));
+	}
+
+	return blob_buf;
+}
+
+#ifdef DEBUG
+static void save_fixed_up_dtb(char *blob_buf, off_t blob_size)
+{
+	FILE *fp;
+
+	fp = fopen("debug.dtb", "w");
+	if (fp) {
+		if ( blob_size == fwrite(blob_buf, sizeof(char), blob_size, fp)) {
+			printf("debug.dtb written\n");
+		} else {
+			printf("Unable to write debug.dtb\n");
+		}
+	} else {
+		printf("Unable to dump flat device tree to debug.dtb\n");
+	}
+}
+#endif
+
+char *fixup_dtb_finalize(struct kexec_info *info, char *blob_buf, off_t *blob_size,
+			char *nodes[], char *cmdline)
+{
 	fixup_nodes(nodes);
 	fixup_cmdline(cmdline);
+	fixup_reserve_regions(info, blob_buf, blob_size);
+	fixup_memory(info, blob_buf);
+	fixup_initrd(blob_buf);
+	fixup_crashkernel(info, blob_buf);
 
 	blob_buf = (char *)dt_ops.finalize();
 	*blob_size = fdt_totalsize(blob_buf);
+
+#ifdef DEBUG
+	save_fixed_up_dtb(blob_buf, *blob_size);
+#endif
+
 	return blob_buf;
 }
diff --git a/kexec/arch/ppc/fixup_dtb.h b/kexec/arch/ppc/fixup_dtb.h
index 0ff981e..b706a5a 100644
--- a/kexec/arch/ppc/fixup_dtb.h
+++ b/kexec/arch/ppc/fixup_dtb.h
@@ -1,6 +1,10 @@
 #ifndef __FIXUP_DTB_H
 #define __FIXUP_DTB_H
 
-char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline);
+char *fixup_dtb_init(struct kexec_info *info, char *blob_buf, off_t *blob_size,
+			unsigned long hole_addr, unsigned long *dtb_addr);
+
+char *fixup_dtb_finalize(struct kexec_info *info, char *blob_buf, off_t *blob_size,
+			char *nodes[], char *cmdline);
 
 #endif
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 58bba54..3b55278 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -175,23 +175,20 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	unsigned char *setup_start;
 	uint32_t setup_size;
 #else
-	unsigned long long *rsvmap_ptr;
-	struct bootblock *bb_ptr;
-	unsigned int nr_segments;
-	unsigned long my_kernel, my_dt_offset;
-	unsigned long my_stack, my_backup_start;
-	unsigned int slave_code[256 / sizeof(unsigned int)], master_entry;
 	char *seg_buf = NULL;
 	off_t seg_size = 0;
 	int target_is_gamecube = 0;
 	unsigned int addr;
 	unsigned long dtb_addr;
+	unsigned long dtb_addr_actual;
 	unsigned long kernel_addr;
 #endif
 #define FIXUP_ENTRYS	(20)
 	char *fixup_nodes[FIXUP_ENTRYS + 1];
 	int cur_fixup = 0;
 	int opt;
+	char *blob_buf = NULL;
+	off_t blob_size = 0;
 
 	command_line = NULL;
 	dtb = NULL;
@@ -351,11 +348,28 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
 			purgatory_size, 0, elf_max_addr(&ehdr), 1, 0);
 
+	/* Here we need to initialize the device tree, and find out where
+	 * it is going to live so we can place it directly after the
+	 * kernel image */
+	if (dtb) {
+		/* Grab device tree from buffer */
+		blob_buf = slurp_file(dtb, &blob_size);
+	} else {
+		create_flatten_tree(info, (unsigned char **)&blob_buf,
+				(unsigned long *)&blob_size, cmdline_buf);
+	}
+	if (!blob_buf || !blob_size)
+		die("Device tree seems to be an empty file.\n");
+
+	/* initial fixup for device tree */
+	blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, kernel_addr, &dtb_addr);
+
 	if (ramdisk)
 	{
 		seg_buf = slurp_file(ramdisk, &seg_size);
+		/* load the ramdisk *above* the device tree */
 		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
-			0, 0, max_addr, 1);
+				0, dtb_addr + blob_size + 1,  max_addr, -1);
 		ramdisk_base = hole_addr;
 		ramdisk_size = seg_size;
 	}
@@ -377,111 +391,37 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		}
 	}
 
-	if (dtb) {
-		char *blob_buf;
-		off_t blob_size = 0;
-
-		/* Grab device tree from buffer */
-		blob_buf = slurp_file(dtb, &blob_size);
-		if (!blob_buf || !blob_size)
-			die("Device tree seems to be an empty file.\n");
-
-		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes,
-				cmdline_buf);
-		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, kernel_addr,
-				kernel_addr + KERNEL_ACCESS_TOP, -1);
-	} else {
-		/* create from fs2dt */
-		seg_buf = NULL;
-		seg_size = 0;
-		create_flatten_tree(info, (unsigned char **)&seg_buf,
-				(unsigned long *)&seg_size, cmdline_buf);
-		add_buffer(info, seg_buf, seg_size, seg_size,
-#ifdef CONFIG_PPC64
-				0, 0,  max_addr, -1);
-#else
-		/* load dev tree at 16 Mb offset from kernel load address */
-			0, 0, ehdr.e_phdr[0].p_paddr + SIZE_16M, -1);
-#endif
+	/* Perform final fixup on devie tree, i.e. everything beside what
+	 * was done above */
+	fixup_dtb_finalize(info, blob_buf, &blob_size, fixup_nodes,
+			cmdline_buf);
+	dtb_addr_actual = add_buffer(info, blob_buf, blob_size, blob_size, 0, dtb_addr,
+			kernel_addr + KERNEL_ACCESS_TOP, 1);
+	if (dtb_addr_actual != dtb_addr)
+	{
+		die("Error device tree not loadded to address it was expecting to be loaded too!\n");
 	}
 
+	/* set various variables for the purgatory  ehdr.e_entry is a
+	 * virtual address, we can use kernel_addr which
+	 * should be the physical start address of the kernel */
+	addr = kernel_addr;
+	elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
 
-	if (dtb) {
-		/* set various variables for the purgatory  ehdr.e_entry is a
-		 * virtual address, we can use kernel_addr which
-		 * should be the physical start address of the kernel */
-		addr = kernel_addr;
-		elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
-
-		addr = dtb_addr;
-		elf_rel_set_symbol(&info->rhdr, "dt_offset",
-						&addr, sizeof(addr));
+	addr = dtb_addr;
+	elf_rel_set_symbol(&info->rhdr, "dt_offset",
+					&addr, sizeof(addr));
 
 #define PUL_STACK_SIZE	(16 * 1024)
-		addr = locate_hole(info, PUL_STACK_SIZE, 0, 0,
+	addr = locate_hole(info, PUL_STACK_SIZE, 0, 0,
 				elf_max_addr(&ehdr), 1);
-		addr += PUL_STACK_SIZE;
-		elf_rel_set_symbol(&info->rhdr, "stack", &addr, sizeof(addr));
+	addr += PUL_STACK_SIZE;
+	elf_rel_set_symbol(&info->rhdr, "stack", &addr, sizeof(addr));
 #undef PUL_STACK_SIZE
 
-		addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
-		info->entry = (void *)addr;
-
-	} else { /*from fs2dt*/
-
-		/* patch reserve map address for flattened device-tree
-		 * find last entry (both 0) in the reserve mem list.  Assume DT
-		 * entry is before this one
-		 */
-		bb_ptr = (struct bootblock *)(
-			(unsigned char *)info->segment[(info->nr_segments) -
-				1].buf);
-		rsvmap_ptr = (unsigned long long *)(
-			(unsigned char *)info->segment[(info->nr_segments) -
-				1].buf + bb_ptr->off_mem_rsvmap);
-		while (*rsvmap_ptr || *(rsvmap_ptr + 1))
-			rsvmap_ptr += 2;
-		rsvmap_ptr -= 2;
-		*rsvmap_ptr = (unsigned long)(
-				info->segment[(info->nr_segments)-1].mem);
-		rsvmap_ptr++;
-		*rsvmap_ptr = (unsigned long long)bb_ptr->totalsize;
-
-		nr_segments = info->nr_segments;
-
-		/* Set kernel */
-		my_kernel = (unsigned long)info->segment[0].mem;
-		elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel,
-				sizeof(my_kernel));
-
-		/* Set dt_offset */
-		my_dt_offset = (unsigned long)info->segment[nr_segments -
-			1].mem;
-		elf_rel_set_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
-				sizeof(my_dt_offset));
-
-		/* get slave code from new kernel, put in purgatory */
-		elf_rel_get_symbol(&info->rhdr, "purgatory_start", slave_code,
-				sizeof(slave_code));
-		master_entry = slave_code[0];
-		memcpy(slave_code, info->segment[0].buf, sizeof(slave_code));
-		slave_code[0] = master_entry;
-		elf_rel_set_symbol(&info->rhdr, "purgatory_start", slave_code,
-				sizeof(slave_code));
-
-		/* Set stack address */
-		my_stack = locate_hole(info, 16*1024, 0, 0, max_addr, 1);
-		my_stack += 16*1024;
-		elf_rel_set_symbol(&info->rhdr, "stack", &my_stack,
-				sizeof(my_stack));
-	}
-
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		/* Set backup address */
-		my_backup_start = info->backup_start;
-		elf_rel_set_symbol(&info->rhdr, "backup_start",
-				&my_backup_start, sizeof(my_backup_start));
-	}
+	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
+	info->entry = (void *)addr;
 #endif
+
 	return 0;
 }
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index 5ad3575..029a656 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -64,6 +64,7 @@ typedef struct mem_rgns {
 } mem_rgns_t;
 extern mem_rgns_t usablemem_rgns;
 extern int max_memory_ranges;
+extern unsigned long long crash_base, crash_size;
 extern unsigned long long initrd_base, initrd_size;
 extern unsigned long long ramdisk_base, ramdisk_size;
 extern unsigned long long devicetree_base, devicetree_size;
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 310d6c3..479b86d 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -17,6 +17,9 @@
 #include "crashdump-powerpc.h"
 #include <limits.h>
 
+int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
+			char *);
+
 /* See options.h -- add any more there, too. */
 static const struct option options[] = {
 	KEXEC_ARCH_OPTIONS
@@ -57,6 +60,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	char *dtb;
 	unsigned int addr;
 	unsigned long dtb_addr;
+	unsigned long dtb_addr_actual;
 #define FIXUP_ENTRYS    (20)
 	char *fixup_nodes[FIXUP_ENTRYS + 1];
 	int cur_fixup = 0;
@@ -66,6 +70,8 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	off_t seg_size = 0;
 	unsigned long long hole_addr;
 	unsigned long max_addr;
+	char *blob_buf = NULL;
+	off_t blob_size = 0;
 
 	cmdline_buf = NULL;
 	command_line = NULL;
@@ -155,11 +161,31 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 			sizeof(crash_cmdline) -
 			strlen(crash_cmdline) - 1);
 
+	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
+				purgatory_size, 0, -1, -1, 0);
+
+	/* Here we need to initialize the device tree, and find out where
+	 * it is going to live so we can place it directly after the
+	 * kernel image */
+	if (dtb) {
+		/* Grab device tree from buffer */
+		blob_buf = slurp_file(dtb, &blob_size);
+	} else {
+		create_flatten_tree(info, (unsigned char **)&blob_buf,
+				(unsigned long *)&blob_size, cmdline_buf);
+	}
+	if (!blob_buf || !blob_size)
+		die("Device tree seems to be an empty file.\n");
+
+	/* initial fixup for device tree */
+	blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, load_addr, &dtb_addr);
+
 	if (ramdisk)
 	{
 		seg_buf = slurp_file(ramdisk, &seg_size);
+		/* Load ramdisk at top of memory */
 		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
-			0, 0, max_addr, 1);
+				0, dtb_addr + blob_size, max_addr, -1);
 		ramdisk_base = hole_addr;
 		ramdisk_size = seg_size;
 	}
@@ -181,24 +207,18 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		}
 	}
 
-	if (dtb) {
-		char *blob_buf;
-		off_t blob_size = 0;
-
-		/* Grab device tree from buffer */
-		blob_buf = slurp_file(dtb, &blob_size);
-		if (!blob_buf || !blob_size)
-			die("Device tree seems to be an empty file.\n");
-		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, cmdline_buf);
-		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, load_addr,
-				load_addr + KERNEL_ACCESS_TOP, -1);
-	} else {
-		dtb_addr = 0;
+	/* Perform final fixup on devie tree, i.e. everything beside what
+	 * was done above */
+	fixup_dtb_finalize(info, blob_buf, &blob_size, fixup_nodes,
+			cmdline_buf);
+	dtb_addr_actual = add_buffer(info, blob_buf, blob_size, blob_size, 0, dtb_addr,
+			load_addr + KERNEL_ACCESS_TOP, 1);
+	if (dtb_addr_actual != dtb_addr)
+	{
+		printf("dtb_addr_actual: %lx, dtb_addr: %lx\n", dtb_addr_actual, dtb_addr);
+		die("Error device tree not loadded to address it was expecting to be loaded too!\n");
 	}
 
-	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
-			purgatory_size, 0, -1, -1, 0);
-
 	/* set various variables for the purgatory */
 	addr = ep;
 	elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
diff --git a/kexec/arch/ppc/ops.h b/kexec/arch/ppc/ops.h
index f33e941..a2eb140 100644
--- a/kexec/arch/ppc/ops.h
+++ b/kexec/arch/ppc/ops.h
@@ -147,5 +147,4 @@ static inline char *get_path(const void *phandle, char *buf, int len)
 
 #define fatal(args...) { printf(args); exit(1); }
 
-char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline);
 #endif /* _PPC_BOOT_OPS_H_ */
-- 
1.6.0.6
