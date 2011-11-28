Return-Path: <prvs=13137ccccf=Staale.Aakermann@kongsberg.com>
Received: from ukgl-edge-p01.kongsberg.com (ukgl-edge-p01.kongsberg.com
 [193.71.180.98]) by ozlabs.org (Postfix) with ESMTP id BDFCC1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 08:01:23 +1100 (EST)
Received: from UKGTW-EXM-P04.kda.kongsberg.com ([10.50.100.65])
 by ukgl-edge-p01.kongsberg.com (8.14.1/8.14.1) with ESMTP id pASKu8L7026521
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 21:56:09 +0100
From: <Staale.Aakermann@kongsberg.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] make gianfar eTSEC vlan hw acceleration work again. 
Date: Mon, 28 Nov 2011 20:56:07 +0000
Message-ID: <BDD883B26EE1104B8A2B30223B09A48C10C724F7@UKGTW-EXM-P03.kda.kongsberg.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.

There seems to be a breakage in the VLAN TX HW acceleration in gianfar (ker=
nel 3.1). It seems like the previous patch that was submitted forgotten to =
initialize the TX registers.

--- drivers/net/gianfar.c-orig  2011-11-28 11:04:09.318992481 +0100
+++ drivers/net/gianfar.c       2011-11-28 11:05:43.530990635 +0100
@@ -394,6 +394,9 @@
        /* Init rctrl based on our settings */
        gfar_write(&regs->rctrl, rctrl);

+       if (ndev->features & NETIF_F_HW_VLAN_TX)
+               tctrl |=3D TCTRL_VLINS;
+
        if (ndev->features & NETIF_F_IP_CSUM)
                tctrl |=3D TCTRL_INIT_CSUM;

After this patch, it seems vlan rx/tx for eTSEC works again.

Best regards

Staale Aakermann

________________________________

CONFIDENTIALITY
This e-mail and any attachment contain KONGSBERG information which may be p=
roprietary, confidential or subject to export regulations, and is only mean=
t for the intended recipient(s). Any disclosure, copying, distribution or u=
se is prohibited, if not otherwise explicitly agreed with KONGSBERG. If rec=
eived in error, please delete it immediately from your system and notify th=
e sender properly.
