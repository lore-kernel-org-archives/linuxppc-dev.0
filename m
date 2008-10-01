Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A077ADE23B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 07:20:32 +1000 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: dtb and purgatory support for ppc32
Date: Wed,  1 Oct 2008 23:20:24 +0200
Message-Id: <1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Siewior <bigeasy@linutronix.de>

Some code dtb scanning & filling has been borrowed from ppc64.
The old behavior is still available if compiled with GameCube,
other PowerPC platform use the can purgatory and specify a new
dtb.
The purgatory is disabled because somehting is wrong and I dunno
the reason. Booting a self containd cuImage (incl. dtb / wiuthout
the need for a bd sturct) can be booted.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kexec/arch/ppc/Makefile            |    1 +
 kexec/arch/ppc/kexec-elf-ppc.c     |  167 ++++++++++----
 kexec/arch/ppc/kexec-elf-rel-ppc.c |    4 +
 kexec/arch/ppc/kexec-ppc.c         |  469 +++++++++++++++++++++++++++++++++++-
 purgatory/arch/ppc/Makefile        |    1 +
 purgatory/arch/ppc/purgatory-ppc.c |    4 +
 purgatory/arch/ppc/v2wrap.S        |   54 ++++
 7 files changed, 652 insertions(+), 48 deletions(-)
 create mode 100644 purgatory/arch/ppc/v2wrap.S

diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 1550c20..ac05bf8 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -7,6 +7,7 @@ ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-elf-rel-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-dol-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-simple.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
+ppc_KEXEC_SRCS += kexec/arch/ppc64/fs2dt.c
 
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
 	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ppc_asm.h		\
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 530e501..d4cfb93 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -26,6 +26,15 @@
 
 #include "config.h"
 
+/* these are here to keep arch/ppc64/fs2dt.c happy and are not implemented */
+#include "../ppc64/kexec-ppc64.h"
+mem_rgns_t usablemem_rgns = {0, NULL};
+unsigned char reuse_initrd = 0;
+uint64_t initrd_base, initrd_size;
+/* */
+
+int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
+		char *);
 static const int probe_debug = 0;
 
 #define MAX_COMMAND_LINE   256
@@ -91,16 +100,6 @@ int elf_ppc_probe(const char *buf, off_t len)
 	return result;
 }
 
-void elf_ppc_usage(void)
-{
-	printf
-	    (
-	     "    --command-line=STRING Set the kernel command line to STRING.\n"
-	     "    --append=STRING       Set the kernel command line to STRING.\n"
-	     "    --gamecube=1|0        Enable/disable support for ELFs with changed\n"
-	     "                          addresses suitable for the GameCube.\n");
-}
-
 static void gamecube_hack_addresses(struct mem_ehdr *ehdr)
 {
 	struct mem_phdr *phdr, *phdr_end;
@@ -122,6 +121,36 @@ static void gamecube_hack_addresses(struct mem_ehdr *ehdr)
 	}
 }
 
+#define OPT_APPEND	(OPT_ARCH_MAX+0)
+#define OPT_GAMECUBE	(OPT_ARCH_MAX+1)
+#define OPT_DTB		(OPT_ARCH_MAX+2)
+static const struct option options[] = {
+	KEXEC_ARCH_OPTIONS
+	{"command-line", 1, 0, OPT_APPEND},
+	{"append",       1, 0, OPT_APPEND},
+	{"gamecube",     1, 0, OPT_GAMECUBE},
+	{"dtb",     1, 0, OPT_DTB},
+	{0, 0, 0, 0},
+};
+static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+
+void elf_ppc_usage(void)
+{
+	printf(
+	     "    --command-line=STRING Set the kernel command line to STRING.\n"
+	     "    --append=STRING       Set the kernel command line to STRING.\n"
+	     "    --gamecube=1|0        Enable/disable support for ELFs with changed\n"
+	     "                          addresses suitable for the GameCube.\n"
+	     "     --devicetreeblob=<filename> Specify device tree blob file.\n"
+	     );
+}
+
+#ifdef WITH_GAMECUBE
+static int go_purgatory = 0;
+#else
+static int go_purgatory = 1;
+#endif
+
 int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len, 
 	struct kexec_info *info)
 {
@@ -131,10 +160,11 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	unsigned long arg_base;
 	struct boot_notes *notes;
 	size_t note_bytes;
-	const char *command_line;
+	char *command_line;
 	int command_line_len;
 	unsigned char *setup_start;
 	uint32_t setup_size;
+	char *dtb;
 	int result;
 #ifdef WITH_GAMECUBE
 	int target_is_gamecube = 1;
@@ -142,19 +172,9 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	int target_is_gamecube = 0;
 #endif
 	int opt;
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-#define OPT_GAMECUBE	(OPT_ARCH_MAX+1)
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{"command-line", 1, 0, OPT_APPEND},
-		{"append",       1, 0, OPT_APPEND},
-		{"gamecube",     1, 0, OPT_GAMECUBE},
-		{0, 0, 0, 0},
-	};
 
