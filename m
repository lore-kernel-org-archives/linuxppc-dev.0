Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4Gvb3YK6zDvJy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 17:19:55 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id u84so1652024pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 23:19:55 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, agraf@suse.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 2/2] powerpc/kvm: Update kvmppc_set_arch_compat() for ISA v3.00
Date: Thu, 27 Oct 2016 17:19:29 +1100
Message-Id: <1477549169-3649-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1477549169-3649-1-git-send-email-sjitindarsingh@gmail.com>
References: <1477549169-3649-1-git-send-email-sjitindarsingh@gmail.com>
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

Finally the PCR value is masked based on the bits of the register which the
current processor is actually aware of.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471..f9ae3fb 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -311,24 +311,38 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			 * If an arch bit is set in PCR, all the defined
 			 * higher-order arch bits also have to be set.
 			 */
-			pcr = PCR_ARCH_206 | PCR_ARCH_205;
+			pcr = PCR_ARCH_207 | PCR_ARCH_206 | PCR_ARCH_205;
 			break;
 		case PVR_ARCH_206:
 		case PVR_ARCH_206p:
-			pcr = PCR_ARCH_206;
+			/* Must be at least v2.06 to emulate it */
+			if (!cpu_has_feature(CPU_FTR_ARCH_206))
+				return -EINVAL;
+			pcr = PCR_ARCH_207 | PCR_ARCH_206;
 			break;
 		case PVR_ARCH_207:
+			/* Must be at least v2.07 to emulate it */
+			if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+				return -EINVAL;
+			pcr = PCR_ARCH_207;
 			break;
+		case PVR_ARCH_300:
+			/* Must be at least v3.00 to emulate it */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -EINVAL;
 		default:
 			return -EINVAL;
 		}
 
-		if (!cpu_has_feature(CPU_FTR_ARCH_207S)) {
-			/* POWER7 can't emulate POWER8 */
-			if (!(pcr & PCR_ARCH_206))
-				return -EINVAL;
-			pcr &= ~PCR_ARCH_206;
-		}
+		/*
+		 * Mask the pcr bits which the current processor knows about
+		 * v2.06 and above knows about the v2.05 compat bit
+		 * v2,07 and above knows about the v2.06 compat bit
+		 * v3.00 and above knows about the v2.07 compat bit
+		 */
+		pcr &= (cpu_has_feature(CPU_FTR_ARCH_300) << 3) |
+			(cpu_has_feature(CPU_FTR_ARCH_207S) << 2) |
+			(cpu_has_feature(CPU_FTR_ARCH_206) << 1);
 	}
 
 	spin_lock(&vc->lock);
-- 
2.5.5
