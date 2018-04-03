Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0dc27JSzF28X
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:13:08 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KAeII131594
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:13:05 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h4fun9tbv-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:13:05 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:13:03 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 06/10] powerpc64/ftrace: Disable ftrace during hotplug
Date: Wed,  4 Apr 2018 01:42:21 +0530
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <94524a0ec17d783a07b223de87f25dc2783b5116.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Disable ftrace when a cpu is about to go offline. When the cpu is woken
up, ftrace will get enabled in start_secondary().

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index d90195dddc57..09a7ef12ff33 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1122,6 +1122,8 @@ int __cpu_disable(void)
 	if (!smp_ops->cpu_disable)
 		return -ENOSYS;
 
+	this_cpu_disable_ftrace();
+
 	err = smp_ops->cpu_disable();
 	if (err)
 		return err;
@@ -1140,6 +1142,12 @@ void __cpu_die(unsigned int cpu)
 
 void cpu_die(void)
 {
+	/*
+	 * Disable on the down path. This will be re-enabled by
+	 * start_secondary() via start_secondary_resume() below
+	 */
+	this_cpu_disable_ftrace();
+
 	if (ppc_md.cpu_die)
 		ppc_md.cpu_die();
 
-- 
2.16.2
