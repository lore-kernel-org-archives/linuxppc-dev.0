Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6Zwj1wYlzDvWv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 11:28:53 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id n85so7162833pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 17:28:53 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, agraf@suse.com
Subject: [PATCH V2 2/2] powerpc/kvm: Update kvmppc_set_arch_compat() for ISA
 v3.00
Date: Mon, 31 Oct 2016 11:28:23 +1100
Message-Id: <1477873703-22403-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1477873703-22403-1-git-send-email-sjitindarsingh@gmail.com>
References: <1477873703-22403-1-git-send-email-sjitindarsingh@gmail.com>
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

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471..24681e7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -311,24 +311,38 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			 * If an arch bit is set in PCR, all the defined
 			 * higher-order arch bits also have to be set.
 			 */
-			pcr = PCR_ARCH_206 | PCR_ARCH_205;
+			if (cpu_has_feature(CPU_FTR_ARCH_206))
+				pcr |= PCR_ARCH_205;
+			if (cpu_has_feature(CPU_FTR_ARCH_207S))
+				pcr |= PCR_ARCH_206;
+			if (cpu_has_feature(CPU_FTR_ARCH_300))
+				pcr |= PCR_ARCH_207;
 			break;
 		case PVR_ARCH_206:
 		case PVR_ARCH_206p:
-			pcr = PCR_ARCH_206;
+			/* Must be at least v2.06 to (emulate) it */
+			if (!cpu_has_feature(CPU_FTR_ARCH_206))
+				return -EINVAL;
+			if (cpu_has_feature(CPU_FTR_ARCH_207S))
+				pcr |= PCR_ARCH_206;
+			if (cpu_has_feature(CPU_FTR_ARCH_300))
+				pcr |= PCR_ARCH_207;
 			break;
 		case PVR_ARCH_207:
+			/* Must be at least v2.07 to (emulate) it */
+			if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+				return -EINVAL;
+			if (cpu_has_feature(CPU_FTR_ARCH_300))
+				pcr |= PCR_ARCH_207;
+			break;
+		case PVR_ARCH_300:
+			/* Must be at least v3.00 to (emulate) it */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -EINVAL;
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
 
 	spin_lock(&vc->lock);
-- 
2.5.5
