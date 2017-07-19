Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC5b10jHHzDrRg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 15:45:00 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6J5hg2P098968
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 01:44:58 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bsu0scp1k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 01:44:58 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 02:44:56 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6J5eTib28442708
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 02:40:29 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6J2iqUx013398
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 23:44:53 -0300
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: cyrilbur@gmail.com, mpe@ellerman.id.au,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/tm: fix TM SPRs in code dump file
Date: Wed, 19 Jul 2017 01:44:13 -0400
Message-Id: <1500443053-1264-1-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently flush_tmregs_to_thread() does not update accordingly the thread
structures from live state before a core dump rendering wrong values of
THFAR, TFIAR, and TEXASR in core dump files.

That commit fixes it by copying from live state to the appropriate thread
structures when it's necessary.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 925a4ef..660ed39 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -127,12 +127,19 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
 	 * If task is not current, it will have been flushed already to
 	 * it's thread_struct during __switch_to().
 	 *
-	 * A reclaim flushes ALL the state.
+	 * A reclaim flushes ALL the state or if not in TM save TM SPRs
+	 * in the appropriate thread structures from live.
 	 */
 
-	if (tsk == current && MSR_TM_SUSPENDED(mfmsr()))
-		tm_reclaim_current(TM_CAUSE_SIGNAL);
+	if (tsk != current)
+		return;
 
+	if (MSR_TM_SUSPENDED(mfmsr())) {
+		tm_reclaim_current(TM_CAUSE_SIGNAL);
+	} else {
+		tm_enable();
+		tm_save_sprs(&(tsk->thread));
+	}
 }
 #else
 static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
-- 
2.7.4
