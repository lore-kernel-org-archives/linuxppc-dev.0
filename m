Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1VVf48rNzDqfM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 21:51:38 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r1VVf2cX6z9snm
 for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2016 21:51:38 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 May 2016 21:51:37 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 153342CE8046
 for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2016 21:51:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u46BpRp95767640
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:51:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u46Bp2Rm015125
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:51:02 +1000
Received: from hbathini.in.ibm.com (hbathini.in.ibm.com [9.184.79.239] (may be
 forged))
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u46Bp2Tj014769
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:51:02 +1000
Subject: [PATCH 2/3] powerpc/fadump: add support to specify memory range
 based size
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 06 May 2016 17:20:37 +0530
Message-ID: <20160506115037.26330.88961.stgit@hbathini.in.ibm.com>
In-Reply-To: <20160506115007.26330.89135.stgit@hbathini.in.ibm.com>
References: <20160506115007.26330.89135.stgit@hbathini.in.ibm.com>
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
where only a fixed size can be specified. This patch tries to extend this
syntax to support conditional reservation based on memory size, with the
below syntax:

	fadump_reserve_mem=<range1>:<size1>[,<range2>:<size2>,...]

This syntax helps using the same commandline parameter for different system
memory sizes.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |  127 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d0af58b..a7fef3e 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -193,6 +193,121 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	return addr;
 }
 
+#define FADUMP_MEM_CMDLINE_PREFIX		"fadump_reserve_mem="
+
+static __init char *get_last_fadump_reserve_mem(void)
+{
+	char *p = boot_command_line, *fadump_cmdline = NULL;
+
+	/* find fadump_reserve_mem and use the last one if there are more */
+	p = strstr(p, FADUMP_MEM_CMDLINE_PREFIX);
+	while (p) {
+		fadump_cmdline = p;
+		p = strstr(p+1, FADUMP_MEM_CMDLINE_PREFIX);
+	}
+
+	return fadump_cmdline;
+}
+
+#define parse_fadump_print(fmt, arg...) \
+	printk(KERN_INFO "fadump_reserve_mem: "	fmt, ##arg)
+
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
+	char *cur, *tmp;
+	char *first_colon, *first_space;
+	char *fadump_cmdline;
+	unsigned long long system_ram;
+
+	fw_dump.reserve_bootvar = 0;
+	fadump_cmdline = get_last_fadump_reserve_mem();
+
+	/* when no fadump_reserve_mem= cmdline option is provided */
+	if (!fadump_cmdline)
+		return 0;
+
+	first_colon = strchr(fadump_cmdline, ':');
+	first_space = strchr(fadump_cmdline, ' ');
+	cur = fadump_cmdline + strlen(FADUMP_MEM_CMDLINE_PREFIX);
+
+	/* for fadump_reserve_mem=size cmdline syntax */
+	if (!first_colon || (first_space && (first_colon > first_space))) {
+		fw_dump.reserve_bootvar = memparse(cur, &cur);
+		return 0;
+	}
+
+	/* for fadump_reserve_mem=ramsize-range:size[,...] cmdline syntax */
+	system_ram = memblock_phys_mem_size();
+	/* for each entry of the comma-separated list */
+	do {
+		unsigned long long start, end = ULLONG_MAX, size;
+
+		/* get the start of the range */
+		start = memparse(cur, &tmp);
+		if (cur == tmp) {
+			parse_fadump_print("Memory value expected\n");
+			return -EINVAL;
+		}
+		cur = tmp;
+		if (*cur != '-') {
+			parse_fadump_print("'-' expected\n");
+			return -EINVAL;
+		}
+		cur++;
+
+		/* if no ':' is here, than we read the end */
+		if (*cur != ':') {
+			end = memparse(cur, &tmp);
+			if (cur == tmp) {
+				parse_fadump_print("Memory value expected\n");
+				return -EINVAL;
+			}
+			cur = tmp;
+			if (end <= start) {
+				parse_fadump_print("end <= start\n");
+				return -EINVAL;
+			}
+		}
+
+		if (*cur != ':') {
+			parse_fadump_print("':' expected\n");
+			return -EINVAL;
+		}
+		cur++;
+
+		size = memparse(cur, &tmp);
+		if (cur == tmp) {
+			parse_fadump_print("Memory value expected\n");
+			return -EINVAL;
+		}
+		cur = tmp;
+		if (size >= system_ram) {
+			parse_fadump_print("invalid size\n");
+			return -EINVAL;
+		}
+
+		/* match ? */
+		if (system_ram >= start && system_ram < end) {
+			fw_dump.reserve_bootvar = size;
+			break;
+		}
+	} while (*cur++ == ',');
+
+	return 0;
+}
+
 /**
  * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
  *
@@ -212,6 +327,9 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 {
 	unsigned long size;
 
+	/* sets fw_dump.reserve_bootvar */
+	parse_fadump_reserve_mem();
+
 	/*
 	 * Check if the size is specified through fadump_reserve_mem= cmdline
 	 * option. If yes, then use that.
@@ -352,15 +470,6 @@ static int __init early_fadump_param(char *p)
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
