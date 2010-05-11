Return-Path: <muvarov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 8AD72B7D69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 00:53:45 +1000 (EST)
Received: by wyf19 with SMTP id 19so251204wyf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 07:53:42 -0700 (PDT)
From: Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH] Fix kexec on powerpc32
To: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
	uvarov@dev.rtsoft.ru
Date: Tue, 11 May 2010 18:53:12 +0400
Message-ID: <20100511145312.8107.68917.stgit@muvarov>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: lists@nerdbynature.de, horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello everybody,

      Please find here patch for user land kexec-tools application. Following
      patch makes kexec-tools work for both kexec and kdump. I tested it with 
      git kernel (linus-tree) and Freescale/Logic MPC8360ERDK board with 
      mpc83xx_defconfig kernel config.

      kexec:
      kexec -l vmlinux --command-line="console= ... etc"
      kexec -e

      kdump:
      kexec -p vmlinux_dump --command-line="console=... etc"
      echo c > /proc/sysrq-trigger

      I also think that is is reasonable:
      - put GAME_CUBE specific code to separate files;
      - combine  ppc and ppc64 to powerpc directory (I'm planning to do it.
	And that why in some places my patch have ifdefs for PPC64);

Best regards,
Maxim Uvarov.

From: Maxim Uvarov <muvarov@gmail.com>

Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
---

 kexec/arch/ppc/Makefile            |    2 
 kexec/arch/ppc/crashdump-powerpc.c |  439 ++++++++++++++++++++++++++++++++++
 kexec/arch/ppc/crashdump-powerpc.h |   38 +++
 kexec/arch/ppc/fs2dt.c             |  460 ++++++++++++++++++++++++++++++++++++
 kexec/arch/ppc/kexec-elf-ppc.c     |  186 +++++++++++++--
 kexec/arch/ppc/kexec-ppc.c         |  276 ++++++++++++++++++++--
 kexec/arch/ppc/kexec-ppc.h         |   32 +++
 purgatory/arch/ppc/Makefile        |    2 
 purgatory/arch/ppc/purgatory-ppc.c |   38 ++-
 purgatory/arch/ppc/purgatory-ppc.h |    4 
 purgatory/arch/ppc/v2wrap.S        |   66 -----
 purgatory/arch/ppc/v2wrap_32.S     |   91 +++++++
 12 files changed, 1524 insertions(+), 110 deletions(-)
 create mode 100644 kexec/arch/ppc/crashdump-powerpc.c
 create mode 100644 kexec/arch/ppc/crashdump-powerpc.h
 create mode 100644 kexec/arch/ppc/fs2dt.c
 delete mode 100644 purgatory/arch/ppc/v2wrap.S
 create mode 100644 purgatory/arch/ppc/v2wrap_32.S

diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 1c7441c..5988213 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -11,6 +11,8 @@ ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-uImage-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-simple.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/fixup_dtb.c
+ppc_KEXEC_SRCS += kexec/arch/ppc/fs2dt.c
+ppc_KEXEC_SRCS += kexec/arch/ppc/crashdump-powerpc.c
 ppc_KEXEC_SRCS += kexec/kexec-uImage.c
 
 libfdt_SRCS = kexec/arch/ppc/libfdt-wrapper.c
diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
new file mode 100644
index 0000000..7bfad20
--- /dev/null
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -0,0 +1,439 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <limits.h>
+#include <elf.h>
+#include <dirent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
+#include "../../crashdump.h"
+#include "kexec-ppc.h"
+#include "crashdump-powerpc.h"
+
+#ifdef CONFIG_PPC64
+static struct crash_elf_info elf_info64 = {
+class: ELFCLASS64,
+data: ELFDATA2MSB,
+machine: EM_PPC64,
+backup_src_start: BACKUP_SRC_START,
+backup_src_end: BACKUP_SRC_END,
+page_offset: PAGE_OFFSET,
+lowmem_limit: MAXMEM,
+};
+#endif
+static struct crash_elf_info elf_info32 = {
+class: ELFCLASS32,
+data: ELFDATA2MSB,
+#ifdef CONFIG_PPC64
+machine: EM_PPC64,
+#else
+machine: EM_PPC,
+#endif
+backup_src_start: BACKUP_SRC_START,
+backup_src_end: BACKUP_SRC_END,
+page_offset: PAGE_OFFSET,
+lowmem_limit: MAXMEM,
+};
+
+/* Stores a sorted list of RAM memory ranges for which to create elf headers.
+ * A separate program header is created for backup region
+ */
+static struct memory_range *crash_memory_range;
+
+/* Define a variable to replace the CRASH_MAX_MEMORY_RANGES macro */
+static int crash_max_memory_ranges;
+
+/*
+ * Used to save various memory ranges/regions needed for the captured
+ * kernel to boot. (lime memmap= option in other archs)
+ */
+mem_rgns_t usablemem_rgns = {0, NULL};
+
+/*
+ * To store the memory size of the first kernel and this value will be
+ * passed to the second kernel as command line (savemaxmem=xM).
+ * The second kernel will be calculated saved_max_pfn based on this
+ * variable.
+ * Since we are creating/using usable-memory property, there is no way
+ * we can determine the RAM size unless parsing the device-tree/memoy@/reg
+ * property in the kernel.
+ */
+unsigned long long saved_max_mem;
+
+/* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
+ * create Elf headers. Keeping it separate from get_memory_ranges() as
+ * requirements are different in the case of normal kexec and crashdumps.
+ *
+ * Normal kexec needs to look at all of available physical memory irrespective
+ * of the fact how much of it is being used by currently running kernel.
+ * Crashdumps need to have access to memory regions actually being used by
+ * running  kernel. Expecting a different file/data structure than /proc/iomem
+ * to look into down the line. May be something like /proc/kernelmem or may
+ * be zone data structures exported from kernel.
+ */
+static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
+{
+
+	int memory_ranges = 0;
+	char device_tree[256] = "/proc/device-tree/";
+	char fname[256];
+	char buf[MAXBYTES-1];
+	DIR *dir, *dmem;
+	FILE *file;
+	struct dirent *dentry, *mentry;
+	int i, n, crash_rng_len = 0;
+	unsigned long long start, end, cstart, cend;
+
+	crash_max_memory_ranges = max_memory_ranges + 6;
+	crash_rng_len = sizeof(struct memory_range) * crash_max_memory_ranges;
+
+	crash_memory_range = (struct memory_range *) malloc(crash_rng_len);
+	if (!crash_memory_range) {
+		fprintf(stderr, "Allocation for crash memory range failed\n");
+		return -1;
+	}
+	memset(crash_memory_range, 0, crash_rng_len);
+
+	/* create a separate program header for the backup region */
+	crash_memory_range[0].start = BACKUP_SRC_START;
+	crash_memory_range[0].end = BACKUP_SRC_END + 1;
+	crash_memory_range[0].type = RANGE_RAM;
+	memory_ranges++;
+
+	dir = opendir(device_tree);
+	if (!dir) {
+		perror(device_tree);
+		goto err;
+	}
+	while ((dentry = readdir(dir)) != NULL) {
+		if (strncmp(dentry->d_name, "memory@", 7)
+		    && strcmp(dentry->d_name, "memory"))
+			continue;
+		strcpy(fname, device_tree);
+		strcat(fname, dentry->d_name);
+		dmem = opendir(fname);
+		if (!dmem) {
+			perror(fname);
+			closedir(dir);
+			goto err;
+		}
+		while ((mentry = readdir(dmem)) != NULL) {
+			if (strcmp(mentry->d_name, "reg"))
+				continue;
+			strcat(fname, "/reg");
+			file = fopen(fname, "r");
+			if (!file) {
+				perror(fname);
+				closedir(dmem);
+				closedir(dir);
+				goto err;
+			}
+			n = fread(buf, 1, MAXBYTES, file);
+			if (n < 0) {
+				perror(fname);
+				fclose(file);
+				closedir(dmem);
+				closedir(dir);
+				goto err;
+			}
+			if (memory_ranges >= (max_memory_ranges + 1)) {
+				/* No space to insert another element. */
+				fprintf(stderr,
+					"Error: Number of crash memory ranges"
+					" excedeed the max limit\n");
+				goto err;
+			}
+
+			/*
+			 * FIXME: This code fails on platforms that
+			 * have more than one memory range specified
+			 * in the device-tree's /memory/reg property.
+			 * or where the #address-cells and #size-cells
+			 * are not identical.
+			 *
+			 * We should interpret the /memory/reg property
+			 * based on the values of the #address-cells and
+			 * #size-cells properites.
+			 */
+			if (n == (sizeof(unsigned long) * 2)) {
+				start = ((unsigned long *)buf)[0];
+				end = start + ((unsigned long *)buf)[1];
+			} else {
+				start = ((unsigned long long *)buf)[0];
+				end = start + ((unsigned long long *)buf)[1];
+			}
+			if (start == 0 && end >= (BACKUP_SRC_END + 1))
+				start = BACKUP_SRC_END + 1;
+
+			cstart = crash_base;
+			cend = crash_base + crash_size;
+			/*
+			 * Exclude the region that lies within crashkernel
+			 */
+			if (cstart < end && cend > start) {
+				if (start < cstart && end > cend) {
+					crash_memory_range[memory_ranges].start
+						= start;
+					crash_memory_range[memory_ranges].end
+						= cstart;
+					crash_memory_range[memory_ranges].type
+						= RANGE_RAM;
+					memory_ranges++;
+					crash_memory_range[memory_ranges].start
+						= cend;
+					crash_memory_range[memory_ranges].end
+						= end;
+					crash_memory_range[memory_ranges].type
+						= RANGE_RAM;
+					memory_ranges++;
+				} else if (start < cstart) {
+					crash_memory_range[memory_ranges].start
+						= start;
+					crash_memory_range[memory_ranges].end
+						= cstart;
+					crash_memory_range[memory_ranges].type
+						= RANGE_RAM;
+					memory_ranges++;
+				} else if (end > cend) {
+					crash_memory_range[memory_ranges].start
+						= cend;
+					crash_memory_range[memory_ranges].end
+						= end;
+					crash_memory_range[memory_ranges].type
+						= RANGE_RAM;
+					memory_ranges++;
+				}
+			} else {
+				crash_memory_range[memory_ranges].start = start;
+				crash_memory_range[memory_ranges].end  = end;
+				crash_memory_range[memory_ranges].type
+					= RANGE_RAM;
+				memory_ranges++;
+			}
+			fclose(file);
+		}
+		closedir(dmem);
+	}
+	closedir(dir);
+
+	/*
+	 * If RTAS region is overlapped with crashkernel, need to create ELF
+	 * Program header for the overlapped memory.
+	 */
+	if (crash_base < rtas_base + rtas_size &&
+		rtas_base < crash_base + crash_size) {
+		cstart = rtas_base;
+		cend = rtas_base + rtas_size;
+		if (cstart < crash_base)
+			cstart = crash_base;
+		if (cend > crash_base + crash_size)
+			cend = crash_base + crash_size;
+		crash_memory_range[memory_ranges].start = cstart;
+		crash_memory_range[memory_ranges++].end = cend;
+	}
+	/*
+	 * Can not trust the memory regions order that we read from
+	 * device-tree. Hence, get the MAX end value.
+	 */
+	for (i = 0; i < memory_ranges; i++)
+		if (saved_max_mem < crash_memory_range[i].end)
+			saved_max_mem = crash_memory_range[i].end;
+
+	*range = crash_memory_range;
+	*ranges = memory_ranges;
+#if DEBUG
+	int j;
+	printf("CRASH MEMORY RANGES\n");
+	for (j = 0; j < *ranges; j++) {
+		start = crash_memory_range[j].start;
+		end = crash_memory_range[j].end;
+		fprintf(stderr, "%016Lx-%016Lx\n", start, end);
+	}
+#endif
+	return 0;
+
+err:
+	if (crash_memory_range)
+		free(crash_memory_range);
+	return -1;
+}
+
+/* Converts unsigned long to ascii string. */
+static void ulltoa(unsigned long long i, char *str)
+{
+	int j = 0, k;
+	char tmp;
+
+	do {
+		str[j++] = i % 10 + '0';
+	} while ((i /= 10) > 0);
+	str[j] = '\0';
+
+	/* Reverse the string. */
+	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
+		tmp = str[k];
+		str[k] = str[j];
+		str[j] = tmp;
+	}
+}
+
+static int add_cmdline_param(char *cmdline, unsigned long long addr,
+				char *cmdstr, char *byte)
+{
+	int cmdlen, len, align = 1024;
+	char str[COMMAND_LINE_SIZE], *ptr;
+
+	/* Passing in =xxxK / =xxxM format. Saves space required in cmdline.*/
+	switch (byte[0]) {
+	case 'K':
+		if (addr%align)
+			return -1;
+		addr = addr/align;
+		break;
+	case 'M':
+		addr = addr/(align *align);
+		break;
+	}
+	ptr = str;
+	strcpy(str, cmdstr);
+	ptr += strlen(str);
+	ulltoa(addr, ptr);
+	strcat(str, byte);
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+#if DEBUG
+	fprintf(stderr, "Command line after adding elfcorehdr: %s\n", cmdline);
+#endif
+	return 0;
+}
+
+/* Loads additional segments in case of a panic kernel is being loaded.
+ * One segment for backup region, another segment for storing elf headers
+ * for crash memory image.
+ */
+int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
+				unsigned long max_addr, unsigned long min_base)
+{
+	void *tmp;
+	unsigned long sz, elfcorehdr;
+	int nr_ranges, align = 1024, i;
+	unsigned long long end;
+	struct memory_range *mem_range;
+
+	if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
+		return -1;
+
+	/* Create a backup region segment to store backup data*/
+	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+	tmp = xmalloc(sz);
+	memset(tmp, 0, sz);
+	info->backup_start = add_buffer(info, tmp, sz, sz, align,
+					0, max_addr, 1);
+	reserve(info->backup_start, sz);
+
+	/* On powerpc memory ranges in device-tree is denoted as start
+	 * and size rather than start and end, as is the case with
+	 * other architectures like i386 . Because of this when loading
+	 * the memory ranges in crashdump-elf.c the filesz calculation
+	 * [ end - start + 1 ] goes for a toss.
+	 *
+	 * To be in sync with other archs adjust the end value for
+	 * every crash memory range before calling the generic function
+	 */
+
+	for (i = 0; i < nr_ranges; i++) {
+		end = crash_memory_range[i].end - 1;
+		crash_memory_range[i].end = end;
+	}
+
+
+#ifdef CONFIG_PPC64
+	/* Create elf header segment and store crash image data. */
+	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
+		if (crash_create_elf64_headers(info, &elf_info64,
+					crash_memory_range, nr_ranges, &tmp,
+					&sz, ELF_CORE_HEADER_ALIGN) < 0)
+			return -1;
+	} else if (crash_create_elf32_headers(info, &elf_info32,
+				crash_memory_range, nr_ranges, &tmp, &sz,
+				ELF_CORE_HEADER_ALIGN) < 0)
+			return -1;
+#else
+	if (crash_create_elf32_headers(info, &elf_info32, crash_memory_range,
+				nr_ranges, &tmp, &sz, ELF_CORE_HEADER_ALIGN)
+			< 0)
+		return -1;
+#endif
+
+	elfcorehdr = add_buffer(info, tmp, sz, sz, align,
+			min_base, max_addr, 1);
+	reserve(elfcorehdr, sz);
+	/* modify and store the cmdline in a global array. This is later
+	 * read by flatten_device_tree and modified if required
+	 */
+	add_cmdline_param(mod_cmdline, elfcorehdr, " elfcorehdr=", "K");
+	add_cmdline_param(mod_cmdline, saved_max_mem, " savemaxmem=", "M");
+	return 0;
+}
+
+/*
+ * Used to save various memory regions needed for the captured kernel.
+ */
+
+void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
+{
+	int i;
+	unsigned long long end = base + size;
+	unsigned long long ustart, uend;
+
+	base = _ALIGN_DOWN(base, getpagesize());
+	end = _ALIGN_UP(end, getpagesize());
+
+	for (i = 0; i < usablemem_rgns.size; i++) {
+		ustart = usablemem_rgns.ranges[i].start;
+		uend = usablemem_rgns.ranges[i].end;
+		if (base < uend && end > ustart) {
+			if ((base >= ustart) && (end <= uend))
+				return;
+			if (base < ustart && end > uend) {
+				usablemem_rgns.ranges[i].start = base;
+				usablemem_rgns.ranges[i].end = end;
+				return;
+			} else if (base < ustart) {
+				usablemem_rgns.ranges[i].start = base;
+				return;
+			} else if (end > uend) {
+				usablemem_rgns.ranges[i].end = end;
+				return;
+			}
+		}
+	}
+	usablemem_rgns.ranges[usablemem_rgns.size].start = base;
+	usablemem_rgns.ranges[usablemem_rgns.size++].end = end;
+
+#ifdef DEBUG
+	fprintf(stderr, "usable memory rgns size:%u base:%llx size:%llx\n",
+		usablemem_rgns.size, base, size);
+#endif
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	int fd;
+
+	fd = open("/proc/device-tree/chosen/linux,crashkernel-base", O_RDONLY);
+	if (fd < 0)
+		return 0;
+	close(fd);
+	return 1;
+}
+
diff --git a/kexec/arch/ppc/crashdump-powerpc.h b/kexec/arch/ppc/crashdump-powerpc.h
new file mode 100644
index 0000000..dc2772d
--- /dev/null
+++ b/kexec/arch/ppc/crashdump-powerpc.h
@@ -0,0 +1,38 @@
+#ifndef CRASHDUMP_POWERPC_H
+#define CRASHDUMP_POWERPC_H
+
+struct kexec_info;
+int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
+				unsigned long max_addr, unsigned long min_base);
+void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
+
+extern struct arch_options_t arch_options;
+
+#ifdef CONFIG_PPC64
+#define PAGE_OFFSET	0xC000000000000000UL
+#define VMALLOCBASE	0xD000000000000000UL
+#define MAXMEM		(-KERNELBASE-VMALLOCBASE)
+#else
+#define PAGE_OFFSET	0xC0000000
+#define MAXMEM		0x30000000 /* Use CONFIG_LOWMEM_SIZE from kernel */
+#endif
+
+#define KERNELBASE	PAGE_OFFSET
+#define __pa(x)		((unsigned long)(x)-PAGE_OFFSET)
+
+#define COMMAND_LINE_SIZE	512 /* from kernel */
+/* Backup Region, First 64K of System RAM. */
+#define BACKUP_SRC_START	0x0000
+#define BACKUP_SRC_END		0xffff
+#define BACKUP_SRC_SIZE		(BACKUP_SRC_END - BACKUP_SRC_START + 1)
+
+#define KDUMP_BACKUP_LIMIT	BACKUP_SRC_SIZE
+#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
+#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
+
+extern unsigned long long crash_base;
+extern unsigned long long crash_size;
+extern unsigned int rtas_base;
+extern unsigned int rtas_size;
+
+#endif /* CRASHDUMP_POWERPC_H */
diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
new file mode 100644
index 0000000..238a3f2
--- /dev/null
+++ b/kexec/arch/ppc/fs2dt.c
@@ -0,0 +1,460 @@
+/*
+ * fs2dt: creates a flattened device-tree
+ *
+ * Copyright (C) 2004,2005  Milton D Miller II, IBM Corporation
+ * Copyright (C) 2005  R Sharada (sharada@in.ibm.com), IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <stdio.h>
+#include "../../kexec.h"
+#include "kexec-ppc.h"
+
+#define MAXPATH			1024	/* max path name length */
+#define NAMESPACE		16384	/* max bytes for property names */
+#define TREEWORDS		65536	/* max 32 bit words for properties */
+#define MEMRESERVE		256	/* max number of reserved memory blks */
+#define MAX_MEMORY_RANGES	1024
+#define COMMAND_LINE_SIZE	512	/* from kernel */
+
+static char pathname[MAXPATH];
+static char propnames[NAMESPACE] = { 0 };
+static unsigned dtstruct[TREEWORDS], *dt;
+static unsigned long long mem_rsrv[2*MEMRESERVE] = { 0, 0 };
+
+static int crash_param;
+static char local_cmdline[COMMAND_LINE_SIZE] = { "" };
+static unsigned *dt_len; /* changed len of modified cmdline
+			    in flat device-tree */
+static struct bootblock bb[1];
+
+void reserve(unsigned long long where, unsigned long long length)
+{
+	size_t offset;
+
+	for (offset = 0; mem_rsrv[offset + 1]; offset += 2)
+		;
+
+	if (offset + 4 >= 2 * MEMRESERVE)
+		die("unrecoverable error: exhasuted reservation meta data\n");
+
+	mem_rsrv[offset] = where;
+	mem_rsrv[offset + 1] = length;
+	mem_rsrv[offset + 3] = 0;  /* N.B: don't care about offset + 2 */
+}
+
+/* look for properties we need to reserve memory space for */
+static void checkprop(char *name, unsigned *data, int len)
+{
+	static unsigned long long base, size, end;
+
+	if ((data == NULL) && (base || size || end))
+		die("unrecoverable error: no property data");
+	else if (!strcmp(name, "linux,rtas-base"))
+		base = *data;
+	else if (!strcmp(name, "linux,tce-base"))
+		base = *(unsigned long long *) data;
+	else if (!strcmp(name, "rtas-size") ||
+			!strcmp(name, "linux,tce-size"))
+		size = *data;
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-start"))
+		if (len == 8)
+			base = *(unsigned long long *) data;
+		else
+			base = *data;
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-end"))
+		end = *(unsigned long long *) data;
+
+	if (size && end)
+		die("unrecoverable error: size and end set at same time\n");
+	if (base && size) {
+		reserve(base, size);
+		base = 0;
+		size = 0;
+	}
+	if (base && end) {
+		reserve(base, end-base);
+		base = 0;
+		end = 0;
+	}
+}
+
+/*
+ * return the property index for a property name, creating a new one
+ * if needed.
+ */
+static unsigned propnum(const char *name)
+{
+	unsigned offset = 0;
+
+	while (propnames[offset])
+		if (strcmp(name, propnames+offset))
+			offset += strlen(propnames+offset)+1;
+		else
+			return offset;
+
+	if (NAMESPACE - offset < strlen(name) + 1)
+		die("unrecoverable error: propnames overrun\n");
+
+	strcpy(propnames+offset, name);
+
+	return offset;
+}
+
+static void add_usable_mem_property(int fd, int len)
+{
+	char fname[MAXPATH], *bname;
+	unsigned long buf[2];
+	unsigned long ranges[2*MAX_MEMORY_RANGES];
+	unsigned long long base, end, loc_base, loc_end;
+	int range, rlen = 0;
+
+	strcpy(fname, pathname);
+	bname = strrchr(fname, '/');
+	bname[0] = '\0';
+	bname = strrchr(fname, '/');
+	if (strncmp(bname, "/memory@", 8) && strcmp(bname, "/memory"))
+		return;
+
+	if (len < 2 * sizeof(unsigned long))
+		die("unrecoverable error: not enough data for mem property\n");
+	len = 2 * sizeof(unsigned long);
+
+	if (lseek(fd, 0, SEEK_SET) < 0)
+		die("unrecoverable error: error seeking in \"%s\": %s\n",
+		    pathname, strerror(errno));
+	if (read(fd, buf, len) != len)
+		die("unrecoverable error: error reading \"%s\": %s\n",
+		    pathname, strerror(errno));
+
+	if (~0ULL - buf[0] < buf[1])
+		die("unrecoverable error: mem property overflow\n");
+	base = buf[0];
+	end = base + buf[1];
+
+	for (range = 0; range < usablemem_rgns.size; range++) {
+		loc_base = usablemem_rgns.ranges[range].start;
+		loc_end = usablemem_rgns.ranges[range].end;
+		if (loc_base >= base && loc_end <= end) {
+			ranges[rlen++] = loc_base;
+			ranges[rlen++] = loc_end - loc_base;
+		} else if (base < loc_end && end > loc_base) {
+			if (loc_base < base)
+				loc_base = base;
+			if (loc_end > end)
+				loc_end = end;
+			ranges[rlen++] = loc_base;
+			ranges[rlen++] = loc_end - loc_base;
+		}
+	}
+
+	if (!rlen) {
+		/*
+		 * User did not pass any ranges for thsi region. Hence, write
+		 * (0,0) duple in linux,usable-memory property such that
+		 * this region will be ignored.
+		 */
+		ranges[rlen++] = 0;
+		ranges[rlen++] = 0;
+	}
+
+	rlen = rlen * sizeof(unsigned long);
+	/*
+	 * No add linux,usable-memory property.
+	 */
+	*dt++ = 3;
+	*dt++ = rlen;
+	*dt++ = propnum("linux,usable-memory");
+	memcpy(dt, &ranges, rlen);
+	dt += (rlen + 3)/4;
+}
+
+/* put all properties (files) in the property structure */
+static void putprops(char *fn, struct dirent **nlist, int numlist)
+{
+	struct dirent *dp;
+	int i = 0, fd, len;
+	struct stat statbuf;
+
+	for (i = 0; i < numlist; i++) {
+		dp = nlist[i];
+		strcpy(fn, dp->d_name);
+
+		if (!strcmp(dp->d_name, ".") || !strcmp(dp->d_name, ".."))
+			continue;
+
+		if (lstat(pathname, &statbuf))
+			die("unrecoverable error: could not stat \"%s\": %s\n",
+			    pathname, strerror(errno));
+
+		if (!crash_param && !strcmp(fn, "linux,crashkernel-base"))
+			continue;
+
+		if (!crash_param && !strcmp(fn, "linux,crashkernel-size"))
+			continue;
+
+		/*
+		 * This property will be created for each node during kexec
+		 * boot. So, ignore it.
+		 */
+		if (!strcmp(dp->d_name, "linux,pci-domain") ||
+			!strcmp(dp->d_name, "linux,htab-base") ||
+			!strcmp(dp->d_name, "linux,htab-size") ||
+			!strcmp(dp->d_name, "linux,kernel-end") ||
+			!strcmp(dp->d_name, "linux,usable-memory"))
+				continue;
+
+		/* This property will be created/modified later in putnode()
+		 * So ignore it, unless we are reusing the initrd.
+		 */
+		if ((!strcmp(dp->d_name, "linux,initrd-start") ||
+		     !strcmp(dp->d_name, "linux,initrd-end")) &&
+		    !reuse_initrd)
+				continue;
+
+		if (!S_ISREG(statbuf.st_mode))
+			continue;
+
+		len = statbuf.st_size;
+
+		*dt++ = 3;
+		dt_len = dt;
+		*dt++ = len;
+		*dt++ = propnum(fn);
+
+		fd = open(pathname, O_RDONLY);
+		if (fd == -1)
+			die("unrecoverable error: could not open \"%s\": %s\n",
+			    pathname, strerror(errno));
+
+		if (read(fd, dt, len) != len)
+			die("unrecoverable error: could not read \"%s\": %s\n",
+			    pathname, strerror(errno));
+
+		checkprop(fn, dt, len);
+
+		/* Get the cmdline from the device-tree and modify it */
+		if (!strcmp(dp->d_name, "bootargs")) {
+			int cmd_len;
+			char temp_cmdline[COMMAND_LINE_SIZE] = { "" };
+			char *param = NULL;
+			cmd_len = strlen(local_cmdline);
+			if (cmd_len != 0) {
+				param = strstr(local_cmdline, "crashkernel=");
+				if (param)
+					crash_param = 1;
+				param = strstr(local_cmdline, "root=");
+			}
+			if (!param) {
+				char *old_param;
+				memcpy(temp_cmdline, dt, len);
+				param = strstr(temp_cmdline, "root=");
+				if (param) {
+					old_param = strtok(param, " ");
+					if (cmd_len != 0)
+						strcat(local_cmdline, " ");
+					strcat(local_cmdline, old_param);
+				}
+			}
+			strcat(local_cmdline, " ");
+			cmd_len = strlen(local_cmdline);
+			cmd_len = cmd_len + 1;
+			memcpy(dt, local_cmdline, cmd_len);
+			len = cmd_len;
+			*dt_len = cmd_len;
+#if	DEBUG
+			fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
+#endif
+		}
+
+		dt += (len + 3)/4;
+		if (!strcmp(dp->d_name, "reg") && usablemem_rgns.size)
+			add_usable_mem_property(fd, len);
+		close(fd);
+	}
+
+	fn[0] = '\0';
+	checkprop(pathname, NULL, 0);
+}
+
+/*
+ * Compare function used to sort the device-tree directories
+ * This function will be passed to scandir.
+ */
+static int comparefunc(const void *dentry1, const void *dentry2)
+{
+	char *str1 = (*(struct dirent **)dentry1)->d_name;
+	char *str2 = (*(struct dirent **)dentry2)->d_name;
+
+	/*
+	 * strcmp scans from left to right and fails to idetify for some
+	 * strings such as memory@10000000 and memory@f000000.
+	 * Therefore, we get the wrong sorted order like memory@10000000 and
+	 * memory@f000000.
+	 */
+	if (strchr(str1, '@') && strchr(str2, '@') &&
+		(strlen(str1) > strlen(str2)))
+		return 1;
+
+	return strcmp(str1, str2);
+}
+
+/*
+ * put a node (directory) in the property structure.  first properties
+ * then children.
+ */
+static void putnode(void)
+{
+	char *dn;
+	struct dirent *dp;
+	char *basename;
+	struct dirent **namelist;
+	int numlist, i;
+	struct stat statbuf;
+
+	numlist = scandir(pathname, &namelist, 0, comparefunc);
+	if (numlist < 0)
+		die("unrecoverable error: could not scan \"%s\": %s\n",
+		    pathname, strerror(errno));
+	if (numlist == 0)
+		die("unrecoverable error: no directory entries in \"%s\"",
+		    pathname);
+
+	basename = strrchr(pathname, '/') + 1;
+
+	*dt++ = 1;
+	strcpy((void *)dt, *basename ? basename : "");
+	dt += strlen((void *)dt) / sizeof(unsigned) + 1;
+
+	strcat(pathname, "/");
+	dn = pathname + strlen(pathname);
+
+	putprops(dn, namelist, numlist);
+
+	/* Add initrd entries to the second kernel */
+	if (initrd_base && !strcmp(basename, "chosen/")) {
+		int len = 8;
+		unsigned long long initrd_end;
+		*dt++ = 3;
+		*dt++ = len;
+		*dt++ = propnum("linux,initrd-start");
+
+		memcpy(dt, &initrd_base, len);
+		dt += (len + 3)/4;
+
+		len = 8;
+		*dt++ = 3;
+		*dt++ = len;
+		*dt++ = propnum("linux,initrd-end");
+
+		initrd_end = initrd_base + initrd_size;
+
+		memcpy(dt, &initrd_end, len);
+		dt += (len + 3)/4;
+
+		reserve(initrd_base, initrd_size);
+	}
+
+	for (i = 0; i < numlist; i++) {
+		dp = namelist[i];
+		strcpy(dn, dp->d_name);
+		free(namelist[i]);
+
+		if (!strcmp(dn, ".") || !strcmp(dn, ".."))
+			continue;
+
+		if (lstat(pathname, &statbuf))
+			die("unrecoverable error: could not stat \"%s\": %s\n",
+			    pathname, strerror(errno));
+
+		if (S_ISDIR(statbuf.st_mode))
+			putnode();
+	}
+
+	*dt++ = 2;
+	dn[-1] = '\0';
+	free(namelist);
+}
+
+int create_flatten_tree(struct kexec_info *info, unsigned char **bufp,
+			unsigned long *sizep, char *cmdline)
+{
+	unsigned long len;
+	unsigned long tlen;
+	unsigned char *buf;
+	unsigned long me;
+
+	me = 0;
+
+	strcpy(pathname, "/proc/device-tree/");
+
+	dt = dtstruct;
+
+	if (cmdline)
+		strcpy(local_cmdline, cmdline);
+
+	putnode();
+	*dt++ = 9;
+
+	len = sizeof(bb[0]);
+	len += 7; len &= ~7;
+
+	bb->off_mem_rsvmap = len;
+
+	for (len = 1; mem_rsrv[len]; len += 2)
+		;
+	len += 3;
+	len *= sizeof(mem_rsrv[0]);
+
+	bb->off_dt_struct = bb->off_mem_rsvmap + len;
+
+	len = dt - dtstruct;
+	len *= sizeof(unsigned);
+	bb->dt_struct_size = len;
+	bb->off_dt_strings = bb->off_dt_struct + len;
+
+	len = propnum("");
+	bb->dt_strings_size = len;
+	len +=  3; len &= ~3;
+	bb->totalsize = bb->off_dt_strings + len;
+
+	bb->magic = 0xd00dfeed;
+	bb->version = 17;
+	bb->last_comp_version = 16;
+
+	reserve(me, bb->totalsize); /* patched later in kexec_load */
+
+	buf = (unsigned char *) malloc(bb->totalsize);
+	*bufp = buf;
+	memcpy(buf, bb, bb->off_mem_rsvmap);
+	tlen = bb->off_mem_rsvmap;
+	memcpy(buf+tlen, mem_rsrv, bb->off_dt_struct - bb->off_mem_rsvmap);
+	tlen = tlen + (bb->off_dt_struct - bb->off_mem_rsvmap);
+	memcpy(buf+tlen, dtstruct,  bb->off_dt_strings - bb->off_dt_struct);
+	tlen = tlen +  (bb->off_dt_strings - bb->off_dt_struct);
+	memcpy(buf+tlen, propnames,  bb->totalsize - bb->off_dt_strings);
+	tlen = tlen + bb->totalsize - bb->off_dt_strings;
+	*sizep = tlen;
+	return 0;
+}
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index a54a5d5..4bcac26 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -23,15 +24,22 @@
 #include "../../kexec-elf.h"
 #include "kexec-ppc.h"
 #include <arch/options.h>
