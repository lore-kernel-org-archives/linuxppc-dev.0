Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F4162C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 06:35:25 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 21 Mar 2013 01:01:23 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 120D73940067
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 01:05:21 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2KJZFRT9699662
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 01:05:16 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2KJZK9d020998
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 19:35:20 GMT
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V4 12/25] powerpc: Return all the valid pte ecndoing in
 KVM_PPC_GET_SMMU_INFO ioctl
Date: Thu, 21 Mar 2013 01:04:57 +0530
Message-Id: <1363808110-25748-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1363808110-25748-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1363808110-25748-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
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
 arch/powerpc/kvm/book3s_hv.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 48f6d99..f472414 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1508,14 +1508,24 @@ long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
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
+		if (def->penc[i] != -1) {
+			if (index >= KVM_PPC_PAGE_SIZES_MAX_SZ) {
+				WARN_ON(1);
+				break;
+			}
+			(*sps)->enc[index].page_shift = mmu_psize_defs[i].shift;
+			(*sps)->enc[index].pte_enc = def->penc[i];
+			index++;
+		}
+	}
 	(*sps)++;
 }
 
-- 
1.7.10