-	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
-
-	command_line = 0;
+	command_line = NULL;
+	dtb = NULL;
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch (opt) {
 		default:
@@ -171,6 +191,10 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		case OPT_GAMECUBE:
 			target_is_gamecube = atoi(optarg);
 			break;
+
+		case OPT_DTB:
+			dtb = optarg;
+			break;
 		}
 	}
 	command_line_len = 0;
@@ -194,31 +218,86 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		return result;
 	}
 
-	if (target_is_gamecube) {
-		setup_start = setup_dol_start;
-		setup_size = setup_dol_size;
-		setup_dol_regs.spr8 = ehdr.e_entry;	/* Link Register */
+	/*
+	 * In case of a toy we take the hardcoded things and an easy setup via
+	 * one of the assembly startups. Every thing else should be grown up
+	 * and go through the purgatory.
+	 */
+	if (!go_purgatory) {
+		if (target_is_gamecube) {
+			setup_start = setup_dol_start;
+			setup_size = setup_dol_size;
+			setup_dol_regs.spr8 = ehdr.e_entry;	/* Link Register */
+		} else {
+			setup_start = setup_simple_start;
+			setup_size = setup_simple_size;
+			setup_simple_regs.spr8 = ehdr.e_entry;	/* Link Register */
+		}
+
+		note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
+		arg_bytes = note_bytes + ((setup_size + 3) & ~3);
+
+		arg_buf = xmalloc(arg_bytes);
+		arg_base = add_buffer(info, arg_buf, arg_bytes, arg_bytes, 4,
+				0, elf_max_addr(&ehdr), 1);
+
+		notes = (struct boot_notes *)(arg_buf + ((setup_size + 3) & ~3));
+
+		memcpy(arg_buf, setup_start, setup_size);
+		memcpy(notes, &elf_boot_notes, sizeof(elf_boot_notes));
+		memcpy(notes->command_line, command_line, command_line_len);
+		notes->hdr.b_size = note_bytes;
+		notes->cmd_hdr.n_descsz = command_line_len;
+		notes->hdr.b_checksum = compute_ip_checksum(notes, note_bytes);
+
+		info->entry = (void *)arg_base;
+
 	} else {
-		setup_start = setup_simple_start;
-		setup_size = setup_simple_size;
-		setup_simple_regs.spr8 = ehdr.e_entry;	/* Link Register */
-	}
-	note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
-	arg_bytes = note_bytes + ((setup_size + 3) & ~3);
+		unsigned char *seg_buf;
+		unsigned long seg_size;
+		unsigned int addr;
+
+		elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
+				purgatory_size, 0, elf_max_addr(&ehdr), 1, 0);
 