+#include "../../kexec-syscall.h"
+#include "crashdump-powerpc.h"
 
 #include "config.h"
 #include "fixup_dtb.h"
 
 static const int probe_debug = 0;
 
-#define MAX_COMMAND_LINE   256
+unsigned long long initrd_base, initrd_size;
+unsigned char reuse_initrd;
+const char *ramdisk;
+int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
+			char *);
 
 #define UPSZ(X) ((sizeof(X) + 3) & ~3)
+#ifdef WITH_GAMECUBE
 static struct boot_notes {
 	Elf_Bhdr hdr;
 	Elf_Nhdr bl_hdr;
@@ -65,7 +73,7 @@ static struct boot_notes {
 		.n_type = EBN_COMMAND_LINE,
 	},
 };
-
+#endif
 
 int elf_ppc_probe(const char *buf, off_t len)
 {
@@ -92,6 +100,7 @@ int elf_ppc_probe(const char *buf, off_t len)
 	return result;
 }
 
+#ifdef WITH_GAMECUBE
 static void gamecube_hack_addresses(struct mem_ehdr *ehdr)
 {
 	struct mem_phdr *phdr, *phdr_end;
@@ -112,6 +121,7 @@ static void gamecube_hack_addresses(struct mem_ehdr *ehdr)
 		phdr->p_paddr &= ~0xf0000000;	/* clear bits 0-3, ibm syntax */
 	}
 }
