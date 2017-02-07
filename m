Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHw6m4Br6zDqCQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 06:55:12 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17Jrhuv121698
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 14:55:10 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28fmmd0gjk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 14:55:09 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 01:25:06 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4723AE0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 01:26:29 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17Js5qP21233736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 01:24:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17Jt1XW021965
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 01:25:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: mhiramat@kernel.org, ananth@linux.vnet.ibm.com
Cc: mingo@kernel.org, mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] arm: kprobes: remove kprobe_exceptions_notify
Date: Wed,  8 Feb 2017 01:24:15 +0530
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

... as the weak variant will do.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/arm/probes/kprobes/core.c     | 10 ----------
 arch/arm64/kernel/probes/kprobes.c |  6 ------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index a4ec240ee7ba..f89db1e278cf 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -391,16 +391,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 	return 0;
 }
 
-int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
-				       unsigned long val, void *data)
-{
-	/*
-	 * notify_die() is currently never called on ARM,
-	 * so this callback is currently empty.
-	 */
-	return NOTIFY_DONE;
-}
-
 /*
  * When a retprobed function returns, trampoline_handler() is called,
  * calling the kretprobe's handler. We construct a struct pt_regs to
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index f0593c92279b..769becae3e90 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -371,12 +371,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 	return 0;
 }
 
-int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
-				       unsigned long val, void *data)
-{
-	return NOTIFY_DONE;
-}
-
 static void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur_kprobe;
-- 
2.11.0
