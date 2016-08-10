Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8RcP2mymzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 20:05:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8RcN2Zczz9stc
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:05:56 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7AA4qVV065062
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 06:05:54 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9rxbg6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 06:05:54 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 20:05:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ED18B2BB0059
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:05:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7AA5ase23265346
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:05:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7AA5aPY030839
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:05:36 +1000
Subject: [PATCH v3 2/2] powerpc/fadump: parse fadump reserve memory size
 based on memory range
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Date: Wed, 10 Aug 2016 15:35:32 +0530
In-Reply-To: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
References: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147082352471.4631.16292252236310652183.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When fadump is enabled, by default 5% of system RAM is reserved for
fadump kernel. While that works for most cases, it is not good enough
for every case.

Currently, to override the default value, fadump supports specifying
memory to reserve with fadump_reserve_mem=size, where only a fixed size
can be specified. This patch adds support to specify memory size to
reserve for different memory ranges as below:

	fadump_reserve_mem=<range1>:<size1>[,<range2>:<size2>,...]

Supporting range based input for "fadump_reserve_mem" parameter helps
using the same commandline parameter for different system memory sizes.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
---

Changes from v2:
1. Updated changelog


 arch/powerpc/kernel/fadump.c |   63 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b3a6633..7c01b5b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -193,6 +193,55 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
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
+	if (!is_colon_in_param(fadump_cmdline)) {
+		fw_dump.reserve_bootvar = memparse(fadump_cmdline, NULL);
+		return 0;
+	}
+
+	/* for fadump_reserve_mem=ramsize-range:size[,...] cmdline syntax */
+	cur = fadump_cmdline;
+	fw_dump.reserve_bootvar = parse_mem_range_size("fadump_reserve_mem",
+					&cur, memblock_phys_mem_size());
+	if (cur == fadump_cmdline) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
  *
@@ -212,12 +261,17 @@ static inline unsigned long fadump_calculate_reserve_size(void)
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
@@ -348,15 +402,6 @@ static int __init early_fadump_param(char *p)
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
