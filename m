Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCE9A1A2B6B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 10 Apr 2015 18:31:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A25D52CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A8V48h9371784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A8UdAX025813
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:30:39 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/13] powerpc: Fix handling of DSCR related facility
 unavailable exception
Date: Fri, 10 Apr 2015 14:00:00 +0530
Message-Id: <1428654612-23539-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently DSCR (Data Stream Control Register) can be accessed with
mfspr or mtspr instructions inside a thread via two different SPR
numbers. One being the user accessible problem state SPR number 0x03
and the other being the privilege state SPR number 0x11. All access
through the privilege state SPR number get emulated through illegal
instruction exception. Any access through the problem state SPR number
raises one facility unavailable exception which sets the thread based
dscr_inherit bit and enables DSCR facility through FSCR register thus
allowing direct access to DSCR without going through this exception in
the future. We set the thread.dscr_inherit bit whether the access was
with mfspr or mtspr instruction which is neither correct nor does it
match the behaviour through the instruction emulation code path driven
from privilege state SPR number. User currently observes two different
kind of behaviour when accessing the DSCR through these two SPR numbers.
This problem can be observed through these two test cases by replacing
the privilege state SPR number with the problem state SPR number.

	(1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
	(2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c

This patch fixes the problem by making sure that the behaviour visible
to the user remains the same irrespective of which SPR number is being
used. Inside facility unavailable exception, we check whether it was
cuased by a mfspr or a mtspr isntrucction. In case of mfspr instruction,
just emulate the instruction. In case of mtspr instruction, set the
thread based dscr_inherit bit and also enable the facility through FSCR.
All user SPR based mfspr instruction will be emulated till one user SPR
based mtspr has been executed.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/traps.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 19e4744..6530f1b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1377,6 +1377,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	};
 	char *facility = "unknown";
 	u64 value;
+	u32 instword, rd;
 	u8 status;
 	bool hv;
 
@@ -1388,12 +1389,46 @@ void facility_unavailable_exception(struct pt_regs *regs)
 
 	status = value >> 56;
 	if (status == FSCR_DSCR_LG) {
-		/* User is acessing the DSCR.  Set the inherit bit and allow
-		 * the user to set it directly in future by setting via the
-		 * FSCR DSCR bit.  We always leave HFSCR DSCR set.
+		/*
+		 * User is accessing the DSCR register using the problem
+		 * state only SPR number (0x03) either through a mfspr or
+		 * a mtspr instruction. If it is a write attempt through
+		 * a mtspr, then we set the inherit bit. This also allows
+		 * the user to write or read the register directly in the
+		 * future by setting via the FSCR DSCR bit. But in case it
+		 * is a read DSCR attempt through a mfspr instruction, we
+		 * just emulate the instruction instead. This code path will
+		 * always emulate all the mfspr instructions till the user
+		 * has attempted atleast one mtspr instruction. This way it
+		 * preserves the same behaviour when the user is accessing
+		 * the DSCR through privilege level only SPR number (0x11)
+		 * which is emulated through illegal instruction exception.
+		 * We always leave HFSCR DSCR set.
 		 */
-		current->thread.dscr_inherit = 1;
-		mtspr(SPRN_FSCR, value | FSCR_DSCR);
+		if (get_user(instword, (u32 __user *)(regs->nip))) {
+			pr_err("Failed to fetch the user instruction\n");
+			return;
+		}
+
+		/* Write into DSCR (mtspr 0x03, RS) */
+		if ((instword & PPC_INST_MTSPR_DSCR_USER_MASK)
+				== PPC_INST_MTSPR_DSCR_USER) {
+			rd = (instword >> 21) & 0x1f;
+			current->thread.dscr = regs->gpr[rd];
+			current->thread.dscr_inherit = 1;
+			mtspr(SPRN_FSCR, value | FSCR_DSCR);
+		}
+
+		/* Read from DSCR (mfspr RT, 0x03) */
+		if ((instword & PPC_INST_MFSPR_DSCR_USER_MASK)
+				== PPC_INST_MFSPR_DSCR_USER) {
+			if (emulate_instruction(regs)) {
+				pr_err("DSCR based mfspr emulation failed\n");
+				return;
+			}
+			regs->nip += 4;
+			emulate_single_step(regs);
+		}
 		return;
 	}
 
-- 
1.9.3
