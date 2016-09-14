Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYvDq5gGGzDsZ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:03:23 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8E83Hli074955
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 04:03:21 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25eupkjbab-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 04:03:20 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 14 Sep 2016 18:02:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D097D2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:37 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8E82bdU52822256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8E82boa020789
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:02:37 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: mikey@neuling.org, anton@samba.org, wei.guo.simon@gmail.com
Subject: [PATCH 1/2] powerpc: tm: Add TM Unavailable Exception
Date: Wed, 14 Sep 2016 18:02:15 +1000
In-Reply-To: <20160914080216.13833-1-cyrilbur@gmail.com>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
Message-Id: <20160914080216.13833-2-cyrilbur@gmail.com>
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
index 0eba74b..cd40130 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1372,6 +1372,13 @@ void vsx_unavailable_exception(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_PPC64
+static void tm_unavailable(struct pt_regs *regs)
+{
+	pr_emerg("Unrecoverable TM Unavailable Exception "
+			"%lx at %lx\n", regs->trap, regs->nip);
+	die("Unrecoverable TM Unavailable Exception", regs, SIGABRT);
+}
+
 void facility_unavailable_exception(struct pt_regs *regs)
 {
 	static char *facility_strings[] = {
@@ -1451,6 +1458,23 @@ void facility_unavailable_exception(struct pt_regs *regs)
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
@@ -1463,6 +1487,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		"%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
 		hv ? "Hypervisor " : "", facility, regs->nip, regs->msr);
 
+out:
 	if (user_mode(regs)) {
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 		return;
-- 
2.9.3
