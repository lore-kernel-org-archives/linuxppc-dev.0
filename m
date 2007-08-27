Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0ECD1DE16E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 00:48:58 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7REmsMm032013
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 09:48:54 -0500
Date: Mon, 27 Aug 2007 09:49:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: RFC: [PATCH] Copy over headers from arch/powerpc to arch/ppc to
	decouple them
Message-ID: <Pine.LNX.4.64.0708270945580.11455@blarg.am.freescale.net>
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

Move over includes files that have CONFIG_PPC_MERGE in them to decouple
to interdepencies between ARCH=powerpc & ARCH=ppc.

Duplicate the following headers in both locations and remove CONFIG_PPC_MERGE:

<asm/dcr.h>
<asm/i8259.h>
<asm/ipic.h>
<asm/irq.h>

---

Not sure what people think about this since removing include asm-powerpc
from ARCH=ppc builds will require a bunch of other copies beyond these
which had a CONFIG_PPC_MERGE in them.

 arch/powerpc/sysdev/dcr.c    |    2 +
 include/asm-powerpc/dcr.h    |    7 -
 include/asm-powerpc/i8259.h  |    5 -
 include/asm-powerpc/ipic.h   |    8 -
 include/asm-powerpc/irq.h    |  500 --------------------------------------
 include/asm-ppc/dcr-native.h |   72 ++++++
 include/asm-ppc/dcr.h        |   31 +++
 include/asm-ppc/i8259.h      |   11 +
 include/asm-ppc/ipic.h       |   85 +++++++
 include/asm-ppc/irq.h        |  549 ++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 750 insertions(+), 520 deletions(-)
 create mode 100644 include/asm-ppc/dcr-native.h
 create mode 100644 include/asm-ppc/dcr.h
 create mode 100644 include/asm-ppc/i8259.h
 create mode 100644 include/asm-ppc/ipic.h
 create mode 100644 include/asm-ppc/irq.h

Removed new file creation (since they duplicate the include/asm-powerpc
version, with CONFIG_PPC_MERGE folded out).

diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index e82d54d..c61557c 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -23,6 +23,7 @@
 #include <asm/prom.h>
 #include <asm/dcr.h>

+#ifdef CONFIG_PPC_MERGE
 unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
 {
 	unsigned int ds;
@@ -46,6 +47,7 @@ unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
 	return dr[index * 2 + 1];
 }
 EXPORT_SYMBOL_GPL(dcr_resource_len);
+#endif

 #ifndef CONFIG_PPC_DCR_NATIVE

diff --git a/include/asm-powerpc/dcr.h b/include/asm-powerpc/dcr.h
index 9338d50..2565674 100644
--- a/include/asm-powerpc/dcr.h
+++ b/include/asm-powerpc/dcr.h
@@ -28,18 +28,11 @@
 #include <asm/dcr-mmio.h>
 #endif

-/*
- * On CONFIG_PPC_MERGE, we have additional helpers to read the DCR
- * base from the device-tree
- */
-#ifdef CONFIG_PPC_MERGE
 struct device_node;
 extern unsigned int dcr_resource_start(struct device_node *np,
 				       unsigned int index);
 extern unsigned int dcr_resource_len(struct device_node *np,
 				     unsigned int index);
-#endif /* CONFIG_PPC_MERGE */
-
 #endif /* CONFIG_PPC_DCR */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_H */
diff --git a/include/asm-powerpc/i8259.h b/include/asm-powerpc/i8259.h
index db1362f..105ade2 100644
--- a/include/asm-powerpc/i8259.h
+++ b/include/asm-powerpc/i8259.h
@@ -4,14 +4,9 @@

 #include <linux/irq.h>

-#ifdef CONFIG_PPC_MERGE
 extern void i8259_init(struct device_node *node, unsigned long intack_addr);
 extern unsigned int i8259_irq(void);
 extern struct irq_host *i8259_get_host(void);
-#else
-extern void i8259_init(unsigned long intack_addr, int offset);
-extern int i8259_irq(void);
-#endif

 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_I8259_H */
diff --git a/include/asm-powerpc/ipic.h b/include/asm-powerpc/ipic.h
index edec79d..263aeec 100644
--- a/include/asm-powerpc/ipic.h
+++ b/include/asm-powerpc/ipic.h
@@ -76,16 +76,8 @@ extern void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq);
 extern void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq);
 extern u32 ipic_get_mcp_status(void);
 extern void ipic_clear_mcp_status(u32 mask);
