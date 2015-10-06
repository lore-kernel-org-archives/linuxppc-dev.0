Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0140.outbound.protection.outlook.com [207.46.100.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433FE1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 09:56:07 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: Simon Horman <horms@verge.net.au>
CC: <kexec@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 1/3] ppc64: Fix warnings
Date: Tue, 6 Oct 2015 17:55:48 -0500
Message-ID: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Produce a warning-free build on ppc64 (at least, when built as 64-bit
userspace -- if a 64-bit binary for ppc64 is a requirement, why is -m64
set only on purgatory?).  Mostly unused (or write-only) variable
warnings, but also one nasty one where reserve() was used without a
prototype, causing long long arguments to be passed as int.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: no change

 kexec/arch/ppc64/crashdump-ppc64.c | 3 ++-
 kexec/arch/ppc64/kexec-elf-ppc64.c | 9 +--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 6214b83..b3c8928 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -33,6 +33,7 @@
 #include "../../kexec-syscall.h"
 #include "../../crashdump.h"
 #include "kexec-ppc64.h"
+#include "../../fs2dt.h"
 #include "crashdump-ppc64.h"
 
 static struct crash_elf_info elf_info64 =
@@ -187,7 +188,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	DIR *dir, *dmem;
 	FILE *file;
 	struct dirent *dentry, *mentry;
-	int i, n, crash_rng_len = 0;
+	int n, crash_rng_len = 0;
 	unsigned long long start, end;
 	int page_size;
 
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 4a1540e..adcee4c 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -97,7 +97,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	struct mem_ehdr ehdr;
 	char *cmdline, *modified_cmdline = NULL;
 	const char *devicetreeblob;
-	int cmdline_len, modified_cmdline_len;
 	uint64_t max_addr, hole_addr;
 	char *seg_buf = NULL;
 	off_t seg_size = 0;
@@ -107,7 +106,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	uint64_t *rsvmap_ptr;
 	struct bootblock *bb_ptr;
 #endif
-	int i;
 	int result, opt;
 	uint64_t my_kernel, my_dt_offset;
 	uint64_t my_opal_base = 0, my_opal_entry = 0;
@@ -162,10 +160,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 		}
 	}
 
-	cmdline_len = 0;
-	if (cmdline)
-		cmdline_len = strlen(cmdline) + 1;
-	else
+	if (!cmdline)
 		fprintf(stdout, "Warning: append= option is not passed. Using the first kernel root partition\n");
 
 	if (ramdisk && reuse_initrd)
@@ -181,7 +176,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			strncpy(modified_cmdline, cmdline, COMMAND_LINE_SIZE);
 			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
 		}
-		modified_cmdline_len = strlen(modified_cmdline);
 	}
 
 	/* Parse the Elf file */
@@ -219,7 +213,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			return -1;
 		/* Use new command line. */
 		cmdline = modified_cmdline;
-		cmdline_len = strlen(modified_cmdline) + 1;
 	}
 
 	/* Add v2wrap to the current image */
-- 
2.1.4
