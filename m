Return-Path: <khlebnikov@yandex-team.ru>
Received: from forward-corp1m.cmail.yandex.net
 (forward-corp1m.cmail.yandex.net [IPv6:2a02:6b8:b030::69])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 873CE1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 19:59:48 +1000 (AEST)
Subject: [PATCH v2 2/3] KVM: PPC: Book3S HV: Use need_resched() instead of
 should_resched()
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Paul Mackerras <paulus@samba.org>, David Vrabel <david.vrabel@citrix.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Jul 2015 12:52:03 +0300
Message-ID: <20150715095203.12246.72922.stgit@buzz>
In-Reply-To: <20150715095201.12246.49283.stgit@buzz>
References: <20150715095201.12246.49283.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function should_resched() is equal to (!preempt_count() && need_resched()).
In preemptive kernel preempt_count here is non-zero because of vc->lock.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 arch/powerpc/kvm/book3s_hv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 68d067ad4222..a9f753fb73a8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2178,7 +2178,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		vc->runner = vcpu;
 		if (n_ceded == vc->n_runnable) {
 			kvmppc_vcore_blocked(vc);
-		} else if (should_resched()) {
+		} else if (need_resched()) {
 			vc->vcore_state = VCORE_PREEMPT;
 			/* Let something else run */
 			cond_resched_lock(&vc->lock);
