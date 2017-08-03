Return-Path: <srs0=5zt0=7f=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNPmz0nMMzDr5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:25:55 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xNPmy5xCnz8syC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:25:54 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xNPmy1lkSz9s82
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2017 19:25:54 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v739OwIM147377
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 05:25:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3wyajqv1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Aug 2017 05:25:52 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 19:25:50 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v739Pcap27590740
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 19:25:46 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v739PDpr020458
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 19:25:14 +1000
Subject: [PATCH 2/4] powerpc/prom: fix early parsing of parameters
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: ben@codiert.org, Michael Ellerman <mpe@ellerman.id.au>,
 stable@vger.kernel.org#2.6.15+, Paul Mackerras <paulus@samba.org>,
 sjitindarsingh@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 03 Aug 2017 14:54:47 +0530
In-Reply-To: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150175228769.9806.13262099086753853191.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Parameters 'mem=', 'iommu=' and the like, which affect the iommu are
parsed early in the boot process. This parser looks for a parameter
substring like 'iommu=' in the cmdline string but it could also succeed
when cmdline string contains parameters like 'x_iommu=' or such leading
to undesired results. Add support to skip proceeding in such cases.

Fixes: 9b6b563c0d2d ("powerpc: Merge in the ppc64 version of the prom code.")
Cc: stable@vger.kernel.org # 2.6.15+
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 723df83..7030145 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -594,6 +594,26 @@ static unsigned long prom_memparse(const char *ptr, const char **retptr)
 }
 
 /*
+ * Check if str is a suffix of another param as "mem=" could
+ * be "iomem=" as well.
+ */
+static bool is_substring_param(const char *cmdline, const char *str)
+{
+	char *p;
+	bool ret = false;
+
+	if (cmdline == str)
+		ret = true;
+	else {
+		p = (char *)(str - 1);
+		if (*p == ' ' || *p == '"')
+			ret = true;
+	}
+
+	return ret;
+}
+
+/*
  * Early parsing of the command line passed to the kernel, used for
  * "mem=x" and the options that affect the iommu
  */
@@ -617,7 +637,7 @@ static void __init early_cmdline_parse(void)
 
 #ifdef CONFIG_PPC64
 	opt = strstr(prom_cmd_line, "iommu=");
-	if (opt) {
+	if (opt && is_substring_param(prom_cmd_line, opt)) {
 		prom_printf("iommu opt is: %s\n", opt);
 		opt += 6;
 		while (*opt && *opt == ' ')
