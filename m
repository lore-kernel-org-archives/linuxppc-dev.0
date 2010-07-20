Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id C921A100829
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 06:15:26 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2 5/7] Add support for ramdisk on ppc32 for uImage-ppc and
	Elf-ppc
Date: Tue, 20 Jul 2010 15:14:58 -0500
Message-ID: <1279656900-27458-5-git-send-email-msm@freescale.com>
In-Reply-To: <1279656900-27458-4-git-send-email-msm@freescale.com>
References: <1279656900-27458-1-git-send-email-msm@freescale.com>
	<1279656900-27458-2-git-send-email-msm@freescale.com>
	<1279656900-27458-3-git-send-email-msm@freescale.com>
	<1279656900-27458-4-git-send-email-msm@freescale.com>
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

This fixes --reuseinitrd and --ramdisk option for ppc32 on
uImage-ppc and Elf. It works for normal kexec as well as for
kdump.

When using --reuseinitrd you need to specifify retain_initrd
on the command line. Also, if you are doing kdump you need to make
sure your initrd lives in the crashdump region otherwise the
kdump kernel will not be able to access it. The --ramdisk option
should always work.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/Makefile               |    1 +
 kexec/arch/ppc/include/arch/options.h |    3 +
 kexec/arch/ppc/kexec-elf-ppc.c        |   44 ++++++++++++++++++++-
 kexec/arch/ppc/kexec-ppc.c            |    6 +++
 kexec/arch/ppc/kexec-ppc.h            |    2 +
 kexec/arch/ppc/kexec-uImage-ppc.c     |   68 +++++++++++++++++++++++++++++++-
 6 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 5988213..c963175 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -21,6 +21,7 @@ libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/arch/ppc/libfdt/%)
 CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/libfdt
 
 ppc_KEXEC_SRCS += $(libfdt_SRCS)
+ppc_ARCH_REUSE_INITRD =
 
 dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)			\
 	kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ppc_asm.h		\
diff --git a/kexec/arch/ppc/include/arch/options.h b/kexec/arch/ppc/include/arch/options.h
index f646ccc..0c00ea7 100644
--- a/kexec/arch/ppc/include/arch/options.h
+++ b/kexec/arch/ppc/include/arch/options.h
@@ -8,6 +8,7 @@
 #define OPT_GAMECUBE    (OPT_ARCH_MAX+1)
 #define OPT_DTB         (OPT_ARCH_MAX+2)
 #define OPT_NODES       (OPT_ARCH_MAX+3)
+#define OPT_RAMDISK	(OPT_ARCH_MAX+4)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -35,6 +36,8 @@
 	KEXEC_ARCH_OPTIONS \
 	{"command-line", 1, 0, OPT_APPEND},\
 	{"append",	 1, 0, OPT_APPEND},\
+	{"ramdisk",	 1, 0, OPT_APPEND},\
+	{"initrd",	 1, 0, OPT_APPEND},\
 	{"gamecube",	 1, 0, OPT_GAMECUBE},\
 	{"dtb",	    1, 0, OPT_DTB},\
 	{"reuse-node",	   1, 0, OPT_NODES},\
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 87e6507..58bba54 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -127,6 +127,8 @@ static const struct option options[] = {
 	KEXEC_ARCH_OPTIONS
 	{"command-line", 1, 0, OPT_APPEND},
 	{"append",       1, 0, OPT_APPEND},
+	{"ramdisk",	 1, 0, OPT_RAMDISK},
+	{"initrd",	 1, 0, OPT_RAMDISK},
 	{"gamecube",     1, 0, OPT_GAMECUBE},
 	{"dtb",     1, 0, OPT_DTB},
 	{"reuse-node",     1, 0, OPT_NODES},
@@ -139,10 +141,12 @@ void elf_ppc_usage(void)
 	printf(
 	     "    --command-line=STRING Set the kernel command line to STRING.\n"
 	     "    --append=STRING       Set the kernel command line to STRING.\n"
+	     "    --ramdisk=<filename>  Initial RAM disk.\n"
+	     "    --initrd=<filename>   same as --ramdisk\n"
 	     "    --gamecube=1|0        Enable/disable support for ELFs with changed\n"
 	     "                          addresses suitable for the GameCube.\n"
-	     "     --dtb=<filename>     Specify device tree blob file.\n"
-	     "     --reuse-node=node    Specify nodes which should be taken from /proc/device-tree.\n"
+	     "    --dtb=<filename>	   Specify device tree blob file.\n"
+	     "    --reuse-node=node	   Specify nodes which should be taken from /proc/device-tree.\n"
 	     "                          Can be set multiple times.\n"
 	     );
 }
