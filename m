Message-Id: <5.1.0.14.2.20030918025210.00b09160@mail.ebshome.net>
Date: Thu, 18 Sep 2003 03:01:06 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@ebshome.net>
Subject: [PATCH] ibm_emac: don't enable tx processing until device is
  opened
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!

There is a bug in PPC 4xx EMAC driver which in my case caused oops during
kernel startup.

Reason is simple, link timer enables tx processing _before_ device is
opened and driver may try to queue packet _before_ TCP/IP subsystem has
been initialized.

Quick fix against linuxppc-2.4 tree:

===== drivers/net/ibm_emac/ibm_ocp_enet.c 1.1 vs edited =====
--- 1.1/drivers/net/ibm_emac/ibm_ocp_enet.c	Thu Jul 10 12:50:02 2003
+++ edited/drivers/net/ibm_emac/ibm_ocp_enet.c	Thu Sep 18 02:51:18 2003
@@ -989,7 +989,8 @@
                   * latency peaks caused by this code
                   */
                  emac_reset_configure(fep);
-                emac_kick(fep);
+		if (fep->opened)
+            		emac_kick(fep);
  	} else {
  	        fep->timer_ticks = 0;
  	        netif_carrier_off(fep->ndev);

Thanks,

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
