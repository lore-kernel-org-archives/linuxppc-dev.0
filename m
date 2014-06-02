Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E2E11A0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jun 2014 16:57:05 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/cpuidle: Only clear LPCR decrementer wakeup bit
 on fast sleep entry
Date: Mon,  2 Jun 2014 16:57:02 +1000
Message-Id: <1401692223-28337-1-git-send-email-mikey@neuling.org>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently when entering fastsleep we clear all LPCR PECE bits.

This patch changes it to only clear the decrementer bit (ie. PECE1), which is
the only bit we really need to clear here.  This is needed if we want to set
other wakeup causes like the PECEDH bit so we can use hypervisor doorbells on
powernv.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 719f6fb..7f7798e 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -73,7 +73,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 		return index;
 
 	new_lpcr = old_lpcr;
-	new_lpcr &= ~(LPCR_MER | LPCR_PECE); /* lpcr[mer] must be 0 */
+	new_lpcr &= ~(LPCR_MER | LPCR_PECE1); /* lpcr[mer] must be 0 */
 
 	/* exit powersave upon external interrupt, but not decrementer
 	 * interrupt.
-- 
1.9.1
