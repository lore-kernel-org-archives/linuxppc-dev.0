Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 38D591A0048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 21:05:19 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: Shorten irq_chip name for the SIU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20150821110515.94DBB1A241A@localhost.localdomain>
Date: Fri, 21 Aug 2015 13:05:15 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

show_interrupts() expects the irq_chip name to be max 8 characters
otherwise everything get misaligned

# cat /proc/interrupts
           CPU0
 17:          0   CPM PIC   0 Level     error
 19:          0  MPC8XX SIU  15 Level     tbint
 20:         90   CPM PIC   4 Level     cpm_uart
 38:      29746  MPC8XX SIU   5 Level     fs_enet-mac
 39:          0  MPC8XX SIU   7 Level     fs_enet-mac
 47:        401   CPM PIC   5 Level     fsl_spi
 68:          1  MPC8XX SIU   2 Level     phy_interrupt, phy_interrupt, phy_interrupt
LOC:    7225485   Local timer interrupts for timer event device
LOC:          9   Local timer interrupts for others
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/mpc8xx_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index c4828c0..475e706 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -61,7 +61,7 @@ static int mpc8xx_set_irq_type(struct irq_data *d, unsigned int flow_type)
 }
 
 static struct irq_chip mpc8xx_pic = {
-	.name = "MPC8XX SIU",
+	.name = "8XX SIU",
 	.irq_unmask = mpc8xx_unmask_irq,
 	.irq_mask = mpc8xx_mask_irq,
 	.irq_ack = mpc8xx_ack,
-- 
2.1.0
