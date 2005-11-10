Return-Path: <galak@gate.crashing.org>
Date: Thu, 10 Nov 2005 10:34:33 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0511101034060.17269-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix PQ2 PCI DMA interrupt handling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bit position in the status register corresponding to the
PCI DMA interrupt was incorrect.  Additionally, we did not
have a define for the PCI DMA interrupt.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 6a9fa9805be85c33a177061d6bf4f4c2a95c9c7e
tree 2a72692b7373d2f4d328aee3652ece9d9ff7e750
parent b23f8a20b85440d4bebf1a2ddea5830ca85ff655
author Kumar Gala <galak@kernel.crashing.org> Thu, 10 Nov 2005 10:35:15 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 10 Nov 2005 10:35:15 -0600

 arch/ppc/syslib/cpm2_pic.c |    2 +-
 include/asm-powerpc/irq.h  |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/cpm2_pic.c b/arch/ppc/syslib/cpm2_pic.c
index c867be6..29d95d4 100644
--- a/arch/ppc/syslib/cpm2_pic.c
+++ b/arch/ppc/syslib/cpm2_pic.c
@@ -37,7 +37,7 @@ static	u_char	irq_to_siureg[] = {
 static	u_char	irq_to_siubit[] = {
 	 0, 15, 14, 13, 12, 11, 10,  9,
 	 8,  7,  6,  5,  4,  3,  2,  1,
-	 2,  1, 15, 14, 13, 12, 11, 10,
+	 2,  1,  0, 14, 13, 12, 11, 10,
 	 9,  8,  7,  6,  5,  4,  3,  0,
 	31, 30, 29, 28, 27, 26, 25, 24,
 	23, 22, 21, 20, 19, 18, 17, 16,
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index b3935ea..921bfa9 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -389,6 +389,7 @@ extern u64 ppc64_interrupt_controller;
 #define	SIU_INT_TIMER4		((uint)0x0f + CPM_IRQ_OFFSET)
 #define	SIU_INT_TMCNT		((uint)0x10 + CPM_IRQ_OFFSET)
 #define	SIU_INT_PIT		((uint)0x11 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PCI		((uint)0x12 + CPM_IRQ_OFFSET)
 #define	SIU_INT_IRQ1		((uint)0x13 + CPM_IRQ_OFFSET)
 #define	SIU_INT_IRQ2		((uint)0x14 + CPM_IRQ_OFFSET)
 #define	SIU_INT_IRQ3		((uint)0x15 + CPM_IRQ_OFFSET)
