Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Rc13cVNzDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 20:05:37 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8Rc10JmSz9stc
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:05:36 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7AA4xJO038237
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 06:05:35 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9sx74m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 06:05:34 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 15:35:31 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 33076E0063
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 15:39:53 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7AA5PqO51052756
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 15:35:25 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7AA5Ku4032750
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 15:35:24 +0530
Subject: [PATCH v3 1/2] kexec: refactor code parsing size based on memory range
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Date: Wed, 10 Aug 2016 15:35:14 +0530
In-Reply-To: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
References: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147082349963.4631.9032919386344219875.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

crashkernel parameter supports different syntaxes to specify the amount
of memory to be reserved for kdump kernel. Below is one of the supported
syntaxes that needs parsing to find the memory size to reserve, based on
memory range:

        crashkernel=<range1>:<size1>[,<range2>:<size2>,...]

While such parsing is implemented for crashkernel parameter, it applies
to other parameters, like fadump_reserve_mem=, which could use similar
syntax. This patch moves crashkernel's parsing code for above syntax to
to kernel/params.c file for reuse. Two functions is_param_range_based()
and parse_mem_range_size() are added to kernel/params.c file for this
purpose.

Any parameter that uses the above syntax can use is_param_range_based()
function to validate the syntax and parse_mem_range_size() function to
get the parsed memory size. While some code is moved to kernel/params.c
file, there is no change functionality wise in parsing the crashkernel
parameter.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes from v2:
1. Moved the code to lib/cmdline.c instead of kernel/params.c


 include/linux/kernel.h |    5 ++
 kernel/kexec_core.c    |   63 ++---------------------------
 lib/cmdline.c          |  104 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 58 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d96a611..39ff869 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -435,6 +435,11 @@ extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
 extern bool parse_option_str(const char *str, const char *option);
 
+extern bool __init is_colon_in_param(const char *cmdline);
+extern unsigned long long __init parse_mem_range_size(const char *param,
+						      char **str,
+						      unsigned long long system_ram);
+
 extern int core_kernel_text(unsigned long addr);
 extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5616755..152c4c1 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1104,59 +1104,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
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
@@ -1293,7 +1243,6 @@ static int __init __parse_crashkernel(char *cmdline,
 			     const char *name,
 			     const char *suffix)
 {
-	char	*first_colon, *first_space;
 	char	*ck_cmdline;
 
 	BUG_ON(!crash_size || !crash_base);
@@ -1311,12 +1260,10 @@ static int __init __parse_crashkernel(char *cmdline,
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
+	if (is_colon_in_param(ck_cmdline))
 		return parse_crashkernel_mem(ck_cmdline, system_ram,
 				crash_size, crash_base);
 
diff --git a/lib/cmdline.c b/lib/cmdline.c
index 8f13cf7..cbe22ea 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -189,3 +189,107 @@ bool parse_option_str(const char *str, const char *option)
 
 	return false;
 }
+
+/*
+ * is_colon_in_param - check if current parameter has colon in it
+ * @cmdline: points to the parameter to check
+ *
+ * This function checks if the current parameter has a colon in it.
+ * Can be used for parameters that are range based or likewise.
+ *
+ * Returns true when the current paramer is has colon, false otherwise
+ */
+bool __init is_colon_in_param(const char *cmdline)
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
+ * @param:  the parameter being parsed
+ * @str: (input)  where parsing begins
+ *                expected format - <range1>:<size1>[,<range2>:<size2>,...]
+ *                Range is specified with a number (potentially suffixed with
+ *                K, M, G, T, P, E), signifying an inclusive start size,
+ *                followed by a hypen and possibly another number signifying
+ *                an exclusive end size
+ *                Eg. : 4G-8G:512M,8G-32G:1024M,32G-128G:2048M,128G-:4096M
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
+			printk(KERN_INFO "%s: memory value expected\n", param);
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
+				printk(KERN_INFO "%s: memory value expected\n",
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
+			printk(KERN_INFO "%s: memory value expected\n", param);
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
