Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 625CCB715B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:08 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 19/26] KVM: PPC: Update int_pending also on dequeue
Date: Tue, 17 Aug 2010 15:57:54 +0200
Message-Id: <1282053481-18787-20-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When having a decrementor interrupt pending, the dequeuing happens manually
through an mtdec instruction. This instruction simply calls dequeue on that
interrupt, so the int_pending hint doesn't get updated.

This patch enables updating the int_pending hint also on dequeue, thus
correctly enabling guests to stay in guest contexts more often.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 5fbe949..8138d31 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -201,6 +201,9 @@ static void kvmppc_book3s_dequeue_irqprio(struct kvm_vcpu *vcpu,
 {
 	clear_bit(kvmppc_book3s_vec2irqprio(vec),
 		  &vcpu->arch.pending_exceptions);
+
+	if (!vcpu->arch.pending_exceptions)
+		vcpu->arch.shared->int_pending = 0;
 }
 
 void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec)
-- 
1.6.0.2
