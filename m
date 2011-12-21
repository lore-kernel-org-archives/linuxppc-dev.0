Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8A41CB7223
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:34:37 +1100 (EST)
Date: Tue, 20 Dec 2011 19:34:29 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 07/16] KVM: PPC: e500: rename e500_tlb.h to e500.h
Message-ID: <20111221013429.GG8378@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111221013340.GA8368@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is in preparation for merging in the contents of
arch/powerpc/include/asm/kvm_e500.h.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kvm/e500.c                 |    2 +-
 arch/powerpc/kvm/{e500_tlb.h => e500.h} |    6 +++---
 arch/powerpc/kvm/e500_emulate.c         |    2 +-
 arch/powerpc/kvm/e500_tlb.c             |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/powerpc/kvm/{e500_tlb.h => e500.h} (98%)

diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 80b9c84..faa32df 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -24,7 +24,7 @@
 #include <asm/kvm_ppc.h>
 
 #include "booke.h"
-#include "e500_tlb.h"
+#include "e500.h"
 
 void kvmppc_core_load_host_debugstate(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/powerpc/kvm/e500_tlb.h b/arch/powerpc/kvm/e500.h
similarity index 98%
rename from arch/powerpc/kvm/e500_tlb.h
rename to arch/powerpc/kvm/e500.h
index 5c6d2d7..02ecde2 100644
--- a/arch/powerpc/kvm/e500_tlb.h
+++ b/arch/powerpc/kvm/e500.h
@@ -12,8 +12,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __KVM_E500_TLB_H__
-#define __KVM_E500_TLB_H__
+#ifndef KVM_E500_H
+#define KVM_E500_H
 
 #include <linux/kvm_host.h>
 #include <asm/mmu-book3e.h>
@@ -171,4 +171,4 @@ static inline int tlbe_is_host_safe(const struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-#endif /* __KVM_E500_TLB_H__ */
+#endif /* KVM_E500_H */
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 6d0b2bd..2a1a228 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -17,7 +17,7 @@
 #include <asm/kvm_e500.h>
 
 #include "booke.h"
-#include "e500_tlb.h"
+#include "e500.h"
 
 #define XOP_TLBIVAX 786
 #define XOP_TLBSX   914
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 6e9bc42..3ec3ad6 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -29,7 +29,7 @@
 #include <asm/kvm_e500.h>
 
 #include "../mm/mmu_decl.h"
-#include "e500_tlb.h"
+#include "e500.h"
 #include "trace.h"
 #include "timing.h"
 
-- 
1.7.7.rc3.4.g8d714