+#endif
 
 #define OPT_APPEND	(OPT_ARCH_MAX+0)
 #define OPT_GAMECUBE	(OPT_ARCH_MAX+1)
@@ -145,10 +155,24 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
-	char *command_line;
+	char *command_line, *crash_cmdline, *cmdline_buf;
 	int command_line_len;
 	char *dtb;
 	int result;
+	unsigned long max_addr, hole_addr;
+	struct mem_phdr *phdr;
+	size_t size;
+	unsigned long long *rsvmap_ptr;
+	struct bootblock *bb_ptr;
+	unsigned int nr_segments;
+	unsigned long my_kernel, my_dt_offset;
+	unsigned long my_stack, my_backup_start;
+#ifdef CONFIG_PPC64
+	unsigned long toc_addr;
+#endif
+	unsigned int slave_code[256 / sizeof(unsigned int)], master_entry;
+	unsigned char *seg_buf = NULL;
+	off_t seg_size = 0;
 #ifdef WITH_GAMECUBE
 	int target_is_gamecube = 1;
 	char *arg_buf;
@@ -170,6 +194,9 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 	command_line = NULL;
 	dtb = NULL;
+	max_addr = LONG_MAX;
+	hole_addr = 0;
+
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch (opt) {
 		default:
@@ -209,15 +236,45 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 	fixup_nodes[cur_fixup] = NULL;
 
+	/* Need to append some command line parameters internally in case of
+	 * taking crash dumps.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
+	} else
+		crash_cmdline = NULL;
+
 	/* Parse the Elf file */
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
 		free_elf_info(&ehdr);
 		return result;
 	}
