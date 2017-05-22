Return-Path: <srs0=ejaj=44=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWYRb5jxxzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 19:35:23 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wWYRb54B9z8wTg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 19:35:23 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wWYRb1vK4z9s7h
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 19:35:23 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4M9Sm2L035426
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 05:35:21 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2akmunj1tv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 05:35:21 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 22 May 2017 19:35:18 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4M9Z6rB63045654
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 19:35:14 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4M9YgHB010635
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 19:34:42 +1000
Subject: [PATCH 1/2] powerpc/fadump: add a warning when
 'fadump_reserve_mem=' is used
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Prarit Bhargava <prarit@redhat.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 22 May 2017 15:04:23 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149544566391.16888.187413825827689513.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit 11550dc0a00b ("powerpc/fadump: reuse crashkernel parameter
for fadump memory reservation"), 'fadump_reserve_mem=' parameter is
deprecated in favor of 'crashkernel=' parameter. Add a warning if
'fadump_reserve_mem=' is still used.

Suggested-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 466569e..c0db844 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -212,6 +212,10 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 	int ret;
 	unsigned long long base, size;
 
+	if (fw_dump.reserve_bootvar)
+		pr_warn("'fadump_reserve_mem=' parameter is deprecated in "
+			"favor of 'crashkernel=' parameter.\n");
+
 	/*
 	 * Check if the size is specified through crashkernel= cmdline
 	 * option. If yes, then use that but ignore base as fadump
@@ -220,8 +224,18 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&size, &base);
 	if (ret == 0 && size > 0) {
+		if (fw_dump.reserve_bootvar)
+			pr_info("Using 'crashkernel=' parameter for"
+				" memory reservation.\n");
+
 		fw_dump.reserve_bootvar = (unsigned long)size;
 		return fw_dump.reserve_bootvar;
+	} else if (fw_dump.reserve_bootvar) {
+		/*
+		 * 'fadump_reserve_mem=' is being used to reserve memory
+		 * for firmware-assisted dump.
+		 */
+		return fw_dump.reserve_bootvar;
 	}
 
 	/* divide by 20 to get 5% of value */
@@ -377,6 +391,19 @@ static int __init early_fadump_param(char *p)
 }
 early_param("fadump", early_fadump_param);
 
+/*
+ * Look for fadump_reserve_mem= cmdline option
+ * TODO: Remove references to 'fadump_reserve_mem=' parameter,
+ *       the sooner 'crashkernel=' parameter is accustomed to.
+ */
+static int __init early_fadump_reserve_mem(char *p)
+{
+	if (p)
+		fw_dump.reserve_bootvar = memparse(p, &p);
+	return 0;
+}
+early_param("fadump_reserve_mem", early_fadump_reserve_mem);
+
 static void register_fw_dump(struct fadump_mem_struct *fdm)
 {
 	int rc;
