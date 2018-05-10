Return-Path: <jrdr.linux@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hhV25SfFzF22W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 04:25:14 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id e6-v6so1761419plt.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 11:25:14 -0700 (PDT)
Date: Thu, 10 May 2018 23:57:19 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 willy@infradead.org
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: kvm: Change return type to vm_fault_t
Message-ID: <20180510182719.GA22217@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a 
VM_FAULT value rather than an errno.  Once all
instances are converted, vm_fault_t will become
a distinct type.

commit 1c8f422059ae ("mm: change return type to
vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Updated the change log

 arch/powerpc/kvm/book3s_64_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 4dffa61..346ac0d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -237,7 +237,7 @@ static void release_spapr_tce_table(struct rcu_head *head)
 	kfree(stt);
 }

-static int kvm_spapr_tce_fault(struct vm_fault *vmf)
+static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
 {
 	struct kvmppc_spapr_tce_table *stt = vmf->vma->vm_file->private_data;
 	struct page *page;
--
1.9.1
