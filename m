Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F16182C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:21:19 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Jan 2014 17:21:15 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4C56C2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:21:12 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0A72CGj18677816
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:02:15 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0A7L9Mu005471
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 18:21:09 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PPC: KVM: fix VCPU run for HV KVM
Date: Fri, 10 Jan 2014 18:21:07 +1100
Message-Id: <1389338467-26303-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When write to MMIO happens and there is an ioeventfd for that and
is handled successfully, ioeventfd_write() returns 0 (success) and
kvmppc_handle_store() returns EMULATE_DONE. Then kvmppc_emulate_mmio()
converts EMULATE_DONE to RESUME_GUEST_NV and this broke from the loop.

This adds handling of RESUME_GUEST_NV in kvmppc_vcpu_run_hv().

Cc: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This definitely needs a better commit message. Please, help.
ps. it seems like ioeventfd never worked on ppc64. hm.

---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 072287f..24f363f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1569,7 +1569,7 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 				vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
 			srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
 		}
-	} while (r == RESUME_GUEST);
+	} while ((r == RESUME_GUEST_NV) || (r == RESUME_GUEST));
 
  out:
 	vcpu->arch.state = KVMPPC_VCPU_NOTREADY;
-- 
1.8.4.rc4