+
+#ifdef WITH_GAMECUBE
 	if (target_is_gamecube) {
 		gamecube_hack_addresses(&ehdr);
 	}
+#endif
+
+	/* Load the Elf data. Physical load addresses in elf64 header do not
+	 * show up correctly. Use user supplied address for now to patch the
+	 * elf header
+	 */
+
+	phdr = &ehdr.e_phdr[0];
+	size = phdr->p_filesz;
+	if (size > phdr->p_memsz)
+		size = phdr->p_memsz;
+
+	hole_addr = locate_hole(info, size, 0, 0, max_addr, 1);
+#ifdef CONFIG_PPC64
+	ehdr.e_phdr[0].p_paddr = (Elf64_Addr)hole_addr;
+#else
+	ehdr.e_phdr[0].p_paddr = hole_addr;
+#endif
+
 	/* Load the Elf data */
 	result = elf_exec_load(&ehdr, info);
 	if (result < 0) {
@@ -225,6 +282,27 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		return result;
 	}
 
+	/* If panic kernel is being loaded, additional segments need
+	 * to be created.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info, crash_cmdline,
+						max_addr, 0);
+		if (result < 0) {
+			free(crash_cmdline);
+			return -1;
+		}
+	}
+
+	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
+	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
+	if (command_line)
+		strncat(cmdline_buf, command_line, command_line_len);
+	if (crash_cmdline)
+		strncat(cmdline_buf, crash_cmdline,
+				sizeof(crash_cmdline) -
+				strlen(crash_cmdline) - 1);
+
 	/*
 	 * In case of a toy we take the hardcoded things and an easy setup via
 	 * one of the assembly startups. Every thing else should be grown up
@@ -269,31 +347,105 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		blob_buf = slurp_file(dtb, &blob_size);
 		if (!blob_buf || !blob_size)
 			die("Device tree seems to be an empty file.\n");
-		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, command_line);
+		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes,
+				cmdline_buf);
 		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
 				KERNEL_ACCESS_TOP, -1);
 	} else {
-		dtb_addr = 0;
+		/* create from fs2dt */
+		seg_buf = NULL;
+		seg_size = 0;
+		create_flatten_tree(info, (unsigned char **)&seg_buf,
+				(unsigned long *)&seg_size, cmdline_buf);
+		add_buffer(info, seg_buf, seg_size, seg_size,
+#ifdef CONFIG_PPC64
+				0, 0,  max_addr, -1);
+#else
+		/* load dev tree at 16 Mb offset from kernel load address */
+			0, 0, ehdr.e_phdr[0].p_paddr + SIZE_16M, -1);
+#endif
 	}
 
-	/* set various variables for the purgatory */
-	addr = ehdr.e_entry;
-	elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
 
