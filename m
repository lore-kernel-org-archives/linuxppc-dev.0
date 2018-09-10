Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 4281SN5WsnzF3Cl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:29:56 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel v2 2/6] KVM: PPC: Validate all tces before updating
 tables
Date: Mon, 10 Sep 2018 18:29:08 +1000
Message-Id: <20180910082912.13255-3-aik@ozlabs.ru>
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

The KVM TCE handlers are written in a way so they fail when either
something went horribly wrong or the userspace did some obvious mistake
such as passing a misaligned address.

We are going to enhance the TCE checker to fail on attempts to map bigger
IOMMU page than the underlying pinned memory so let's valitate TCE
beforehand.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v2:
* added a comment for the second get_user() from v1 discussion
---
 arch/powerpc/kvm/book3s_64_vio.c    | 18 ++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 9a3f264..3c17977 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -599,6 +599,24 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		ret = kvmppc_tce_validate(stt, tce);
 		if (ret != H_SUCCESS)
 			goto unlock_exit;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		/*
+		 * This looks unsafe, because we validate, then regrab
+		 * the TCE from userspace which could have been changed by
+		 * another thread.
+		 *
+		 * But it actually is safe, because the relevant checks will be
+		 * re-executed in the following code.  If userspace tries to
+		 * change this dodgily it will result in a messier failure mode
+		 * but won't threaten the host.
+		 */
+		if (get_user(tce, tces + i)) {
+			ret = H_TOO_HARD;
+			goto unlock_exit;
+		}
+		tce = be64_to_cpu(tce);
 
 		if (kvmppc_gpa_to_ua(vcpu->kvm,
 				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 6821ead..c2848e0b 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -524,6 +524,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
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
