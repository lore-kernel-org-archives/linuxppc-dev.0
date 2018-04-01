Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPbr4NhGzF219
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:50:56 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id s10-v6so359343plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:50:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: Fix ppc_breakpoint_available compile
 error
Date: Sun,  1 Apr 2018 15:50:35 +1000
Message-Id: <20180401055036.18078-2-npiggin@gmail.com>
In-Reply-To: <20180401055036.18078-1-npiggin@gmail.com>
References: <20180401055036.18078-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kvm/book3s_hv.c: In function ‘kvmppc_h_set_mode’:
arch/powerpc/kvm/book3s_hv.c:745:8: error: implicit declaration of function ‘ppc_breakpoint_available’; did you mean ‘hw_breakpoint_disable’? [-Werror=implicit-function-declaration]
   if (!ppc_breakpoint_available())
        ^~~~~~~~~~~~~~~~~~~~~~~~
        hw_breakpoint_disable

Cc: Michael Neuling <mikey@neuling.org>
Fixes: 398e712c00 ("KVM: PPC: Book3S HV: Return error from h_set_mode(SET_DAWR) on POWER9")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 948642e16338..81e2ea882d97 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -49,6 +49,7 @@
 #include <asm/reg.h>
 #include <asm/ppc-opcode.h>
 #include <asm/asm-prototypes.h>
+#include <asm/debug.h>
 #include <asm/disassemble.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
-- 
2.16.3
