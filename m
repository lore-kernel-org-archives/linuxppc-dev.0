Return-Path: <dadair@ariodata.com>
Received: from orion.ariodata.com (adsl-64-170-199-186.dsl.snfc21.pacbell.net
	[64.170.199.186]) by ozlabs.org (Postfix) with ESMTP id EF3EF2BDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2004 07:37:31 +1100 (EST)
Date: Wed, 10 Nov 2004 11:48:31 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <F152162DB1B0D2458EA395AD074DE1C48590CF@orion.ariodata.com>
From: "David Adair" <dadair@ariodata.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Problems with MII mode operation on 440GP ethernet
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

I have two different boards with the following symptoms:
	- 2.4.19-pre7 works fine.
	- 2.4.24 (from ELDK) or 2.4.27 (from BK) both fail.
	- Both TX, RX interrupts happen and ifconfig shows
	  RX and TX packets.
	- No outbound traffic shows up on wire, at least not
	  in a format I can see with ethereal.

These boards are virtually identical to the EBONY board except
that the PHY is connected via MII.

Turns out that the problem is that MII mode is getting enabled
in the ZMII FER register for both EMAC0 and EMAC1 as a result of
the PHY probe operation on EMAC1.  The older versions do the PHY
probe during the open while it now occurs earlier.

Would it be better to fix this by changing the OCP definitions to
remove EMAC1 or by modifying the Ethernet driver to enforce the
"only one channel in MII mode" restriction?

To me it seems like the latter is a better choice since the OCP
really has more to do with the CPU than my board configuration
which is defined by the initial values loaded into the ZMII
FER register.

For instance the following works on my boards but contains
an implicit assumption that emac_init_zmii() is only ever
called with "AUTO" mode since it relies on valid initial data
in the fer register.

(I also tweaked things so my version of mii-tool would work
does anyone else have trouble with the wrong variable size?)


diff -ru linux24/drivers/net/ibm_emac/ibm_ocp_debug.c
linux24_mod/drivers/net/ibm_emac/ibm_ocp_debug.c
--- linux24/drivers/net/ibm_emac/ibm_ocp_debug.c	2004-08-27
14:14:07.000000000 -0700
+++ linux24_mod/drivers/net/ibm_emac/ibm_ocp_debug.c	2004-11-10
09:10:55.000000000 -0800
@@ -152,6 +152,25 @@
 	       (unsigned int) get_mal_dcrn(mal, DCRN_MALRCBS1));
 }
=20
+#define ZMII_PRIV(ocpdev) ((struct
ibm_ocp_zmii*)ocp_get_drvdata(ocpdev))
+void
+emac_zmii_dump(struct net_device *dev)
+{
+	struct ocp_enet_private *fep =3D dev->priv;
+    struct ibm_ocp_zmii *zmii;
+
+    if ((fep) && (fep->zmii_dev)) {
+        zmii =3D ZMII_PRIV(fep->zmii_dev);
+    } else {
+        return;
+    }
+
+	printk(KERN_DEBUG "ZMII DEBUG ********** \n");
+	printk(KERN_DEBUG "ZMII_FER    =3D=3D> 0x%x\n",
in_be32(&zmii->base->fer));
+	printk(KERN_DEBUG "ZMII_SSR    =3D=3D> 0x%x\n",
in_be32(&zmii->base->ssr));
+	printk(KERN_DEBUG "EMAC_SMIISR =3D=3D> 0x%x\n",
in_be32(&zmii->base->smiirs));
+}
+
 void
 emac_serr_dump_0(struct net_device *dev)
 {

diff -ru linux24/drivers/net/ibm_emac/ibm_ocp_enet.c
linux24_mod/drivers/net/ibm_emac/ibm_ocp_enet.c
--- linux24/drivers/net/ibm_emac/ibm_ocp_enet.c	2004-08-27
14:14:07.000000000 -0700
+++ linux24_mod/drivers/net/ibm_emac/ibm_ocp_enet.c	2004-11-10
11:25:10.000000000 -0800
@@ -126,7 +126,7 @@
 }
=20
 static int
-emac_init_zmii(struct ocp_device *ocpdev, int mode)
+emac_init_zmii(struct ocp_device *ocpdev, int mode, int emac)
 {
 	struct ibm_ocp_zmii *zmii =3D ZMII_PRIV(ocpdev);
 	struct zmii_regs *zmiip;
@@ -136,7 +136,13 @@
 		/* We have already initialized ZMII device,
 		   so just increment refcount and return */=09
 		zmii->users++;
-		return 0;		  =20
+
+		/* Only return success if mode is enabled */
+		if (zmii->base->fer & zmii_enable[emac][zmii->mode]) {
+			return 0;
+		} else {
+			return -ENODEV;
+		}
 	}
 =09
 	zmii =3D kmalloc(sizeof(struct ibm_ocp_zmii), GFP_KERNEL);