-	arg_buf = xmalloc(arg_bytes);
-	arg_base = add_buffer(info, 
-		arg_buf, arg_bytes, arg_bytes, 4, 0, elf_max_addr(&ehdr), 1);
+		if (dtb) {
+			char *blob_buf;
+			off_t blob_size = 0;
 
-	notes = (struct boot_notes *)(arg_buf + ((setup_size + 3) & ~3));
+			/* Grab device tree from buffer */
+			blob_buf = slurp_file(dtb, &blob_size);
+			add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
+					elf_max_addr(&ehdr), -1);
+		} else {
+			seg_buf = NULL;
+			seg_size = 0;
+			create_flatten_tree(info, &seg_buf, &seg_size, command_line);
+			add_buffer(info, seg_buf, seg_size, seg_size,
+					0, 0, elf_max_addr(&ehdr), -1);
+		}
+		/* set various variables for the purgatory */
+		addr = ehdr.e_entry;
+		elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
+
+		addr = (unsigned int)info->segment[info->nr_segments - 1].mem;
+		elf_rel_set_symbol(&info->rhdr, "dt_offset", &addr, sizeof(addr));
+
+#define PUL_STACK_SIZE	(16 * 1024)
+		addr = locate_hole(info, PUL_STACK_SIZE, 0, 0, elf_max_addr(&ehdr), 1);
+		addr += PUL_STACK_SIZE;
+		elf_rel_set_symbol(&info->rhdr, "pul_stack", &addr, sizeof(addr));
+#undef PUL_STACK_SIZE
 
-	memcpy(arg_buf, setup_start, setup_size);
-	memcpy(notes, &elf_boot_notes, sizeof(elf_boot_notes));
-	memcpy(notes->command_line, command_line, command_line_len);
-	notes->hdr.b_size = note_bytes;
-	notes->cmd_hdr.n_descsz = command_line_len;
-	notes->hdr.b_checksum = compute_ip_checksum(notes, note_bytes);
+		addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
+		info->entry = (void *)addr;
 
-	info->entry = (void *)arg_base;
+		elf_rel_get_symbol(&info->rhdr, "pul_stack", &addr, sizeof(addr));
+		printf("Stack is: %08x\n", addr);
+		elf_rel_get_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
+		printf("Kernel is entry: %08x\n", addr);
+		elf_rel_get_symbol(&info->rhdr, "dt_offset", &addr, sizeof(addr));
+		printf("dtb is: %08x\n", addr);
+
+	}
 	return 0;
 }
diff --git a/kexec/arch/ppc/kexec-elf-rel-ppc.c b/kexec/arch/ppc/kexec-elf-rel-ppc.c
index e711f3b..9a66bed 100644
--- a/kexec/arch/ppc/kexec-elf-rel-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-rel-ppc.c
@@ -31,6 +31,10 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 		*(uint16_t *)location = value;
 		break;
 		
+	case R_PPC_ADDR16_HI:
+		*(uint16_t *)location = (value>>16) & 0xffff;
+		break;
+
 	case R_PPC_ADDR16_HA:
 		/* Sign-adjusted lower 16 bits: PPC ELF ABI says:
 		   (((x >> 16) + ((x & 0x8000) ? 1 : 0))) & 0xFFFF.
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index ef4fe35..183b4e5 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -12,6 +12,12 @@
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-ppc.h"
@@ -19,14 +25,13 @@
 
 #include "config.h"
 
+#ifdef WITH_GAMECUBE
 #define MAX_MEMORY_RANGES  64
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
-/* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges,
+static int get_memory_ranges_gc(struct memory_range **range, int *ranges,
 					unsigned long kexec_flags)
 {
-#ifdef WITH_GAMECUBE
 	int memory_ranges = 0;
 
 	/* RAM - lowmem used by DOLs - framebuffer */
@@ -37,9 +42,465 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	*range = memory_range;
 	*ranges = memory_ranges;
 	return 0;
+}
 #else
