Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CF8C2C0302
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:44:14 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Date: Wed, 3 Jul 2013 15:42:36 +0300
Message-ID: <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
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

Increase FPU laziness by calling kvmppc_load_guest_fp() just before
returning to guest instead of each sched in. Without this improvement
an interrupt may also claim floting point corrupting guest state.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c  |    1 +
 arch/powerpc/kvm/e500mc.c |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 113961f..3cae2e3 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1204,6 +1204,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
 		} else {
 			kvmppc_lazy_ee_enable();
+			kvmppc_load_guest_fp(vcpu);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 19c8379..09da1ac 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -143,8 +143,6 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvmppc_e500_tlbil_all(vcpu_e500);
 		__get_cpu_var(last_vcpu_on_cpu) = vcpu;
 	}
-
-	kvmppc_load_guest_fp(vcpu);
 }
 
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
-- 
1.7.3.4
