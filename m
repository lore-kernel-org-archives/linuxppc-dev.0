Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
 Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
Subject: [PATCH] powerpc kvm: fix kvmppc_start_thread() for CONFIG_SMP=N
Date: Fri, 11 Nov 2011 13:03:20 +1100
Message-ID: <12283.1320977000@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently kvmppc_start_thread() tries to wake other SMT threads via
xics_wake_cpu().  Unfortunately xics_wake_cpu only exists when
CONFIG_SMP=Y so when compiling with CONFIG_SMP=N we get:

  arch/powerpc/kvm/built-in.o: In function `.kvmppc_start_thread':
  book3s_hv.c:(.text+0xa1e0): undefined reference to `.xics_wake_cpu'

The following should be fine since kvmppc_start_thread() shouldn't
called to start non-zero threads when SMP=N since threads_per_core=1.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kvm/book3s_hv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-ozlabs/arch/powerpc/kvm/book3s_hv.c
===================================================================
--- linux-ozlabs.orig/arch/powerpc/kvm/book3s_hv.c
+++ linux-ozlabs/arch/powerpc/kvm/book3s_hv.c
@@ -538,7 +538,7 @@ static void kvmppc_start_thread(struct k
 	tpaca->kvm_hstate.napping = 0;
 	vcpu->cpu = vc->pcpu;
 	smp_wmb();
-#ifdef CONFIG_PPC_ICP_NATIVE
+#if defined(CONFIG_PPC_ICP_NATIVE) && defined(CONFIG_SMP)
 	if (vcpu->arch.ptid) {
 		tpaca->cpu_start = 0x80;
 		wmb();
