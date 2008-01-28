Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9E85DDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 02:22:31 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0SFMQam015752
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 09:22:27 -0600
Date: Mon, 28 Jan 2008 09:20:00 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 86xx: Remove unused IRQ defines
Message-ID: <Pine.LNX.4.64.0801280919410.22627@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

86xx uses the flat device tree for all its needs so we dont need explicit
IRQ info. Its not clear why this code existed since 86xx never existed in
arch/ppc.

---
 include/asm-powerpc/irq.h |   86 ---------------------------------------------
 1 files changed, 0 insertions(+), 86 deletions(-)

diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 0efe7b2..b5c0312 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -483,92 +483,6 @@ static __inline__ int irq_canonicalize(int irq)
  */
 #define	mk_int_int_mask(IL) (1 << (7 - (IL/2)))

-#elif defined(CONFIG_PPC_86xx)
-#include <asm/mpc86xx.h>
-
-#define NR_EPIC_INTS 48
-#ifndef NR_8259_INTS
-#define NR_8259_INTS 16 /*ULI 1575 can route 12 interrupts */
-#endif
-#define NUM_8259_INTERRUPTS NR_8259_INTS
-
-#ifndef I8259_OFFSET
-#define I8259_OFFSET 0
-#endif
-
-#define NR_IRQS 256
-
-/* Internal IRQs on MPC86xx OpenPIC */
-
-#ifndef MPC86xx_OPENPIC_IRQ_OFFSET
-#define MPC86xx_OPENPIC_IRQ_OFFSET NR_8259_INTS
-#endif
-
-/* The 48 internal sources */
-#define MPC86xx_IRQ_NULL        ( 0 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_MCM         ( 1 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_DDR         ( 2 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_LBC         ( 3 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_DMA0        ( 4 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_DMA1        ( 5 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_DMA2        ( 6 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_DMA3        ( 7 + MPC86xx_OPENPIC_IRQ_OFFSET)
-
-/* no 10,11 */
-#define MPC86xx_IRQ_UART2       (12 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC1_TX    (13 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC1_RX    (14 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC3_TX    (15 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC3_RX    (16 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC3_ERROR (17 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC1_ERROR (18 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC2_TX    (19 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC2_RX    (20 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC4_TX    (21 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC4_RX    (22 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC4_ERROR (23 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_TSEC2_ERROR (24 + MPC86xx_OPENPIC_IRQ_OFFSET)
-/* no 25 */
-#define MPC86xx_IRQ_UART1       (26 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_IIC         (27 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_PERFMON       (28 + MPC86xx_OPENPIC_IRQ_OFFSET)
-/* no 29,30,31 */
-#define MPC86xx_IRQ_SRIO_ERROR    (32 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_SRIO_OUT_BELL (33 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_SRIO_IN_BELL  (34 + MPC86xx_OPENPIC_IRQ_OFFSET)
-/* no 35,36 */
-#define MPC86xx_IRQ_SRIO_OUT_MSG1 (37 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_SRIO_IN_MSG1  (38 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_SRIO_OUT_MSG2 (39 + MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_SRIO_IN_MSG2  (40 + MPC86xx_OPENPIC_IRQ_OFFSET)
-
-/* The 12 external interrupt lines */
-#define MPC86xx_IRQ_EXT_BASE	48
-#define MPC86xx_IRQ_EXT0	(0 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT1	(1 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT2	(2 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT3	(3 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT4	(4 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT5	(5 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT6	(6 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT7	(7 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT8	(8 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT9	(9 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT10	(10 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-#define MPC86xx_IRQ_EXT11	(11 + MPC86xx_IRQ_EXT_BASE \
-		+ MPC86xx_OPENPIC_IRQ_OFFSET)
-
 #else /* CONFIG_40x + CONFIG_8xx */
 /*
  * this is the # irq's for all ppc arch's (pmac/chrp/prep)
-- 
1.5.3.7
