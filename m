Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJRJH1lTnzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 03:20:15 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y143so11986647pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 08:20:15 -0800 (PST)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: agraf@suse.com, pbonzini@redhat.com, rkrcmar@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: Wei Yongjun <weiyongjun1@huawei.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -next v2] KVM: PPC: fix error return code in
 kvm_vm_ioctl_create_spapr_tce()
Date: Wed,  8 Feb 2017 16:20:01 +0000
Message-Id: <20170208162001.3603-1-weiyj.lk@gmail.com>
In-Reply-To: <20170207153407.22325-1-weiyj.lk@gmail.com>
References: <20170207153407.22325-1-weiyj.lk@gmail.com>
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
 arch/powerpc/kvm/book3s_64_vio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index d71f872..ab9d14c 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -171,6 +171,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		goto fail;
 	}
 
+	ret = -ENOMEM;
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
 	if (!stt)
