Return-Path: <shriyak@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGkpd29jgzDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 20:53:13 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0A9ntMd035783
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 04:53:10 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fdg2w1m8d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 04:53:10 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shriyak@linux.vnet.ibm.com>;
 Wed, 10 Jan 2018 04:53:09 -0500
From: Shriya <shriyak@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 shilpa.bhat@linux.vnet.ibm.com, npiggin@gmail.com,
 Shriya <shriyak@linux.vnet.ibm.com>
Subject: [PATCH] powerpc : Fix sleeping-in-atomic section warning triggered by
 /proc/cpuinfo
Date: Wed, 10 Jan 2018 15:22:58 +0530
Message-Id: <1515577978-21701-1-git-send-email-shriyak@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cd77b5ce208c ("Fix the frequency read by /proc/cpuinfo")
to fix /proc/cpuinfo on POWERNV triggered a sleeping-in-atomic section
warning. This was because the place where we cpufreq_get (which takes
an rwsem) from show_cpuinfo is in a preempt_disabled. However, the
preempt_disable() in show_cpuinfo is for protection against
CPU-Hotplug, since we don't want to report the information of offline
CPUs in /proc/cpuinfo.

Fix this by replacing preempt_disable()/preempt_enable() in
show_cpuinfo() by get_online_cpus()/put_online_cpus() giving a proper
protection against CPU-Hotplug.
---
 arch/powerpc/kernel/setup-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2075322..f772442 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -244,9 +244,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)

 	/* We only show online cpus: disable preempt (overzealous, I
 	 * knew) to prevent cpu going down. */
-	preempt_disable();
+	get_online_cpus();
 	if (!cpu_online(cpu_id)) {
-		preempt_enable();
+		put_online_cpus();
 		return 0;
 	}

@@ -359,7 +359,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "\n");
 #endif

-	preempt_enable();
+	put_online_cpus();

 	/* If this is the last cpu, print the summary */
 	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
--
1.9.1
