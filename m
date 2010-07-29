Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id B6B53B70F6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 14/27] KVM: PPC: Expose magic page support to guest
Date: Thu, 29 Jul 2010 14:47:55 +0200
Message-Id: <1280407688-9815-15-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
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

v2 -> v3:

  - align hypercalls to in/out of ePAPR
---
 arch/powerpc/include/asm/kvm_para.h |    2 ++
 arch/powerpc/kvm/powerpc.c          |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 0653b0d..7438ab3 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -45,6 +45,8 @@ struct kvm_vcpu_arch_shared {
 #define HC_EV_SUCCESS		0
 #define HC_EV_UNIMPLEMENTED	12
 
+#define KVM_FEATURE_MAGIC_PAGE	1
+
 #ifdef __KERNEL__
 
 #ifdef CONFIG_KVM_GUEST
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a4cf4b4..fecfe04 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -61,8 +61,19 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 	}
 
 	switch (nr) {
+	case HC_VENDOR_KVM | KVM_HC_PPC_MAP_MAGIC_PAGE:
+	{
+		vcpu->arch.magic_page_pa = param1;
+		vcpu->arch.magic_page_ea = param2;
+
+		r = HC_EV_SUCCESS;
+		break;
+	}
 	case HC_VENDOR_KVM | KVM_HC_FEATURES:
 		r = HC_EV_SUCCESS;
+#if defined(CONFIG_PPC_BOOK3S) /* XXX Missing magic page on BookE */
+		r2 |= (1 << KVM_FEATURE_MAGIC_PAGE);
+#endif
 
 		/* Second return value is in r4 */
 		kvmppc_set_gpr(vcpu, 4, r2);
-- 
1.6.0.2
