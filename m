Message-ID: <9CFB9DA5261CD611A29B00508B7890480C4E23C9@ex-deu-munich02.force.de>
From: "Demke, Torsten" <Torsten.Demke@fci.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 2.4 versus 2.6 patches
Date: Mon, 26 Jul 2004 18:48:08 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C47330.546FE420"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C47330.546FE420
Content-Type: text/plain

Hello Robert,

>
> well, the linuxppc-2.5 bk pull from bkbits.net compiles and boots on
> our 8xx board.  although i'm still working on relocating SMC1 to allow
> ethernet on SCC3.  but other than that, sure, it builds and boots.
>
I'm using here a MPC852T with SMC1 and SCC3. Attached is part of an private
patch
against linuxppc-2.5. Its used on our board (CONFIG_SHMC) and there are some
hardcoded
values, but you could try...

/*
* The relocation address must match with the
* port address that is used in the driver table[]!
*   reloc. addr       | table.port
*   (offset in dpmem) | (offset in dparam)
*   0x1FC0            | 0x03C0  <---- hardcoded
*/

Regards,
Torsten


------_=_NextPart_000_01C47330.546FE420
Content-Type: application/octet-stream;
	name="SMC1_SCC3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="SMC1_SCC3.patch"

diff -purN linuxppc-2.6.7-bk1.1248-org/include/asm-ppc/commproc.h =
linuxppc-2.6.7-bk1.1248/include/asm-ppc/commproc.h
--- linuxppc-2.6.7-bk1.1248-org/include/asm-ppc/commproc.h	2004-07-20 =
10:56:22.000000000 +0200
+++ linuxppc-2.6.7-bk1.1248/include/asm-ppc/commproc.h	2004-07-20 =
11:02:21.000000000 +0200
@@ -145,6 +145,8 @@ typedef struct smc_uart {
 	ushort	smc_brkec;	/* rcv'd break condition counter */
 	ushort	smc_brkcr;	/* xmt break count register */
 	ushort	smc_rmask;	/* Temporary bit mask */
+	u_char  smc_res[8];     /* 0x34..0x3b */
+	ushort	smc_rpbase;	/* Relocation pointer */
 } smc_uart_t;
=20
 /* Function code bits.
diff -purN =
linuxppc-2.6.7-bk1.1248-org/drivers/serial/cpm_uart/cpm_uart_core.c =
linuxppc-2.6.7-bk1.1248/drivers/serial/cpm_uart/cpm_uart_core.c
--- linuxppc-2.6.7-bk1.1248-org/drivers/serial/cpm_uart/cpm_uart_core.c	=
2004-07-20 10:57:37.000000000 +0200
+++ linuxppc-2.6.7-bk1.1248/drivers/serial/cpm_uart/cpm_uart_core.c	=
2004-07-20 11:02:21.000000000 +0200
@@ -743,6 +743,15 @@ static void cpm_uart_init_smc(struct uar
 	pinfo->smcup->smc_rbase =3D (u_char *)pinfo->rx_bd_base - DPRAM_BASE;
 	pinfo->smcup->smc_tbase =3D (u_char *)pinfo->tx_bd_base - DPRAM_BASE;
=20
+#if defined (CONFIG_SHMC) && defined (CONFIG_UCODE_PATCH)
+	up->smc_rbptr =3D pinfo->smcup->smc_rbase;
+	up->smc_tbptr =3D pinfo->smcup->smc_tbase;
+	up->smc_rstate =3D 0;
+	up->smc_tstate =3D 0;
+	up->smc_brkcr =3D 1;		/* number of break chars */
+	up->smc_brkec =3D 0;
+#endif
+
 	/* Set up the uart parameters in the
 	 * parameter ram.
 	 */
