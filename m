Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 522AA67D54
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:44:37 +1100 (EST)
Date: Mon, 13 Nov 2006 14:44:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix irq.c for combined build
Message-Id: <20061113144440.cc6bb0fe.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/irq.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index eb9fc62..e173c76 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -267,13 +267,12 @@ void do_IRQ(struct pt_regs *regs)
         irq_exit();
 	set_irq_regs(old_regs);
 
-#ifdef CONFIG_PPC_ISERIES
-	if (get_lppaca()->int_dword.fields.decr_int) {
+	if (firmware_has_feature(FW_FEATURE_ISERIES) &&
+			get_lppaca()->int_dword.fields.decr_int) {
 		get_lppaca()->int_dword.fields.decr_int = 0;
 		/* Signal a fake decrementer interrupt */
 		timer_interrupt(regs);
 	}
-#endif
 }
 
 void __init init_IRQ(void)
-- 
1.4.3.3
