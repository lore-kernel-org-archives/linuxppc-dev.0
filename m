Return-Path: <nixiaoming@huawei.com>
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcCpp4TSSzDqgx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 00:38:26 +1000 (AEST)
From: nixiaoming <nixiaoming@huawei.com>
To: <agraf@suse.com>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
CC: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix memory leak on kvm_vm_ioctl_get_htab_fd
Date: Tue, 22 Aug 2017 22:18:20 +0800
Message-ID: <20170822141820.67839-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
but no free when anon_inode_getfd return fail
so, add kfree(ctx) to fix memory leak

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index b42812e..be3d08f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1940,6 +1940,7 @@ int kvm_vm_ioctl_get_htab_fd(struct kvm *kvm, struct kvm_get_htab_fd *ghf)
 	rwflag = (ghf->flags & KVM_GET_HTAB_WRITE) ? O_WRONLY : O_RDONLY;
 	ret = anon_inode_getfd("kvm-htab", &kvm_htab_fops, ctx, rwflag | O_CLOEXEC);
 	if (ret < 0) {
+		kfree(ctx);
 		kvm_put_kvm(kvm);
 		return ret;
 	}
-- 
2.11.0.1
