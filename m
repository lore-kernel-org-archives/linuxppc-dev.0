Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS6l956s1zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 15:21:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS6l90Msrz9s5g
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 15:21:40 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L4J7YX083542
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 23:21:39 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r3p8fdyc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 23:21:39 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 09:51:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 42A61E005A
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:53:12 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L4LYPk40501360
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:51:34 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L4LXgR029603
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:51:34 +0530
Subject: [PATCH 2/2] powerpc/book3s: mce: Use add_taint_no_warn() in
 machine_check_early().
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 21 Feb 2017 09:51:33 +0530
In-Reply-To: <148765088309.20315.15300624012053746538.stgit@jupiter.in.ibm.com>
References: <148765088309.20315.15300624012053746538.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148765089349.20315.11180051017586952500.stgit@jupiter.in.ibm.com>
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
to panic. Instead use the add_taint_no_warn() that does not call printk.

This is broken with current FW level. We got lucky so far for not getting
very first MCE hit while in OPAL. But easily reproducible on Mambo.
This should go to stable as well alongwith patch 1/2.

Fixes: 27ea2c420cad powerpc: Set the correct kernel taint on machine check errors.
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 62b587f..4a048dc 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -306,7 +306,7 @@ long machine_check_early(struct pt_regs *regs)
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
-	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+	add_taint_no_warn(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
 	/*
 	 * See if platform is capable of handling machine check. (e.g. PowerNV
