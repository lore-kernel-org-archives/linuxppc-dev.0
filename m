Return-Path: <dja@axtens.net>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssgzp1W9jzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 11:31:49 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id rw4so1200392pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 17:31:49 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, paulus@samba.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/2] KVM: PPC: Fix sparse static warning.
Date: Mon, 10 Oct 2016 11:31:19 +1100
Message-Id: <1476059480-18145-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Squash a couple of sparse warnings by making things static.

Build tested.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 05f09ae82587..95abca69b168 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -255,7 +255,7 @@ static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
 	kvmppc_set_msr(vcpu, msr);
 }
 
-long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
+static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret)
 {
@@ -1608,7 +1608,7 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-ssize_t debugfs_htab_write(struct file *file, const char __user *buf,
+static ssize_t debugfs_htab_write(struct file *file, const char __user *buf,
 			   size_t len, loff_t *ppos)
 {
 	return -EACCES;
-- 
2.7.4
