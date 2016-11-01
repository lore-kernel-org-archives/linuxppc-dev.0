Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7JTq3wtpzDt11
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 15:41:35 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id n85so10535744pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 21:41:35 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, agraf@suse.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH V3 2/2] powerpc/kvm: Update kvmppc_set_arch_compat() for ISA
 v3.00
Date: Tue,  1 Nov 2016 15:41:03 +1100
Message-Id: <1477975263-29045-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1477975263-29045-1-git-send-email-sjitindarsingh@gmail.com>
References: <1477975263-29045-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function kvmppc_set_arch_compat() is used to determine the value of the
processor compatibility register (PCR) for a guest running in a given
compatibility mode. There is currently no support for v3.00 of the ISA.

Add support for v3.00 of the ISA which adds an ISA v2.07 compatilibity mode
to the PCR.

We also add a check to ensure the processor we are running on is capable of
emulating the chosen processor (for example a POWER7 cannot emulate a
POWER8, similarly with a POWER8 and a POWER9).

Based on work by: Paul Mackerras <paulus@samba.org>

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471..5d83ecb 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -301,39 +301,47 @@ static void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
 
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
+	vc->pcr = host_pcr_bit - guest_pcr_bit;
 	spin_unlock(&vc->lock);
 
 	return 0;
-- 
2.5.5
