Message-ID: <3E3FE6D0.1010600@imc-berlin.de>
Date: Tue, 04 Feb 2003 17:14:08 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: was: FEC on MPC860T & race condition
References: <3E395B40.9090506@imc-berlin.de> <3E39898E.5060804@embeddededge.com> <3E3A3EE9.7000608@imc-berlin.de> <20030203210959.GA7857@ip68-0-152-218.tc.ph.cox.net> <3E3F7C29.8030807@imc-berlin.de> <20030204160401.GA30936@ip68-0-152-218.tc.ph.cox.net>
Content-Type: multipart/mixed;
 boundary="------------040007030203080909060302"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040007030203080909060302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I wrote:

>>I just hab a look at arch/ppc/8xx_io/fec.c in the recent linuxppc_2_4 and
>>could find this problem fixed! The MII irq is still requested very early
>>without waiting for the PHY to discovered!
Damn it!!! Stupid fingers.
I meant to write "could NOT find this problem fixed" !

> So linuxppc_2_4 has a partial fix then is what you're saying?  Around
> what lines?  I'm interested to see why _devel doesn't have this.

So IHMO there is neither in recent linuxppc_2_4_devel nor in linuxppc_2_4 a fix
for the mentioned problem.

I'll attach my patch. It is not configurable since I think it won't break anything.

If you need or wish something like CONFIG_FEC_FIX_RACE or
CONFIG_FEC_LATE_ENABLE_PHY I could do that!

Regards,

Steven

--------------040007030203080909060302
Content-Type: text/plain;
 name="fec8xx_fix_race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec8xx_fix_race.patch"

Index: arch/ppc/8xx_io/fec.c
===================================================================
RCS file: /home/cvsroot/linuxppc_2_4_denx/arch/ppc/8xx_io/fec.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fec.c
--- arch/ppc/8xx_io/fec.c	15 Dec 2002 05:06:41 -0000	1.1.1.1
+++ arch/ppc/8xx_io/fec.c	31 Jan 2003 14:55:18 -0000
@@ -33,6 +33,10 @@
  *
  * Added code for Multicast support, Frederic Goddeeris, Paul Geerinckx
  * Copyright (c) 2002 Siemens Atea
+ *
+ * Fix compiler warning: changed type of mem_addr
+ * Fix to avoid race condition: wait until PHY is discovered
+ *                              before requesting the MII irq
  */

 #include <linux/config.h>
@@ -2032,7 +2036,7 @@
 	struct fec_enet_private *fep;
 	int i, j, k;
 	unsigned char	*eap, *iap, *ba;
-	unsigned long	mem_addr;
+	dma_addr_t	mem_addr;
 	volatile	cbd_t	*bdp;
 	cbd_t		*cbd_base;
 	volatile	immap_t	*immap;
@@ -2172,17 +2176,6 @@
 	*((uint *) RPX_CSR_ADDR) &= ~BCSR2_FETHLEDMODE;
 #endif	/* CONFIG_RPXCLASSIC */

-#ifdef CONFIG_USE_MDIO
-# ifndef PHY_INTERRUPT
-#  error Want to use MII, but PHY_INTERRUPT not defined!
-# endif
-	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel |=
-		(0x80000000 >> PHY_INTERRUPT);
-
-	if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) != 0)
-		panic("Could not allocate MII IRQ!");
-#endif	/* CONFIG_USE_MDIO */
-
 	dev->base_addr = (unsigned long)fecp;
 	dev->priv = fep;

@@ -2285,6 +2278,39 @@
 	fep->old_status = 0;
 #endif	/* CONFIG_USE_MDIO */

+#ifdef CONFIG_USE_MDIO
+# ifndef PHY_INTERRUPT
+#  error Want to use MII, but PHY_INTERRUPT not defined!
+# endif
+	/* before requesting the irq, we should wait until PHY is discovered
+	 * to avoid race conditions
+	 */
+	while (!fep->phy_id_done) {
+		udelay(5);
+	}
+
+	/* I found the following lines in a post from yhkim@da-san.com>
+	 * (http://lists.linuxppc.org/linuxppc-embedded/200110/msg00206.html)
+	 * But I am not sure if and why this is necessary.
+	 * Enable it just to be sure, be sure ... ?
+	 * It works for me without it.
+	 */
+#if 0
+	mii_do_cmd(dev, fep->phy->ack_int);
+	mii_do_cmd(dev, fep->phy->startup);
+
+	{
+		int tmp;
+		for (tmp = 0; tmp < 50; tmp++)
+			udelay(5);
+	}
+#endif
+	if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) != 0)
+		panic("Could not allocate MII IRQ!");
+
+	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel |=
+		(0x80000000 >> PHY_INTERRUPT);
+#endif	/* CONFIG_USE_MDIO */
 	return 0;
 }


--------------040007030203080909060302--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
