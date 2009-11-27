Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr5.xs4all.nl (smtp-vbr5.xs4all.nl [194.109.24.25])
	by ozlabs.org (Postfix) with ESMTP id C6097B6F1A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 21:11:32 +1100 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id nARA2fiw026845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 11:02:41 +0100 (CET)
	(envelope-from nvbolhuis@aimvalley.nl)
Date: Fri, 27 Nov 2009 11:02:40 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Message-Id: <200911271002.nARA2ekI017140@linpc062.aimsys.nl>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ipic: support external edge triggered IRQ0
Cc: nvbolhuis@aimvalley.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Currently an external edge triggered IRQ0 gives 2 problems.
It gives a sense error ("edge sense not supported on internal interrupts")
and it isn't acked.
This patch takes into account IRQ0 can be internal or external and fixes
both issues.

Signed-off-by: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
---
 arch/powerpc/sysdev/ipic.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index cb7689c..3201db1 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -316,6 +316,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[48] = {
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -619,7 +620,9 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 		return -EINVAL;
 	}
 	/* ipic supports only edge mode on external interrupts */
-	if ((flow_type & IRQ_TYPE_EDGE_FALLING) && !ipic_info[src].ack) {
+	if ((flow_type & IRQ_TYPE_EDGE_FALLING) &&
+	    ((src != IPIC_IRQ_EXT0 && !ipic_info[src].ack) ||
+	     (src == IPIC_IRQ_EXT0 && (ipic_read(ipic->regs, IPIC_SEMSR) & SEMSR_SIRQ0)))) {
 		printk(KERN_ERR "ipic: edge sense not supported on internal "
 				"interrupts\n");
 		return -EINVAL;
-- 
1.5.2.2
