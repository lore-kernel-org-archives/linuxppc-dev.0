Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42172q70ljzF36l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 13:17:23 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 1/4] KVM: PPC: Validate all tces before updating tables
Date: Thu, 30 Aug 2018 13:16:44 +1000
Message-Id: <20180830031647.34134-2-aik@ozlabs.ru>
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

The KVM TCE handlers are written in a way so they fail when either
something went horribly wrong or the userspace did some obvious mistake
such as passing a misaligned address.

We are going to enhance the TCE checker to fail on attempts to map bigger
IOMMU page than the underlying pinned memory so let's valitate TCE
beforehand.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 9a3f264..0fef22b 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -599,6 +599,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		ret = kvmppc_tce_validate(stt, tce);
 		if (ret != H_SUCCESS)
 			goto unlock_exit;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		if (get_user(tce, tces + i)) {
+			ret = H_TOO_HARD;
+			goto unlock_exit;
+		}
+		tce = be64_to_cpu(tce);
 
 		if (kvmppc_gpa_to_ua(vcpu->kvm,
 				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 506a4d4..7ab6f3f 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -501,6 +501,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		ret = kvmppc_tce_validate(stt, tce);
 		if (ret != H_SUCCESS)
 			goto unlock_exit;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
 
 		ua = 0;
 		if (kvmppc_gpa_to_ua(vcpu->kvm,
-- 
2.11.0
