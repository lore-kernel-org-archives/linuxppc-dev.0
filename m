Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyXqZ4gkKzDrd4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 12:27:54 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id m26so4976447pfj.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 17:27:54 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 2/3] powerpc/powernv: Identify scom driven system reset
Date: Fri, 15 Dec 2017 12:27:39 +1100
Message-Id: <20171215012740.30291-2-bsingharora@gmail.com>
In-Reply-To: <20171215012740.30291-1-bsingharora@gmail.com>
References: <20171215012740.30291-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In irq_set_pending_from_srr1() we were missing 0x2 as system
reset identified from SRR1 caused by back to back system
resets or when interrupts are caused by SCOM when the thread
is not in power saving mode.

This helps us get to NMI handling in both the case where NMI
is caused when in power-saving and not in power-saving mode.
The actual exploitation is expected when we are doing a kdump
and an offline CPU might not be in power-saving mode due to
an already spurious IPI or any other reason.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index b7a84522e652..ec89104e8ab9 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -413,7 +413,7 @@ bool prep_irq_for_idle_irqsoff(void)
 #define IRQ_SYSTEM_RESET	0xff
 
 static const u8 srr1_to_lazyirq[0x10] = {
-	0, 0, 0,
+	0, 0, IRQ_SYSTEM_RESET,
 	PACA_IRQ_DBELL,
 	IRQ_SYSTEM_RESET,
 	PACA_IRQ_DBELL,
-- 
2.13.6
