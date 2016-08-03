Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4NY66K4xzDqbk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 05:34:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4NY630M9z9stc
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 05:34:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73JXgJb088822
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Aug 2016 15:34:00 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkag15ej-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Aug 2016 15:34:00 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 05:33:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3D11B3578057
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 05:33:55 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u73JXtBY25559072
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 05:33:55 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u73JXsXH007398
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 05:33:55 +1000
Subject: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve memory
 size based on memory range
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Date: Thu, 04 Aug 2016 01:03:49 +0530
In-Reply-To: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
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
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   64 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b3a6633..4661ae6 100644
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
@@ -348,15 +403,6 @@ static int __init early_fadump_param(char *p)
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
