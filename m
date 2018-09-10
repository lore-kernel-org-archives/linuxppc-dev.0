Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 4281SX6qtdzF3DX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:30:04 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel v2 5/6] KVM: PPC: Propagate errors to the guest when
 failed instead of ignoring
Date: Mon, 10 Sep 2018 18:29:11 +1000
Message-Id: <20180910082912.13255-6-aik@ozlabs.ru>
In-Reply-To: <20180910082912.13255-1-aik@ozlabs.ru>
References: <20180910082912.13255-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment if the PUT_TCE{_INDIRECT} handlers fail to update
the hardware tables, we print a warning once, clear the entry and
continue. This is so as at the time the assumption was that if
a VFIO device is hotplugged into the guest, and the userspace replays
virtual DMA mappings (i.e. TCEs) to the hardware tables and if this fails,
then there is nothing useful we can do about it.

However the assumption is not valid as these handlers are not called for
TCE replay (VFIO ioctl interface is used for that) and these handlers
are for new TCEs.

This returns an error to the guest if there is a request which cannot be
processed. By now the only possible failure must be H_TOO_HARD.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 20 ++++++--------------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 21 +++++++--------------
 2 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 01e1994..8231b17 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -568,14 +568,10 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			ret = kvmppc_tce_iommu_map(vcpu->kvm, stt, stit->tbl,
 					entry, ua, dir);
 
-		if (ret == H_SUCCESS)
-			continue;
-
-		if (ret == H_TOO_HARD)
+		if (ret != H_SUCCESS) {
+			kvmppc_clear_tce(stit->tbl, entry);
 			goto unlock_exit;
-
-		WARN_ON_ONCE(1);
-		kvmppc_clear_tce(stit->tbl, entry);
+		}
 	}
 
 	kvmppc_tce_put(stt, entry, tce);
@@ -663,14 +659,10 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 					stit->tbl, entry + i, ua,
 					iommu_tce_direction(tce));
 
-			if (ret == H_SUCCESS)
-				continue;
-
-			if (ret == H_TOO_HARD)
+			if (ret != H_SUCCESS) {
+				kvmppc_clear_tce(stit->tbl, entry);
 				goto unlock_exit;
-
-			WARN_ON_ONCE(1);
-			kvmppc_clear_tce(stit->tbl, entry);
+			}
 		}
 
 		kvmppc_tce_put(stt, entry + i, tce);
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 977e95a..adf3b21 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -403,14 +403,10 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			ret = kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
 					stit->tbl, entry, ua, dir);
 
-		if (ret == H_SUCCESS)
-			continue;
-
-		if (ret == H_TOO_HARD)
+		if (ret != H_SUCCESS) {
+			kvmppc_rm_clear_tce(vcpu->kvm, stit->tbl, entry);
 			return ret;
-
-		WARN_ON_ONCE_RM(1);
-		kvmppc_rm_clear_tce(vcpu->kvm, stit->tbl, entry);
+		}
 	}
 
 	kvmppc_tce_put(stt, entry, tce);
@@ -556,14 +552,11 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 					stit->tbl, entry + i, ua,
 					iommu_tce_direction(tce));
 
-			if (ret == H_SUCCESS)
-				continue;
-
-			if (ret == H_TOO_HARD)
+			if (ret != H_SUCCESS) {
+				kvmppc_rm_clear_tce(vcpu->kvm, stit->tbl,
+						entry);
 				goto unlock_exit;
-
-			WARN_ON_ONCE_RM(1);
-			kvmppc_rm_clear_tce(vcpu->kvm, stit->tbl, entry);
+			}
 		}
 
 		kvmppc_tce_put(stt, entry + i, tce);
-- 
2.11.0
