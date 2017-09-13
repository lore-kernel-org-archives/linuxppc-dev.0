Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsvjF43ndzDrJc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:21:05 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8DLIxx0031843
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:21:02 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cyb1tw9sq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:21:02 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 07:20:59 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8DLKud340566824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:20:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8DLKw72026050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:20:58 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH 3/5] powerpc/kprobes: Fix warnings from __this_cpu_read() on
 preempt kernels
Date: Thu, 14 Sep 2017 02:50:34 +0530
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <63b0f9f3fd3d95d758678a892b87b7c561545c99.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kamalesh pointed out that we are getting the below call traces with
livepatched functions when we enable CONFIG_PREEMPT:

[  495.470721] BUG: using __this_cpu_read() in preemptible [00000000] code: cat/8394
[  495.471167] caller is is_current_kprobe_addr+0x30/0x90
[  495.471171] CPU: 4 PID: 8394 Comm: cat Tainted: G              K 4.13.0-rc7-nnr+ #95
[  495.471173] Call Trace:
[  495.471178] [c00000008fd9b960] [c0000000009f039c] dump_stack+0xec/0x160 (unreliable)
[  495.471184] [c00000008fd9b9a0] [c00000000059169c] check_preemption_disabled+0x15c/0x170
[  495.471187] [c00000008fd9ba30] [c000000000046460] is_current_kprobe_addr+0x30/0x90
[  495.471191] [c00000008fd9ba60] [c00000000004e9a0] ftrace_call+0x1c/0xb8
[  495.471195] [c00000008fd9bc30] [c000000000376fd8] seq_read+0x238/0x5c0
[  495.471199] [c00000008fd9bcd0] [c0000000003cfd78] proc_reg_read+0x88/0xd0
[  495.471203] [c00000008fd9bd00] [c00000000033e5d4] __vfs_read+0x44/0x1b0
[  495.471206] [c00000008fd9bd90] [c0000000003402ec] vfs_read+0xbc/0x1b0
[  495.471210] [c00000008fd9bde0] [c000000000342138] SyS_read+0x68/0x110
[  495.471214] [c00000008fd9be30] [c00000000000bc6c] system_call+0x58/0x6c

Commit c05b8c4474c030 ("powerpc/kprobes: Skip livepatch_handler() for
jprobes") introduced a helper is_current_kprobe_addr() to help determine
if the current function has been livepatched or if it has a jprobe
installed, both of which modify the NIP.

In the case of a jprobe, kprobe_ftrace_handler() disables pre-emption
before calling into setjmp_pre_handler() which returns without disabling
pre-emption. This is done to ensure that the jprobe handler won't
disappear beneath us if the jprobe is unregistered between the
setjmp_pre_handler() and the subsequent longjmp_break_handler() called
from the jprobe handler. Due to this, we can use __this_cpu_read() in
is_current_kprobe_addr() with the pre-emption check as we know that
pre-emption will be disabled.

However, if this function has been livepatched, we are still doing this
check and when we do so, pre-emption won't necessarily be disabled. This
results in the call trace shown above.

Fix this by only invoking is_current_kprobe_addr() when pre-emption is
disabled. And since we now guard this within a pre-emption check, we can
instead use raw_cpu_read() to get the current_kprobe value skipping the
check done by __this_cpu_read().

Fixes: c05b8c4474c030 ("powerpc/kprobes: Skip livepatch_handler() for jprobes")
Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index e848fe2c93fb..db40b13fd3d1 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -45,8 +45,12 @@ struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
 int is_current_kprobe_addr(unsigned long addr)
 {
-	struct kprobe *p = kprobe_running();
-	return (p && (unsigned long)p->addr == addr) ? 1 : 0;
+	if (!preemptible()) {
+		struct kprobe *p = raw_cpu_read(current_kprobe);
+		return (p && (unsigned long)p->addr == addr) ? 1 : 0;
+	}
+
+	return 0;
 }
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
-- 
2.14.1
