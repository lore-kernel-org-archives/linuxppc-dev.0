Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBDFE2C0311
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:52 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 18:01:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 774632CE8023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:45 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1Q7r9Tv10813840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 18:53:09 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1Q85hdT007934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:44 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V1 10/24] powerpc: Return all the valid pte ecndoing in
 KVM_PPC_GET_SMMU_INFO ioctl
Date: Tue, 26 Feb 2013 13:35:00 +0530
Message-Id: <1361865914-13911-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 48f6d99..e50eb0d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1508,14 +1508,21 @@ long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
 static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
 				     int linux_psize)
 {
+	int i, index = 0;
 	struct mmu_psize_def *def = &mmu_psize_defs[linux_psize];
 
 	if (!def->shift)
 		return;
 	(*sps)->page_shift = def->shift;
 	(*sps)->slb_enc = def->sllp;
-	(*sps)->enc[0].page_shift = def->shift;
-	(*sps)->enc[0].pte_enc = def->penc[linux_psize];
+	for (i = 0; i < MMU_PAGE_COUNT; i++) {
+		if ((signed int)def->penc[i] != -1) {
+			BUG_ON(index >= KVM_PPC_PAGE_SIZES_MAX_SZ);
+			(*sps)->enc[index].page_shift = mmu_psize_defs[i].shift;
+			(*sps)->enc[index].pte_enc = def->penc[i];
+			index++;
+		}
+	}
 	(*sps)++;
 }
 
-- 
1.7.10