@@ -177,7 +181,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	unsigned long my_kernel, my_dt_offset;
 	unsigned long my_stack, my_backup_start;
 	unsigned int slave_code[256 / sizeof(unsigned int)], master_entry;
-	unsigned char *seg_buf = NULL;
+	char *seg_buf = NULL;
 	off_t seg_size = 0;
 	int target_is_gamecube = 0;
 	unsigned int addr;
@@ -193,6 +197,8 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	dtb = NULL;
 	max_addr = LONG_MAX;
 	hole_addr = 0;
+	kernel_addr = 0;
+	ramdisk = 0;
 
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch (opt) {
@@ -207,6 +213,9 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
+		case OPT_RAMDISK:
+			ramdisk = optarg;
+			break;
 		case OPT_GAMECUBE:
 			target_is_gamecube = atoi(optarg);
 			break;
@@ -234,6 +243,9 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		command_line_len = strlen(command_line) + 1;
 	}
 
+	if (ramdisk && reuse_initrd)
+		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
+
 	fixup_nodes[cur_fixup] = NULL;
 
 	/* Need to append some command line parameters internally in case of
@@ -339,6 +351,32 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
 			purgatory_size, 0, elf_max_addr(&ehdr), 1, 0);
 
+	if (ramdisk)
+	{
+		seg_buf = slurp_file(ramdisk, &seg_size);
+		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
+			0, 0, max_addr, 1);
+		ramdisk_base = hole_addr;
+		ramdisk_size = seg_size;
+	}
+	if (reuse_initrd)
+	{
+		ramdisk_base = initrd_base;
+		ramdisk_size = initrd_size;
+	}
+
+	if (info->kexec_flags & KEXEC_ON_CRASH && ramdisk_base != 0) {
+		if ( (ramdisk_base < crash_base) ||
+			(ramdisk_base > crash_base + crash_size) )
+		{
+			printf("WARNING: ramdisk is above crashkernel region!\n");
+		}
+		else if (ramdisk_base + initrd_size > crash_base + crash_size)
+		{
+			printf("WARNING: ramdisk overflows crashkernel region!\n");
+		}
+	}
+
 	if (dtb) {
 		char *blob_buf;
 		off_t blob_size = 0;
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index d9f1d05..7adea2b 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -33,6 +33,12 @@ unsigned long long ramdisk_base = 0, ramdisk_size = 0;
 unsigned long long devicetree_base = 0, devicetree_size = 0;
 unsigned int rtas_base, rtas_size;
 int max_memory_ranges;
+const char *ramdisk;
+
+void arch_reuse_initrd(void)
+{
+	reuse_initrd = 1;
+}
 
 #ifdef WITH_GAMECUBE
 #define MAX_MEMORY_RANGES  64
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index aefdc6f..5ad3575 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -65,8 +65,10 @@ typedef struct mem_rgns {
 extern mem_rgns_t usablemem_rgns;
 extern int max_memory_ranges;
 extern unsigned long long initrd_base, initrd_size;
+extern unsigned long long ramdisk_base, ramdisk_size;
 extern unsigned long long devicetree_base, devicetree_size;
 extern unsigned char reuse_initrd;
+extern const char *ramdisk;
 #define COMMAND_LINE_SIZE	512 /* from kernel */
 /*fs2dt*/
 void reserve(unsigned long long where, unsigned long long length);
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 21a7c1b..310d6c3 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -14,12 +14,16 @@
 #include "kexec-ppc.h"
 #include "fixup_dtb.h"
 #include <kexec-uImage.h>