-
-#ifdef CONFIG_PPC_MERGE
 extern struct ipic * ipic_init(struct device_node *node, unsigned int flags);
 extern unsigned int ipic_get_irq(void);
-#else
-extern void ipic_init(phys_addr_t phys_addr, unsigned int flags,
-		unsigned int irq_offset,
-		unsigned char *senses, unsigned int senses_count);
-extern int ipic_get_irq(void);
-#endif

 #endif /* __ASM_IPIC_H__ */
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 0485c53..1c16e47 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -25,8 +25,6 @@

 extern atomic_t ppc_n_lost_interrupts;

-#ifdef CONFIG_PPC_MERGE
-
 /* This number is used when no interrupt has been assigned */
 #define NO_IRQ			(0)

@@ -322,504 +320,6 @@ static __inline__ int irq_canonicalize(int irq)
 	return irq;
 }

-
-#else /* CONFIG_PPC_MERGE */
-
-/* This number is used when no interrupt has been assigned */
-#define NO_IRQ			(-1)
-#define NO_IRQ_IGNORE		(-2)
-
-
-/*
- * These constants are used for passing information about interrupt
- * signal polarity and level/edge sensing to the low-level PIC chip
- * drivers.
- */
-#define IRQ_SENSE_MASK		0x1
-#define IRQ_SENSE_LEVEL		0x1	/* interrupt on active level */
-#define IRQ_SENSE_EDGE		0x0	/* interrupt triggered by edge */
-
-#define IRQ_POLARITY_MASK	0x2
-#define IRQ_POLARITY_POSITIVE	0x2	/* high level or low->high edge */
-#define IRQ_POLARITY_NEGATIVE	0x0	/* low level or high->low edge */
-
-
-#if defined(CONFIG_40x)
-#include <asm/ibm4xx.h>
-
-#ifndef NR_BOARD_IRQS
-#define NR_BOARD_IRQS 0
-#endif
-
-#ifndef UIC_WIDTH /* Number of interrupts per device */
-#define UIC_WIDTH 32
-#endif
-
-#ifndef NR_UICS /* number  of UIC devices */
-#define NR_UICS 1
-#endif
-
-#if defined (CONFIG_403)
-/*
- * The PowerPC 403 cores' Asynchronous Interrupt Controller (AIC) has
- * 32 possible interrupts, a majority of which are not implemented on
- * all cores. There are six configurable, external interrupt pins and
- * there are eight internal interrupts for the on-chip serial port
- * (SPU), DMA controller, and JTAG controller.
- *
- */
-
-#define	NR_AIC_IRQS 32
-#define	NR_IRQS	 (NR_AIC_IRQS + NR_BOARD_IRQS)
-
-#elif !defined (CONFIG_403)
-
-/*
- *  The PowerPC 405 cores' Universal Interrupt Controller (UIC) has 32
- * possible interrupts as well. There are seven, configurable external
- * interrupt pins and there are 17 internal interrupts for the on-chip
- * serial port, DMA controller, on-chip Ethernet controller, PCI, etc.
- *
- */
-
-
-#define NR_UIC_IRQS UIC_WIDTH
-#define NR_IRQS		((NR_UIC_IRQS * NR_UICS) + NR_BOARD_IRQS)
-#endif
-
-#elif defined(CONFIG_44x)
-#include <asm/ibm44x.h>
-
-#define	NR_UIC_IRQS	32
-#define	NR_IRQS		((NR_UIC_IRQS * NR_UICS) + NR_BOARD_IRQS)
-
-#elif defined(CONFIG_8xx)
-
-/* Now include the board configuration specific associations.
-*/
-#include <asm/mpc8xx.h>
-
-/* The MPC8xx cores have 16 possible interrupts.  There are eight
- * possible level sensitive interrupts assigned and generated internally
- * from such devices as CPM, PCMCIA, RTC, PIT, TimeBase and Decrementer.
- * There are eight external interrupts (IRQs) that can be configured
- * as either level or edge sensitive.
- *
- * On some implementations, there is also the possibility of an 8259
- * through the PCI and PCI-ISA bridges.
- *
- * We are "flattening" the interrupt vectors of the cascaded CPM
- * and 8259 interrupt controllers so that we can uniquely identify
- * any interrupt source with a single integer.
- */
-#define NR_SIU_INTS	16
-#define NR_CPM_INTS	32
-#ifndef NR_8259_INTS
-#define NR_8259_INTS 0
-#endif
-
-#define SIU_IRQ_OFFSET		0
-#define CPM_IRQ_OFFSET		(SIU_IRQ_OFFSET + NR_SIU_INTS)
-#define I8259_IRQ_OFFSET	(CPM_IRQ_OFFSET + NR_CPM_INTS)
-
-#define NR_IRQS	(NR_SIU_INTS + NR_CPM_INTS + NR_8259_INTS)
-
-/* These values must be zero-based and map 1:1 with the SIU configuration.
- * They are used throughout the 8xx I/O subsystem to generate
- * interrupt masks, flags, and other control patterns.  This is why the
- * current kernel assumption of the 8259 as the base controller is such
- * a pain in the butt.
- */
-#define	SIU_IRQ0	(0)	/* Highest priority */
-#define	SIU_LEVEL0	(1)
-#define	SIU_IRQ1	(2)
-#define	SIU_LEVEL1	(3)
-#define	SIU_IRQ2	(4)
-#define	SIU_LEVEL2	(5)
-#define	SIU_IRQ3	(6)
-#define	SIU_LEVEL3	(7)
-#define	SIU_IRQ4	(8)
-#define	SIU_LEVEL4	(9)
-#define	SIU_IRQ5	(10)
-#define	SIU_LEVEL5	(11)
-#define	SIU_IRQ6	(12)
-#define	SIU_LEVEL6	(13)
-#define	SIU_IRQ7	(14)
-#define	SIU_LEVEL7	(15)
-
-#define MPC8xx_INT_FEC1		SIU_LEVEL1
-#define MPC8xx_INT_FEC2		SIU_LEVEL3
-
-#define MPC8xx_INT_SCC1		(CPM_IRQ_OFFSET + CPMVEC_SCC1)
-#define MPC8xx_INT_SCC2		(CPM_IRQ_OFFSET + CPMVEC_SCC2)
-#define MPC8xx_INT_SCC3		(CPM_IRQ_OFFSET + CPMVEC_SCC3)
-#define MPC8xx_INT_SCC4		(CPM_IRQ_OFFSET + CPMVEC_SCC4)
-#define MPC8xx_INT_SMC1		(CPM_IRQ_OFFSET + CPMVEC_SMC1)
-#define MPC8xx_INT_SMC2		(CPM_IRQ_OFFSET + CPMVEC_SMC2)
-
-/* The internal interrupts we can configure as we see fit.
- * My personal preference is CPM at level 2, which puts it above the
- * MBX PCI/ISA/IDE interrupts.
- */
-#ifndef PIT_INTERRUPT
-#define PIT_INTERRUPT		SIU_LEVEL0
-#endif
-#ifndef	CPM_INTERRUPT
-#define CPM_INTERRUPT		SIU_LEVEL2
-#endif
-#ifndef	PCMCIA_INTERRUPT
-#define PCMCIA_INTERRUPT	SIU_LEVEL6
-#endif
-#ifndef	DEC_INTERRUPT
-#define DEC_INTERRUPT		SIU_LEVEL7
-#endif
-
-/* Some internal interrupt registers use an 8-bit mask for the interrupt
- * level instead of a number.
- */
-#define	mk_int_int_mask(IL) (1 << (7 - (IL/2)))
-
-#elif defined(CONFIG_83xx)
-#include <asm/mpc83xx.h>
-
-#define	NR_IRQS	(NR_IPIC_INTS)
-
-#elif defined(CONFIG_85xx)
-/* Now include the board configuration specific associations.
-*/
-#include <asm/mpc85xx.h>
-
-/* The MPC8548 openpic has 48 internal interrupts and 12 external
- * interrupts.
- *
- * We are "flattening" the interrupt vectors of the cascaded CPM
- * so that we can uniquely identify any interrupt source with a
- * single integer.
- */
-#define NR_CPM_INTS	64
-#define NR_EPIC_INTS	60
-#ifndef NR_8259_INTS
-#define NR_8259_INTS	0
-#endif
-#define NUM_8259_INTERRUPTS NR_8259_INTS
-
-#ifndef CPM_IRQ_OFFSET
-#define CPM_IRQ_OFFSET	0
-#endif
-
-#define NR_IRQS	(NR_EPIC_INTS + NR_CPM_INTS + NR_8259_INTS)
-
-/* Internal IRQs on MPC85xx OpenPIC */
-
-#ifndef MPC85xx_OPENPIC_IRQ_OFFSET
-#ifdef CONFIG_CPM2
-#define MPC85xx_OPENPIC_IRQ_OFFSET	(CPM_IRQ_OFFSET + NR_CPM_INTS)
-#else
-#define MPC85xx_OPENPIC_IRQ_OFFSET	0
-#endif
-#endif
-
-/* Not all of these exist on all MPC85xx implementations */
-#define MPC85xx_IRQ_L2CACHE	( 0 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_ECM		( 1 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DDR		( 2 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_LBIU	( 3 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA0	( 4 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA1	( 5 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA2	( 6 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA3	( 7 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PCI1	( 8 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PCI2	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_ERROR	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_BELL	(10 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_TX	(11 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_RX	(12 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_TX	(13 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_RX	(14 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC3_TX	(15 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC3_RX	(16 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC3_ERROR	(17 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_ERROR	(18 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_TX	(19 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_RX	(20 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC4_TX	(21 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC4_RX	(22 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC4_ERROR	(23 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_ERROR	(24 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_FEC		(25 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DUART	(26 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_IIC1	(27 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PERFMON	(28 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_SEC2	(29 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_CPM		(30 + MPC85xx_OPENPIC_IRQ_OFFSET)
-
-/* The 12 external interrupt lines */
-#define MPC85xx_IRQ_EXT0        (48 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT1        (49 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT2        (50 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT3        (51 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT4        (52 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT5        (53 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT6        (54 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT7        (55 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT8        (56 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT9        (57 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT10       (58 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT11       (59 + MPC85xx_OPENPIC_IRQ_OFFSET)
-
-/* CPM related interrupts */
-#define	SIU_INT_ERROR		((uint)0x00+CPM_IRQ_OFFSET)
-#define	SIU_INT_I2C		((uint)0x01+CPM_IRQ_OFFSET)
-#define	SIU_INT_SPI		((uint)0x02+CPM_IRQ_OFFSET)
-#define	SIU_INT_RISC		((uint)0x03+CPM_IRQ_OFFSET)
-#define	SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
-#define	SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
-#define	SIU_INT_USB		((uint)0x0b+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER1		((uint)0x0c+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER2		((uint)0x0d+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER3		((uint)0x0e+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER4		((uint)0x0f+CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC1		((uint)0x20+CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC2		((uint)0x21+CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC3		((uint)0x22+CPM_IRQ_OFFSET)
-#define	SIU_INT_MCC1		((uint)0x24+CPM_IRQ_OFFSET)
-#define	SIU_INT_MCC2		((uint)0x25+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC15		((uint)0x30+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC14		((uint)0x31+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC13		((uint)0x32+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC12		((uint)0x33+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC11		((uint)0x34+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC10		((uint)0x35+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC9		((uint)0x36+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC8		((uint)0x37+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC7		((uint)0x38+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC6		((uint)0x39+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC5		((uint)0x3a+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC4		((uint)0x3b+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC3		((uint)0x3c+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC2		((uint)0x3d+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC1		((uint)0x3e+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC0		((uint)0x3f+CPM_IRQ_OFFSET)
-
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
-#else /* CONFIG_40x + CONFIG_8xx */
-/*
- * this is the # irq's for all ppc arch's (pmac/chrp/prep)
- * so it is the max of them all
- */
-#define NR_IRQS			256
-#define __DO_IRQ_CANON	1
-
-#ifndef CONFIG_8260
-
-#define NUM_8259_INTERRUPTS	16
-
-#else /* CONFIG_8260 */
-
-/* The 8260 has an internal interrupt controller with a maximum of
- * 64 IRQs.  We will use NR_IRQs from above since it is large enough.
- * Don't be confused by the 8260 documentation where they list an
- * "interrupt number" and "interrupt vector".  We are only interested
- * in the interrupt vector.  There are "reserved" holes where the
- * vector number increases, but the interrupt number in the table does not.
- * (Document errata updates have fixed this...make sure you have up to
- * date processor documentation -- Dan).
- */
-
-#ifndef CPM_IRQ_OFFSET
-#define CPM_IRQ_OFFSET	0
-#endif
-
-#define NR_CPM_INTS	64
-
-#define	SIU_INT_ERROR		((uint)0x00 + CPM_IRQ_OFFSET)
-#define	SIU_INT_I2C		((uint)0x01 + CPM_IRQ_OFFSET)
-#define	SIU_INT_SPI		((uint)0x02 + CPM_IRQ_OFFSET)
-#define	SIU_INT_RISC		((uint)0x03 + CPM_IRQ_OFFSET)
-#define	SIU_INT_SMC1		((uint)0x04 + CPM_IRQ_OFFSET)
-#define	SIU_INT_SMC2		((uint)0x05 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IDMA1		((uint)0x06 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IDMA2		((uint)0x07 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IDMA3		((uint)0x08 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IDMA4		((uint)0x09 + CPM_IRQ_OFFSET)
-#define	SIU_INT_SDMA		((uint)0x0a + CPM_IRQ_OFFSET)
-#define	SIU_INT_USB		((uint)0x0b + CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER1		((uint)0x0c + CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER2		((uint)0x0d + CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER3		((uint)0x0e + CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER4		((uint)0x0f + CPM_IRQ_OFFSET)
-#define	SIU_INT_TMCNT		((uint)0x10 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PIT		((uint)0x11 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PCI		((uint)0x12 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IRQ1		((uint)0x13 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IRQ2		((uint)0x14 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IRQ3		((uint)0x15 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IRQ4		((uint)0x16 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IRQ5		((uint)0x17 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IRQ6		((uint)0x18 + CPM_IRQ_OFFSET)
-#define	SIU_INT_IRQ7		((uint)0x19 + CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC1		((uint)0x20 + CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC2		((uint)0x21 + CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC3		((uint)0x22 + CPM_IRQ_OFFSET)
-#define	SIU_INT_MCC1		((uint)0x24 + CPM_IRQ_OFFSET)
-#define	SIU_INT_MCC2		((uint)0x25 + CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC1		((uint)0x28 + CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC2		((uint)0x29 + CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC3		((uint)0x2a + CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC4		((uint)0x2b + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC15		((uint)0x30 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC14		((uint)0x31 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC13		((uint)0x32 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC12		((uint)0x33 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC11		((uint)0x34 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC10		((uint)0x35 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC9		((uint)0x36 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC8		((uint)0x37 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC7		((uint)0x38 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC6		((uint)0x39 + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC5		((uint)0x3a + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC4		((uint)0x3b + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC3		((uint)0x3c + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC2		((uint)0x3d + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC1		((uint)0x3e + CPM_IRQ_OFFSET)
-#define	SIU_INT_PC0		((uint)0x3f + CPM_IRQ_OFFSET)
-
-#endif /* CONFIG_8260 */
-
-#endif /* Whatever way too big #ifdef */
-
-#define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
-/* pedantic: these are long because they are used with set_bit --RR */
-extern unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
-
-/*
- * Because many systems have two overlapping names spaces for
- * interrupts (ISA and XICS for example), and the ISA interrupts
- * have historically not been easy to renumber, we allow ISA
- * interrupts to take values 0 - 15, and shift up the remaining
- * interrupts by 0x10.
- */
-#define NUM_ISA_INTERRUPTS	0x10
-extern int __irq_offset_value;
-
-static inline int irq_offset_up(int irq)
-{
-	return(irq + __irq_offset_value);
-}
-
-static inline int irq_offset_down(int irq)
-{
-	return(irq - __irq_offset_value);
-}
-
-static inline int irq_offset_value(void)
-{
-	return __irq_offset_value;
-}
-
-#ifdef __DO_IRQ_CANON
-extern int ppc_do_canonicalize_irqs;
-#else
-#define ppc_do_canonicalize_irqs	0
-#endif
-
-static __inline__ int irq_canonicalize(int irq)
-{
-	if (ppc_do_canonicalize_irqs && irq == 2)
-		irq = 9;
-	return irq;
-}
-#endif /* CONFIG_PPC_MERGE */
-
 extern int distribute_irqs;

 struct irqaction;
-- 
1.5.2.4
