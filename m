Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:24:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 01/14] KVM: PPC: Make wakeups work again for Book3S HV
 guests
Message-ID: <20111212222448.GB18868@bloggs.ozlabs.ibm.com>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When commit f43fdc15fa ("KVM: PPC: booke: Improve timer register
emulation") factored out some code in arch/powerpc/kvm/powerpc.c
into a new helper function, kvm_vcpu_kick(), an error crept in
which causes Book3s HV guest vcpus to stall.  This fixes it.
On POWER7 machines, guest vcpus are grouped together into virtual
CPU cores that share a single waitqueue, so it's important to use
vcpu->arch.wqp rather than &vcpu->wq.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/powerpc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ef8c990..b939b8a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -561,7 +561,7 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
         int cpu = vcpu->cpu;
 
         me = get_cpu();
-	if (waitqueue_active(&vcpu->wq)) {
+	if (waitqueue_active(vcpu->arch.wqp)) {
 		wake_up_interruptible(vcpu->arch.wqp);
 		vcpu->stat.halt_wakeup++;
 	} else if (cpu != me && cpu != -1) {
-- 
1.7.7.3
