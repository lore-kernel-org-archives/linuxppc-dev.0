Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A674B6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:40 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 06/37] KVM: PPC: e500: rename e500_tlb.h to e500.h
Date: Fri, 24 Feb 2012 15:26:00 +0100
Message-Id: <1330093591-19523-7-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

This is in preparation for merging in the contents of
arch/powerpc/include/asm/kvm_e500.h.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/e500.c                 |    2 +-
 arch/powerpc/kvm/{e500_tlb.h => e500.h} |    6 +++---
 arch/powerpc/kvm/e500_emulate.c         |    2 +-
 arch/powerpc/kvm/e500_tlb.c             |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/powerpc/kvm/{e500_tlb.h => e500.h} (98%)

diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index ac6c9ae..5c450ba 100644
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
index 6e53e41..1d623a0 100644
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
1.6.0.2
