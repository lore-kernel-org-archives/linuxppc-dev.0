Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96E3814017D
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 00:17:25 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 28 Apr 2014 19:47:22 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 39E6E394004E
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 19:47:20 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3SEHDJg49610924
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 19:47:13 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3SEHIWe007957
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2014 19:47:19 +0530
Subject: [PATCH] powerpc/book3s: Increment the mce counter during
 machine_check_early call.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 28 Apr 2014 19:47:17 +0530
Message-ID: <20140428141717.5582.73823.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

We don't see MCE counter getting increased in /proc/interrupts which gives
false impression of no MCE occurred even when there were MCE events.
The machine check early handling was added for PowerKVM and we missed to
increment the MCE count in the early handler.

We also increment mce counters in the machine_check_exception call, but
in most cases where we handle the error hypervisor never reaches there
unless its fatal and we want to crash. Only during fatal situation we may
see double increment of mce count. We need to fix that. But for
now it always good to have some count increased instead of zero.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/traps.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1bd7ca2..239f1cd 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -295,6 +295,8 @@ long machine_check_early(struct pt_regs *regs)
 {
 	long handled = 0;
 
+	__get_cpu_var(irq_stat).mce_exceptions++;
+
 	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
 		handled = cur_cpu_spec->machine_check_early(regs);
 	return handled;
