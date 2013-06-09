Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 4/5] powerpc/tm: Fix return of 32bit rt signals to active
 transactions
Date: Sun,  9 Jun 2013 21:23:18 +1000
Message-Id: <1370776999-14108-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1370776999-14108-1-git-send-email-mikey@neuling.org>
References: <1370776999-14108-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we only restore signals which are transactionally suspended but it's
possible that the transaction can be restored even when it's active.  Most
likely this will result in a transactional rollback by the hardware as the
transaction will have been doomed by an earlier treclaim.

The current code is a legacy of earlier kernel implementations which did
software rollback of active transactions in the kernel.  That code has now gone
but we didn't correctly fix up this part of the signals code which still makes
assumptions based on having software rollback.

This changes the signal return code to always restore both contexts on 32 bit
rt signal return.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@vger.kernel.org (v3.9 only)
---
 arch/powerpc/kernel/signal_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 364cb1e..0f83122 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1245,7 +1245,7 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 		if (__get_user(msr_hi, &mcp->mc_gregs[PT_MSR]))
 			goto bad;
 
-		if (MSR_TM_SUSPENDED(msr_hi<<32)) {
+		if (MSR_TM_ACTIVE(msr_hi<<32)) {
 			/* We only recheckpoint on return if we're
 			 * transaction.
 			 */
-- 
1.7.10.4
