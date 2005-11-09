Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DD10686DE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 07:35:23 +1100 (EST)
Date: Wed, 9 Nov 2005 14:33:20 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0511091432500.29821-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Add support for handling PCI interrupts on MPC834x
 PCI expansion card
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The MPC8349 PIBs system has a expansion board with 6 PCI slots.  We needed
to update the IDSEL interrupt mapping for it to work properly.  However,
only PCI1 is supported as the first revision of this expansion board doesn't
function properly for PCI2.  For the time being we have zero'd out the entries
for the IDSELs related to PCI2.  When a functioning expansion board exists
we can fix the table.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit b23f8a20b85440d4bebf1a2ddea5830ca85ff655
tree c60902116ecca2880d12d15350fed1e5d780bc79
parent 35003e02e33939b7359635f3cf7b424723ffd4b0
author Kumar Gala <galak@kernel.crashing.org> Wed, 09 Nov 2005 14:33:30 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 09 Nov 2005 14:33:30 -0600

 arch/ppc/platforms/83xx/mpc834x_sys.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
index 98edc75..763777c 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -73,12 +73,19 @@ mpc83xx_map_irq(struct pci_dev *dev, uns
 	     *       A      B      C      D
 	     */
 	{
-		{PIRQA, PIRQB,  PIRQC,  PIRQD}, /* idsel 0x11 */
-		{PIRQC, PIRQD,  PIRQA,  PIRQB}, /* idsel 0x12 */
-		{PIRQD, PIRQA,  PIRQB,  PIRQC}  /* idsel 0x13 */
+		{PIRQA, PIRQB, PIRQC, PIRQD},	/* idsel 0x11 */
+		{PIRQC, PIRQD, PIRQA, PIRQB},	/* idsel 0x12 */
+		{PIRQD, PIRQA, PIRQB, PIRQC},	/* idsel 0x13 */
+		{0, 0, 0, 0},
+		{PIRQA, PIRQB, PIRQC, PIRQD},	/* idsel 0x15 */
+		{PIRQD, PIRQA, PIRQB, PIRQC},	/* idsel 0x16 */
+		{PIRQC, PIRQD, PIRQA, PIRQB},	/* idsel 0x17 */
+		{PIRQB, PIRQC, PIRQD, PIRQA},	/* idsel 0x18 */
+		{0, 0, 0, 0},			/* idsel 0x19 */
+		{0, 0, 0, 0},			/* idsel 0x20 */
 	};
 
-	const long min_idsel = 0x11, max_idsel = 0x13, irqs_per_slot = 4;
+	const long min_idsel = 0x11, max_idsel = 0x20, irqs_per_slot = 4;
 	return PCI_IRQ_TABLE_LOOKUP;
 }
 
