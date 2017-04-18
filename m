Return-Path: <srs0=dvxa=32=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6rRb1MzFzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 02:38:35 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w6rRb04DRz8t00
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 02:38:35 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w6rRZ1M9vz9s78
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2017 02:38:33 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3IGO7Jh142827
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2017 12:38:29 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29w0e2mwcb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2017 12:38:29 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 18 Apr 2017 22:08:25 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3IGaxxn12714050
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2017 22:06:59 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3IGcM4V025455
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2017 22:08:23 +0530
Subject: [PATCH v2] powerpc/book3s: mce: Move add_taint() later in virtual
 mode.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Date: Tue, 18 Apr 2017 22:08:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

machine_check_early() gets called in real mode. The very first time when
add_taint() is called, it prints a warning which ends up calling opal
call (that uses OPAL_CALL wrapper) for writing it to console. If we get a
very first machine check while we are in opal we are doomed. OPAL_CALL
overwrites the PACASAVEDMSR in r13 and in this case when we are done with
MCE handling the original opal call will use this new MSR on it's way
back to opal_return. This usually leads unexpected behaviour or kernel
to panic. Instead move the add_taint() call later in the virtual mode
where it is safe to call.

This is broken with current FW level. We got lucky so far for not getting
very first MCE hit while in OPAL. But easily reproducible on Mambo.
This should go to stable.

Fixes: 27ea2c420cad powerpc: Set the correct kernel taint on machine check errors.
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/mce.c   |    2 ++
 arch/powerpc/kernel/traps.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index a1475e6..b23b323 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -221,6 +221,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
 {
 	int index;
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
 	/*
 	 * For now just print it to console.
 	 * TODO: log this error event to FSP or nvram.
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ff365f9..af97e81 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -306,8 +306,6 @@ long machine_check_early(struct pt_regs *regs)
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
-	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
 	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
 		handled = cur_cpu_spec->machine_check_early(regs);
 	return handled;
@@ -741,6 +739,8 @@ void machine_check_exception(struct pt_regs *regs)
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
 	/* See if any machine dependent calls. In theory, we would want
 	 * to call the CPU first, and call the ppc_md. one if the CPU
 	 * one returns a positive number. However there is existing code
