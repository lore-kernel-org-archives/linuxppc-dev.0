Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 88DFBB709F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:07 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 15/27] KVM: PPC: Expose magic page support to guest
Date: Thu,  1 Jul 2010 12:42:50 +0200
Message-Id: <1277980982-12433-16-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have the shared page in place and the MMU code knows about
the magic page, we can expose that capability to the guest!

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_para.h |    2 ++
 arch/powerpc/kvm/powerpc.c          |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 82131fc..3cae15d 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -43,6 +43,8 @@ struct kvm_vcpu_arch_shared {
 #define KVM_SC_MAGIC_R0		0x4b564d52 /* "KVMR" */
 #define KVM_SC_MAGIC_R3		0x554c455a /* "ULEZ" */
 
+#define KVM_FEATURE_MAGIC_PAGE	1
+
 #ifdef __KERNEL__
 
 static inline int kvm_para_available(void)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1ebb29e..0be119a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -60,8 +60,19 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 	}
 
 	switch (nr) {
+	case KVM_HC_PPC_MAP_MAGIC_PAGE:
+	{
+		vcpu->arch.magic_page_pa = param1;
+		vcpu->arch.magic_page_ea = param2;
+
+		r = 0;
+		break;
+	}
 	case KVM_HC_FEATURES:
 		r = 0;
+#if !defined(CONFIG_KVM_440) /* XXX missing bits on 440 */
+		r |= (1 << KVM_FEATURE_MAGIC_PAGE);
+#endif
 		break;
 	default:
 		r = -KVM_ENOSYS;
-- 
1.6.0.2
