To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_4_devel patch: 8xx commproc extensions
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_11411527670"
Date: Fri, 20 Dec 2002 02:00:25 +0100
Message-Id: <20021220010025.07FE3C613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_11411527670
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit


Hi,

this is a patch against linuxppc_2_4_devel BK Changeset 1.1197
(trini@kernel.crashing.org|ChangeSet|20021219180614|11718)


It adds support for SPI and RISC timers to the MPC8xx commproc.h file.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The perversity of nature is nowhere better demonstrated by  the  fact
that,  when  exposed to the same atmosphere, bread becomes hard while
crackers become soft.


--==_Exmh_11411527670
Content-Type: application/x-patch ; name="commproc.patch"
Content-Description: commproc.patch
Content-Disposition: attachment; filename="commproc.patch"

--- /work/bk_2_4_devel-1.1197/include/asm-ppc/commproc.h	2002-12-20 01:32:58.000000000 +0100
+++ linuxppc_2_4_devel/include/asm-ppc/commproc.h	2002-12-20 01:55:08.000000000 +0100
@@ -39,18 +39,21 @@
 #define CPM_CR_HUNT_MODE	((ushort)0x0003)
 #define CPM_CR_STOP_TX		((ushort)0x0004)
 #define CPM_CR_RESTART_TX	((ushort)0x0006)
+#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
 #define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_SET_TIMER	CPM_CR_SET_GADDR

 /* Channel numbers.
 */
-#define CPM_CR_CH_SCC1	((ushort)0x0000)
-#define CPM_CR_CH_I2C	((ushort)0x0001)	/* I2C and IDMA1 */
-#define CPM_CR_CH_SCC2	((ushort)0x0004)
-#define CPM_CR_CH_SPI	((ushort)0x0005)	/* SPI / IDMA2 / Timers */
-#define CPM_CR_CH_SCC3	((ushort)0x0008)
-#define CPM_CR_CH_SMC1	((ushort)0x0009)	/* SMC1 / DSP1 */
-#define CPM_CR_CH_SCC4	((ushort)0x000c)
-#define CPM_CR_CH_SMC2	((ushort)0x000d)	/* SMC2 / DSP2 */
+#define CPM_CR_CH_SCC1		((ushort)0x0000)
+#define CPM_CR_CH_I2C		((ushort)0x0001)	/* I2C and IDMA1 */
+#define CPM_CR_CH_SCC2		((ushort)0x0004)
+#define CPM_CR_CH_SPI		((ushort)0x0005)	/* SPI / IDMA2 / Timers */
+#define CPM_CR_CH_TIMER		CPM_CR_CH_SPI
+#define CPM_CR_CH_SCC3		((ushort)0x0008)
+#define CPM_CR_CH_SMC1		((ushort)0x0009)	/* SMC1 / DSP1 */
+#define CPM_CR_CH_SCC4		((ushort)0x000c)
+#define CPM_CR_CH_SMC2		((ushort)0x000d)	/* SMC2 / DSP2 */

 #define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))

@@ -84,20 +87,25 @@
 #define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
 #define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
 #define BD_SC_LAST	((ushort)0x0800)	/* Last buffer in frame */
+#define BD_SC_TC	((ushort)0x0400)	/* Transmit CRC */
 #define BD_SC_CM	((ushort)0x0200)	/* Continous mode */
 #define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
 #define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
 #define BD_SC_BR	((ushort)0x0020)	/* Break received */
 #define BD_SC_FR	((ushort)0x0010)	/* Framing error */
 #define BD_SC_PR	((ushort)0x0008)	/* Parity error */
+#define BD_SC_NAK	((ushort)0x0004)	/* NAK - did not respond */
 #define BD_SC_OV	((ushort)0x0002)	/* Overrun */
+#define BD_SC_UN	((ushort)0x0002)	/* Underrun */
 #define BD_SC_CD	((ushort)0x0001)	/* ?? */
+#define BD_SC_CL	((ushort)0x0001)	/* Collision */

 /* Parameter RAM offsets.
 */
 #define PROFF_SCC1	((uint)0x0000)
 #define PROFF_IIC	((uint)0x0080)
 #define PROFF_SCC2	((uint)0x0100)
+#define PROFF_SPI	((uint)0x0180)
 #define PROFF_SCC3	((uint)0x0200)
 #define PROFF_SMC1	((uint)0x0280)
 #define PROFF_SCC4	((uint)0x0300)
@@ -212,6 +220,17 @@
 #define CPM_BRG_CD_MASK		((uint)0x00001ffe)
 #define CPM_BRG_DIV16		((uint)0x00000001)

+/* SI Clock Route Register
+*/
+#define SICR_RCLK_SCC1_BRG1	((uint)0x00000000)
+#define SICR_TCLK_SCC1_BRG1	((uint)0x00000000)
+#define SICR_RCLK_SCC2_BRG2	((uint)0x00000800)
+#define SICR_TCLK_SCC2_BRG2	((uint)0x00000100)
+#define SICR_RCLK_SCC3_BRG3	((uint)0x00100000)
+#define SICR_TCLK_SCC3_BRG3	((uint)0x00020000)
+#define SICR_RCLK_SCC4_BRG4	((uint)0x18000000)
+#define SICR_TCLK_SCC4_BRG4	((uint)0x03000000)
+
 /* SCCs.
 */
 #define SCC_GSMRH_IRP		((uint)0x00040000)
