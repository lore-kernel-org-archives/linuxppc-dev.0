Date: Tue, 14 May 2002 13:56:58 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] fix ifconfig oops for ibm ocp enet
Message-ID: <Pine.LNX.4.30.0205141354450.18953-101000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="394922409-1395623869-1021409818=:18953"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--394922409-1395623869-1021409818=:18953
Content-Type: TEXT/PLAIN; charset=US-ASCII

The priv structure is not initialized until the open for the ibm
ocp ethernet adapter. This causes ifconfig to cause a kernel oops if run
before the device is brought "up".

Please correct if necessary, but it is working for me. Patch was made from
a pull about 20 minutes ago.

--- drivers/net/ibm_ocp/ibm_ocp_enet.c.orig	Tue May 14 13:40:17 2002
+++ drivers/net/ibm_ocp/ibm_ocp_enet.c	Tue May 14 13:48:17 2002
@@ -226,12 +226,11 @@
 static int
 ppc405_enet_open(struct net_device *dev)
 {
-	int loop, i, emac_num;
+	int loop, i;
 	unsigned long mode_reg;
 	struct fec_enet_private *fep;
 	volatile emac_t *emacp;
 	unsigned long emac_ier;
-	struct ocp_driver *emac_driver;
 	int already_opened;

 	for (i = 0; i < ocp_dev_count(EMAC); i++)
@@ -240,35 +239,9 @@

 	already_opened = ((i < ocp_dev_count(EMAC))
 			  && (get_ocp_dev(EMAC, i) != NULL));
-	if (already_opened) {
-		fep = (struct fec_enet_private *) EMAC_DEV(ocpdev);
-		emacp = (emac_t *) EMAC_DEV(paddr);
-	} else {
-		if ((emac_driver =
-		     ocp_alloc_dev(sizeof (struct fec_enet_private))) == NULL)
-			return -ENOMEM;
-		strcpy(emac_driver->name, "emac");
-		emac_driver->type = EMAC;
-		/* this returns the next emac number */
-		if ((emac_num = ocp_register(emac_driver)) >= 0) {
-			dev->priv = (void *) emac_driver;
-			emac_driver->priv_index = dev->ifindex;
-			emacp =
-			    (emac_t *) ((struct ocp_driver *) dev->priv)->paddr;
-			fep = (struct fec_enet_private *) ((struct ocp_driver *)
-							   dev->priv)->ocpdev;
-			fep->emac_num = emac_num;
-			fep->mal = MBASE[0];
-			fep->irq_resource = irq_resource[emac_num];
-			fep->sequence_done = 0;
-			init_zmii(ZMII_AUTO, dev);
-			find_phy(dev);
-			fep->link = 1;
-		} else {
-			ocp_free_dev(emac_driver);
-			return -ENODEV;
-		}
-	}
+
+	fep = (struct fec_enet_private *) EMAC_DEV(ocpdev);
+	emacp = (emac_t *) EMAC_DEV(paddr);

 	if (!fep->phy) {
 		printk(KERN_NOTICE "%s: Cannot open interface without phy\n",
@@ -658,6 +631,11 @@
 	emac_max = ocp_get_max(EMAC);
 	printk("emac max %d\n", emac_max);
 	for (curr_emac = 0; curr_emac < emac_max; curr_emac++) {
+		int emac_num;
+		struct ocp_driver *emac_driver;
+		struct fec_enet_private *fep;
+		volatile emac_t *emacp;
+
 		dev = init_etherdev(NULL, sizeof (struct ocp_driver));
 		dev->irq = irq_resource[curr_emac][BL_MAC_WOL].irq;
 		/* read the MAC Address */
@@ -676,6 +654,31 @@
 		dev->set_multicast_list = &ppc405_enet_set_multicast_list;
 		dev->do_ioctl = &fec_enet_ioctl;
 		emac_dev[curr_emac] = dev;
+
+		if ((emac_driver =
+		     ocp_alloc_dev(sizeof (struct fec_enet_private))) == NULL)
+			return -ENOMEM;
+		strcpy(emac_driver->name, "emac");
+		emac_driver->type = EMAC;
+		/* this returns the next emac number */
+		if ((emac_num = ocp_register(emac_driver)) >= 0) {
+			dev->priv = (void *) emac_driver;
+			emac_driver->priv_index = dev->ifindex;
+			emacp =
+				(emac_t *) ((struct ocp_driver *) dev->priv)->paddr;
+			fep = (struct fec_enet_private *) ((struct ocp_driver *)
+							   dev->priv)->ocpdev;
+			fep->emac_num = emac_num;
+			fep->mal = MBASE[0];
+			fep->irq_resource = irq_resource[emac_num];
+			fep->sequence_done = 0;
+			init_zmii(ZMII_AUTO, dev);
+			find_phy(dev);
+			fep->link = 1;
+		} else {
+			ocp_free_dev(emac_driver);
+			break;
+		}
 	}

 	for (i = 0; i < NMII - 1; i++)

--394922409-1395623869-1021409818=:18953
Content-Type: APPLICATION/octet-stream; name="ibm_ocp_enet.c.patch.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0205141356580.18953@hill.cs.ucr.edu>
Content-Description: 
Content-Disposition: attachment; filename="ibm_ocp_enet.c.patch.gz"

H4sICD154TwCA2libV9vY3BfZW5ldC5jLnBhdGNoAKVWbVPbOBD+7PyKLTNl
bGRD3khbUhgozQfmSJi5o3czxzEeYyugwZFdW86R3vS/366UFwWSNKV8MdLu
Ptp9dvUoQRBAUogxL8oDydWBuBuFWZzPviHHzf14PyvEvXNdcehHE2i0odE6
atePGu+gWa83a4yxLUCex7+fx5+eQtBsdvxGE5j+NuD0tAalipSIQUhVgzyP
2/VDjRRmOZduqYoqVkDrhI9FzGEPv14N/qsFDoZAmmW5D8IHPoriUFajbo3Z
hm4NnEqW4l7yBPfkPYyyhIcFvyfLFH7IY3NmjuVFCg8Z8pzs4yzF5FJu0BXs
0Td/ianNghddzGqKSYwYtkzUdEGxlF6UFjxKJrpKnuAu7g+zAlwBx1DvgoCP
BoKPwzirpHJ7/bNzDw2MeYbKdt1vHSKVrQ/+B80kQizDIpTrrkFCDh3HAdjd
Bfee6DYu2oi8efDmGAZfLi89j4oSQ3CXsT3dAgeJolPWEukBAYafe3+6eAL1
juAczSMFzoi1/PIoSQrt9h14WnJzEGXgWkTCMe0C/VHqUZpmsS6gFN94Nlyb
kud5cDwtjRCcgquqkBD0Blf9Xl9nh6FxPrFPC05kNOI+7NDezqKGuVlNco71
UBHaeLAH6kGUYNBLXHCc4ielRwVwTu9oMA6WK8NtxKBycD5FqXhh54CJn+Bs
TIl3sNbghIoiGseZSIjEpUkjr6UkyTsUMuFPGKPjxVAvF7654VUTazXHdVeM
tQfzHDz8UNsM0I+HYjWeDnbM6Ta0mZw5dnBisbW493PrKErR0P909kfvpn5r
GUTxFZkts6qIqVn28maGY/uX/GvFZczDJJNc30ttE1Ko8NtICPfv/sVFePbl
+sqH+Wg7RGmYP0xca4vQUiEfEaSht+zRdoiEYcG5nl+7493nE4r3w4TT7agx
1LrXXEC21f0jPaHZfKOzx4Jo8lA0EFqqR/e33u+DcHB1fXHeg5235RGcR1Jm
2FGUB1JzXgwjpPlfoR6ySgHG/yN3fC1dncP3fgdYp9WYPQJmTkfR03T+SZFw
NRU9tE8P1fcPyO9tQnAwi9NOWkDjqihC7aaFdLH8OHe2dlFNsSrmaFG235Af
6vjCZc3zgQ7r3g9GPGIvaAhpmDjKQ0HNJ1ny4ZmELVLwdJnm6uP0Pp/heVW3
N58uQ+rnX1eXt/voo8NQk0jBtRahEc6wz7wsSYZ0V951dFcO235r2hVzUknN
qFJ8paNShSkKEx68a7/VLz0WeSZZKLJY0ZXcnTOld7SP4ZSPreSNOHX1eK/S
ffbLus9W6D7bSvfZJt1n2+s+e5Xus610n/2E7jNL9+l/51Wiz35F9Nlm0Wcb
RZ+tE332k6LPNog+2yz67KXos5eizyzRZ5tFn8x3eFUfTRRek+8rfyAOMBMI
ENz8Kvwf/RwtmOYLAAA=
--394922409-1395623869-1021409818=:18953--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
