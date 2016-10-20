Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szw4D0P08zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 14:57:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org
Subject: [PATCH] KVM: PPC: Book3S HV: Fix build error when SMP=n
Date: Thu, 20 Oct 2016 14:57:12 +1100
Message-Id: <1476935832-28880-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5d375199ea96 ("KVM: PPC: Book3S HV: Set server for passed-through
interrupts") broke the SMP=n build:

  arch/powerpc/kvm/book3s_hv_rm_xics.c:758:2: error: implicit declaration of function 'get_hard_smp_processor_id'

That is because we lost the implicit include of asm/smp.h, so include it
explicitly to get the definition for get_hard_smp_processor_id().

Fixes: 5d375199ea96 ("KVM: PPC: Book3S HV: Set server for passed-through interrupts")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 82ff5de8b1e7..a0ea63ac2b52 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -23,6 +23,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/pnv-pci.h>
 #include <asm/opal.h>
+#include <asm/smp.h>
 
 #include "book3s_xics.h"
 
-- 
2.7.4
