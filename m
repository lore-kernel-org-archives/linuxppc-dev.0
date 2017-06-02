Return-Path: <breno.leitao@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfc4V667pzDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 06:58:18 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v52Krg3o026964
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 16:58:09 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2au4r3bk4y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 16:58:09 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <breno.leitao@gmail.com>;
 Fri, 2 Jun 2017 17:58:07 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v52KvvFA4129026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 17:58:05 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v52KvXOZ030881
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 17:57:33 -0300
From: Breno Leitao <breno.leitao@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <breno.leitao@gmail.com>,
 Gustavo Romero <gusbromero@gmail.com>
Subject: [PATCH] powerpc/kernel: improve FP and vector registers restoration
Date: Fri,  2 Jun 2017 17:56:43 -0300
Message-Id: <1496437003-32584-1-git-send-email-breno.leitao@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently tsk->thread->load_vec and load_fp are not initialized during a
task creation, which set garbage to these variables (non-zero value).

These variables will be checked later at restore_math() to validate if the
FP and vectors are being utilized. Since these values might be non-zero,
the restore_math() will continue to save the FP and vectors even if they
were never utilized before the userspace application. load_fp and load_vec
counters will then overflow and the FP and Altivec will be finally
disabled, but before that condition is reached (counter overflow) several
context switches restored FP and vector registers without need, causing a
performance degradation.

Signed-off-by: Breno Leitao <breno.leitao@gmail.com>
Signed-off-by: Gustavo Romero <gusbromero@gmail.com>
---
 arch/powerpc/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index baae104b16c7..a9435397eab8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1666,6 +1666,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 #ifdef CONFIG_VSX
 	current->thread.used_vsr = 0;
 #endif
+	current->thread.load_fp = 0;
 	memset(&current->thread.fp_state, 0, sizeof(current->thread.fp_state));
 	current->thread.fp_save_area = NULL;
 #ifdef CONFIG_ALTIVEC
@@ -1674,6 +1675,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.vr_save_area = NULL;
 	current->thread.vrsave = 0;
 	current->thread.used_vr = 0;
+	current->thread.load_vec = 0;
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
 	memset(current->thread.evr, 0, sizeof(current->thread.evr));
-- 
2.11.0
