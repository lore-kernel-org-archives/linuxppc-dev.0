Return-Path: <ego@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C0E21A077B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 17:08:51 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 5 Aug 2015 01:08:50 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 97D531FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 00:59:57 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7577rSc28704782
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2015 00:07:53 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7578lgX027748
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2015 01:08:47 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Segher Boessenkool <segher@kernel.crashing.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v3] powerpc: Add an inline function to update POWER8 HID0
Date: Wed,  5 Aug 2015 12:38:31 +0530
Message-Id: <1438758511-918-1-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <20150805065400.GA14701@in.ibm.com>
References: <20150805065400.GA14701@in.ibm.com>
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

Create an inline function name update_power8_hid0() which follows this
recipe and invoke it from the static split core path.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
[v1 --> v2: Moved defn of update_hid0 to reg.h from kvm_ppc.h]
[v2 --> v3: Renamed to update_power8_hid0 and used asm volatile]

 arch/powerpc/include/asm/reg.h           | 9 +++++++++
 arch/powerpc/platforms/powernv/subcore.c | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index af56b5c..1245d99 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1281,6 +1281,15 @@ struct pt_regs;
 
 extern void ppc_save_regs(struct pt_regs *regs);
 
+static inline void update_power8_hid0(unsigned long hid0)
+{
+	/*
+	 *  The HID0 update on Power8 should at the very least be
+	 *  preceded by a a SYNC instruction followed by an ISYNC
+	 *  instruction
+	 */
+	asm volatile("sync; mtspr %0,%1; isync":: "i"(SPRN_HID0), "r"(hid0));
+}
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_REG_H */
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index f60f80a..503a73f 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -190,7 +190,7 @@ static void unsplit_core(void)
 
 	hid0 = mfspr(SPRN_HID0);
 	hid0 &= ~HID0_POWER8_DYNLPARDIS;
-	mtspr(SPRN_HID0, hid0);
+	update_power8_hid0(hid0);
 	update_hid_in_slw(hid0);
 
 	while (mfspr(SPRN_HID0) & mask)
@@ -227,7 +227,7 @@ static void split_core(int new_mode)
 	/* Write new mode */
 	hid0  = mfspr(SPRN_HID0);
 	hid0 |= HID0_POWER8_DYNLPARDIS | split_parms[i].value;
-	mtspr(SPRN_HID0, hid0);
+	update_power8_hid0(hid0);
 	update_hid_in_slw(hid0);
 
 	/* Wait for it to happen */
-- 
1.9.3
