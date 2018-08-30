Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42172L2hGgzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 13:16:58 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 4/4] KVM: PPC: Propagate errors to the guest when
 failed instead of ignoring
Date: Thu, 30 Aug 2018 13:16:47 +1000
Message-Id: <20180830031647.34134-5-aik@ozlabs.ru>
In-Reply-To: <20180830031647.34134-1-aik@ozlabs.ru>
References: <20180830031647.34134-1-aik@ozlabs.ru>
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
---
 arch/powerpc/kvm/book3s_64_vio.c    | 20 ++++++--------------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 20 ++++++--------------
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 5cd2a66..5e3151b 100644
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
@@ -660,14 +656,10 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
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
index e79ffbb..8d82133 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -380,14 +380,10 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			ret = kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
 					stit->tbl, entry, ua, dir);
 
-		if (ret == H_SUCCESS)
-			continue;
-
-		if (ret == H_TOO_HARD)
+		if (ret != H_SUCCESS) {
+			kvmppc_rm_clear_tce(stit->tbl, entry);
 			return ret;
-
-		WARN_ON_ONCE_RM(1);
-		kvmppc_rm_clear_tce(stit->tbl, entry);
+		}
 	}
 
 	kvmppc_tce_put(stt, entry, tce);
@@ -533,14 +529,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 					stit->tbl, entry + i, ua,
 					iommu_tce_direction(tce));
 
-			if (ret == H_SUCCESS)
-				continue;
-
-			if (ret == H_TOO_HARD)
+			if (ret != H_SUCCESS) {
+				kvmppc_rm_clear_tce(stit->tbl, entry);
 				goto unlock_exit;
-
-			WARN_ON_ONCE_RM(1);
-			kvmppc_rm_clear_tce(stit->tbl, entry);
+			}
 		}
 
 		kvmppc_tce_put(stt, entry + i, tce);
-- 
2.11.0
