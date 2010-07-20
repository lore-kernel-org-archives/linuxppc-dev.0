Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 7ED451007E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 06:15:19 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2 3/7] Update uImage to support crash kernel and misc fixes
Date: Tue, 20 Jul 2010 15:14:56 -0500
Message-ID: <1279656900-27458-3-git-send-email-msm@freescale.com>
In-Reply-To: <1279656900-27458-2-git-send-email-msm@freescale.com>
References: <1279656900-27458-1-git-send-email-msm@freescale.com>
	<1279656900-27458-2-git-send-email-msm@freescale.com>
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

Use current command line if none given, specifically useful for
when arguments are added causing the use of the current cmdline
to not occur.

We also try to load the dtb above the kernel, this is useful for
relocatable kernels where they device tree needs to reside just
above the kernel base address.

Only allocate 1 MiB extra for bss space after kernel as it appears
to be more than adequate.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/kexec-uImage-ppc.c |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 4a8d28d..21a7c1b 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -10,6 +10,7 @@
 #include <getopt.h>
 #include <arch/options.h>
 #include "../../kexec.h"
+#include "../../kexec-syscall.h"
 #include "kexec-ppc.h"
 #include "fixup_dtb.h"
 #include <kexec-uImage.h>
@@ -45,7 +46,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		off_t len, struct kexec_info *info, unsigned int load_addr,
 		unsigned int ep)
 {
-	char *command_line;
+	char *command_line, *cmdline_buf;
 	int command_line_len;
 	char *dtb;
 	unsigned int addr;
@@ -56,6 +57,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	int opt;
 	int ret;
 
+	cmdline_buf = NULL;
 	command_line = NULL;
 	dtb = NULL;
 
@@ -89,24 +91,34 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	}
 
 	command_line_len = 0;
-	if (command_line)
+	if (command_line) {
+		command_line_len = strlen(command_line) + 1;
+	} else {
+		command_line = get_command_line();
 		command_line_len = strlen(command_line) + 1;
+	}
 
 	fixup_nodes[cur_fixup] = NULL;
 
 	/*
 	 * len contains the length of the whole kernel image except the bss
-	 * section. The 3 MiB should cover it. The purgatory and the dtb are
+	 * section. The 1 MiB should cover it. The purgatory and the dtb are
 	 * allocated from memtop down towards zero so we should never get too
 	 * close to the bss :)
 	 */
-	ret = valid_memory_range(info, load_addr, len + 3 * 1024 * 1024);
+	ret = valid_memory_range(info, load_addr, load_addr + (len + (1 * 1024 * 1024)));
 	if (!ret) {
 		printf("Can't add kernel to addr 0x%08x len %ld\n",
-				load_addr, len + 3 * 1024 * 1024);
+				load_addr, len + (1 * 1024 * 1024));
 		return -1;
 	}
-	add_segment(info, buf, len, load_addr, len + 3 * 1024 * 1024);
+	add_segment(info, buf, len, load_addr, len + (1 * 1024 * 1024));
+
+	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
+	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
+	if (command_line)
+		strncat(cmdline_buf, command_line, command_line_len);
+
 	if (dtb) {
 		char *blob_buf;
 		off_t blob_size = 0;
@@ -115,10 +127,9 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		blob_buf = slurp_file(dtb, &blob_size);
 		if (!blob_buf || !blob_size)
 			die("Device tree seems to be an empty file.\n");
-		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, command_line);
-
-		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
-				KERNEL_ACCESS_TOP, -1);
+		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, cmdline_buf);
+		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, load_addr,
+				load_addr + KERNEL_ACCESS_TOP, -1);
 	} else {
 		dtb_addr = 0;
 	}
@@ -142,6 +153,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 
 	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
 	info->entry = (void *)addr;
+
 	return 0;
 }
 
-- 
1.6.0.6