-	addr = dtb_addr;
-	elf_rel_set_symbol(&info->rhdr, "dt_offset", &addr, sizeof(addr));
+	if (dtb) {
+		/* set various variables for the purgatory */
+		addr = ehdr.e_entry;
+		elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
+
+		addr = dtb_addr;
+		elf_rel_set_symbol(&info->rhdr, "dt_offset",
+						&addr, sizeof(addr));
 
-	addr = rmo_top;
-	elf_rel_set_symbol(&info->rhdr, "mem_size", &addr, sizeof(addr));
+		addr = rmo_top;
+
+		elf_rel_set_symbol(&info->rhdr, "mem_size",
+						&addr, sizeof(addr));
 
 #define PUL_STACK_SIZE	(16 * 1024)
-	addr = locate_hole(info, PUL_STACK_SIZE, 0, 0, elf_max_addr(&ehdr), 1);
-	addr += PUL_STACK_SIZE;
-	elf_rel_set_symbol(&info->rhdr, "pul_stack", &addr, sizeof(addr));
+		addr = locate_hole(info, PUL_STACK_SIZE, 0, 0,
+				elf_max_addr(&ehdr), 1);
+		addr += PUL_STACK_SIZE;
+		elf_rel_set_symbol(&info->rhdr, "stack", &addr, sizeof(addr));
 #undef PUL_STACK_SIZE
 
-	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
-	info->entry = (void *)addr;
+		addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
+		info->entry = (void *)addr;
+
+	} else { /*from fs2dt*/
+
+		/* patch reserve map address for flattened device-tree
+		 * find last entry (both 0) in the reserve mem list.  Assume DT
+		 * entry is before this one
+		 */
+		bb_ptr = (struct bootblock *)(
+			(unsigned char *)info->segment[(info->nr_segments) -
+				1].buf);
+		rsvmap_ptr = (unsigned long long *)(
+			(unsigned char *)info->segment[(info->nr_segments) -
+				1].buf + bb_ptr->off_mem_rsvmap);
+		while (*rsvmap_ptr || *(rsvmap_ptr + 1))
+			rsvmap_ptr += 2;
+		rsvmap_ptr -= 2;
+		*rsvmap_ptr = (unsigned long)(
+				info->segment[(info->nr_segments)-1].mem);
+		rsvmap_ptr++;
+		*rsvmap_ptr = (unsigned long long)bb_ptr->totalsize;
+
+		nr_segments = info->nr_segments;
+
+		/* Set kernel */
+		my_kernel = (unsigned long)info->segment[0].mem;
+		elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel,
+				sizeof(my_kernel));
+
+		/* Set dt_offset */
+		my_dt_offset = (unsigned long)info->segment[nr_segments -
+			1].mem;
+		elf_rel_set_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
+				sizeof(my_dt_offset));
+
+		/* get slave code from new kernel, put in purgatory */
+		elf_rel_get_symbol(&info->rhdr, "purgatory_start", slave_code,
+				sizeof(slave_code));
+		master_entry = slave_code[0];
+		memcpy(slave_code, info->segment[0].buf, sizeof(slave_code));
+		slave_code[0] = master_entry;
+		elf_rel_set_symbol(&info->rhdr, "purgatory_start", slave_code,
+				sizeof(slave_code));
+
+		/* Set stack address */
+		my_stack = locate_hole(info, 16*1024, 0, 0, max_addr, 1);
+		my_stack += 16*1024;
+		elf_rel_set_symbol(&info->rhdr, "stack", &my_stack,
+				sizeof(my_stack));
+	}
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		/* Set backup address */
+		my_backup_start = info->backup_start;
+		elf_rel_set_symbol(&info->rhdr, "backup_start",
+				&my_backup_start, sizeof(my_backup_start));
+	}
 #endif
 	return 0;
 }
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index f552d79..aabc02f 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -21,6 +21,7 @@
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-ppc.h"
+#include "crashdump-powerpc.h"
 #include <arch/options.h>
 
 #include "config.h"
@@ -45,13 +46,14 @@ static int get_memory_ranges_gc(struct memory_range **range, int *ranges,
 }
 #else
 static int use_new_dtb;
-static int max_memory_ranges;
+int max_memory_ranges;
 static int nr_memory_ranges, nr_exclude_ranges;
 static struct memory_range *exclude_range;
 static struct memory_range *memory_range;
 static struct memory_range *base_memory_range;
 static uint64_t memory_max;
 uint64_t rmo_top;
+unsigned long long crash_base, crash_size;
 unsigned int rtas_base, rtas_size;
 
 /*
@@ -174,7 +176,40 @@ static int sort_base_ranges(void)
 
 #define MAXBYTES 128
 
-/* Get base memory ranges */
+static int realloc_memory_ranges(void)
+{
+	size_t memory_range_len;
+
+	max_memory_ranges++;
+	memory_range_len = sizeof(struct memory_range) * max_memory_ranges;
+
+	memory_range = (struct memory_range *) malloc(memory_range_len);
+	if (!memory_range)
+		goto err;
+
+	base_memory_range = (struct memory_range *) realloc(memory_range,
+			memory_range_len);
+	if (!base_memory_range)
+		goto err;
+
+	exclude_range = (struct memory_range *) realloc(exclude_range,
+			memory_range_len);
+	if (!exclude_range)
+		goto err;
+
+	usablemem_rgns.ranges = (struct memory_range *)
+				realloc(usablemem_rgns.ranges,
+						memory_range_len);
+	if (!(usablemem_rgns.ranges))
+		goto err;
+
+	return 0;
+
+err:
+	fprintf(stderr, "memory range structure re-allocation failure\n");
+	return -1;
+}
+
 static int get_base_ranges(void)
 {
 	int local_memory_ranges = 0;
@@ -219,8 +254,10 @@ static int get_base_ranges(void)
 				return -1;
 			}
 			if (local_memory_ranges >= max_memory_ranges) {
-				fclose(file);
-				break;
+				if (realloc_memory_ranges() < 0){
+	-				fclose(file);
+					break;
+				}
 			}
 			base_memory_range[local_memory_ranges].start =
 				((uint32_t *)buf)[0];
@@ -250,16 +287,23 @@ static int get_base_ranges(void)
 /* Get devtree details and create exclude_range array
  * Also create usablemem_ranges for KEXEC_ON_CRASH
  */
