Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5CDY1wZgzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 22:37:17 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r5CDX69p5z9s3s
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:37:16 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 12 May 2016 22:37:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9D5B6357805C
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:37:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4CCatLH11141518
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:37:03 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4CCaSpe011984
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 22:36:28 +1000
Subject: [PATCH 1/2] Refactor code parsing size based on memory range
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
Date: Thu, 12 May 2016 18:05:48 +0530
Message-ID: <20160512123422.12838.85753.stgit@hbathini.in.ibm.com>
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

Currently, crashkernel parameter supports the below syntax to parse size
based on memory range:

	crashkernel=<range1>:<size1>[,<range2>:<size2>,...]

While such parsing is implemented for crashkernel parameter, it applies to
other parameters with similar syntax. So, move this code to a more generic
place for code reuse.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
While this patch in itself has nothing to do with powerpc,
the powerpc patch (2/2) depends on this patch..

 include/linux/kernel.h |    5 +++
 kernel/kexec_core.c    |   63 +++-----------------------------
 kernel/params.c        |   96 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 58 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f7775e..e755ed1 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -429,6 +429,11 @@ extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
 extern bool parse_option_str(const char *str, const char *option);
 
+extern bool __init is_param_range_based(const char *cmdline);
+extern unsigned long long __init parse_mem_range_size(const char *param,
+						      char **str,
+						      unsigned long long system_ram);
+
 extern int core_kernel_text(unsigned long addr);
 extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 1391d3e..71e92b2 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1084,59 +1084,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
 	char *cur = cmdline, *tmp;
 
 	/* for each entry of the comma-separated list */
-	do {
-		unsigned long long start, end = ULLONG_MAX, size;
-
-		/* get the start of the range */
-		start = memparse(cur, &tmp);
-		if (cur == tmp) {
-			pr_warn("crashkernel: Memory value expected\n");
-			return -EINVAL;
-		}
-		cur = tmp;
-		if (*cur != '-') {
-			pr_warn("crashkernel: '-' expected\n");
-			return -EINVAL;
-		}
-		cur++;
-
-		/* if no ':' is here, than we read the end */
-		if (*cur != ':') {
-			end = memparse(cur, &tmp);
-			if (cur == tmp) {
-				pr_warn("crashkernel: Memory value expected\n");
-				return -EINVAL;
-			}
-			cur = tmp;
-			if (end <= start) {
-				pr_warn("crashkernel: end <= start\n");
-				return -EINVAL;
-			}
-		}
-
-		if (*cur != ':') {
-			pr_warn("crashkernel: ':' expected\n");
-			return -EINVAL;
-		}
-		cur++;
-
-		size = memparse(cur, &tmp);
-		if (cur == tmp) {
-			pr_warn("Memory value expected\n");
-			return -EINVAL;
-		}
-		cur = tmp;
-		if (size >= system_ram) {
-			pr_warn("crashkernel: invalid size\n");
-			return -EINVAL;
-		}
-
-		/* match ? */
-		if (system_ram >= start && system_ram < end) {
-			*crash_size = size;
-			break;
-		}
-	} while (*cur++ == ',');
+	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
+	if (cur == cmdline)
+		return -EINVAL;
 
 	if (*crash_size > 0) {
 		while (*cur && *cur != ' ' && *cur != '@')
@@ -1273,7 +1223,6 @@ static int __init __parse_crashkernel(char *cmdline,
 			     const char *name,
 			     const char *suffix)
 {
-	char	*first_colon, *first_space;
 	char	*ck_cmdline;
 
 	BUG_ON(!crash_size || !crash_base);
@@ -1291,12 +1240,10 @@ static int __init __parse_crashkernel(char *cmdline,
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
 	/*
-	 * if the commandline contains a ':', then that's the extended
+	 * if the parameter is range based, then that's the extended
 	 * syntax -- if not, it must be the classic syntax
 	 */
-	first_colon = strchr(ck_cmdline, ':');
-	first_space = strchr(ck_cmdline, ' ');
-	if (first_colon && (!first_space || first_colon < first_space))
+	if (is_param_range_based(ck_cmdline))
 		return parse_crashkernel_mem(ck_cmdline, system_ram,
 				crash_size, crash_base);
 
diff --git a/kernel/params.c b/kernel/params.c
index a6d6149..84e40ae 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -268,6 +268,102 @@ char *parse_args(const char *doing,
 	return err;
 }
 
+/*
+ * is_param_range_based - check if current parameter is range based
+ * @cmdline: points to the parameter to check
+ *
+ * Returns true when the current paramer is range based, false otherwise
+ */
+bool __init is_param_range_based(const char *cmdline)
+{
+	char    *first_colon, *first_space;
+
+	first_colon = strchr(cmdline, ':');
+	first_space = strchr(cmdline, ' ');
+	if (first_colon && (!first_space || first_colon < first_space))
+		return true;
+
+	return false;
+}
+
+/*
+ * parse_mem_range_size - parse size based on memory range
+ * @param:  the thing being parsed
+ * @str: (input)  where parse begins
+ *                expected format - <range1>:<size1>[,<range2>:<size2>,...]
+ *       (output) On success - next char after parse completes
+ *                On failure - unchanged
+ * @system_ram: system ram size to check memory range against
+ *
+ * Returns the memory size on success and 0 on failure
+ */
+unsigned long long __init parse_mem_range_size(const char *param,
+					       char **str,
+					       unsigned long long system_ram)
+{
+	char *cur = *str, *tmp;
+	unsigned long long mem_size = 0;
+
+	/* for each entry of the comma-separated list */
+	do {
+		unsigned long long start, end = ULLONG_MAX, size;
+
+		/* get the start of the range */
+		start = memparse(cur, &tmp);
+		if (cur == tmp) {
+			printk(KERN_INFO "%s: Memory value expected\n", param);
+			return mem_size;
+		}
+		cur = tmp;
+		if (*cur != '-') {
+			printk(KERN_INFO "%s: '-' expected\n", param);
+			return mem_size;
+		}
+		cur++;
+
+		/* if no ':' is here, than we read the end */
+		if (*cur != ':') {
+			end = memparse(cur, &tmp);
+			if (cur == tmp) {
+				printk(KERN_INFO "%s: Memory value expected\n",
+					param);
+				return mem_size;
+			}
+			cur = tmp;
+			if (end <= start) {
+				printk(KERN_INFO "%s: end <= start\n", param);
+				return mem_size;
+			}
+		}
+
+		if (*cur != ':') {
+			printk(KERN_INFO "%s: ':' expected\n", param);
+			return mem_size;
+		}
+		cur++;
+
+		size = memparse(cur, &tmp);
+		if (cur == tmp) {
+			printk(KERN_INFO "%s: Memory value expected\n", param);
+			return mem_size;
+		}
+		cur = tmp;
+		if (size >= system_ram) {
+			printk(KERN_INFO "%s: invalid size\n", param);
+			return mem_size;
+		}
+
+		/* match ? */
+		if (system_ram >= start && system_ram < end) {
+			mem_size = size;
+			*str = cur;
+			break;
+		}
+	} while (*cur++ == ',');
+
+	return mem_size;
+}
+
 /* Lazy bastard, eh? */
 #define STANDARD_PARAM_DEF(name, type, format, strtolfn)      		\
 	int param_set_##name(const char *val, const struct kernel_param *kp) \
