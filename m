Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JCJ5jTbzF272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:37:32 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 david@gibson.dropbear.id.au, npiggin@gmail.com,
 pedromfc@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH v3 4/8] KVM: PPC: Book3S HV: Return error from
 h_set_mode(SET_DAWR) on POWER9
Date: Tue, 27 Mar 2018 15:37:20 +1100
Message-Id: <20180327043724.13862-5-mikey@neuling.org>
In-Reply-To: <20180327043724.13862-1-mikey@neuling.org>
References: <20180327043724.13862-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Return H_P2 on a h_set_mode(SET_DAWR) on POWER9 where the DAWR is
disabled.

Current Linux guests ignore this error, so they will silently not get
the DAWR (sigh). The same error code is being used by POWERVM in this
case.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 89707354c2..0c17c9f30b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -741,6 +741,8 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
 	case H_SET_MODE_RESOURCE_SET_DAWR:
 		if (!kvmppc_power8_compatible(vcpu))
 			return H_P2;
+		if (!ppc_breakpoint_available())
+			return H_P2;
 		if (mflags)
 			return H_UNSUPPORTED_FLAG_START;
 		if (value2 & DABRX_HYP)
-- 
2.14.1
