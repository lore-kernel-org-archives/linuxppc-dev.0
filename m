Return-Path: <B08248@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 557482C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 06:12:50 +1100 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <mikey@neuling.org>
Subject: [PATCH] PPC: define the conditions where the ePAPR idle hcall can be
 supported
Date: Fri, 22 Mar 2013 14:12:13 -0500
Message-ID: <1363979533-24485-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: sfr@canb.auug.org.au, Stuart Yoder <stuart.yoder@freescale.com>,
 matt@ozlabs.org, gang.chen@asianux.com, linux-kernel@vger.kernel.org,
 paulus@samba.org, imunsie@au1.ibm.com, chen.gang.flying.transformer@gmail.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

For 32-bit, CONFIG_EPAPR_PARAVIRT pulls in both epapr_paravirt.c
and epapr_hcalls.c which contains the 32-bit paravirt idle loop.

For 64-bit, the paravirt idle loop is in idle_book3e.S and that
source file is included only if CONFIG_PPC_BOOK3E_64 defined.

This patch makes that dependency for 64-bit explicit.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 arch/powerpc/kernel/epapr_paravirt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index f3eab85..d44a571 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -23,8 +23,10 @@
 #include <asm/code-patching.h>
 #include <asm/machdep.h>
 
+#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
 extern void epapr_ev_idle(void);
 extern u32 epapr_ev_idle_start[];
+#endif
 
 bool epapr_paravirt_enabled;
 
@@ -47,11 +49,15 @@ static int __init epapr_paravirt_init(void)
 
 	for (i = 0; i < (len / 4); i++) {
 		patch_instruction(epapr_hypercall_start + i, insts[i]);
+#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
 		patch_instruction(epapr_ev_idle_start + i, insts[i]);
+#endif
 	}
 
+#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
 	if (of_get_property(hyper_node, "has-idle", NULL))
 		ppc_md.power_save = epapr_ev_idle;
+#endif
 
 	epapr_paravirt_enabled = true;
 
-- 
1.7.9.7
