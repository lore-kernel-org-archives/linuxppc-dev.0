Message-ID: <3BB35CD3.6D152CA6@imc-berlin.de>
Date: Thu, 27 Sep 2001 19:07:31 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: structs and defs for IDMA on MPC8xx???
References: <3BB33EBA.DF2DCA44@imc-berlin.de> <3BB353D0.F4AA371D@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------65875D8015396AD350A9DB98"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------65875D8015396AD350A9DB98
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan,

> > are threre any structs for IDMA in the recent kernel sources?
>
> No, they would be in 'commproc.h'.  Again, just use a similar
> method to all of the other device drivers for the CPM.  There
> is a standard BD structure that is part of all devices for
> DMA purposes, and simply add the information needed by IDMA.

Have you ever use IDMA? I think there is a significanct difference
between SDMA and IDMA.
The "standard BD structure" doesn't help much for IDMA, does it?
So it's not that easy. I already had a look at enet.c...

> Don't confuse "parameter ram" and IDMA buffer descriptors.  If
> you notice, the parameter ram is defined as the offset into the
> appropriate pages of the CPM memory.  This information for IDMA
> is not currently defined in 'commproc.h' and you will need to do that.
I don't. Thanks.

> > I know Greg Johnson <gjohnson@research.canon.com.au> proposed some stuff
> > last year. But they never made it into the linuxppc_2_4_devel, did they?
>
> I don't recall anyone sending a patch to do this.  If they did,
> I apologize for missing it and I'll look through the archives to
> find it.
 It was in April last year!


> > /* Buffer descriptors used by IDMA
> > */
> > typedef struct idma_buf_desc {
>
> There you go, the IDMA buffer descriptor.  Why didn't you just
> edit commproc.h to include this, get it working, and send a patch :-)?
I will!
But since I found this message from Greg I thought it's already done.

I'll attach what I have so far. It's basicly the patch sent by Greg. I
am about to check all these defines again.

Cheers,

Steven
--------------65875D8015396AD350A9DB98
Content-Type: text/plain; charset=us-ascii;
 name="commproc.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="commproc.h.diff"

--- commproc.h.greg	Thu Sep 27 17:08:44 2001
+++ commproc.h	Thu Sep 27 17:52:40 2001
@@ -17,6 +17,17 @@
  * bytes of the DP RAM and relocates the I2C parameter area to the
  * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
  * or other use.
+ *
+ * 2000-03-30 - Added some commands to the 'Some commands' section for
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
@@ -37,17 +48,21 @@
 #define CPM_CR_INIT_RX		((ushort)0x0001)
 #define CPM_CR_INIT_TX		((ushort)0x0002)
 #define CPM_CR_HUNT_MODE	((ushort)0x0003)
+#define CPM_CR_IDMA_INIT	((ushort)0x0005)
 #define CPM_CR_STOP_TX		((ushort)0x0004)
 #define CPM_CR_RESTART_TX	((ushort)0x0006)
 #define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_IDMA_STOP	((ushort)0x000b)
 #define CPM_CR_SET_TIMER	CPM_CR_SET_GADDR

 /* Channel numbers.
 */
 #define CPM_CR_CH_SCC1		((ushort)0x0000)
 #define CPM_CR_CH_I2C		((ushort)0x0001)	/* I2C and IDMA1 */
+#define CPM_CR_CH_IDMA1		((ushort)0x0001)	/* I2C and IDMA1 */
 #define CPM_CR_CH_SCC2		((ushort)0x0004)
 #define CPM_CR_CH_SPI		((ushort)0x0005)	/* SPI / IDMA2 / Timers */
+#define CPM_CR_CH_IDMA2		((ushort)0x0005)	/* SPI / IDMA2 / Timers */
 #define CPM_CR_CH_TIMER		CPM_CR_CH_SPI
 #define CPM_CR_CLOSE_RXBD	((ushort)0x0007)
 #define CPM_CR_CH_SCC3		((ushort)0x0008)
@@ -57,6 +72,17 @@

 #define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))

+/* CPM RISC Controller Configuration Register */
+#define CPM_RCCR_TIME		((ushort)0x8000) /* Timer enable */
+#define CPM_RCCR_RES		((ushort)0x4000) /* Reserved */
+#define CPM_RCCR_TIMEP		((ushort)0x3f00) /* Timer period */
+#define CPM_RCCR_DR1M		((ushort)0x0080) /* IDMA request 1 mode */
+#define CPM_RCCR_DR0M		((ushort)0x0040) /* IDMA request 0 mode */
+#define CPM_RCCR_DRQP		((ushort)0x0030) /* IDMA emulation req. pri. */
+#define CPM_RCCR_EIE		((ushort)0x0008) /* External interrupt enable */
+#define CPM_RCCR_SCD		((ushort)0x0004) /* Scheduler config. */
+#define CPM_RCCR_ERAM		((ushort)0x0003) /* Enable RAM microcode */
+
 /* The dual ported RAM is multi-functional.  Some areas can be (and are
  * being) used for microcode.  There is an area that can only be used
  * as data ram for buffer descriptors, which is all we use right now.
@@ -83,18 +109,6 @@
 	uint	cbd_bufaddr;	/* Buffer address in host memory */
 } cbd_t;

