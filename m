Return-Path: <ego@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A83B11A076F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 18:31:12 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 4 Aug 2015 04:31:09 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 480A438C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 04:31:07 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t748V7gc66977830
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 08:31:07 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t748V6jS001291
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 04:31:07 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Add an inline function to update HID0
Date: Tue,  4 Aug 2015 14:00:58 +0530
Message-Id: <1438677058-12883-1-git-send-email-ego@linux.vnet.ibm.com>
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

Create a function name update_hid0() which follows this recipe and
invoke it from the static split core path.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h       | 11 +++++++++++
 arch/powerpc/platforms/powernv/subcore.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c6ef05b..325f1d6 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -685,4 +685,15 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
 
 extern void xics_wake_cpu(int cpu);
 
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
 #endif /* __POWERPC_KVM_PPC_H__ */
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
