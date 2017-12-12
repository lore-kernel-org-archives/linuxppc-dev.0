Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yx6BD58DFzDrWw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 04:24:04 +1100 (AEDT)
From: Laurent Vivier <lvivier@redhat.com>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] KVM: PPC: Book3S HV: Fix pending_pri value in
 kvmppc_xive_get_icp()
Date: Tue, 12 Dec 2017 18:23:56 +0100
Message-Id: <20171212172356.2397-1-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we migrate a VM from a POWER8 host (XICS) to a POWER9 host
(XICS-on-XIVE), we have an error:

qemu-kvm: Unable to restore KVM interrupt controller state \
          (0xff000000) for CPU 0: Invalid argument

This is because kvmppc_xics_set_icp() checks the new state
is internaly consistent, and especially:

...
   1129         if (xisr == 0) {
   1130                 if (pending_pri != 0xff)
   1131                         return -EINVAL;
...

On the other side, kvmppc_xive_get_icp() doesn't set
neither the pending_pri value, nor the xisr value (set to 0)
(and kvmppc_xive_set_icp() ignores the pending_pri value)

As xisr is 0, pending_pri must be set to 0xff.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/kvm/book3s_xive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index bf457843e032..e79062573f8c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -725,7 +725,8 @@ u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu)
 
 	/* Return the per-cpu state for state saving/migration */
 	return (u64)xc->cppr << KVM_REG_PPC_ICP_CPPR_SHIFT |
-	       (u64)xc->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT;
+	       (u64)xc->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT |
+	       (u64)0xff << KVM_REG_PPC_ICP_PPRI_SHIFT;
 }
 
 int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval)
-- 
2.14.3
