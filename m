Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syMGn34gLzDt2r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 02:16:01 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 128so12987604pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 08:16:01 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Alexander Graf <agraf@suse.com>, pbonzini@redhat.com, rkrcmar@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: Wei Yongjun <weiyongjun1@huawei.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -next] KVM: PPC: Book3S HV: Use list_move_tail instead of
 list_del/list_add_tail
Date: Mon, 17 Oct 2016 15:15:50 +0000
Message-Id: <1476717350-12884-1-git-send-email-weiyj.lk@gmail.com>
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

Using list_move_tail() instead of list_del() + list_add_tail().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/kvm/book3s_hv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471..4159431 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2123,8 +2123,7 @@ static bool can_dynamic_split(struct kvmppc_vcore *vc, struct core_info *cip)
 	cip->subcore_threads[sub] = vc->num_threads;
 	cip->subcore_vm[sub] = vc->kvm;
 	init_master_vcore(vc);
-	list_del(&vc->preempt_list);
-	list_add_tail(&vc->preempt_list, &cip->vcs[sub]);
+	list_move_tail(&vc->preempt_list, &cip->vcs[sub]);
 
 	return true;
 }
