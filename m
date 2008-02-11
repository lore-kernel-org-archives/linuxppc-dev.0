Return-Path: <alex.bou9@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id 2807CDDECD
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 06:33:42 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4678451wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:33:41 -0800 (PST)
Message-ID: <d5f62df20802111133x4c1669efybb0895c3f2210f6e@mail.gmail.com>
Date: Mon, 11 Feb 2008 14:33:40 -0500
From: "Alex Bounine" <alex.bou9@gmail.com>
To: jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [PATCH 1/5 v3] Tsi108_eth: add missing linking to driver data
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bug fix for tsi108_eth network driver.
This patch adds missing linking to driver data.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-01-24 17:58:37.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
14:30:04.000000000 -0500
@@ -1629,6 +1629,7 @@ tsi108_init_one(struct platform_device *
 		goto register_fail;
 	}

+	platform_set_drvdata(pdev, dev);
 	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: %s\n",
 	       dev->name, print_mac(mac, dev->dev_addr));
 #ifdef DEBUG
