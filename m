Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 335472BF18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 21:29:47 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Steffen Rumler <Steffen.Rumler@siemens.com>
In-Reply-To: <41E4E1EB.6080903@siemens.com>
References: <41E4E1EB.6080903@siemens.com>
Content-Type: multipart/mixed; boundary="=-FH+VcV7So46jJ9J2R09z"
Date: Wed, 12 Jan 2005 11:29:35 +0100
Message-Id: <1105525776.10942.4.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel boot hangs by parallel flood pings
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-FH+VcV7So46jJ9J2R09z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-01-12 at 09:38 +0100, Steffen Rumler wrote:
> I'm using a 2.4.20 kernel (PPC).
> 
> When I run multiple 'ping -f' directed to my board
> during the kernel boots, sometimes it hangs with
> the following messages:

> I have checked this with the BDI2000 and found that the
> kernel loops anywhere inside ip_route_input().

This is a long-standing bug in the cpm and cmp2 drivers.
I think it's also present in 2.6 as far as I remember.

I sent my own fix some time ago, you may find it in the
archives as "[patch] Race condition #2 in arch/ppc/cpm2_io/fcc_enet.c".

Greetings,

-- 
Stefan Nickl
Kontron Modular Computers


--=-FH+VcV7So46jJ9J2R09z
Content-Disposition: attachment; filename=fcc_enet-mdio_race.patch
Content-Type: text/x-patch; name=fcc_enet-mdio_race.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/arch/ppc/cpm2_io/fcc_enet.c	2004-08-09 08:32:28.000000000 +0200
+++ fcc_enet.c	2004-11-25 18:28:56.000000000 +0100
@@ -2095,10 +2095,10 @@ mii_send_receive(fcc_info_t *fip, uint c
 		for (i = 0, off = 15; i < 16; i++, off--)
 		{
 			FCC_PDATC_MDC(1);
+			udelay(1);
 			retval <<= 1;
 			if (io->iop_pdatc & fip->fc_mdio)
 				retval++;
-			udelay(1);
 			FCC_PDATC_MDC(0);
 			udelay(1);
 		}

--=-FH+VcV7So46jJ9J2R09z
Content-Disposition: attachment; filename=fcc_enet-startup_race.patch
Content-Type: text/x-patch; name=fcc_enet-startup_race.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/arch/ppc/cpm2_io/fcc_enet.c	2004-08-09 08:32:28.000000000 +0200
+++ fcc_enet.c	2004-11-25 18:41:22.000000000 +0100
@@ -2008,16 +2008,6 @@ init_fcc_startup(fcc_info_t *fip, struct
         *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_FETHIEN;
         *(volatile uint *)(BCSR_ADDR + 4) |=  BCSR1_FETH_RST;
 #endif
-
-#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
-	/* start in full duplex mode, and negotiate speed
-	 */
-	fcc_restart (dev, 1);
-#else
-	/* start in half duplex mode
-	 */
-	fcc_restart (dev, 0);
-#endif
 }
 
 #ifdef	CONFIG_USE_MDIO
@@ -2155,6 +2145,16 @@ fcc_enet_open(struct net_device *dev)
 {
 	struct fcc_enet_private *fep = dev->priv;
 
+#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
+	/* start in full duplex mode, and negotiate speed
+	 */
+	fcc_restart (dev, 1);
+#else
+	/* start in half duplex mode
+	 */
+	fcc_restart (dev, 0);
+#endif
+
 #ifdef	CONFIG_USE_MDIO
 	fep->sequence_done = 0;
 	fep->link = 0;

--=-FH+VcV7So46jJ9J2R09z--
