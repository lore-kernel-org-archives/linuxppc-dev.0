Return-Path: <nixiaoming@huawei.com>
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcCwD6BjKzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 00:43:08 +1000 (AEST)
From: nixiaoming <nixiaoming@huawei.com>
To: <agraf@suse.com>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
CC: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix memory leak on kvm_vm_ioctl_create_spapr_tce
Date: Tue, 22 Aug 2017 22:28:23 +0800
Message-ID: <20170822142823.69425-1-nixiaoming@huawei.com>
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

miss kfree(stt) when anon_inode_getfd return fail
so add check anon_inode_getfd return val, and kfree stt

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index a160c14..a0b4459 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -341,8 +341,11 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 
 	mutex_unlock(&kvm->lock);
 
-	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
+	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
 				stt, O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto fail;
+	return ret;
 
 fail:
 	if (stt) {
-- 
2.11.0.1