@@ -628,6 +647,8 @@
 #define BD_ENET_RX_CR		((ushort)0x0004)
 #define BD_ENET_RX_OV		((ushort)0x0002)
 #define BD_ENET_RX_CL		((ushort)0x0001)
+#define BD_ENET_RX_BC		((ushort)0x0080)	/* DA is Broadcast */
+#define BD_ENET_RX_MC		((ushort)0x0040)	/* DA is Multicast */
 #define BD_ENET_RX_STATS	((ushort)0x013f)	/* All status bits */

 /* Buffer descriptor control/status used by Ethernet transmit.
@@ -736,13 +757,84 @@
 	ushort	iic_tbptr;	/* Internal */
 	ushort	iic_tbc;	/* Internal */
 	uint	iic_txtmp;	/* Internal */
-	uint	iic_res;
+	uint	iic_res;	/* reserved */
 	ushort	iic_rpbase;	/* Relocation pointer */
-	ushort	iic_res2;
-
+	ushort	iic_res2;	/* reserved */
 } iic_t;

 #define BD_IIC_START		((ushort)0x0400)
+
+/* SPI parameter RAM.
+*/
+typedef struct spi {
+	ushort	spi_rbase;	/* Rx Buffer descriptor base address */
+	ushort	spi_tbase;	/* Tx Buffer descriptor base address */
+	u_char	spi_rfcr;	/* Rx function code */
+	u_char	spi_tfcr;	/* Tx function code */
+	ushort	spi_mrblr;	/* Max receive buffer length */
+	uint	spi_rstate;	/* Internal */
+	uint	spi_rdp;	/* Internal */
+	ushort	spi_rbptr;	/* Internal */
+	ushort	spi_rbc;	/* Internal */
+	uint	spi_rxtmp;	/* Internal */
+	uint	spi_tstate;	/* Internal */
+	uint	spi_tdp;	/* Internal */
+	ushort	spi_tbptr;	/* Internal */
+	ushort	spi_tbc;	/* Internal */
+	uint	spi_txtmp;	/* Internal */
+	uint	spi_res;
+	ushort	spi_rpbase;	/* Relocation pointer */
+	ushort	spi_res2;
+} spi_t;
+
+/* SPI Mode register.
+*/
+#define SPMODE_LOOP	((ushort)0x4000)	/* Loopback */
+#define SPMODE_CI	((ushort)0x2000)	/* Clock Invert */
+#define SPMODE_CP	((ushort)0x1000)	/* Clock Phase */
+#define SPMODE_DIV16	((ushort)0x0800)	/* BRG/16 mode */
+#define SPMODE_REV	((ushort)0x0400)	/* Reversed Data */
+#define SPMODE_MSTR	((ushort)0x0200)	/* SPI Master */
+#define SPMODE_EN	((ushort)0x0100)	/* Enable */
+#define SPMODE_LENMSK	((ushort)0x00f0)	/* character length */
+#define SPMODE_LEN4	((ushort)0x0030)	/*  4 bits per char */
+#define SPMODE_LEN8	((ushort)0x0070)	/*  8 bits per char */
+#define SPMODE_LEN16	((ushort)0x00f0)	/* 16 bits per char */
+#define SPMODE_PMMSK	((ushort)0x000f)	/* prescale modulus */
+
+/* SPIE fields */
+#define SPIE_MME	0x20
+#define SPIE_TXE	0x10
+#define SPIE_BSY	0x04
+#define SPIE_TXB	0x02
+#define SPIE_RXB	0x01
+
+/*
+ * RISC Controller Configuration Register definitons
+ */
+#define RCCR_TIME	0x8000			/* RISC Timer Enable		*/
+#define RCCR_TIMEP(t)	(((t) & 0x3F)<<8)	/* RISC Timer Period		*/
+#define RCCR_TIME_MASK	0x00FF			/* not RISC Timer related bits	*/
+
+/* RISC Timer Parameter RAM offset */
+#define PROFF_RTMR	((uint)0x01B0)
+
+typedef struct risc_timer_pram {
+	unsigned short	tm_base;	/* RISC Timer Table Base Address	*/
+	unsigned short	tm_ptr;		/* RISC Timer Table Pointer (internal)	*/
+	unsigned short	r_tmr;		/* RISC Timer Mode Register		*/
+	unsigned short	r_tmv;		/* RISC Timer Valid Register		*/
+	unsigned long	tm_cmd;		/* RISC Timer Command Register		*/
+	unsigned long	tm_cnt;		/* RISC Timer Internal Count		*/
+} rt_pram_t;
+
+/* Bits in RISC Timer Command Register */
+#define TM_CMD_VALID	0x80000000	/* Valid - Enables the timer		*/
+#define TM_CMD_RESTART	0x40000000	/* Restart - for automatic restart	*/
+#define TM_CMD_PWM	0x20000000	/* Run in Pulse Width Modulation Mode	*/
+#define TM_CMD_NUM(n)	(((n)&0xF)<<16)	/* Timer Number				*/
+#define TM_CMD_PERIOD(p) ((p)&0xFFFF)	/* Timer Period				*/
+

 /* CPM interrupts.  There are nearly 32 interrupts generated by CPM
  * channels or devices.  All of these are presented to the PPC core

--==_Exmh_11411527670--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
