Subject: Structs and Defs for IDMA
To: linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Date: Tue, 11 Apr 2000 11:47:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000411014728.3A5061B516@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here be a patch to commproc.h. It has structures and other definitions
that are needed in order to implement IDMA transfers. I have not been
able to make use of this myself yet, so use with caution. It does compile
into the kernel ok.

Greg.

--

Index: arch/ppc/8xx_io/commproc.h
===================================================================
retrieving revision 1.3
retrieving revision 1.4
diff -u -r1.3 -r1.4
--- arch/ppc/8xx_io/commproc.h	2000/04/04 08:43:42	1.3
+++ arch/ppc/8xx_io/commproc.h	2000/04/06 01:02:33	1.4
@@ -14,6 +14,17 @@
  * bytes of the DP RAM and relocates the I2C parameter area to the
  * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
  * or other use.
+ *
+ * 2000-03-30	- Added some commands to the 'Some commands' section for
+ * support of IDMA. Replicated some channel numbers for use as IDMA
+ * channel numbers. Added bit masks for the RISC Controller Configuration
+ * Register. Added structure definitions for IDMA parameter RAM and
+ * IDMA buffer descriptors. Added bit field descriptions for IDMA
+ * buffer descriptor status and control register and function code
+ * registers.
+ *
+ * -- Greg (gjohnson@research.canon.com.au)
+ *
  */
 #ifndef __CPM_8XX__
 #define __CPM_8XX__
@@ -33,16 +44,20 @@
 #define CPM_CR_INIT_RX		((ushort)0x0001)
 #define CPM_CR_INIT_TX		((ushort)0x0002)
 #define CPM_CR_HUNT_MODE	((ushort)0x0003)
+#define CPM_CR_IDMA_INIT	((ushort)0x0005)
 #define CPM_CR_STOP_TX		((ushort)0x0004)
 #define CPM_CR_RESTART_TX	((ushort)0x0006)
 #define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_IDMA_STOP	((ushort)0x000b)

 /* Channel numbers.
 */
 #define CPM_CR_CH_SCC1	((ushort)0x0000)
 #define CPM_CR_CH_I2C	((ushort)0x0001)	/* I2C and IDMA1 */
+#define CPM_CR_CH_IDMA1	((ushort)0x0001)	/* I2C and IDMA1 */
 #define CPM_CR_CH_SCC2	((ushort)0x0004)
 #define CPM_CR_CH_SPI	((ushort)0x0005)	/* SPI / IDMA2 / Timers */
+#define CPM_CR_CH_IDMA2	((ushort)0x0005)	/* SPI / IDMA2 / Timers */
 #define CPM_CR_CH_SCC3	((ushort)0x0008)
 #define CPM_CR_CH_SMC1	((ushort)0x0009)	/* SMC1 / DSP1 */
 #define CPM_CR_CH_SCC4	((ushort)0x000c)
@@ -50,6 +65,17 @@

 #define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))

+/* CPM RISC Controller Configuration Register */
+#define CPM_RCCR_TIME	((ushort)0x8000)	/* Timer enable */
+#define CPM_RCCR_RES	((ushort)0x4000)	/* Reserved */
+#define CPM_RCCR_TIMEP	((ushort)0x3f00)	/* Timer period */
+#define CPM_RCCR_DR1M	((ushort)0x0080)	/* IDMA request 1 mode */
+#define CPM_RCCR_DR0M	((ushort)0x0040)	/* IDMA request 0 mode */
+#define CPM_RCCR_DRQP	((ushort)0x0030)	/* IDMA emulation req. pri. */
+#define CPM_RCCR_EIE 	((ushort)0x0008)	/* External interrupt enable */
+#define CPM_RCCR_SCD	((ushort)0x0004)	/* Scheduler config. */
+#define CPM_RCCR_ERAM	((ushort)0x0003)	/* Enable RAM microcode */
+
 /* The dual ported RAM is multi-functional.  Some areas can be (and are
  * being) used for microcode.  There is an area that can only be used
  * as data ram for buffer descriptors, which is all we use right now.
@@ -94,8 +120,10 @@
 */
 #define PROFF_SCC1	((uint)0x0000)
 #define PROFF_IIC	((uint)0x0080)
+#define PROFF_IDMA1	((uint)0x00c0)
 #define PROFF_SCC2	((uint)0x0100)
 #define PROFF_SPI	((uint)0x0180)
+#define PROFF_IDMA2	((uint)0x01c0)
 #define PROFF_SCC3	((uint)0x0200)
 #define PROFF_SMC1	((uint)0x0280)
 #define PROFF_SCC4	((uint)0x0300)
