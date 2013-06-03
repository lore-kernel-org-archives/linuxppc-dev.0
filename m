Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A491F2C02F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 06:54:56 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 6/6] KVM: PPC: Book3E: Enhance FPU laziness
Date: Mon, 3 Jun 2013 23:54:28 +0300
Message-ID: <1370292868-2697-7-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
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

Adopt AltiVec approach to increase laziness by calling kvmppc_load_guest_fp()
just before returning to guest instaed of each sched in.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c  |    1 +
 arch/powerpc/kvm/e500mc.c |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 019496d..5382238 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1258,6 +1258,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		} else {
 			kvmppc_lazy_ee_enable();
 			kvmppc_load_guest_altivec(vcpu);
+			kvmppc_load_guest_fp(vcpu);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 9d7f38e..29cf97a 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -138,8 +138,6 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	if (vcpu->arch.oldpir != mfspr(SPRN_PIR))
 		kvmppc_e500_tlbil_all(vcpu_e500);
-
-	kvmppc_load_guest_fp(vcpu);
 }
 
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
-- 
1.7.4.1
