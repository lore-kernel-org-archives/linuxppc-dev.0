Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kxvr05BSzF3LN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 22:24:39 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Haren Myneni <haren@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: consolidate MCE counter increment.
Date: Wed, 26 Sep 2018 14:24:30 +0200
Message-Id: <20180926122430.13924-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The code in machine_check_exception excludes 64s hvmode when
incrementing the MCE counter only to call opal_machine_check to
increment it specifically for this case.

Remove the exclusion and special case.

Fixes: a43c1590426c ("powerpc/pseries: Flush SLB contents on SLB MCE
		errors.")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/traps.c           | 4 +---
 arch/powerpc/platforms/powernv/opal.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6ab66a88db14..e5bc413c7d53 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -741,9 +741,7 @@ void machine_check_exception(struct pt_regs *regs)
 	if (!nested)
 		nmi_enter();
 
-	/* 64s accounts the mce in machine_check_early when in HVMODE */
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !cpu_has_feature(CPU_FTR_HVMODE))
-		__this_cpu_inc(irq_stat.mce_exceptions);
+	__this_cpu_inc(irq_stat.mce_exceptions);
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 62c291e23dbe..38fe4087484a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -578,8 +578,6 @@ int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
 
-	__this_cpu_inc(irq_stat.mce_exceptions);
-
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return 0;
 
-- 
2.13.7
