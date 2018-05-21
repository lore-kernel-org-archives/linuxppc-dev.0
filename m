Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5nQ2B9kzF0bZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:45:46 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id v24-v6so8051752plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 21:45:46 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 08/29] KVM: PPC: Book3S PR: In PR KVM suspends
 Transactional state when inject an interrupt.
Date: Mon, 21 May 2018 12:09:25 +0800
Message-Id: <1526875786-10372-9-git-send-email-wei.guo.simon@gmail.com>
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

This patch simulates interrupt behavior per Power ISA while injecting
interrupt in PR KVM:
- When interrupt happens, transactional state should be suspended.

kvmppc_mmu_book3s_64_reset_msr() will be invoked when injecting an
interrupt. This patch performs this ISA logic in
kvmppc_mmu_book3s_64_reset_msr().

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_64_mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index a93d719..cf9d686 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -38,7 +38,16 @@
 
 static void kvmppc_mmu_book3s_64_reset_msr(struct kvm_vcpu *vcpu)
 {
-	kvmppc_set_msr(vcpu, vcpu->arch.intr_msr);
+	unsigned long msr = vcpu->arch.intr_msr;
+	unsigned long cur_msr = kvmppc_get_msr(vcpu);
+
+	/* If transactional, change to suspend mode on IRQ delivery */
+	if (MSR_TM_TRANSACTIONAL(cur_msr))
+		msr |= MSR_TS_S;
+	else
+		msr |= cur_msr & MSR_TS_MASK;
+
+	kvmppc_set_msr(vcpu, msr);
 }
 
 static struct kvmppc_slb *kvmppc_mmu_book3s_64_find_slbe(
-- 
1.8.3.1