@@ -665,6 +693,63 @@
 #define SPMODE_EN	((ushort)0x0100)	/* Enable */
 #define SPMODE_LENMSK	((ushort)0x00f0)	/* character length */
 #define SPMODE_PMMSK	((ushort)0x000f)	/* prescale modulus */
+
+/* IDMA Parameter RAM */
+typedef struct idma_pr
+{
+    uint16_t	ipr_ibase;	/* Buff. Desc. base address. */
+    uint16_t	ipr_dcmr;	/* DMA Channel Mode Register. */
+    uint32_t	ipr_sapr;	/* Internal Use */
+    uint32_t	ipr_dapr;	/* Internal Use */
+    uint16_t	ipr_ibptr;	/* Internal Use */
+    uint16_t	ipr_write_sp;	/* Internal Use */
+    uint32_t	ipr_s_byte_c;	/* Internal Use */
+    uint32_t	ipr_d_byte_c;	/* Internal Use */
+    uint32_t	ipr_s_state;	/* Internal Use */
+    uint32_t	ipr_itemp[4];	/* Internal Use */
+    uint32_t	ipr_sr_mem;	/* Internal Use */
+    uint16_t	ipr_read_sp;	/* Internal Use */
+    uint16_t	ipr_undef_0;	/* Internal Use */
+    uint16_t	ipr_undef_1;	/* Internal Use */
+    uint16_t	ipr_undef_2;	/* Internal Use */
+    uint32_t	ipr_d_state;	/* Internal Use */
+} idma_pr_t;
+
+/* IDMA Parameter RAM DCMR Register */
+#define IPR_DCMR_RESERVED	((ushort)0xffe0)
+#define IPR_DCMR_SIZE		((ushort)0x0018) /* Peripheral port size */
+#define IPR_DCMR_SD		((ushort)0x0006) /* Src/Dest Mem/Peripheral */
+#define IPR_DCMR_SINGLE		((ushort)0x0001) /* Single/dual cycle */
+
+/* IDMA Buffer Descriptor. */
+typedef struct idma_bd
+{
+    uint16_t	ibd_stat_ctrl;	/* Status Control */
+    uint8_t	ibd_dfcr;	/* Dest. Function Code Reg. */
+    uint8_t	ibd_sfcr;	/* Src. Function Code Reg. */
+    uint32_t	ibd_length;	/* Number of bytes to transfer. */
+    uint32_t	ibd_source;	/* Source Buffer address. */
+    uint32_t	ibd_dest;	/* Destination Buffer address. */
+} idma_bd_t;
+
+/* IDMA Buff. Desc. Status and Control Register. */
+#define IBD_STCT_VALID	((ushort)0x8000)	/* Ready for processing. */
+#define IBD_STCT_RES1	((ushort)0x4000)	/* Reserved */
+#define IBD_STCT_WRAP	((ushort)0x2000)	/* Last entry in table. */
+#define IBD_STCT_INTR	((ushort)0x1000)	/* Interrupt enable. */
+#define IBD_STCT_LAST	((ushort)0x0800)	/* Last. End of buffer chain. */
+#define IBD_STCT_RES2	((ushort)0x0400)	/* Reserved */
+#define IBD_STCT_CONT	((ushort)0x0200)	/* Continuous mode */
+#define IBD_STCT_RES3	((ushort)0x01ff)	/* Reserved */
+
+/* IDMA Buff. Desc. Function Code Register. */
+#define IBD_FCR_RES	((unsigned char)0xe0)	/* Reserved */
+#define IBD_FCR_BO	((unsigned char)0x18)	/* Byte order */
+#define IBD_FCR_AT	((unsigned char)0x07)	/* Addr. Type bits [1-3] */
+
+/* IDMA BD FCR Byte Order */
+#define IBD_FCR_PPCLE	((unsigned char)0x08)	/* PowerPC Little endian */
+#define IBD_FCR_BETLE	((unsigned char)0x10)	/* Big/True_Little endian */

 /* CPM interrupts.  There are nearly 32 interrupts generated by CPM
  * channels or devices.  All of these are presented to the PPC core
--
+----------------------------------------------------+
| Do you want to know more?                          |
| www.geocities --== Greg Johnson ==-- .com/worfsom/ |
| HW/SW Engineer      gjohnson@research.canon.com.au |
| Canon   Information  Systems   Research  Australia |
| 1 Thomas Holt Dr, North Ryde, NSW, 2113, Australia |
|     "I FLEXed my BISON and it went YACC!" - me.    |
+----------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
