Return-Path: <prvs=1764394d47=Staale.Aakermann@kongsberg.com>
Received: from ukgl-edge-p01.kongsberg.com (ukgl-edge-p01.kongsberg.com
 [193.71.180.98]) by ozlabs.org (Postfix) with ESMTP id AEBD22C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 19:09:25 +1100 (EST)
Received: from KDA-MAILGW-02.mail.kongsberg.com
 (kda-mailgw-02.mail.kongsberg.com [193.71.180.105])
 by ukgl-edge-p01.kongsberg.com (8.14.5/8.14.5) with ESMTP id r1L847RZ011173
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 09:04:07 +0100
Received: from UKGTW-EXM-P03.kda.kongsberg.com (unverified [10.50.100.64]) by
 KDA-MAILGW-02.mail.kongsberg.com
 (Clearswift SMTPRS 5.5.0) with ESMTP id
 <Taa08670851c147b46913c8@KDA-MAILGW-02.mail.kongsberg.com> for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 09:03:30 +0100
From: <Staale.Aakermann@kongsberg.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: PATCH [1/1] GIANFAR infiinate loop on reception of PAUSE FRAME
Date: Thu, 21 Feb 2013 08:04:06 +0000
Message-ID: <BDD883B26EE1104B8A2B30223B09A48C1AC98A96@UKGAW-EXM-P03.kda.kongsberg.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a undesired behavior in the GIANFAR driver that causes a infinite =
loop stalling the CPU when reception of PAUSE FRAMES.
I found this error during testing with a DSL modem (Westermo http://www.wes=
termo.com). This equipment spawns PAUSE FRAMES continuously on its LAN side=
 as long as the link is not up on the WAN side. The GIANFAR driver does not=
 handle that it get an timeout on transmission on the first packet sent. It=
 will try to gracefully stop all ongoing transactions, but this will fail a=
s there aren't any, and it will loop forever.

--- drivers/net/ethernet/freescale/gianfar.c    2012-12-11 04:30:57.0000000=
00 +0100
+++ drivers/net/ethernet/freescale/gianfar.c    2013-02-20 20:28:13.2019316=
02 +0100
@@ -1600,8 +1600,10 @@
        struct gfar_private *priv =3D netdev_priv(dev);
        struct gfar __iomem *regs =3D NULL;
        u32 tempval;
-       int i;
-
+       u32 reset_value =3D DMACTRL_GRS;
+       u32 event_value =3D IEVENT_GRSC;
+       int i =3D 0;
+
        for (i =3D 0; i < priv->num_grps; i++) {
                regs =3D priv->gfargrp[i].regs;
                /* Mask all interrupts */
@@ -1612,22 +1614,32 @@
        }

        regs =3D priv->gfargrp[0].regs;
+
+       if (!((gfar_read(&regs->tctrl) & TCTRL_RFCPAUSE) =3D=3D TCTRL_RFCPA=
USE))
+       {
+               reset_value |=3D DMACTRL_GTS;
+               event_value |=3D IEVENT_GTSC;
+
+       }
+
        /* Stop the DMA, and wait for it to stop */
        tempval =3D gfar_read(&regs->dmactrl);
-       if ((tempval & (DMACTRL_GRS | DMACTRL_GTS)) !=3D
-           (DMACTRL_GRS | DMACTRL_GTS)) {
+       if ((tempval & reset_value) !=3D reset_value) {
                int ret;

-               tempval |=3D (DMACTRL_GRS | DMACTRL_GTS);
+               tempval |=3D reset_value;
                gfar_write(&regs->dmactrl, tempval);

                do {
-                       ret =3D spin_event_timeout(((gfar_read(&regs->ieven=
t) &
-                                (IEVENT_GRSC | IEVENT_GTSC)) =3D=3D
-                                (IEVENT_GRSC | IEVENT_GTSC)), 1000000, 0);
+
+                       ret =3D spin_event_timeout(((gfar_read(&regs->ieven=
t) & event_value) =3D=3D event_value), 1000000, 0);
+
                        if (!ret && !(gfar_read(&regs->ievent) & IEVENT_GRS=
C))
+                       {
                                ret =3D __gfar_is_rx_idle(priv);
+                       }
                } while (!ret);
+
        }
 }

@@ -1668,9 +1682,10 @@
        lock_rx_qs(priv);

        gfar_halt(dev);
-
+
        unlock_rx_qs(priv);
        unlock_tx_qs(priv);
+
        local_irq_restore(flags);

        /* Free the IRQs */
@@ -2424,22 +2439,32 @@
        struct gfar_private *priv =3D container_of(work, struct gfar_privat=
e,
                                                 reset_task);
        struct net_device *dev =3D priv->ndev;
-
        if (dev->flags & IFF_UP) {
                netif_tx_stop_all_queues(dev);
                stop_gfar(dev);
                startup_gfar(dev);
                netif_tx_start_all_queues(dev);
        }
-
        netif_tx_schedule_all(dev);
 }

 static void gfar_timeout(struct net_device *dev)
 {
        struct gfar_private *priv =3D netdev_priv(dev);
+       struct gfar __iomem *regs =3D NULL;

-       dev->stats.tx_errors++;
+       regs =3D priv->gfargrp[0].regs;
+
+       if ((gfar_read(&regs->tctrl) & TCTRL_RFCPAUSE) =3D=3D TCTRL_RFCPAUS=
E)
+       {
+               printk(KERN_DEBUG "PAUSE FRAME RECEIVED\n");
+               dev->stats.tx_dropped++;
+       }
+       else
+       {
+               dev->stats.tx_errors++;
+       }
+
        schedule_work(&priv->reset_task);
 }


________________________________

CONFIDENTIALITY
This e-mail and any attachment contain KONGSBERG information which may be p=
roprietary, confidential or subject to export regulations, and is only mean=
t for the intended recipient(s). Any disclosure, copying, distribution or u=
se is prohibited, if not otherwise explicitly agreed with KONGSBERG. If rec=
eived in error, please delete it immediately from your system and notify th=
e sender properly.
