Message-ID: <69AB2E42243FD511920200805FE64EAD0E361C@ZBR01EXM01>
From: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
To: "'Jeremy Rosen'" <Rosen.Jeremy@tms-pty.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problem using FEC on a860T
Date: Mon, 22 Oct 2001 09:38:46 -0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C15AEE.1C5D2FF0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C15AEE.1C5D2FF0
Content-Type: text/plain;
	charset="iso-8859-1"

> Jeremy Rosen wrote:
>
> I am still struggling with my FADS, and the 2.4.4-07.23 kernel from
> Denx...
>
> I am trying to have the FEC working, but I hqve problems..
>
> when I compile without "MDIO for PHY configuration"
> the kernel prints forever the message  "fec.c[1374]
> mii_link_interrupt:
> unexpected Link interrupt
> on the console at boottime.
>
> when I compile with it, the kernel Oopses.
> after carefull debugging, I tracked it down to the line 1367 in
> arch/ppc/8xx_io/
>     mii_do_cmd(dev, fep->phy->ack_int);
>
> it is a kernel access of bad area.
>
> It is possible that I have missed something in the
> configuration, but I
> really can't guess what...

No, You have not missed anything on configuration.

There is a problem in some FADS boards that makes the irq pin used for mii_link_interrupt always active. That is the reason why you are getting the unexpected mii_link_interrupt.

Firstly, apply the attached patch. This patch was written by Dave Ellis. It will disable the mii_link_interrupt when the "MDIO for PHY configuration" was not selected.

Secondly, you need compile without the "MDIO for PHY configuration". FADS does not use that.

I hope this helps

Evandro


------_=_NextPart_000_01C15AEE.1C5D2FF0
Content-Type: application/octet-stream;
	name="fads0723_2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fads0723_2.patch"

diff -Naur linux-2.4.4-2001-07-23.sxn/arch/ppc/8xx_io/fec.c =
linux-2.4.4-2001-07-23.sxn2/arch/ppc/8xx_io/fec.c=0A=
--- linux-2.4.4-2001-07-23.sxn/arch/ppc/8xx_io/fec.c	Mon Mar 12 =
10:48:01 2001=0A=
+++ linux-2.4.4-2001-07-23.sxn2/arch/ppc/8xx_io/fec.c	Tue Sep 11 =
16:30:54 2001=0A=
@@ -25,12 +25,6 @@=0A=
  * Copyright (c) 2000 Wolfgang Denk, DENX Software Engineering.=0A=
  */=0A=
 =0A=
-/* List of PHYs we wish to support.=0A=
-*/=0A=
-#undef	CONFIG_FEC_LXT970=0A=
-#define	CONFIG_FEC_LXT971=0A=
-#undef	CONFIG_FEC_QS6612=0A=
-=0A=
 #include <linux/config.h>=0A=
 #include <linux/kernel.h>=0A=
 #include <linux/sched.h>=0A=
@@ -59,6 +53,15 @@=0A=
 #include <asm/uaccess.h>=0A=
 #include "commproc.h"=0A=
 =0A=
+/* List of PHYs we wish to support.=0A=
+** If one or more is defined, just use it (or them), otherwise =
default=0A=
+** to LXT971.=0A=
+*/=0A=
+#if !defined(CONFIG_FEC_LXT970) && !defined(CONFIG_FEC_LXT971)\=0A=
+    && !defined(CONFIG_FEC_QS6612)=0A=
+#define	CONFIG_FEC_LXT971=0A=
+#endif=0A=
+=0A=
 #ifdef	CONFIG_USE_MDIO=0A=
 /* Forward declarations of some structures to support different =
PHYs=0A=
 */=0A=
@@ -1336,6 +1339,8 @@=0A=
 }=0A=
 #endif	/* CONFIG_USE_MDIO */=0A=
 =0A=
+#if defined(CONFIG_USE_MDIO) \=0A=
+    && (defined(PHY_INTERRUPT) || defined(CONFIG_RPXCLASSIC))=0A=
 /* This interrupt occurs when the PHY detects a link change.=0A=
 */=0A=
 static void=0A=
