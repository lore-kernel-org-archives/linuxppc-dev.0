Return-Path: <SRS0+703ff539752438bf2049+1557+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CA21DE0C4
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 05:04:37 +1100 (EST)
Subject: [PATCH] SET_NETDEV_DEV() in fec_mpc52xx.c
From: David Woodhouse <dwmw2@infradead.org>
To: jgarzik@pobox.com
Content-Type: text/plain
Date: Wed, 28 Nov 2007 18:04:31 +0000
Message-Id: <1196273071.30806.46.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This helps to allow the Fedora installer to use the built-in Ethernet on
the Efika for a network install.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -971,6 +971,8 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 
 	mpc52xx_fec_reset_stats(ndev);
 
+	SET_NETDEV_DEV(ndev, &op->dev);
+
 	/* Register the new network device */
 	rv = register_netdev(ndev);
 	if (rv < 0)

-- 
dwmw2
