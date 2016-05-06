Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1VWD4Nm5zDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 21:52:08 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r1VWD2VGmz9snm
 for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2016 21:52:08 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 May 2016 21:52:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D04853578052
 for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2016 21:52:05 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u46BpviB58785886
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:52:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u46BpXEo015538
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:51:33 +1000
Received: from hbathini.in.ibm.com (hbathini.in.ibm.com [9.184.79.239] (may be
 forged))
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u46BpW7O015218
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:51:33 +1000
Subject: [PATCH 3/3] powerpc/fadump: add support for fadump_nr_cpus= parameter
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 06 May 2016 17:21:08 +0530
Message-ID: <20160506115108.26330.38061.stgit@hbathini.in.ibm.com>
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

Kernel parameter 'nr_cpus' can be used to limit the maximum number
of processors that an SMP kernel could support. This patch extends
this to fadump by introducing 'fadump_nr_cpus' parameter that can
help in booting fadump kernel on a lower memory footprint.

Suggested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a7fef3e..c75783c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -470,6 +470,28 @@ static int __init early_fadump_param(char *p)
 }
 early_param("fadump", early_fadump_param);
 
+/* Look for fadump_nr_cpus= cmdline option. */
+static int __init early_fadump_nrcpus(char *p)
+{
+	int nr_cpus;
+
+	/*
+	 * fadump_nr_cpus parameter is only applicable on a
+	 * fadump active kernel. This is to reduce memory
+	 * needed to boot a fadump active kernel.
+	 * So, check if we are booting after crash.
+	 */
+	if (!is_fadump_active())
+		return 0;
+
+	get_option(&p, &nr_cpus);
+	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
+		nr_cpu_ids = nr_cpus;
+
+	return 0;
+}
+early_param("fadump_nr_cpus", early_fadump_nrcpus);
+
 static void register_fw_dump(struct fadump_mem_struct *fdm)
 {
 	int rc;
