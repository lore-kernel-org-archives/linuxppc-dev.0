Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfY376CgVzDqvL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:40:51 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rfY370DB3z9t0X
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:50 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T6d2cf141563
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:40:49 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23utc8pqj1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:40:48 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 29 Jun 2016 16:40:44 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8568B2CE8059
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5T6eeKk3735814
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5T6ee1u018497
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org, mikey@neuling.org
Subject: [RFC 2/3] powerpc: tm: Add TM Unavailable Exception
Date: Wed, 29 Jun 2016 16:34:35 +1000
In-Reply-To: <20160629063436.10003-1-cyrilbur@gmail.com>
References: <20160629063436.10003-1-cyrilbur@gmail.com>
Message-Id: <20160629063436.10003-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the kernel disables transactional memory (TM) and userspace still
tries TM related actions (TM instructions or TM SPR accesses) TM aware
hardware will cause the kernel to take a facility unavailable
exception.

Add checks for the exception being caused by illegal TM access in
userspace.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/traps.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 3e4c84d..29260ee 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1364,6 +1364,13 @@ void vsx_unavailable_exception(struct pt_regs *regs)
 	die("Unrecoverable VSX Unavailable Exception", regs, SIGABRT);
 }
 
+static void tm_unavailable(struct pt_regs *regs)
+{
+	pr_emerg("Unrecoverable TM Unavailable Exception "
+			"%lx at %lx\n", regs->trap, regs->nip);
+	die("Unrecoverable TM Unavailable Exception", regs, SIGABRT);
+}
+
 #ifdef CONFIG_PPC64
 void facility_unavailable_exception(struct pt_regs *regs)
 {
@@ -1434,6 +1441,23 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		return;
 	}
 
+	/*
+	 * TM Unavailable
+	 *
+	 * If
+	 *  - firmware bits say don't do TM or
+	 *  - CONFIG_PPC_TRANSACTIONAL_MEM was not set and
+	 *  - hardware is actually TM aware
+	 * Then userspace can spam the console (even with the use of
+	 * _ratelimited), just send the SIGILL.
+	 */
+	if (status == FSCR_TM_LG) {
+		if (!cpu_has_feature(CPU_FTR_TM))
+			goto out;
+		tm_unavailable(regs);
+		return;
+	}
+
 	if ((status < ARRAY_SIZE(facility_strings)) &&
 	    facility_strings[status])
 		facility = facility_strings[status];
@@ -1446,6 +1470,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		"%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
 		hv ? "Hypervisor " : "", facility, regs->nip, regs->msr);
 
+out:
 	if (user_mode(regs)) {
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 		return;
-- 
2.9.0
