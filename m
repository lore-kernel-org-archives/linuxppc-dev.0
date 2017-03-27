Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vrzlp4wNfzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 14:19:33 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel] KVM: PPC: Check kzalloc() return
Date: Mon, 27 Mar 2017 14:19:27 +1100
Message-Id: <20170327031927.18572-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds missing check for failed kzalloc().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is a followup change for:
[PATCH kernel v11 10/10] KVM: PPC: VFIO: Add in-kernel acceleration for VFIO

Please squash it. Thanks!
---
 arch/powerpc/kvm/book3s_64_vio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 22c67a47eaab..c3d8a88f1f4e 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -212,6 +212,11 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	}
 
 	stit = kzalloc(sizeof(*stit), GFP_KERNEL);
+	if (!stit) {
+		iommu_tce_table_put(tbl);
+		return -ENOMEM;
+	}
+
 	stit->tbl = tbl;
 	kref_init(&stit->kref);
 
-- 
2.11.0
