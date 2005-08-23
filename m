Return-Path: <deboralh@fel.com.cn>
Received: from sina37-40.sina.com.cn (sina37-40.sina.net [202.108.37.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "securemail.sina.net",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 41B846810D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 21:13:45 +1000 (EST)
Date: Tue, 23 Aug 2005 19:18:29 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "linuxppc-embedde" <Linuxppc-embedded@ozlabs.org>
Message-Id: <20050823111345.41B846810D@ozlabs.org>
Subject: eldk-3.1.1 8xx FEC bug
Reply-To: deboralh@fel.com.cn
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi ALL:
   I find one problem with 8xx FEC driver.
   After "ifconfig eth0 down", again "ifconfig eth0 up", kernel dead
   I modify fec.c to fix this bug as below

   My board use MII

--- fec.c.org   2005-08-23 19:09:06.000000000 +0800
+++ fec.c       2005-08-23 19:07:50.000000000 +0800
@@ -2,6 +2,9 @@
 fec_enet_close(struct net_device *dev)
 {
        /* Don't know what to do yet.
+       */
+       struct fec_enet_private *fep = dev->priv;
+       del_timer( &fep->phy_timer_list );
        netif_stop_queue(dev);
        fec_stop(dev);



        Debora Liu
        deboralh@fel.com.cn
          2005-08-23
