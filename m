Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 5B9D6B7C3B
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:37 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 18/27] Add Book3s_64 offsets to asm-offsets.c
Date: Fri, 30 Oct 2009 16:47:18 +0100
Message-Id: <1256917647-6200-19-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to access some VCPU fields from assembly code. In order to get
the proper offsets, we have to define them in asm-offsets.c.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/asm-offsets.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0812b0f..aba3ea6 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -398,6 +398,19 @@ int main(void)
 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
 	DEFINE(VCPU_FAULT_DEAR, offsetof(struct kvm_vcpu, arch.fault_dear));
 	DEFINE(VCPU_FAULT_ESR, offsetof(struct kvm_vcpu, arch.fault_esr));
+
+	/* book3s_64 */
+#ifdef CONFIG_PPC64
+	DEFINE(VCPU_FAULT_DSISR, offsetof(struct kvm_vcpu, arch.fault_dsisr));
+	DEFINE(VCPU_HOST_RETIP, offsetof(struct kvm_vcpu, arch.host_retip));
+	DEFINE(VCPU_HOST_R2, offsetof(struct kvm_vcpu, arch.host_r2));
+	DEFINE(VCPU_HOST_MSR, offsetof(struct kvm_vcpu, arch.host_msr));
+	DEFINE(VCPU_SHADOW_MSR, offsetof(struct kvm_vcpu, arch.shadow_msr));
+	DEFINE(VCPU_TRAMPOLINE_LOWMEM, offsetof(struct kvm_vcpu, arch.trampoline_lowmem));
+	DEFINE(VCPU_TRAMPOLINE_ENTER, offsetof(struct kvm_vcpu, arch.trampoline_enter));
+	DEFINE(VCPU_HIGHMEM_HANDLER, offsetof(struct kvm_vcpu, arch.highmem_handler));
+	DEFINE(VCPU_HFLAGS, offsetof(struct kvm_vcpu, arch.hflags));
+#endif
 #endif
 #ifdef CONFIG_44x
 	DEFINE(PGD_T_LOG2, PGD_T_LOG2);
-- 
1.6.0.2
