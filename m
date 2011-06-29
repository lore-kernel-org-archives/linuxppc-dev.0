Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jun 2011 20:16:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 01/17] KVM: PPC: Fix machine checks on 32-bit Book3S
Message-ID: <20110629101642.GB25406@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 69acc0d3ba ("KVM: PPC: Resolve real-mode handlers through
function exports") resulted in vcpu->arch.trampoline_lowmem and
vcpu->arch.trampoline_enter ending up with kernel virtual addresses
rather than physical addresses.  This is OK on 64-bit Book3S machines,
which ignore the top 4 bits of the effective address in real mode,
but on 32-bit Book3S machines, accessing these addresses in real mode
causes machine check interrupts, as the hardware uses the whole
effective address as the physical address in real mode.

This fixes the problem by using __pa() to convert these addresses
to physical addresses.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 73fdab8..83500fb 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -28,6 +28,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/mmu_context.h>
+#include <asm/page.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
@@ -1342,8 +1343,8 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	vcpu_book3s->slb_nr = 64;
 
 	/* remember where some real-mode handlers are */
-	vcpu->arch.trampoline_lowmem = (ulong)kvmppc_handler_lowmem_trampoline;
-	vcpu->arch.trampoline_enter = (ulong)kvmppc_handler_trampoline_enter;
+	vcpu->arch.trampoline_lowmem = __pa(kvmppc_handler_lowmem_trampoline);
+	vcpu->arch.trampoline_enter = __pa(kvmppc_handler_trampoline_enter);
 	vcpu->arch.highmem_handler = (ulong)kvmppc_handler_highmem;
 #ifdef CONFIG_PPC_BOOK3S_64
 	vcpu->arch.rmcall = *(ulong*)kvmppc_rmcall;
-- 
1.7.5.4
