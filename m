Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssqxt2TDJzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 17:30:42 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ssqxs4zy1z9sf9
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2016 17:30:41 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9A6TFAF061622
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2016 02:30:39 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25yt47wa0a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2016 02:30:39 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 10 Oct 2016 12:00:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 01215E0024
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2016 12:00:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9A6UVdA35651774
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2016 12:00:32 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9A6UUSF021067
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2016 12:00:31 +0530
Subject: [PATCH] powerpc/fadump: Fix the race in crash_fadump().
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Haren Myneni <hbabu@us.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 Anton Blanchard <anton@samba.org>
Date: Mon, 10 Oct 2016 12:00:12 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147608098939.18363.6488762843827913560.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

There are chances that multiple CPUs can call crash_fadump() simultaneously
and would start duplicating same info to vmcoreinfo ELF note section. This
causes makedumpfile to fail during kdump capture. One example is,
triggering dumprestart from HMC which sends system reset to all the CPUs at
once.

makedumpfile --dump-dmesg /proc/vmcore
read_vmcoreinfo_basic_info: Invalid data in /tmp/vmcoreinfoyjgxlL: CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971
makedumpfile Failed.
Running makedumpfile --dump-dmesg /proc/vmcore failed (1).

makedumpfile  -d 31 -l /proc/vmcore
read_vmcoreinfo_basic_info: Invalid data in /tmp/vmcoreinfo1mmVdO: CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971
makedumpfile Failed.
Running makedumpfile  -d 31 -l /proc/vmcore failed (1).

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b3a6633..2ed9d1c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -402,8 +402,14 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 {
 	struct fadump_crash_info_header *fdh = NULL;
 
-	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr)
+	mutex_lock(&fadump_mutex);
+	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr) {
+		mutex_unlock(&fadump_mutex);
 		return;
+	}
+
+	if (crashing_cpu != -1)
+		goto unlock_out;
 
 	fdh = __va(fw_dump.fadumphdr_addr);
 	crashing_cpu = smp_processor_id();
@@ -417,6 +423,9 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 
 	fdh->online_mask = *cpu_online_mask;
 
+unlock_out:
+	mutex_unlock(&fadump_mutex);
+
 	/* Call ibm,os-term rtas call to trigger firmware assisted dump */
 	rtas_os_term((char *)str);
 }
