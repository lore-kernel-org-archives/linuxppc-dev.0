Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39247688C3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 01:51:40 +1100 (EST)
Date: Fri, 16 Dec 2005 08:47:04 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512160844570.30115-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel.Belz@cyclades.com, Edson.Seabra@cyclades.com,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] powerpc: CPM2 interrupt handler failure after 100,000
 interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The CPM2 interrupt handler does not return success to the IRQ subsystem, which
causes it to kill the IRQ line after 100,000 interrupts.

Signed-off-by: Edson Seabra <Edson.Seabra@cyclades.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---

Paul: We should put this in the merge tree for linus to pick up for 
2.6.15.

commit 5f5a24140939b8f908a3cd131edaed6b6cf22174
tree 88efa1b2c4331abcda8858c64b5b971fabe9fc4f
parent b7d20dabe1f83f44d24d06121e10210b2a7e3ef8
author Kumar Gala <galak@kernel.crashing.org> Fri, 16 Dec 2005 08:47:28 -0600
committer Kumar Gala <galak@kernel.crashing.org> Fri, 16 Dec 2005 08:47:28 -0600

 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
index d8991b8..5bfe688 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -130,10 +130,11 @@ mpc85xx_cds_show_cpuinfo(struct seq_file
 }
 
 #ifdef CONFIG_CPM2
-static void cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+static int cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
 {
 	while((irq = cpm2_get_irq(regs)) >= 0)
 		__do_IRQ(irq, regs);
+	return IRQ_HANDLED;
 }
 
 static struct irqaction cpm2_irqaction = {
