Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 May 2011 20:38:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH 02/13] kvm/powerpc: Fix kvmppc_core_pending_dec
Message-ID: <20110511103850.GC2837@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110511103443.GA2837@brick.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The vcpu->arch.pending_exceptions field is a bitfield indexed by
interrupt priority number as returned by kvmppc_book3s_vec2irqprio.
However, kvmppc_core_pending_dec was using an interrupt vector shifted
by 7 as the bit index.  Fix it to use the irqprio value for the
decrementer interrupt instead.  This problem was found by code
inspection.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 3501961..42a2fed 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -237,7 +237,7 @@ void kvmppc_core_queue_dec(struct kvm_vcpu *vcpu)
 
 int kvmppc_core_pending_dec(struct kvm_vcpu *vcpu)
 {
-	return test_bit(BOOK3S_INTERRUPT_DECREMENTER >> 7, &vcpu->arch.pending_exceptions);
+	return test_bit(BOOK3S_IRQPRIO_DECREMENTER, &vcpu->arch.pending_exceptions);
 }
 
 void kvmppc_core_dequeue_dec(struct kvm_vcpu *vcpu)
-- 
1.7.4.4
