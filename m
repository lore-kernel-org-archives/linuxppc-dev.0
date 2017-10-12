Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCTsK5WBbzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 22:59:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, benh@kernel.crashing.org, stewart@linux.vnet.ibm.com,
 cyrilbur@gmail.com, paulus@samba.org
Subject: [PATCH 5/4] KVM: PPC: Tie KVM_CAP_PPC_HTM to the user-visible TM
 feature
Date: Thu, 12 Oct 2017 22:58:54 +1100
Message-Id: <1507809534-10721-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we use CPU_FTR_TM to decide if the CPU/kernel can support
TM (Transactional Memory), and if it's true we advertise that to
Qemu (or similar) via KVM_CAP_PPC_HTM.

PPC_FEATURE2_HTM is the user-visible feature bit, which indicates that
the CPU and kernel can support TM. Currently CPU_FTR_TM and
PPC_FEATURE2_HTM always have the same value, either true or false, so
using the former for KVM_CAP_PPC_HTM is correct.

However some Power9 CPUs can operate in a mode where TM is enabled but
TM suspended state is disabled. In this mode CPU_FTR_TM is true, but
PPC_FEATURE2_HTM is false. Instead a different PPC_FEATURE2 bit is
set, to indicate that this different mode of TM is available.

It is not safe to let guests use TM as-is, when the CPU is in this
mode. So to prevent that from happening, use PPC_FEATURE2_HTM to
determine the value of KVM_CAP_PPC_HTM.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kvm/powerpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3480faaf1ef8..a3746b98ec11 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -644,8 +644,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_PPC_HTM:
-		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
-		    is_kvmppc_hv_enabled(kvm);
+		r = is_kvmppc_hv_enabled(kvm) &&
+		    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM_COMP);
 		break;
 	default:
 		r = 0;
-- 
2.7.4