-	fprintf(stderr, "%s(): Unsupported platform\n", __func__);
+static int use_new_dtb;
+static int max_memory_ranges;
+static int nr_memory_ranges, nr_exclude_ranges;
+static struct memory_range *exclude_range;
+static struct memory_range *memory_range;
+static struct memory_range *base_memory_range;
+static uint64_t memory_max;
+static uint64_t rmo_top;
+unsigned int rtas_base, rtas_size;
+
+/*
+ * Count the memory nodes under /proc/device-tree and populate the
+ * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
+ * macro used earlier.
+ */
+static int count_memory_ranges(void)
+{
+	char device_tree[256] = "/proc/device-tree/";
+	struct dirent *dentry;
+	DIR *dir;
+
+	if ((dir = opendir(device_tree)) == NULL) {
+		perror(device_tree);
+		return -1;
+	}
+
+	while ((dentry = readdir(dir)) != NULL) {
+		if (strncmp(dentry->d_name, "memory@", 7) &&
+				strcmp(dentry->d_name, "memory"))
+			continue;
+		max_memory_ranges++;
+	}
+
+	/* need to add extra region for retained initrd */
+	if (use_new_dtb) {
+		max_memory_ranges++;
+	}
+
+	closedir(dir);
+	return 0;
+
+}
+
+ static void cleanup_memory_ranges(void)
+ {
+	 free(memory_range);
+	 free(base_memory_range);
+	 free(exclude_range);
+ }
+
+/*
+ * Allocate memory for various data structures used to hold
+ * values of different memory ranges
+ */
+static int alloc_memory_ranges(void)
+{
+	int memory_range_len;
+
+	memory_range_len = sizeof(struct memory_range) * max_memory_ranges;
+
+	memory_range = malloc(memory_range_len);
+	if (!memory_range)
+		return -1;
+
+	base_memory_range = malloc(memory_range_len);
+	if (!base_memory_range)
+		goto err1;
+
+	exclude_range = malloc(memory_range_len);
+	if (!exclude_range)
+		goto err1;
+
+#if 0
+	usablemem_rgns.ranges = (struct memory_range *)
+		malloc(memory_range_len);
+	if (!(usablemem_rgns.ranges))
+		goto err1;
+
+	memset(usablemem_rgns.ranges, 0, memory_range_len);
+#endif
+	memset(memory_range, 0, memory_range_len);
+	memset(base_memory_range, 0, memory_range_len);
+	memset(exclude_range, 0, memory_range_len);
+	return 0;
+
+err1:
+	fprintf(stderr, "memory range structure allocation failure\n");
+	cleanup_memory_ranges();
 	return -1;
+}
+
+/* Sort the exclude ranges in memory */
+static int sort_ranges(void)
+{
+	int i, j;
+	uint64_t tstart, tend;
+	for (i = 0; i < nr_exclude_ranges - 1; i++) {
+		for (j = 0; j < nr_exclude_ranges - i - 1; j++) {
+			if (exclude_range[j].start > exclude_range[j+1].start) {
+				tstart = exclude_range[j].start;
+				tend = exclude_range[j].end;
+				exclude_range[j].start = exclude_range[j+1].start;
+				exclude_range[j].end = exclude_range[j+1].end;
+				exclude_range[j+1].start = tstart;
+				exclude_range[j+1].end = tend;
+			}
+		}
+	}
+	return 0;
+}
+
+/* Sort the base ranges in memory - this is useful for ensuring that our
+ * ranges are in ascending order, even if device-tree read of memory nodes
+ * is done differently. Also, could be used for other range coalescing later
+ */
+static int sort_base_ranges(void)
+{
+	int i, j;
+	unsigned long long tstart, tend;
+
+	for (i = 0; i < nr_memory_ranges - 1; i++) {
+		for (j = 0; j < nr_memory_ranges - i - 1; j++) {
+			if (base_memory_range[j].start > base_memory_range[j+1].start) {
+				tstart = base_memory_range[j].start;
+				tend = base_memory_range[j].end;
+				base_memory_range[j].start = base_memory_range[j+1].start;
+				base_memory_range[j].end = base_memory_range[j+1].end;
+				base_memory_range[j+1].start = tstart;
+				base_memory_range[j+1].end = tend;
+			}
+		}
+	}
+	return 0;
+}
+
+
+#define MAXBYTES 128
+
+/* Get base memory ranges */
+static int get_base_ranges(void)
+{
+	int local_memory_ranges = 0;
+	char device_tree[256] = "/proc/device-tree/";
+	char fname[256];
+	char buf[MAXBYTES];
+	DIR *dir, *dmem;
+	FILE *file;
+	struct dirent *dentry, *mentry;
+	int n;
+
+	if ((dir = opendir(device_tree)) == NULL) {
+		perror(device_tree);
+		return -1;
+	}
+	while ((dentry = readdir(dir)) != NULL) {
+		if (strncmp(dentry->d_name, "memory@", 7) &&
+				strcmp(dentry->d_name, "memory"))
+			continue;
+		strcpy(fname, device_tree);
+		strcat(fname, dentry->d_name);
+		if ((dmem = opendir(fname)) == NULL) {
+			perror(fname);
+			closedir(dir);
+			return -1;
+		}
+		while ((mentry = readdir(dmem)) != NULL) {
+			if (strcmp(mentry->d_name, "reg"))
+				continue;
+			strcat(fname, "/reg");
+			if ((file = fopen(fname, "r")) == NULL) {
+				perror(fname);
+				closedir(dmem);
+				closedir(dir);
+				return -1;
+			}
+			if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+				perror(fname);
+				fclose(file);
+				closedir(dmem);
+				closedir(dir);
+				return -1;
+			}
+			if (local_memory_ranges >= max_memory_ranges) {
+				fclose(file);
+				break;
+			}
+			base_memory_range[local_memory_ranges].start =
+				((uint64_t *)buf)[0];
+			base_memory_range[local_memory_ranges].end  =
+				base_memory_range[local_memory_ranges].start +
+				((uint64_t *)buf)[1];
+			base_memory_range[local_memory_ranges].type = RANGE_RAM;
+			local_memory_ranges++;
+			dbgprintf("%016llx-%016llx : %x\n",
+					base_memory_range[local_memory_ranges-1].start,
+					base_memory_range[local_memory_ranges-1].end,
+					base_memory_range[local_memory_ranges-1].type);
+			fclose(file);
+		}
+		closedir(dmem);
+	}
+	closedir(dir);
+	nr_memory_ranges = local_memory_ranges;
+	sort_base_ranges();
+	memory_max = base_memory_range[nr_memory_ranges - 1].end;
+#ifdef DEBUG
+	fprintf(stderr, "get base memory ranges:%d\n", nr_memory_ranges);
+#endif
+	return 0;
+}
+
+/* Get devtree details and create exclude_range array
+ * Also create usablemem_ranges for KEXEC_ON_CRASH
+ */
+static int get_devtree_details(unsigned long kexec_flags)
+{
+	uint64_t rmo_base;
+	char buf[MAXBYTES];
+	char device_tree[256] = "/proc/device-tree/";
+	char fname[256];
+	DIR *dir, *cdir;
+	FILE *file;
+	struct dirent *dentry;
+	int n, i = 0;
+
+	if ((dir = opendir(device_tree)) == NULL) {
+		perror(device_tree);
+		return -1;
+	}
+
+	while ((dentry = readdir(dir)) != NULL) {
+		if (strncmp(dentry->d_name, "chosen", 6) &&
+				strncmp(dentry->d_name, "memory@", 7) &&
+				strcmp(dentry->d_name, "memory") &&
+				strncmp(dentry->d_name, "rtas", 4))
+			continue;
+
+		strcpy(fname, device_tree);
+		strcat(fname, dentry->d_name);
+		if ((cdir = opendir(fname)) == NULL) {
+			perror(fname);
+			goto error_opendir;
+		}
+
+		if (strncmp(dentry->d_name, "rtas", 4) == 0) {
+			strcat(fname, "/linux,rtas-base");
+			if ((file = fopen(fname, "r")) == NULL) {
+				perror(fname);
+				goto error_opencdir;
+			}
+			if (fread(&rtas_base, sizeof(unsigned int), 1, file) != 1) {
+				perror(fname);
+				goto error_openfile;
+			}
+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/rtas-size");
+			if ((file = fopen(fname, "r")) == NULL) {
+				perror(fname);
+				goto error_opencdir;
+			}
+			if (fread(&rtas_size, sizeof(unsigned int), 1, file) != 1) {
+				perror(fname);
+				goto error_openfile;
+			}
+			closedir(cdir);
+			/* Add rtas to exclude_range */
+			exclude_range[i].start = rtas_base;
+			exclude_range[i].end = rtas_base + rtas_size;
+			i++;
+		} /* rtas */
+
+		if (!strncmp(dentry->d_name, "memory@", 7) ||
+				!strcmp(dentry->d_name, "memory")) {
+			strcat(fname, "/reg");
+			if ((file = fopen(fname, "r")) == NULL) {
+				perror(fname);
+				goto error_opencdir;
+			}
+			if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+				perror(fname);
+				goto error_openfile;
+			}
+			if (n == 8) {
+				rmo_base = ((uint32_t *)buf)[0];
+				rmo_top = rmo_base + ((uint32_t *)buf)[1];
+			} else if (n == 16) {
+				rmo_base = ((uint64_t *)buf)[0];
+				rmo_top = rmo_base + ((uint64_t *)buf)[1];
+			} else {
+				fprintf(stderr, "Mem node has invalid size: %d\n", n);
+				goto error_openfile;
+			}
+			if (rmo_top > 0x30000000UL)
+				rmo_top = 0x30000000UL;
+
+			fclose(file);
+			closedir(cdir);
+		} /* memory */
+	}
+	closedir(dir);
+
+	nr_exclude_ranges = i;
+
+	sort_ranges();
+
+#ifdef DEBUG
+	int k;
+	for (k = 0; k < i; k++)
+		fprintf(stderr, "exclude_range sorted exclude_range[%d] "
+				"start:%llx, end:%llx\n", k, exclude_range[k].start,
+				exclude_range[k].end);
+#endif
+	return 0;
+
+error_openfile:
+	fclose(file);
+error_opencdir:
+	closedir(cdir);
+error_opendir:
+	closedir(dir);
+	return -1;
+}
+
+
+/* Setup a sorted list of memory ranges. */
+static int setup_memory_ranges(unsigned long kexec_flags)
+{
+	int i, j = 0;
+
+	/* Get the base list of memory ranges from /proc/device-tree/memory
+	 * nodes. Build list of ranges to be excluded from valid memory
+	 */
+
+	if (get_base_ranges())
+		goto out;
+	if (get_devtree_details(kexec_flags))
+		goto out;
+
+	for (i = 0; i < nr_exclude_ranges; i++) {
+		/* If first exclude range does not start with 0, include the
+		 * first hole of valid memory from 0 - exclude_range[0].start
+		 */
+		if (i == 0) {
+			if (exclude_range[i].start != 0) {
+				memory_range[j].start = 0;
+				memory_range[j].end = exclude_range[i].start - 1;
+				memory_range[j].type = RANGE_RAM;
+				j++;
+			}
+		} /* i == 0 */
+		/* If the last exclude range does not end at memory_max, include
+		 * the last hole of valid memory from exclude_range[last].end -
+		 * memory_max
+		 */
+		if (i == nr_exclude_ranges - 1) {
+			if (exclude_range[i].end < memory_max) {
+				memory_range[j].start = exclude_range[i].end + 1;
+				memory_range[j].end = memory_max;
+				memory_range[j].type = RANGE_RAM;
+				j++;
+				/* Limit the end to rmo_top */
+				if (memory_range[j-1].start >= rmo_top) {
+					j--;
+					break;
+				}
+				if ((memory_range[j-1].start < rmo_top) &&
+						(memory_range[j-1].end >= rmo_top)) {
+					memory_range[j-1].end = rmo_top;
+					break;
+				}
+				continue;
+			}
+		} /* i == nr_exclude_ranges - 1 */
+		/* contiguous exclude ranges - skip */
+		if (exclude_range[i+1].start == exclude_range[i].end + 1)
+			continue;
+		memory_range[j].start = exclude_range[i].end + 1;
+		memory_range[j].end = exclude_range[i+1].start - 1;
+		memory_range[j].type = RANGE_RAM;
+		j++;
+		/* Limit range to rmo_top */
+		if (memory_range[j-1].start >= rmo_top) {
+			j--;
+			break;
+		}
+		if ((memory_range[j-1].start < rmo_top) &&
+				(memory_range[j-1].end >= rmo_top)) {
+			memory_range[j-1].end = rmo_top;
+			break;
+		}
+	}
+	nr_memory_ranges = j;
+
+
+#ifdef DEBUG
+	int k;
+	for (k = 0; k < j; k++)
+		fprintf(stderr, "setup_memory_ranges memory_range[%d] "
+				"start:%llx, end:%llx\n", k, memory_range[k].start,
+				memory_range[k].end);
+#endif
+	return 0;
+
+out:
+	cleanup_memory_ranges();
+	return -1;
+}
+
+
+/* Return a list of valid memory ranges */
+int get_memory_ranges_dt(struct memory_range **range, int *ranges,
+		unsigned long kexec_flags)
+{
+	if (count_memory_ranges())
+		return -1;
+	if (alloc_memory_ranges())
+		return -1;
+	if (setup_memory_ranges(kexec_flags))
+		return -1;
+
+	/* fixup in case we have no exclude regions */
+	if (!nr_memory_ranges) {
+		memory_range[0].start = 0x0ULL;
+		memory_range[0].end = rmo_top;
+		memory_range[0].type = RANGE_RAM;
+		nr_memory_ranges = 1;
+	}
+
+	*range = memory_range;
+	*ranges = nr_memory_ranges;
+#if 0
+	{
+		int i;
+
+		for (i = 0; i < nr_memory_ranges; i++)
+			printf("%d:: %016llx - %016llx\n",
+					i,
+					memory_range[i].start,
+					memory_range[i].end);
+
+	}
+#endif
+	fprintf(stderr, "get memory ranges:%d\n", nr_memory_ranges);
+	return 0;
+}
+#endif
+
+/* Return a sorted list of memory ranges. */
+int get_memory_ranges(struct memory_range **range, int *ranges,
+					unsigned long kexec_flags)
+{
+#ifdef WITH_GAMECUBE
+	return get_memory_ranges_gc(range, ranges, kexec_flags);
+#else
+	return get_memory_ranges_dt(range, ranges, kexec_flags);
 #endif
 }
 
