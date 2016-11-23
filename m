Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjvy2Q4yzDw1r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 11/11] KVM: PPC: Book3S HV: Update kvmppc_set_arch_compat()
 for ISA v3.00
Date: Wed, 23 Nov 2016 11:32:05 +1100
Message-Id: <1479861125-21394-12-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
References: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The function kvmppc_set_arch_compat() is used to determine the value of the
processor compatibility register (PCR) for a guest running in a given
compatibility mode. There is currently no support for v3.00 of the ISA.

Add support for v3.00 of the ISA which adds an ISA v2.07 compatilibity mode
to the PCR.

We also add a check to ensure the processor we are running on is capable of
emulating the chosen processor (for example a POWER7 cannot emulate a
POWER8, similarly with a POWER8 and a POWER9).

Based on work by: Paul Mackerras <paulus@ozlabs.org>

[paulus@ozlabs.org - moved dummy PCR_ARCH_300 definition here; set
 guest_pcr_bit when arch_compat == 0, added comment.]

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 94294c3..7ee77fe 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -316,41 +316,54 @@ static void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
 	vcpu->arch.pvr = pvr;
 }
 
+/* Dummy value used in computing PCR value below */
+#define PCR_ARCH_300	(PCR_ARCH_207 << 1)
+
 static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 {
-	unsigned long pcr = 0;
+	unsigned long host_pcr_bit = 0, guest_pcr_bit = 0;
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
+	/* We can (emulate) our own architecture version and anything older */
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		host_pcr_bit = PCR_ARCH_300;
+	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		host_pcr_bit = PCR_ARCH_207;
+	else if (cpu_has_feature(CPU_FTR_ARCH_206))
+		host_pcr_bit = PCR_ARCH_206;
+	else
+		host_pcr_bit = PCR_ARCH_205;
+
+	/* Determine lowest PCR bit needed to run guest in given PVR level */
+	guest_pcr_bit = host_pcr_bit;
 	if (arch_compat) {
 		switch (arch_compat) {
 		case PVR_ARCH_205:
-			/*
-			 * If an arch bit is set in PCR, all the defined
-			 * higher-order arch bits also have to be set.
-			 */
-			pcr = PCR_ARCH_206 | PCR_ARCH_205;
+			guest_pcr_bit = PCR_ARCH_205;
 			break;
 		case PVR_ARCH_206:
 		case PVR_ARCH_206p:
-			pcr = PCR_ARCH_206;
+			guest_pcr_bit = PCR_ARCH_206;
 			break;
 		case PVR_ARCH_207:
+			guest_pcr_bit = PCR_ARCH_207;
+			break;
+		case PVR_ARCH_300:
+			guest_pcr_bit = PCR_ARCH_300;
 			break;
 		default:
 			return -EINVAL;
 		}
-
-		if (!cpu_has_feature(CPU_FTR_ARCH_207S)) {
-			/* POWER7 can't emulate POWER8 */
-			if (!(pcr & PCR_ARCH_206))
-				return -EINVAL;
-			pcr &= ~PCR_ARCH_206;
-		}
 	}
 
+	/* Check requested PCR bits don't exceed our capabilities */
+	if (guest_pcr_bit > host_pcr_bit)
+		return -EINVAL;
+
 	spin_lock(&vc->lock);
 	vc->arch_compat = arch_compat;
-	vc->pcr = pcr;
+	/* Set all PCR bits for which guest_pcr_bit <= bit < host_pcr_bit */
+	vc->pcr = host_pcr_bit - guest_pcr_bit;
 	spin_unlock(&vc->lock);
 
 	return 0;
-- 
2.7.4
