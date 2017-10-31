Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQznf6Xx9zDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 16:05:42 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9V540t7088830
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 01:05:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dxfhsadah-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 01:05:39 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 31 Oct 2017 05:05:38 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, leitao@debian.org, gromero@linux.vnet.ibm.com,
 andrew@aj.id.au, jk@ozlabs.org, sam@mendozajonas.com
Subject: [PATCH v2 4/4] powerpc: Remove facility loadups on transactional {fp,
 vec, vsx} unavailable
Date: Tue, 31 Oct 2017 16:05:17 +1100
In-Reply-To: <20171031050517.3198-1-cyrilbur@gmail.com>
References: <20171031050517.3198-1-cyrilbur@gmail.com>
Message-Id: <20171031050517.3198-4-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After handling a transactional FP, Altivec or VSX unavailable exception.
The return to userspace code will detect that the TIF_RESTORE_TM bit is
set and call restore_tm_state(). restore_tm_state() will call
restore_math() to ensure that the correct facilities are loaded.

This means that all the loadup code in {fp,altivec,vsx}_unavailable_tm()
is doing pointless work and can simply be removed.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
V2: Obvious cleanup which should have been in v1

 arch/powerpc/kernel/traps.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4a7bc64352fd..3181e85ef17c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1471,12 +1471,6 @@ void facility_unavailable_exception(struct pt_regs *regs)
 
 void fp_unavailable_tm(struct pt_regs *regs)
 {
-	/*
-	 * Save the MSR now because tm_reclaim_current() is likely to
-	 * change it
-	 */
-	unsigned long orig_msr = regs->msr;
-
 	/* Note:  This does not handle any kind of FP laziness. */
 
 	TM_DEBUG("FP Unavailable trap whilst transactional at 0x%lx, MSR=%lx\n",
@@ -1502,24 +1496,10 @@ void fp_unavailable_tm(struct pt_regs *regs)
 	 * so we don't want to load the VRs from the thread_struct.
 	 */
 	tm_recheckpoint(&current->thread);
-
-	/* If VMX is in use, get the transactional values back */
-	if (orig_msr & MSR_VEC) {
-		msr_check_and_set(MSR_VEC);
-		load_vr_state(&current->thread.vr_state);
-		/* At this point all the VSX state is loaded, so enable it */
-		regs->msr |= MSR_VSX;
-	}
 }
 
 void altivec_unavailable_tm(struct pt_regs *regs)
 {
-	/*
-	 * Save the MSR now because tm_reclaim_current() is likely to
-	 * change it
-	 */
-	unsigned long orig_msr = regs->msr;
-
 	/* See the comments in fp_unavailable_tm().  This function operates
 	 * the same way.
 	 */
@@ -1531,12 +1511,6 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 	current->thread.load_vec = 1;
 	tm_recheckpoint(&current->thread);
 	current->thread.used_vr = 1;
-
-	if (orig_msr & MSR_FP) {
-		msr_check_and_set(MSR_FP);
-		load_fp_state(&current->thread.fp_state);
-		regs->msr |= MSR_VSX;
-	}
 }
 
 void vsx_unavailable_tm(struct pt_regs *regs)
@@ -1561,10 +1535,6 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 	current->thread.load_fp = 1;
 
 	tm_recheckpoint(&current->thread);
-
-	msr_check_and_set(MSR_FP | MSR_VEC);
-	load_fp_state(&current->thread.fp_state);
-	load_vr_state(&current->thread.vr_state);
 }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-- 
2.14.3
