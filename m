Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0CED22C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 17:04:48 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Dec 2013 16:04:45 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 47B5A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 17:04:42 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBU5k7Mk55640168
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 16:46:07 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBU64fm3024482
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 17:04:42 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2] POWERPC: BOOK3S: KVM: Use the saved dsisr and dar values
 on book3s 64
Date: Mon, 30 Dec 2013 11:34:29 +0530
Message-Id: <1388383469-6411-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Although it's optional IBM POWER cpus always had DAR value set on
alignment interrupt. So don't try to compute these values.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_emulate.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 502a47ac4453..d8e2d079483d 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -599,6 +599,19 @@ unprivileged:
 
 u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst)
 {
+#ifdef CONFIG_PPC_BOOK3S_64
+	return vcpu->arch.fault_dsisr;
+#else
+	/*
+	 * Mac OS X has some applications - namely the Finder - that require
+	 * alignment interrupts to work properly. So we need to implement them.
+
+	 * But the spec for 970 and 750 also looks different. While 750 requires
+	 * the DSISR and DAR fields to reflect some instruction bits (DSISR) and
+	 * the fault address (DAR), the 970 declares this as an optional feature.
+	 * So we need to reconstruct DSISR and DAR manually.
+	 */
+
 	u32 dsisr = 0;
 
 	/*
@@ -637,10 +650,24 @@ u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst)
 	dsisr |= (inst >> 16) & 0x03ff; /* bits 22:31 */
 
 	return dsisr;
+#endif
 }
 
 ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
 {
+#ifdef CONFIG_PPC_BOOK3S_64
+	return vcpu->arch.fault_dar;
+#else
+	/*
+	 * Mac OS X has some applications - namely the Finder - that require
+	 * alignment interrupts to work properly. So we need to implement them.
+
+	 * But the spec for 970 and 750 also looks different. While 750 requires
+	 * the DSISR and DAR fields to reflect some instruction bits (DSISR) and
+	 * the fault address (DAR), the 970 declares this as an optional feature.
+	 * So we need to reconstruct DSISR and DAR manually.
+	 */
+
 	ulong dar = 0;
 	ulong ra = get_ra(inst);
 	ulong rb = get_rb(inst);
@@ -665,4 +692,5 @@ ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
 	}
 
 	return dar;
+#endif
 }
-- 
1.8.3.2
