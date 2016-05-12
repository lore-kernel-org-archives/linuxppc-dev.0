Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5CHT42sZzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 22:39:49 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r5CHT2qWHz9s2G
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:39:49 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 12 May 2016 22:39:47 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B54B62BB005A
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:39:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4CCdaTY5702048
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:39:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4CCctbq015203
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:38:55 +1000
Subject: [PATCH v2 2/2] powerpc/fadump: add support to parse size based on
 memory range
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
Date: Thu, 12 May 2016 18:08:15 +0530
Message-ID: <20160512123633.12838.29515.stgit@hbathini.in.ibm.com>
In-Reply-To: <20160512123422.12838.85753.stgit@hbathini.in.ibm.com>
References: <20160512123422.12838.85753.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, memory for fadump can be specified with fadump_reserve_mem=size,
where only a fixed size can be specified. Add the below syntax as well, to
support conditional reservation based on system memory size:

	fadump_reserve_mem=<range1>:<size1>[,<range2>:<size2>,...]

This syntax helps using the same commandline parameter for different system
memory sizes.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
Changes from v1:
1. Changed subject from "powerpc/fadump: add support to specify memory range based size"
2. Reused crashkernel parsing code that was moved to kernel/params.c (see patch 1/2)

 arch/powerpc/kernel/fadump.c |   64 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d0af58b..a868281 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -193,6 +193,56 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	return addr;
 }
 
+/*
+ * This function parses command line for fadump_reserve_mem=
+ *
+ * Supports the below two syntaxes:
+ *    1. fadump_reserve_mem=size
+ *    2. fadump_reserve_mem=ramsize-range:size[,...]
+ *
+ * Sets fw_dump.reserve_bootvar with the memory size
+ * provided, 0 otherwise
+ *
+ * The function returns -EINVAL on failure, 0 otherwise.
+ */
+static int __init parse_fadump_reserve_mem(void)
+{
+	char *name = "fadump_reserve_mem=";
+	char *fadump_cmdline = NULL, *cur;
+
+	fw_dump.reserve_bootvar = 0;
+
+	/* find fadump_reserve_mem and use the last one if there are many */
+	cur = strstr(boot_command_line, name);
+	while (cur) {
+		fadump_cmdline = cur;
+		cur = strstr(cur+1, name);
+	}
+
+	/* when no fadump_reserve_mem= cmdline option is provided */
+	if (!fadump_cmdline)
+		return 0;
+
+	fadump_cmdline += strlen(name);
+
+	/* for fadump_reserve_mem=size cmdline syntax */
+	if (!is_param_range_based(fadump_cmdline)) {
+		fw_dump.reserve_bootvar = memparse(fadump_cmdline, NULL);
+		return 0;
+	}
+
+	/* for fadump_reserve_mem=ramsize-range:size[,...] cmdline syntax */
+	cur = fadump_cmdline;
+	fw_dump.reserve_bootvar = parse_mem_range_size("fadump_reserve_mem",
+					&cur, memblock_phys_mem_size());
+	if (cur == fadump_cmdline) {
+		printk(KERN_INFO "fadump_reserve_mem: Invaild syntax!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
  *
@@ -212,12 +262,17 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 {
 	unsigned long size;
 
+	/* sets fw_dump.reserve_bootvar */
+	parse_fadump_reserve_mem();
+
 	/*
 	 * Check if the size is specified through fadump_reserve_mem= cmdline
 	 * option. If yes, then use that.
 	 */
 	if (fw_dump.reserve_bootvar)
 		return fw_dump.reserve_bootvar;
+	else
+		printk(KERN_INFO "fadump: calculating default boot size\n");
 
 	/* divide by 20 to get 5% of value */
 	size = memblock_end_of_DRAM() / 20;
@@ -352,15 +407,6 @@ static int __init early_fadump_param(char *p)
 }
 early_param("fadump", early_fadump_param);
 
-/* Look for fadump_reserve_mem= cmdline option */
-static int __init early_fadump_reserve_mem(char *p)
-{
-	if (p)
-		fw_dump.reserve_bootvar = memparse(p, &p);
-	return 0;
-}
-early_param("fadump_reserve_mem", early_fadump_reserve_mem);
-
 static void register_fw_dump(struct fadump_mem_struct *fdm)
 {
 	int rc;
