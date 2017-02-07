Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vHbKM0g8bzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 18:18:15 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from update
Date: Tue,  7 Feb 2017 18:17:09 +1100
Message-Id: <20170207071711.28938-9-aik@ozlabs.ru>
In-Reply-To: <20170207071711.28938-1-aik@ozlabs.ru>
References: <20170207071711.28938-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the emulated devices it does not matter much if we get a broken TCE
half way handling a TCE list but for VFIO it will matter as it has
more chances to fail so we try to do our best and check as much as we
can before proceeding.

This separates a guest view table update from validation. No change in
behavior is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 15df8ae627d9..9a7b7fca5e84 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -282,6 +282,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
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
 
 		kvmppc_tce_put(stt, entry + i, tce);
 	}
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 918af76ab2b6..f8a54b7c788e 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -237,7 +237,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret = H_SUCCESS;
-	unsigned long tces, entry, ua = 0;
+	unsigned long tces, entry, tce, ua = 0;
 	unsigned long *rmap = NULL;
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
@@ -279,11 +279,15 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 
 	for (i = 0; i < npages; ++i) {
-		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
+		tce = be64_to_cpu(((u64 *)tces)[i]);
 
 		ret = kvmppc_tce_validate(stt, tce);
 		if (ret != H_SUCCESS)
 			goto unlock_exit;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		tce = be64_to_cpu(((u64 *)tces)[i]);
 
 		kvmppc_tce_put(stt, entry + i, tce);
 	}
-- 
2.11.0
