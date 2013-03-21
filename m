Return-Path: <pc+lkml@asdf.org>
From: Phil Carmody <pc+lkml@asdf.org>
To: sfr@canb.auug.org.au
Subject: [PATCH] kvm: (ppc) stub out more functions in order to permit kernel
 to build
Date: Fri, 22 Mar 2013 01:59:56 +0200
Message-Id: <1363910396-24604-1-git-send-email-pc+lkml@asdf.org>
Cc: Phil Carmody <pc+lkml@asdf.org>, khilman@linaro.org,
 Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build failure mentioned by Stephen Rothwell here:
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg65408.html

Traced to:
commit f445f11eb2cc -"KVM: allow host header to be included even for !CONFIG_KVM"

This patch permits the build to progress by stubbing out the two functions
that it fell over on. I have no idea if that's even vaguely appropriate.

This has been .c->.o compile tested only, as g5_defconfig FTB elsewhere.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Phil Carmody <pc+lkml@asdf.org>
---
 arch/powerpc/include/asm/kvm_ppc.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 44a657a..262d9b7 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -20,6 +20,8 @@
 #ifndef __POWERPC_KVM_PPC_H__
 #define __POWERPC_KVM_PPC_H__
 
+#if IS_ENABLED(CONFIG_KVM)
+
 /* This file exists just so we can dereference kvm_vcpu, avoiding nested header
  * dependencies. */
 
@@ -324,4 +326,9 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
 	return ea;
 }
 
+#else
+static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr) { return; }
+static inline void kvm_linear_init(void) { return; }
+#endif /* IS_ENABLED(CONFIG_KVM) */
+
 #endif /* __POWERPC_KVM_PPC_H__ */
-- 
1.7.2.5
