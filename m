Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 648F2B7E2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 01:25:26 +1000 (EST)
Date: Fri, 14 May 2010 00:25:19 +0900
From: Simon Horman <horms@verge.net.au>
To: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: [patch] ppc: Fix gamecube build
Message-ID: <20100513152519.GA4143@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maxim Uvarov <muvarov@gmail.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the kexec-build on ppc32 when
the --game-cube option is supplied to ./configure.
It seems to have bit-rotted a little.

Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Maxim Uvarov <muvarov@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/ppc/kexec-elf-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-elf-ppc.c	2010-05-14 00:18:25.000000000 +0900
+++ kexec-tools/kexec/arch/ppc/kexec-elf-ppc.c	2010-05-14 00:20:58.000000000 +0900
@@ -162,17 +162,9 @@ int elf_ppc_load(int argc, char **argv,
 	unsigned long max_addr, hole_addr;
 	struct mem_phdr *phdr;
 	size_t size;
-	unsigned long long *rsvmap_ptr;
-	struct bootblock *bb_ptr;
-	unsigned int nr_segments;
-	unsigned long my_kernel, my_dt_offset;
-	unsigned long my_stack, my_backup_start;
 #ifdef CONFIG_PPC64
 	unsigned long toc_addr;
 #endif
-	unsigned int slave_code[256 / sizeof(unsigned int)], master_entry;
-	unsigned char *seg_buf = NULL;
-	off_t seg_size = 0;
 #ifdef WITH_GAMECUBE
 	int target_is_gamecube = 1;
 	char *arg_buf;
@@ -183,13 +175,21 @@ int elf_ppc_load(int argc, char **argv,
 	unsigned char *setup_start;
 	uint32_t setup_size;
 #else
+	unsigned long long *rsvmap_ptr;
+	struct bootblock *bb_ptr;
+	unsigned int nr_segments;
+	unsigned long my_kernel, my_dt_offset;
+	unsigned long my_stack, my_backup_start;
+	unsigned int slave_code[256 / sizeof(unsigned int)], master_entry;
+	unsigned char *seg_buf = NULL;
+	off_t seg_size = 0;
 	int target_is_gamecube = 0;
 	unsigned int addr;
 	unsigned long dtb_addr;
+#endif
 #define FIXUP_ENTRYS	(20)
 	char *fixup_nodes[FIXUP_ENTRYS + 1];
 	int cur_fixup = 0;
-#endif
 	int opt;
 
 	command_line = NULL;
Index: kexec-tools/kexec/arch/ppc/kexec-ppc.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc/kexec-ppc.c	2010-05-14 00:18:25.000000000 +0900
+++ kexec-tools/kexec/arch/ppc/kexec-ppc.c	2010-05-14 00:20:58.000000000 +0900
@@ -26,6 +26,11 @@
 
 #include "config.h"
 
+uint64_t rmo_top;
+unsigned long long crash_base, crash_size;
+unsigned int rtas_base, rtas_size;
+int max_memory_ranges;
+
 #ifdef WITH_GAMECUBE
 #define MAX_MEMORY_RANGES  64
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
@@ -46,15 +51,11 @@ static int get_memory_ranges_gc(struct m
 }
 #else
 static int use_new_dtb;
-int max_memory_ranges;
 static int nr_memory_ranges, nr_exclude_ranges;
 static struct memory_range *exclude_range;
 static struct memory_range *memory_range;
 static struct memory_range *base_memory_range;
 static uint64_t memory_max;
-uint64_t rmo_top;
-unsigned long long crash_base, crash_size;
-unsigned int rtas_base, rtas_size;
 
 /*
  * Count the memory nodes under /proc/device-tree and populate the
