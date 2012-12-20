Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6CCE92C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2012 01:53:00 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH] KVM: PPC: Fix mfspr/mtspr MMUCFG emulation
Date: Thu, 20 Dec 2012 16:52:39 +0200
Message-ID: <1356015159-7777-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On mfspr/mtspr emulation path Book3E's MMUCFG SPR with value 1015 clashes
with G4's MSSSR0 SPR. Move MSSSR0 emulation from generic part to Books3S.
MSSSR0 also clashes with Book3S's DABRX SPR. DABRX was not explicitly
handled so Book3S execution flow will behave as before.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/book3s_emulate.c |    2 ++
 arch/powerpc/kvm/emulate.c        |    5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index d31a716..4800a7b 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -427,6 +427,7 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	case SPRN_PMC3_GEKKO:
 	case SPRN_PMC4_GEKKO:
 	case SPRN_WPAR_GEKKO:
+	case SPRN_MSSSR0:
 		break;
 unprivileged:
 	default:
@@ -523,6 +524,7 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 	case SPRN_PMC3_GEKKO:
 	case SPRN_PMC4_GEKKO:
 	case SPRN_WPAR_GEKKO:
+	case SPRN_MSSSR0:
 		*spr_val = 0;
 		break;
 	default:
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index b0855e5..71abcf4 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -149,8 +149,6 @@ static int kvmppc_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 	case SPRN_TBWL: break;
 	case SPRN_TBWU: break;
 
-	case SPRN_MSSSR0: break;
-
 	case SPRN_DEC:
 		vcpu->arch.dec = spr_val;
 		kvmppc_emulate_dec(vcpu);
@@ -201,9 +199,6 @@ static int kvmppc_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 	case SPRN_PIR:
 		spr_val = vcpu->vcpu_id;
 		break;
-	case SPRN_MSSSR0:
-		spr_val = 0;
-		break;
 
 	/* Note: mftb and TBRL/TBWL are user-accessible, so
 	 * the guest can always access the real TB anyways.
-- 
1.7.4.1