-static int get_devtree_details(unsigned long UNUSED(kexec_flags))
+static int get_devtree_details(unsigned long kexec_flags)
 {
 	uint64_t rmo_base;
-	char buf[MAXBYTES];
+	unsigned long long tce_base;
+	unsigned int tce_size;
+	unsigned long long htab_base, htab_size;
+	unsigned long long kernel_end;
+	unsigned long long initrd_start, initrd_end;
+	char buf[MAXBYTES-1];
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	DIR *dir, *cdir;
 	FILE *file;
 	struct dirent *dentry;
+	struct stat fstat;
 	int n, i = 0;
+	unsigned long tmp_long;
 
 	if ((dir = opendir(device_tree)) == NULL) {
 		perror(device_tree);
@@ -269,10 +313,10 @@ static int get_devtree_details(unsigned long UNUSED(kexec_flags))
 	while ((dentry = readdir(dir)) != NULL) {
 		if (strncmp(dentry->d_name, "chosen", 6) &&
 				strncmp(dentry->d_name, "memory@", 7) &&
-				strcmp(dentry->d_name, "memory") &&
+				strncmp(dentry->d_name, "memory", 6) &&
+				strncmp(dentry->d_name, "pci@", 4) &&
 				strncmp(dentry->d_name, "rtas", 4))
 			continue;
-
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
 		if ((cdir = opendir(fname)) == NULL) {
@@ -280,13 +324,172 @@ static int get_devtree_details(unsigned long UNUSED(kexec_flags))
 			goto error_opendir;
 		}
 
+		if (strncmp(dentry->d_name, "chosen", 6) == 0) {
+			strcat(fname, "/linux,kernel-end");
+			file = fopen(fname, "r");
+			if (!file) {
+				perror(fname);
+				goto error_opencdir;
+			}
+			if (fread(&tmp_long, sizeof(unsigned long), 1, file)
+					!= 1) {
+				perror(fname);
+				goto error_openfile;
+			}
+			kernel_end = tmp_long;
+			fclose(file);
+
+			/* Add kernel memory to exclude_range */
+			exclude_range[i].start = 0x0UL;
+			exclude_range[i].end = kernel_end;
+			i++;
+			if (i >= max_memory_ranges)
+				realloc_memory_ranges();
+			if (kexec_flags & KEXEC_ON_CRASH) {
+				memset(fname, 0, sizeof(fname));
+				strcpy(fname, device_tree);
+				strcat(fname, dentry->d_name);
+				strcat(fname, "/linux,crashkernel-base");
+				file = fopen(fname, "r");
+				if (!file) {
+					perror(fname);
+					goto error_opencdir;
+				}
+				if (fread(&tmp_long, sizeof(unsigned long), 1,
+						file) != 1) {
+					perror(fname);
+					goto error_openfile;
+				}
+				crash_base = tmp_long;
+				fclose(file);
+
+				memset(fname, 0, sizeof(fname));
+				strcpy(fname, device_tree);
+				strcat(fname, dentry->d_name);
+				strcat(fname, "/linux,crashkernel-size");
+				file = fopen(fname, "r");
+				if (!file) {
+					perror(fname);
+					goto error_opencdir;
+				}
+				if (fread(&tmp_long, sizeof(unsigned long), 1,
+						file) != 1) {
+					perror(fname);
+					goto error_openfile;
+				}
+				crash_size = tmp_long;
+
+				if (crash_base > mem_min)
+					mem_min = crash_base;
+				if (crash_base + crash_size < mem_max)
+					mem_max = crash_base + crash_size;
+
+				add_usable_mem_rgns(0, crash_base + crash_size);
+				reserve(KDUMP_BACKUP_LIMIT,
+						crash_base-KDUMP_BACKUP_LIMIT);
+			}
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,htab-base");
+			file = fopen(fname, "r");
+			if (!file) {
+				closedir(cdir);
+				if (errno == ENOENT) {
+					/* Non LPAR */
+					errno = 0;
+					continue;
+				}
+				perror(fname);
+				goto error_opendir;
+			}
+			if (fread(&htab_base, sizeof(unsigned long), 1, file)
+					!= 1) {
+				perror(fname);
+				goto error_openfile;
+			}
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,htab-size");
+			file = fopen(fname, "r");
+			if (!file) {
+				perror(fname);
+				goto error_opencdir;
+			}
+			if (fread(&htab_size, sizeof(unsigned long), 1, file)
+					!= 1) {
+				perror(fname);
+				goto error_openfile;
+			}
+			/* Add htab address to exclude_range - NON-LPAR only */
+			exclude_range[i].start = htab_base;
+			exclude_range[i].end = htab_base + htab_size;
+			i++;
+			if (i >= max_memory_ranges)
+				realloc_memory_ranges();
+
+			/* reserve the initrd_start and end locations. */
+			if (reuse_initrd) {
+				memset(fname, 0, sizeof(fname));
+				strcpy(fname, device_tree);
+				strcat(fname, dentry->d_name);
+				strcat(fname, "/linux,initrd-start");
+				file = fopen(fname, "r");
+				if (!file) {
+					perror(fname);
+					goto error_opencdir;
+				}
+				/* check for 4 and 8 byte initrd offset sizes */
+				if (stat(fname, &fstat) != 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (fread(&initrd_start, fstat.st_size, 1, file)
+						!= 1) {
+					perror(fname);
+					goto error_openfile;
+				}
+				fclose(file);
+
+				memset(fname, 0, sizeof(fname));
+				strcpy(fname, device_tree);
+				strcat(fname, dentry->d_name);
+				strcat(fname, "/linux,initrd-end");
+				file = fopen(fname, "r");
+				if (!file) {
+					perror(fname);
+					goto error_opencdir;
+				}
+				/* check for 4 and 8 byte initrd offset sizes */
+				if (stat(fname, &fstat) != 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (fread(&initrd_end, fstat.st_size, 1, file)
+						!= 1) {
+					perror(fname);
+					goto error_openfile;
+				}
+				fclose(file);
+
+				/* Add initrd address to exclude_range */
+				exclude_range[i].start = initrd_start;
+				exclude_range[i].end = initrd_end;
+				i++;
+				if (i >= max_memory_ranges)
+					realloc_memory_ranges();
+			}
+		} /* chosen */
+
 		if (strncmp(dentry->d_name, "rtas", 4) == 0) {
 			strcat(fname, "/linux,rtas-base");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
 				goto error_opencdir;
 			}
-			if (fread(&rtas_base, sizeof(unsigned int), 1, file) != 1) {
+			if (fread(&rtas_base, sizeof(unsigned int), 1, file)
+					!= 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -298,7 +501,8 @@ static int get_devtree_details(unsigned long UNUSED(kexec_flags))
 				perror(fname);
 				goto error_opencdir;
 			}
-			if (fread(&rtas_size, sizeof(unsigned int), 1, file) != 1) {
+			if (fread(&rtas_size, sizeof(unsigned int), 1, file)
+					!= 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -307,6 +511,8 @@ static int get_devtree_details(unsigned long UNUSED(kexec_flags))
 			exclude_range[i].start = rtas_base;
 			exclude_range[i].end = rtas_base + rtas_size;
 			i++;
+			if (kexec_flags & KEXEC_ON_CRASH)
+				add_usable_mem_rgns(rtas_base, rtas_size);
 		} /* rtas */
 
 		if (!strncmp(dentry->d_name, "memory@", 7) ||
@@ -336,6 +542,48 @@ static int get_devtree_details(unsigned long UNUSED(kexec_flags))
 			fclose(file);
 			closedir(cdir);
 		} /* memory */
+
+		if (strncmp(dentry->d_name, "pci@", 4) == 0) {
+			strcat(fname, "/linux,tce-base");
+			file = fopen(fname, "r");
+			if (!file) {
+				closedir(cdir);
+				if (errno == ENOENT) {
+					/* Non LPAR */
+					errno = 0;
+					continue;
+				}
+				perror(fname);
+				goto error_opendir;
+			}
+			if (fread(&tce_base, sizeof(unsigned long), 1, file)
+					!= 1) {
+				perror(fname);
+				goto error_openfile;
+				return -1;
+			}
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,tce-size");
+			file = fopen(fname, "r");
+			if (!file) {
+				perror(fname);
+				goto error_opencdir;
+			}
+			if (fread(&tce_size, sizeof(unsigned int), 1, file)
+					!= 1) {
+				perror(fname);
+				goto error_openfile;
+			}
+			/* Add tce to exclude_range - NON-LPAR only */
+			exclude_range[i].start = tce_base;
+			exclude_range[i].end = tce_base + tce_size;
+			i++;
+			if (kexec_flags & KEXEC_ON_CRASH)
+				add_usable_mem_rgns(tce_base, tce_size);
+			closedir(cdir);
+		} /* pci */
 	}
 	closedir(dir);
 
@@ -347,8 +595,8 @@ static int get_devtree_details(unsigned long UNUSED(kexec_flags))
 	int k;
 	for (k = 0; k < i; k++)
 		fprintf(stderr, "exclude_range sorted exclude_range[%d] "
-				"start:%llx, end:%llx\n", k, exclude_range[k].start,
-				exclude_range[k].end);
+			"start:%llx, end:%llx\n", k, exclude_range[k].start,
+			exclude_range[k].end);
 #endif
 	return 0;
 
@@ -532,7 +780,3 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
-int is_crashkernel_mem_reserved(void)
-{
-	return 0; /* kdump is not supported on this platform (yet) */
-}
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index 6cec467..fc0471f 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -1,6 +1,11 @@
 #ifndef KEXEC_PPC_H
 #define KEXEC_PPC_H
 
+#define MAXBYTES	128
+#define MAX_LINE	160
+#define CORE_TYPE_ELF32	1
+#define CORE_TYPE_ELF64	2
+
 extern unsigned char setup_simple_start[];
 extern uint32_t setup_simple_size;
 
@@ -16,6 +21,8 @@ extern struct {
 	uint32_t spr8;
 } setup_dol_regs;
 
+#define SIZE_16M	(16*1024*1024UL)
+
 int elf_ppc_probe(const char *buf, off_t len);
 int elf_ppc_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
@@ -37,4 +44,29 @@ void dol_ppc_usage(void);
  */
 #define KERNEL_ACCESS_TOP (24 * 1024 * 1024)
 
+/* boot block version 17 as defined by the linux kernel */
+struct bootblock {
+	unsigned magic,
+		totalsize,
+		off_dt_struct,
+		off_dt_strings,
+		off_mem_rsvmap,
+		version,
+		last_comp_version,
+		boot_physid,
+		dt_strings_size,
+		dt_struct_size;
+};
+
+typedef struct mem_rgns {
+	unsigned int size;
+	struct memory_range *ranges;
+} mem_rgns_t;
+extern mem_rgns_t usablemem_rgns;
+extern int max_memory_ranges;
+extern unsigned long long initrd_base, initrd_size;
+extern unsigned char reuse_initrd;
+#define COMMAND_LINE_SIZE	512 /* from kernel */
+/*fs2dt*/
+void reserve(unsigned long long where, unsigned long long length);
 #endif /* KEXEC_PPC_H */
diff --git a/purgatory/arch/ppc/Makefile b/purgatory/arch/ppc/Makefile
index 0dd18b6..72289a0 100644
--- a/purgatory/arch/ppc/Makefile
+++ b/purgatory/arch/ppc/Makefile
@@ -2,7 +2,7 @@
 # Purgatory ppc
 #
 
-ppc_PURGATORY_SRCS += purgatory/arch/ppc/v2wrap.S
+ppc_PURGATORY_SRCS += purgatory/arch/ppc/v2wrap_32.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/misc.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/purgatory-ppc.c
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/console-ppc.c
diff --git a/purgatory/arch/ppc/purgatory-ppc.c b/purgatory/arch/ppc/purgatory-ppc.c
index 01d0f38..3d7d484 100644
--- a/purgatory/arch/ppc/purgatory-ppc.c
+++ b/purgatory/arch/ppc/purgatory-ppc.c
@@ -1,19 +1,41 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Created by: Mohan Kumar M (mohan@in.ibm.com)
+ *
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
 #include <purgatory.h>
 #include "purgatory-ppc.h"
 
-unsigned int pul_stack = 0;
-unsigned int dt_offset = 0;
-unsigned int kernel = 0;
-unsigned int epapr_magic = 0;
-unsigned int mem_size = 0;
+unsigned int panic_kernel = 0;
+unsigned long backup_start = 0;
+unsigned long stack = 0;
+unsigned long dt_offset = 0;
+unsigned long my_toc = 0;
+unsigned long kernel = 0;
 
 void setup_arch(void)
 {
-	/* Nothing for now */
+	return;
 }
 
-/* This function can be used to execute after the SHA256 verification. */
 void post_verification_setup_arch(void)
 {
-	/* Nothing for now */
+	if (panic_kernel)
+		crashdump_backup_memory();
 }
diff --git a/purgatory/arch/ppc/purgatory-ppc.h b/purgatory/arch/ppc/purgatory-ppc.h
index e931cae..7eff8aa 100644
--- a/purgatory/arch/ppc/purgatory-ppc.h
+++ b/purgatory/arch/ppc/purgatory-ppc.h
@@ -1,6 +1,6 @@
 #ifndef PURGATORY_PPC_H
 #define PURGATORY_PPC_H
 
-/* nothing yet */
-
+void crashdump_backup_memory(void);
+void post_verification_setup_arch(void);
 #endif /* PURGATORY_PPC_H */
diff --git a/purgatory/arch/ppc/v2wrap.S b/purgatory/arch/ppc/v2wrap.S
deleted file mode 100644
index 79d188f..0000000
--- a/purgatory/arch/ppc/v2wrap.S
+++ /dev/null
@@ -1,66 +0,0 @@
-#
-#  kexec: Linux boots Linux
-#
-#  Copyright (C) 2004 - 2005, Milton D Miller II, IBM Corporation
-#  Copyright (C) 2006, Mohan Kumar M (mohan@in.ibm.com), IBM Corporation
-#  Copyright (C) 2008, Sebastian Andrzej Siewior (bigeasy@linutronix.de), linutronix
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation (version 2 of the License).
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-#
-
-#include "ppc_asm.h"
-
-# v2wrap.S
-# a wrapper to call purgatory code
-# Invokes ppc kernel with the arguments according to ePAPR v1.0
-# It assumes that the MSR is allready correct.
-
-# calling convention:
-#  no register are considred
-#
-
-#define LOADADDR(rn,name)	\
-	lis     rn,name##@h;	\
-	ori     rn,rn,name##@l;	\
-
-	.globl purgatory_start
-purgatory_start:
-
-	LOADADDR(r6,pul_stack)
-	lwz	r1,0(r6)		#setup stack
-
-	subi	r1, r1, 112
-	bl	purgatory
-	nop
-
-	LOADADDR(r6,kernel)
-	lwz	r4,0(r6)		# load the kernel address
-	mtlr	r4			# prepare branch too
-
-	LOADADDR(r6, dt_offset)
-	lwz	r3, 0(r6)		# load device-tree address
-
-	li	r4, 0
-	li	r5, 0
-
-	LOADADDR(r6, epapr_magic)	# ePAPR magic value
-	lwz	r6, 0(r6)
-
-	LOADADDR(r7, mem_size)		# the Initial Mapped Area
-	lwz	r7, 0(r6)
-
-	li	r8, 0
-	li	r9, 0
-
-	blr				# start kernel
diff --git a/purgatory/arch/ppc/v2wrap_32.S b/purgatory/arch/ppc/v2wrap_32.S
new file mode 100644
index 0000000..8442d16
--- /dev/null
+++ b/purgatory/arch/ppc/v2wrap_32.S
@@ -0,0 +1,91 @@
+#
+#  kexec: Linux boots Linux
+#
+#  Copyright (C) 2004 - 2005, Milton D Miller II, IBM Corporation
+#  Copyright (C) 2006, Mohan Kumar M (mohan@in.ibm.com), IBM Corporation
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation (version 2 of the License).
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#
+
+# v2wrap.S
+# a wrapper to call purgatory code to backup first
+# 32kB of first kernel into the backup region
+# reserved by kexec-tools.
+# Invokes powerpc kernel with the expected arguments
+# of kernel(device-tree, phys-offset, 0)
+
+#
+# calling convention:
+#   r3 = physical number of this cpu (all cpus)
+#   r4 = address of this chunk (master only)
+# master enters at purgatory_start (aka first byte of this chunk)
+# slaves (additional cpus), if any, enter a copy of the
+# first 0x100 bytes of this code relocated to 0x0
+#
+# in other words,
+#   a copy of the first 0x100 bytes of this code is copied to 0
+#   and the slaves are sent to address 0x60
+#   with r3 = their physical cpu number.
+
+	.globl purgatory_start
+purgatory_start:	b	master
+	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
+slave:	b $
+	.org purgatory_start + 0x100    # ABI: end of copied region
+	.size purgatory_start, . - purgatory_start
+
+#
+# The above 0x100 bytes at purgatory_start are replaced with the
+# code from the kernel (or next stage) by kexec/arch/powerpc/kexec-powerpc.c
+#
+
+master:
+	or	1,1,1		# low priority to let other threads catchup
+	isync
+	mr      17,3            # save cpu id to r17
+	mr      15,4            # save physical address in reg15
+
+	lis	6,stack@h
+	ori	6,6,stack@l
+	lwz     1,0(6)          #setup stack
+
+	subi    1,1,112
+	bl      purgatory
+	nop
+
+	or	3,3,3		# ok now to high priority, lets boot
+	lis	6,0x1
+	mtctr	6		# delay a bit for slaves to catch up
+83:	bdnz	83b		# before we overwrite 0-100 again
+
+	lis	6,dt_offset@h
+	ori	6,6,dt_offset@l
+	lwz     3,0(6)          # load device-tree address
+	lwz     6,20(3)         # fetch version number
+	cmpwi   0,6,2           # v2 ?
+	blt     80f
+	stw     17,28(3)        # save my cpu number as boot_cpu_phys
+80:
+	lis	6,kernel@h
+	ori	6,6,kernel@l
+	lwz     4,0(6)          # load the kernel address
+	li	5,0		# r5 will be 0 for kernel
+	li	6,0		# clear r6 for good measure
+	mtctr	4		# prepare branch too
+
+	lwz	8,0(4)		# get the first instruction that we stole
+	stw	8,0(0)		# and put it in the slave loop at 0
+				# skip cache flush, do we care?
+
+	bctr			# start kernel
