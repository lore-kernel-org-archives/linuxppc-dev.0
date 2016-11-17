Return-Path: <tklauser@distanz.ch>
Received: from mail.zhinst.com (mail.zhinst.com [212.126.164.98])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tKRCy18gqzDvjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 03:19:31 +1100 (AEDT)
From: Tobias Klauser <tklauser@distanz.ch>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mce: Remove unused but set variable
Date: Thu, 17 Nov 2016 17:19:21 +0100
Message-Id: <20161117161921.13232-1-tklauser@distanz.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the unused but set variable srr1 in save_mce_event() to
fix the following GCC warning when building with 'W=1':

  arch/powerpc/kernel/mce.c:75:11: warning: variable 'srr1' set but not used [-Wunused-but-set-variable]

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/powerpc/kernel/mce.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 5e7ece0fda9f..c6923ff45131 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -72,7 +72,6 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		    struct mce_error_info *mce_err,
 		    uint64_t nip, uint64_t addr)
 {
-	uint64_t srr1;
 	int index = __this_cpu_inc_return(mce_nest_count) - 1;
 	struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
 
@@ -99,8 +98,6 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		mce->disposition = MCE_DISPOSITION_NOT_RECOVERED;
 	mce->severity = MCE_SEV_ERROR_SYNC;
 
-	srr1 = regs->msr;
-
 	/*
 	 * Populate the mce error_type and type-specific error_type.
 	 */
-- 
2.11.0.rc0.7.gbe5a750
