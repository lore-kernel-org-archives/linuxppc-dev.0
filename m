Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E063F1A00CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 15:59:31 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/cpuidle: Only clear LPCR decrementer wakeup bit
 on fast sleep entry
Date: Wed, 11 Jun 2014 15:59:24 +1000
Message-Id: <1402466368-22583-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1402466368-22583-1-git-send-email-mikey@neuling.org>
References: <1402466368-22583-1-git-send-email-mikey@neuling.org>
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
powernv.  Also we no longer clear the MER bit as it should never be set in the
host anyway.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 719f6fb..74f5788 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -73,12 +73,10 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 		return index;
 
 	new_lpcr = old_lpcr;
-	new_lpcr &= ~(LPCR_MER | LPCR_PECE); /* lpcr[mer] must be 0 */
-
-	/* exit powersave upon external interrupt, but not decrementer
-	 * interrupt.
+	/* Do not exit powersave upon decrementer as we've setup the timer
+	 * offload.
 	 */
-	new_lpcr |= LPCR_PECE0;
+	new_lpcr &= ~LPCR_PECE1;
 
 	mtspr(SPRN_LPCR, new_lpcr);
 	power7_sleep();
-- 
1.9.1
