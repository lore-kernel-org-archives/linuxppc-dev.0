Return-Path: <ego@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A3BC1A0748
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 21:06:44 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 4 Aug 2015 05:06:42 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0308519D8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 04:57:37 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t74B5lE843319416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 04:05:47 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t74B6c27032693
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 05:06:38 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc: Add an inline function to update HID0
Date: Tue,  4 Aug 2015 16:36:24 +0530
Message-Id: <1438686384-15629-1-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <20150804105747.GA19966@in.ibm.com>
References: <20150804105747.GA19966@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
prescribes that updates to HID0 be preceded by a SYNC instruction and
followed by an ISYNC instruction (Page 91).

Create an inline function name update_hid0() which follows this recipe
and invoke it from the static split core path.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
[v1--> v2: Moved defn of update_hid0 to reg.h from kvm_ppc.h]

 arch/powerpc/include/asm/reg.h           | 13 +++++++++++++
 arch/powerpc/platforms/powernv/subcore.c |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index af56b5c..beb98ac 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -12,6 +12,8 @@
 
 #include <linux/stringify.h>
 #include <asm/cputable.h>
+#include <asm/barrier.h>
+#include <asm/synch.h>
 
 /* Pickup Book E specific registers. */
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
@@ -1281,6 +1283,17 @@ struct pt_regs;
 
 extern void ppc_save_regs(struct pt_regs *regs);
 
+static inline void update_hid0(unsigned long hid0)
+{
+	/*
+	 *  The HID0 update should at the very least be preceded by a
+	 *  a SYNC instruction followed by an ISYNC instruction
+	 */
+	mb();
+	mtspr(SPRN_HID0, hid0);
+	isync();
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_REG_H */
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index f60f80a..37e77bf 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -190,7 +190,7 @@ static void unsplit_core(void)
 
 	hid0 = mfspr(SPRN_HID0);
 	hid0 &= ~HID0_POWER8_DYNLPARDIS;
-	mtspr(SPRN_HID0, hid0);
+	update_hid0(hid0);
 	update_hid_in_slw(hid0);
 
 	while (mfspr(SPRN_HID0) & mask)
@@ -227,7 +227,7 @@ static void split_core(int new_mode)
 	/* Write new mode */
 	hid0  = mfspr(SPRN_HID0);
 	hid0 |= HID0_POWER8_DYNLPARDIS | split_parms[i].value;
-	mtspr(SPRN_HID0, hid0);
+	update_hid0(hid0);
 	update_hid_in_slw(hid0);
 
 	/* Wait for it to happen */
-- 
1.9.3