@@ -180,8 +186,14 @@
 	ocp_set_drvdata(ocpdev, zmii);
=20
 	printk(KERN_NOTICE "zmii%d: bridge in %s mode\n",
ocpdev->def->index,
-		mode_name[mode]);
-	return 0;
+	       mode_name[mode]);
+
+	if (zmiip->fer & zmii_enable[emac][zmii->mode]) {
+		return 0;
+	} else {
+		return -ENODEV;
+	}
+
 }
=20
 static void
@@ -732,7 +744,7 @@
 	       fep->ndev->name,
 	       speed =3D=3D SPEED_100 ? "100" : "10",
 	       full_duplex ? "Full" : "Half");
-	if (fep->opened)
+        if (fep->opened)
 	        out_be32(&emacp->em0mr1, mode_reg);
=20
 	return 0;
@@ -1101,25 +1113,25 @@
 emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct ocp_enet_private *fep =3D dev->priv;
-	uint *data =3D (uint *) & rq->ifr_data;
+	struct mii_ioctl_data *data =3D (struct mii_ioctl_data
*)&rq->ifr_data;
=20
 	switch (cmd) {
         case SIOCETHTOOL:
                 return emac_ethtool(dev, rq->ifr_data);
 	case SIOCDEVPRIVATE:
 	case SIOCGMIIPHY:
-		data[0] =3D fep->mii_phy_addr;
+		data->phy_id =3D fep->mii_phy_addr;
 		/*FALLTHRU*/
 	case SIOCDEVPRIVATE + 1:
 	case SIOCGMIIREG:
-		data[3] =3D emac_phy_read(dev, fep->mii_phy_addr,
data[1]);
+		data->val_out =3D emac_phy_read(dev, fep->mii_phy_addr,
data->reg_num);
 		return 0;
 	case SIOCDEVPRIVATE + 2:
 	case SIOCSMIIREG:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
=20
-		emac_phy_write(dev, fep->mii_phy_addr, data[1],
data[2]);
+		emac_phy_write(dev, fep->mii_phy_addr, data->reg_num,
data->val_in);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -1155,6 +1167,10 @@
         emac_kick(fep);
         spin_unlock_irq(&fep->lock);
=20
+	emac_zmii_dump(dev);
+	emac_mac_dump(dev);
+	emac_mal_dump(dev);
+
 	netif_start_queue(dev);
 bail:
 	return rc;
@@ -1297,8 +1313,11 @@
 		if (ep->zmii_dev =3D=3D NULL)
 	                printk(KERN_WARNING "emac%d: ZMII %d requested
but not found !\n",
 	                	ocpdev->def->index, emacdata->zmii_idx);
-		else if ((rc =3D emac_init_zmii(ep->zmii_dev, ZMII_AUTO))
!=3D 0)
+		else if ((rc =3D emac_init_zmii(ep->zmii_dev,
ZMII_AUTO,ocpdev->def->index)) !=3D 0) {
+	                printk(KERN_NOTICE "emac%d: ZMII %d requested
but not available !\n",
+	                	ocpdev->def->index, emacdata->zmii_idx);
 			goto bail;
+		}
 	}
=20
 	/* Reset the EMAC */

diff -ru linux24/drivers/net/ibm_emac/ibm_ocp_enet.h
linux24_mod/drivers/net/ibm_emac/ibm_ocp_enet.h
--- linux24/drivers/net/ibm_emac/ibm_ocp_enet.h	2004-08-27
14:14:07.000000000 -0700
+++ linux24_mod/drivers/net/ibm_emac/ibm_ocp_enet.h	2004-11-10
10:55:30.000000000 -0800
@@ -109,6 +109,7 @@
 void emac_desc_dump(struct net_device *);
 void emac_mac_dump(struct net_device *);
 void emac_mal_dump(struct net_device *);
+void emac_zmii_dump(struct net_device *);
 #else
 #define emac_serr_dump_0(dev) do { } while (0)
 #define emac_serr_dump_1(dev) do { } while (0)
@@ -117,6 +118,7 @@
 #define emac_desc_dump(dev) do { } while (0)
 #define emac_mac_dump(dev) do { } while (0)
 #define emac_mal_dump(dev) do { } while (0)
+#define emac_zmii_dump(dev) do { } while (0)
 #endif
=20
=20
