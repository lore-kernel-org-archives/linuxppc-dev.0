Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wttRz5sK3zDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:27:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MKPrdk108225
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 16:27:40 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8magsnft-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 16:27:40 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 22 Jun 2017 17:27:38 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5MKRZiU16056412
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 17:27:35 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5MKRZQU007649
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 17:27:35 -0300
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/kernel: Avoid redundancies on giveup_all
Date: Thu, 22 Jun 2017 17:27:23 -0300
Message-Id: <1498163243-22203-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently giveup_all() calls __giveup_fpu(), __giveup_altivec(), and
__giveup_vsx(). But __giveup_vsx() also calls __giveup_fpu() and
__giveup_altivec() again, in a redudant manner.

Other than giving up FP and Altivec, __giveup_vsx() also disables
MSR_VSX on MSR, but this is already done by __giveup_{fpu,altivec}().
As VSX can not be enabled alone on MSR (without FP and/or VEC
enabled), this is also a redundancy. VSX is never enabled alone (without
FP and VEC) because every time VSX is enabled, as through load_up_vsx()
and restore_math(), FP is also enabled together.

This change improves giveup_all() in average just 3%, but since
giveup_all() is called very frequently, around 8x per CPU per second on
an idle machine, this change might show some noticeable improvement.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2ad725ef4368..5d6af58270e6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -494,10 +494,6 @@ void giveup_all(struct task_struct *tsk)
 	if (usermsr & MSR_VEC)
 		__giveup_altivec(tsk);
 #endif
-#ifdef CONFIG_VSX
-	if (usermsr & MSR_VSX)
-		__giveup_vsx(tsk);
-#endif
 #ifdef CONFIG_SPE
 	if (usermsr & MSR_SPE)
 		__giveup_spe(tsk);
-- 
2.11.0
