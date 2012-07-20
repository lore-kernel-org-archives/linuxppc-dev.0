Return-Path: <B35336@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 960942C1131
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 22:45:26 +1000 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/smp: Do not disable IPI interrupts during suspend
Date: Fri, 20 Jul 2012 20:47:01 +0800
Message-ID: <1342788421-27648-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During suspend, all interrupts including IPI will be disabled. In this case,
the suspend process will hang in SMP. To prevent this, pass the flag
IRQF_NO_SUSPEND when requesting IPI irq.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index fecb038..d26bbf8 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -171,7 +171,7 @@ int smp_request_message_ipi(int virq, int msg)
 	}
 #endif
 	err = request_irq(virq, smp_ipi_action[msg],
-			  IRQF_PERCPU | IRQF_NO_THREAD,
+			  IRQF_PERCPU | IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 			  smp_ipi_name[msg], 0);
 	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
 		virq, smp_ipi_name[msg], err);
-- 
1.6.4.1