-/* Buffer descriptors used by IDMA
-*/
-typedef struct idma_buf_desc {
-	ushort	ibd_sc;		/* Status and Control */
-	unchar	ibd_dfcr;	/* destination function code register, s.20.3.4.1*/
-	unchar	ibd_sfcr;	/* source function code register */
-	uint	ibd_buflen;	/* "number of bytes to transfer" */
-	uint	ibd_srcbuf;	/* "points to the beginning of the source buffer" */
-	uint	ibd_destbuf;	/* "points to the beginning of the destination buffer" */
-} ibd_t;
-
-
 #define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
 #define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
 #define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
@@ -115,8 +129,10 @@
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
@@ -797,7 +813,7 @@
 #define PC_ENET_CLSN	((ushort)0x0040)	/* PC  9 */
 #define PC_ENET_RENA	((ushort)0x0080)	/* PC  8 */

-/*#define PC_ENET_LBK	((ushort)0x0008)	/*???	PC 12 */
+/*#define PC_ENET_LBK	((ushort)0x0008)	???	PC 12 */

 /* Control bits in the SICR to route TCLK (CLK3) and RCLK (CLK1) to
  * SCC1.  Also, make sure GR1 (bit 24) and SC1 (bit 25) are zero.
@@ -997,6 +1013,62 @@
 #define SPMODE_EN	((ushort)0x0100)	/* Enable */
 #define SPMODE_LENMSK	((ushort)0x00f0)	/* character length */
 #define SPMODE_PMMSK	((ushort)0x000f)	/* prescale modulus */
+
+/* IDMA Parameter RAM */
+typedef struct idma_pr
+{
+	uint16_t ipr_ibase;	/* Buff. Desc. base address. */
+	uint16_t ipr_dcmr;	/* DMA Channel Mode Register. */
+	uint32_t ipr_sapr;	/* Internal Use */
+	uint32_t ipr_dapr;	/* Internal Use */
+	uint16_t ipr_ibptr;	/* Internal Use */
+	uint16_t ipr_write_sp;	/* Internal Use */
+	uint32_t ipr_s_byte_c;	/* Internal Use */
+	uint32_t ipr_d_byte_c;	/* Internal Use */
+	uint32_t ipr_s_state;	/* Internal Use */
+	uint32_t ipr_itemp[4];	/* Internal Use */
+	uint32_t ipr_sr_mem;	/* Internal Use */
+	uint16_t ipr_read_sp;	/* Internal Use */
+	uint16_t ipr_undef_0;	/* Internal Use */
+	uint16_t ipr_undef_1;	/* Internal Use */
+	uint16_t ipr_undef_2;	/* Internal Use */
+	uint32_t ipr_d_state;	/* Internal Use */
+} idma_pr_t;
+
+/* IDMA Parameter RAM DCMR Register */
+#define IPR_DCMR_RESERVED	((ushort)0xffe0)
+#define IPR_DCMR_SIZE		((ushort)0x0018) /* Peripheral port size */
+#define IPR_DCMR_SD		((ushort)0x0006) /* Src/Dest Mem/Peripheral */
+#define IPR_DCMR_SINGLE		((ushort)0x0001) /* Single/dual cycle */
+
+/* IDMA Buffer Descriptor. */
+typedef struct idma_buf_desc {
+	uint16_t ibd_sc;	/* Status and Control */
+	uint8_t  ibd_dfcr;	/* Dest. Function Code Reg. */
+	uint8_t  ibd_sfcr;	/* Src. Function Code Reg. */
+	uint32_t ibd_length;	/* Number of bytes to transfer. */
+	uint32_t ibd_source;	/* Source Buffer address. */
+	uint32_t ibd_dest;	/* Destination Buffer address. */
+} idma_bd_t;
+
+/* IDMA Buff. Desc. Status and Control Register. */
+#define IBD_STCT_VALID	((ushort)0x8000) /* Ready for processing. */
+#define IBD_STCT_RES1	((ushort)0x4000) /* Reserved */
+#define IBD_STCT_WRAP	((ushort)0x2000) /* Last entry in table. */
+#define IBD_STCT_INTR	((ushort)0x1000) /* Interrupt enable. */
+#define IBD_STCT_LAST	((ushort)0x0800) /* Last. End of buffer chain. */
+#define IBD_STCT_RES2	((ushort)0x0400) /* Reserved */
+#define IBD_STCT_CONT	((ushort)0x0200) /* Continuous mode */
+#define IBD_STCT_RES3	((ushort)0x01ff) /* Reserved */
+
+/* IDMA Buff. Desc. Function Code Register. */
+#define IBD_FCR_RES	((unsigned char)0xe0) /* Reserved */
+#define IBD_FCR_BO	((unsigned char)0x18) /* Byte order */
+#define IBD_FCR_AT	((unsigned char)0x07) /* Addr. Type bits [1-3] */
+
+/* IDMA BD FCR Byte Order */
+#define IBD_FCR_PPCLE	((unsigned char)0x08) /* PowerPC Little endian */
+#define IBD_FCR_BETLE	((unsigned char)0x10) /* Big/True_Little endian */

 /* CPM interrupts.  There are nearly 32 interrupts generated by CPM
  * channels or devices.  All of these are presented to the PPC core

--------------65875D8015396AD350A9DB98--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
