Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C85FD2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 08:21:34 +1000 (EST)
Date: Fri, 10 Aug 2012 17:21:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [PATCH] powerpc/epapr: export epapr_hypercall_start
Message-ID: <20120810222121.GA9408@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes breakage introduced by the following commit:

  commit 6d2d82627f4f1e96a33664ace494fa363e0495cb
  Author: Liu Yu-B13201 <Yu.Liu@freescale.com>
  Date:   Tue Jul 3 05:48:56 2012 +0000

    PPC: Don't use hardcoded opcode for ePAPR hcall invocation

when a driver that uses ePAPR hypercalls is built as a module.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Sending to Alex even though this isn't KVM-specific since the commit it
fixes is still only in his tree (and linux-next).

 arch/powerpc/kernel/ppc_ksyms.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 3e40315..e597dde 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -43,6 +43,7 @@
 #include <asm/dcr.h>
 #include <asm/ftrace.h>
 #include <asm/switch_to.h>
+#include <asm/epapr_hcalls.h>
 
 #ifdef CONFIG_PPC32
 extern void transfer_to_handler(void);
@@ -192,3 +193,7 @@ EXPORT_SYMBOL(__arch_hweight64);
 #ifdef CONFIG_PPC_BOOK3S_64
 EXPORT_SYMBOL_GPL(mmu_psize_defs);
 #endif
+
+#ifdef CONFIG_EPAPR_PARAVIRT
+EXPORT_SYMBOL(epapr_hypercall_start);
+#endif
-- 
1.7.9.5
