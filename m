Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfKdk3djczDsgf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 23:06:50 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Alexander Graf <agraf@suse.com>,
 stable@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3s PR: Allow access to unprivileged MMCR2
 register
Date: Wed, 21 Sep 2016 15:06:45 +0200
Message-Id: <1474463205-5965-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MMCR2 register is available twice, one time with number 785
(privileged access), and one time with number 769 (unprivileged,
but it can be disabled completely). In former times, the Linux
kernel was using the unprivileged register 769 only, but since
commit 8dd75ccb571f3c92c ("powerpc: Use privileged SPR number
for MMCR2"), it uses the privileged register 785 instead.
The KVM-PR code then of course also switched to use the SPR 785,
but this is causing older guest kernels to crash, since these
kernels still access 769 instead. So to support older kernels
with KVM-PR again, we have to support register 769 in KVM-PR, too.

Fixes: 8dd75ccb571f3c92c48014b3dabd3d51a115ab41
Cc: stable@vger.kernel.org # v3.10+
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/include/asm/reg.h    | 1 +
 arch/powerpc/kvm/book3s_emulate.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f69f40f..978dada 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -737,6 +737,7 @@
 #define   MMCR0_FCHV	0x00000001UL /* freeze conditions in hypervisor mode */
 #define SPRN_MMCR1	798
 #define SPRN_MMCR2	785
+#define SPRN_UMMCR2	769
 #define SPRN_MMCRA	0x312
 #define   MMCRA_SDSYNC	0x80000000UL /* SDAR synced with SIAR */
 #define   MMCRA_SDAR_DCACHE_MISS 0x40000000UL
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 2afdb9c..729f8fa 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -498,6 +498,7 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	case SPRN_MMCR0:
 	case SPRN_MMCR1:
 	case SPRN_MMCR2:
+	case SPRN_UMMCR2:
 #endif
 		break;
 unprivileged:
@@ -640,6 +641,7 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 	case SPRN_MMCR0:
 	case SPRN_MMCR1:
 	case SPRN_MMCR2:
+	case SPRN_UMMCR2:
 	case SPRN_TIR:
 #endif
 		*spr_val = 0;
-- 
1.8.3.1