diff -purN linuxppc-2.6.7-bk1.1248-org/arch/ppc/8xx_io/micropatch.c =
linuxppc-2.6.7-bk1.1248/arch/ppc/8xx_io/micropatch.c
--- linuxppc-2.6.7-bk1.1248-org/arch/ppc/8xx_io/micropatch.c	2004-07-20 =
10:57:49.000000000 +0200
+++ linuxppc-2.6.7-bk1.1248/arch/ppc/8xx_io/micropatch.c	2004-07-20 =
11:02:21.000000000 +0200
@@ -20,9 +20,8 @@
 #include <asm/commproc.h>
=20
 /* Define this to get SMC patches as well.  You need to modify the =
uart
- * driver as well......
+ * driver as well...... */
 #define USE_SMC_PATCH 1
- */
=20
 #ifdef CONFIG_USB_MPC8xx
 #define USE_USB_SOF_PATCH
@@ -638,6 +637,7 @@ cpm_load_patch(volatile immap_t *immr)
 	volatile cpm8xx_t	*commproc;
 	volatile iic_t		*iip;
 	volatile spi_t		*spp;
+	volatile smc_uart_t	*smp;
 	int	i;
=20
 	commproc =3D (cpm8xx_t *)&immr->im_cpm;
@@ -683,7 +683,11 @@ cpm_load_patch(volatile immap_t *immr)
 #if defined(USE_SMC_PATCH) || defined(USE_IIC_PATCH)
=20
 	iip =3D (iic_t *)&commproc->cp_dparam[PROFF_IIC];
+#if defined(USE_SMC_PATCH) /* uses dpmem from 0..0x4FF */
+#define RPBASE 0x0500
+#else
 #define RPBASE 0x0400
+#endif
 	iip->iic_rpbase =3D RPBASE;
=20
 	/* Put SPI above the IIC, also 32-byte aligned.
@@ -707,6 +711,20 @@ cpm_load_patch(volatile immap_t *immr)
 	/* Enable uCode fetches from DPRAM.
 	*/
 	commproc->cp_rccr =3D 3;
+
+	printk("SMC1 uCode patch installed\n");
+
+	/* Put SMC DSP2 area.=20
+	 * The relocation address must match with the=20
+	 * port address that is used in the rs_table[]! =20
+	 *   reloc. addr       | rs_table.port
+	 *   (offset in dpmem) | (offset in dparam)
+	 *   0x1FC0            | 0x03C0 =20
+	*/
+	smp =3D (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
+	smp->smc_rpbase =3D 0x1FC0;
+
+	printk("SMC1 relocated to 0x%x\n", smp->smc_rpbase);
 #endif
=20
 #ifdef USE_IIC_PATCH
diff -purN =
linuxppc-2.6.7-bk1.1248-org/drivers/serial/cpm_uart/cpm_uart_cpm1.c =
linuxppc-2.6.7-bk1.1248/drivers/serial/cpm_uart/cpm_uart_cpm1.c
--- linuxppc-2.6.7-bk1.1248-org/drivers/serial/cpm_uart/cpm_uart_cpm1.c	=
2004-07-20 10:56:09.000000000 +0200
+++ linuxppc-2.6.7-bk1.1248/drivers/serial/cpm_uart/cpm_uart_cpm1.c	=
2004-07-20 11:02:21.000000000 +0200
@@ -196,6 +196,10 @@ int cpm_uart_init_portdesc(void)
 	cpm_uart_ports[UART_SMC1].smcp =3D &cpmp->cp_smc[0];
 	cpm_uart_ports[UART_SMC1].smcup =3D
 	    (smc_uart_t *) & cpmp->cp_dparam[PROFF_SMC1];
+#if defined (CONFIG_SHMC) && defined (CONFIG_UCODE_PATCH)
+	cpm_uart_ports[UART_SMC1].smcup =3D
+	    (smc_uart_t *) & cpmp->cp_dparam[0x3C0];
+#endif
 	cpm_uart_ports[UART_SMC1].port.mapbase =3D
 	    (unsigned long)&cpmp->cp_smc[0];

------_=_NextPart_000_01C47330.546FE420--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
