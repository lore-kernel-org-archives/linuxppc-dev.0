Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5nl2tbWzF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:46:03 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 63-v6so3656422pgg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 21:46:03 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 14/29] KVM: PPC: Book3S PR: add
 kvmppc_save/restore_tm_sprs() APIs
Date: Mon, 21 May 2018 12:09:31 +0800
Message-Id: <1526875786-10372-15-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch adds 2 new APIs kvmppc_save_tm_sprs()/kvmppc_restore_tm_sprs()
for the purpose of TEXASR/TFIAR/TFHAR save/restore.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_pr.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index f2ae5a3..7d4905a 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -42,6 +42,7 @@
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/miscdevice.h>
+#include <asm/asm-prototypes.h>
 
 #include "book3s.h"
 
@@ -284,6 +285,27 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu)
 	svcpu_put(svcpu);
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
+{
+	tm_enable();
+	vcpu->arch.tfhar = mfspr(SPRN_TFHAR);
+	vcpu->arch.texasr = mfspr(SPRN_TEXASR);
+	vcpu->arch.tfiar = mfspr(SPRN_TFIAR);
+	tm_disable();
+}
+
+static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
+{
+	tm_enable();
+	mtspr(SPRN_TFHAR, vcpu->arch.tfhar);
+	mtspr(SPRN_TEXASR, vcpu->arch.texasr);
+	mtspr(SPRN_TFIAR, vcpu->arch.tfiar);
+	tm_disable();
+}
+
+#endif
+
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
 {
 	int r = 1; /* Indicate we want to get back into the guest */
-- 
1.8.3.1