@@ -1345,7 +1350,6 @@=0A=
 mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)=0A=
 #endif=0A=
 {=0A=
-#ifdef	CONFIG_USE_MDIO=0A=
 	struct	net_device *dev =3D dev_id;=0A=
 	struct fec_enet_private *fep =3D dev->priv;=0A=
 	volatile immap_t *immap =3D (immap_t *)IMAP_ADDR;=0A=
@@ -1357,25 +1361,15 @@=0A=
 	if ((ecntrl & FEC_ECNTRL_ETHER_EN) =3D=3D 0) {=0A=
 		fecp->fec_ecntrl |=3D FEC_ECNTRL_ETHER_EN;=0A=
 	}=0A=
-#endif	/* CONFIG_USE_MDIO */=0A=
-=0A=
-#if 0=0A=
-	disable_irq(fep->mii_irq);  /* disable now, enable later */=0A=
-#endif=0A=
-=0A=
 =0A=
-#ifdef	CONFIG_USE_MDIO=0A=
 	mii_do_cmd(dev, fep->phy->ack_int);=0A=
 	mii_do_cmd(dev, phy_cmd_relink);  /* restart and display status */=0A=
 =0A=
 	if ((ecntrl & FEC_ECNTRL_ETHER_EN) =3D=3D 0) {=0A=
 		fecp->fec_ecntrl =3D ecntrl;	/* restore old settings */=0A=
 	}=0A=
-#else=0A=
-printk("%s[%d] %s: unexpected Link interrupt\n", =
__FILE__,__LINE__,__FUNCTION__);=0A=
-#endif	/* CONFIG_USE_MDIO */=0A=
-=0A=
 }=0A=
+#endif	/* defined(CONFIG_USE_MDIO) && ... */=0A=
 =0A=
 static int=0A=
 fec_enet_open(struct net_device *dev)=0A=
@@ -1643,6 +1637,7 @@=0A=
 		panic("Could not allocate FEC IRQ!");=0A=
 =0A=
 #ifdef CONFIG_RPXCLASSIC=0A=
+#ifdef CONFIG_USE_MDIO=0A=
 	/* Make Port C, bit 15 an input that causes interrupts.=0A=
 	*/=0A=
 	immap->im_ioport.iop_pcpar &=3D ~0x0001;=0A=
@@ -1650,13 +1645,14 @@=0A=
 	immap->im_ioport.iop_pcso  &=3D ~0x0001;=0A=
 	immap->im_ioport.iop_pcint |=3D  0x0001;=0A=
 	cpm_install_handler(CPMVEC_PIO_PC15, mii_link_interrupt, dev);=0A=
+#endif=0A=
 =0A=
 	/* Make LEDS reflect Link status.=0A=
 	*/=0A=
 	*((uint *) RPX_CSR_ADDR) &=3D ~BCSR2_FETHLEDMODE;=0A=
 #endif=0A=
 =0A=
-#ifdef PHY_INTERRUPT=0A=
+#if defined(PHY_INTERRUPT) && defined(CONFIG_USE_MDIO)=0A=
 	if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) =
!=3D 0)=0A=
 		panic("Could not allocate MII IRQ!");=0A=
 =0A=
@@ -1706,12 +1702,12 @@=0A=
 #endif	/* CONFIG_USE_MDIO */=0A=
 =0A=
 	printk ("%s: FEC ENET Version 0.2, FEC irq %d"=0A=
-#ifdef PHY_INTERRUPT=0A=
+#if defined(PHY_INTERRUPT) && defined(CONFIG_USE_MDIO)=0A=
 		", MII irq %d"=0A=
 #endif=0A=
 		", addr ",=0A=
 		dev->name, FEC_INTERRUPT=0A=
-#ifdef PHY_INTERRUPT=0A=
+#if defined(PHY_INTERRUPT) && defined(CONFIG_USE_MDIO)=0A=
 		, PHY_INTERRUPT=0A=
 #endif=0A=
 	);=0A=
diff -Naur linux-2.4.4-2001-07-23.sxn/include/asm-ppc/fads.h =
linux-2.4.4-2001-07-23.sxn2/include/asm-ppc/fads.h=0A=
--- linux-2.4.4-2001-07-23.sxn/include/asm-ppc/fads.h	Tue Sep 11 =
15:46:25 2001=0A=
+++ linux-2.4.4-2001-07-23.sxn2/include/asm-ppc/fads.h	Tue Sep 11 =
16:13:02 2001=0A=
@@ -48,6 +48,7 @@=0A=
  */=0A=
 #define FEC_INTERRUPT	SIU_LEVEL1	/* FEC interrupt */=0A=
 #define PHY_INTERRUPT	SIU_IRQ2	/* PHY link change interrupt */=0A=
+#define	CONFIG_FEC_LXT970               /* many (all?) FADS use the =
LXT970 */=0A=
 =0A=
 /* We don't use the 8259.=0A=
  */=0A=
@@ -56,7 +57,5 @@=0A=
 /* Machine type=0A=
  */=0A=
 #define _MACH_8xx (_MACH_fads)=0A=
-=0A=
-#define PHY_INTERRUPT		SIU_IRQ2=0A=
 =0A=
 #endif=0A=

------_=_NextPart_000_01C15AEE.1C5D2FF0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