+#include "crashdump-powerpc.h"
+#include <limits.h>
 
 /* See options.h -- add any more there, too. */
 static const struct option options[] = {
 	KEXEC_ARCH_OPTIONS
 	{"command-line",	1, 0, OPT_APPEND},
 	{"append",	1, 0, OPT_APPEND},
+	{"ramdisk",	1, 0, OPT_RAMDISK},
+	{"initrd",	1, 0, OPT_RAMDISK},
 	{"dtb",		1, 0, OPT_DTB},
 	{"reuse-node",	1, 0, OPT_NODES},
 	{0, 0, 0, 0},
@@ -31,8 +35,10 @@ void uImage_ppc_usage(void)
 	printf(
 			"    --command-line=STRING Set the kernel command line to STRING.\n"
 			"    --append=STRING       Set the kernel command line to STRING.\n"
-			"     --dtb=<filename>     Specify device tree blob file.\n"
-			"     --reuse-node=node    Specify nodes which should be taken from /proc/device-tree.\n"
+			"    --ramdisk=<filename>  Initial RAM disk.\n"
+			"    --initrd=<filename>   same as --ramdisk\n"
+			"    --dtb=<filename>      Specify device tree blob file.\n"
+			"    --reuse-node=node     Specify nodes which should be taken from /proc/device-tree.\n"
 			"                          Can be set multiple times.\n"
 	);
 }
@@ -46,7 +52,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		off_t len, struct kexec_info *info, unsigned int load_addr,
 		unsigned int ep)
 {
-	char *command_line, *cmdline_buf;
+	char *command_line, *cmdline_buf, *crash_cmdline;
 	int command_line_len;
 	char *dtb;
 	unsigned int addr;
@@ -56,10 +62,15 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	int cur_fixup = 0;
 	int opt;
 	int ret;
+	char *seg_buf = NULL;
+	off_t seg_size = 0;
+	unsigned long long hole_addr;
+	unsigned long max_addr;
 
 	cmdline_buf = NULL;
 	command_line = NULL;
 	dtb = NULL;
+	max_addr = LONG_MAX;
 
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch (opt) {
@@ -75,6 +86,10 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 			command_line = optarg;
 			break;
 
+		case OPT_RAMDISK:
+			ramdisk = optarg;
+			break;
+
 		case OPT_DTB:
 			dtb = optarg;
 			break;
@@ -90,6 +105,9 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		}
 	}
 
+	if (ramdisk && reuse_initrd)
+		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
+
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) + 1;
@@ -114,10 +132,54 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	}
 	add_segment(info, buf, len, load_addr, len + (1 * 1024 * 1024));
 
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+                crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
+                memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
+        } else
+                crash_cmdline = NULL;
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		ret = load_crashdump_segments(info, crash_cmdline,
+						max_addr, 0);
+		if (ret < 0) {
+			return -1;
+		}
+	}
+
 	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
 	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
 	if (command_line)
 		strncat(cmdline_buf, command_line, command_line_len);
+	if (crash_cmdline)
+		strncat(cmdline_buf, crash_cmdline,
+			sizeof(crash_cmdline) -
+			strlen(crash_cmdline) - 1);
+
+	if (ramdisk)
+	{
+		seg_buf = slurp_file(ramdisk, &seg_size);
+		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
+			0, 0, max_addr, 1);
+		ramdisk_base = hole_addr;
+		ramdisk_size = seg_size;
+	}
+	if (reuse_initrd)
+	{
+		ramdisk_base = initrd_base;
+		ramdisk_size = initrd_size;
+	}
+
+	if (info->kexec_flags & KEXEC_ON_CRASH && ramdisk_base != 0) {
+		if ( (ramdisk_base < crash_base) ||
+		     (ramdisk_base > crash_base + crash_size) )
+		{
+			printf("WARNING: ramdisk is above crashkernel region!\n");
+		}
+		else if (ramdisk_base + ramdisk_size > crash_base + crash_size)
+		{
+			printf("WARNING: ramdisk overflows crashkernel region!\n");
+		}
+	}
 
 	if (dtb) {
 		char *blob_buf;
-- 
1.6.0.6
