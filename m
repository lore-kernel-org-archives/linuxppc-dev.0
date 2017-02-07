Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHpKg1rHWzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 02:34:15 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 204so12411612pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 07:34:15 -0800 (PST)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: agraf@suse.com, pbonzini@redhat.com, rkrcmar@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: Wei Yongjun <weiyongjun1@huawei.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -next] KVM: PPC: Fix error return code in
 kvm_vm_ioctl_create_spapr_tce()
Date: Tue,  7 Feb 2017 15:34:07 +0000
Message-Id: <20170207153407.22325-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return error code -ENOMEM from the memory alloc error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index d71f872..8a4a3f0 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -173,8 +173,10 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
-	if (!stt)
+	if (!stt) {
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	stt->liobn = args->liobn;
 	stt->page_shift = args->page_shift;
@@ -184,8 +186,10 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 
 	for (i = 0; i < npages; i++) {
 		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
-		if (!stt->pages[i])
+		if (!stt->pages[i]) {
+			ret = -ENOMEM;
 			goto fail;
+		}
 	}
 
 	kvm_get_kvm(kvm);