diff --git a/purgatory/arch/ppc/Makefile b/purgatory/arch/ppc/Makefile
index 69fd46c..0dd18b6 100644
--- a/purgatory/arch/ppc/Makefile
+++ b/purgatory/arch/ppc/Makefile
@@ -2,6 +2,7 @@
 # Purgatory ppc
 #
 
+ppc_PURGATORY_SRCS += purgatory/arch/ppc/v2wrap.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/misc.S
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/purgatory-ppc.c
 ppc_PURGATORY_SRCS += purgatory/arch/ppc/console-ppc.c
diff --git a/purgatory/arch/ppc/purgatory-ppc.c b/purgatory/arch/ppc/purgatory-ppc.c
index 077f495..369f7d7 100644
--- a/purgatory/arch/ppc/purgatory-ppc.c
+++ b/purgatory/arch/ppc/purgatory-ppc.c
@@ -1,6 +1,10 @@
 #include <purgatory.h>
 #include "purgatory-ppc.h"
 
+unsigned long pul_stack = 0;
+unsigned long dt_offset = 0;
+unsigned long kernel = 0;
+
 void setup_arch(void)
 {
 	/* Nothing for now */
diff --git a/purgatory/arch/ppc/v2wrap.S b/purgatory/arch/ppc/v2wrap.S
new file mode 100644
index 0000000..35803e7
--- /dev/null
+++ b/purgatory/arch/ppc/v2wrap.S
@@ -0,0 +1,54 @@
+#
+#  kexec: Linux boots Linux
+#
+#  Copyright (C) 2004 - 2005, Milton D Miller II, IBM Corporation
+#  Copyright (C) 2006, Mohan Kumar M (mohan@in.ibm.com), IBM Corporation
+#  Copyright (C) 2008, Sebastian Andrzej Siewior (bigeasy@linutronix.de), linutronix
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
+#include "ppc_asm.h"
+
+# v2wrap.S
+# a wrapper to call purgatory code
+# Invokes ppc kernel with the expected arguments
+# of kernel(device-tree)
+
+# calling convention:
+#  no register are considred
+#
+
+#define LOADADDR(rn,name)	\
+	lis     rn,name##@h;	\
+	ori     rn,rn,name##@l;	\
+
+	.globl purgatory_start
+purgatory_start:
+
+	LOADADDR(r6,pul_stack)
+##	lwz	r1,0(r6)		#setup stack
+
+	subi	r1, r1, 112
+	bl	purgatory
+	nop
+
+	LOADADDR(r6,kernel)
+	lwz	r4,0(r6)		# load the kernel address
+	mtlr	r4			# prepare branch too
+
+	LOADADDR(r6, dt_offset)
+	lwz	r3, 0(r6)		# load device-tree address
+
+	blr				# start kernel
-- 
1.5.6.5
