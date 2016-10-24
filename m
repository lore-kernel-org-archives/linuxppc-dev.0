Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2l4C05gVzDvXb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 05:22:03 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t2l4B3FVfz9t1d
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 05:22:02 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9OIJ1Sf043836
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Oct 2016 14:22:00 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269kjvn4v0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Oct 2016 14:21:59 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 04:21:57 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 679B23578053
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 05:21:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9OILtQA13238506
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 05:21:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9OILsxW012889
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 05:21:55 +1100
Subject: [PATCH v2] powerpc/fadump: Fix the race in crash_fadump().
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Anton Blanchard <anton@samba.org>
Date: Mon, 24 Oct 2016 23:51:51 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147733331174.26684.12646675491489853468.stgit@jupiter.in.ibm.com>
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
Changes in V2:
- Use cmpxchg instead of mutex lock during panic path.
---
 arch/powerpc/kernel/fadump.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b3a6633..a795956 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -401,12 +401,35 @@ static void register_fw_dump(struct fadump_mem_struct *fdm)
 void crash_fadump(struct pt_regs *regs, const char *str)
 {
 	struct fadump_crash_info_header *fdh = NULL;
+	int old_cpu, this_cpu;
 
 	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr)
 		return;
 
+	/*
+	 * old_cpu == -1 means this is the first CPU which has come here,
+	 * go ahead and trigger fadump.
+	 *
+	 * old_cpu != -1 means some other CPU has already on it's way
+	 * to trigger fadump, just keep looping here.
+	 */
+	this_cpu = smp_processor_id();
+	old_cpu = cmpxchg(&crashing_cpu, -1, this_cpu);
+
+	if (old_cpu != -1) {
+		/*
+		 * We can't loop here indefinitely. Wait as long as fadump
+		 * is in force. If we race with fadump un-registration this
+		 * loop will break and then we go down to normal panic path
+		 * and reboot. If fadump is in force the first crashing
+		 * cpu will definitely trigger fadump.
+		 */
+		while (fw_dump.dump_registered)
+			cpu_relax();
+		return;
+	}
+
 	fdh = __va(fw_dump.fadumphdr_addr);
-	crashing_cpu = smp_processor_id();
 	fdh->crashing_cpu = crashing_cpu;
 	crash_save_vmcoreinfo();
 
