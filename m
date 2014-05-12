Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66E2914007D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:33 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 12 May 2014 21:34:31 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CFF322BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:27 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4CBYCfh62259200
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4CBYREc010580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:27 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH V6 1/2] KVM: PPC: BOOK3S: Always use the saved DAR value
Date: Mon, 12 May 2014 17:04:05 +0530
Message-Id: <1399894447-11322-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Although it's optional, IBM POWER cpus always had DAR value set on
alignment interrupt. So don't try to compute these values.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V5:
* Split the patch to two and also update commit message

 arch/powerpc/kvm/book3s_emulate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 99d40f8977e8..5d0f71663b99 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -611,6 +611,12 @@ u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst)
 
 ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
 {
+#ifdef CONFIG_PPC_BOOK3S_64
+	/*
+	 * Linux's fix_alignment() assumes that DAR is valid, so can we
+	 */
+	return vcpu->arch.fault_dar;
+#else
 	ulong dar = 0;
 	ulong ra = get_ra(inst);
 	ulong rb = get_rb(inst);
@@ -635,4 +641,5 @@ ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
 	}
 
 	return dar;
+#endif
 }
-- 
1.9.1
