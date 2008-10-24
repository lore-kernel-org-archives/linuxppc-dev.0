Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id ED899DDDE3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 00:54:55 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c34so91390anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 06:54:54 -0700 (PDT)
Date: Fri, 24 Oct 2008 09:53:14 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] ibm_newemac: Fix typo in flow control config option
Message-ID: <20081024135314.GA2299@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, hch@lst.de, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The recent build fix for ibm_newemac has a typo in the config
option #ifdef used for disabling flow control.  This corrects
it to the proper Kconfig option name.

Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 2ee2622..901212a 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2605,7 +2605,7 @@ static int __devinit emac_init_config(struct emac_instance *dev)
 		    of_device_is_compatible(np, "ibm,emac-440gr"))
 			dev->features |= EMAC_FTR_440EP_PHY_CLK_FIX;
 		if (of_device_is_compatible(np, "ibm,emac-405ez")) {
-#ifdef CONFIG_IBM_NEW_EMAC_NO_FLOW_CONTROL
+#ifdef CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL
 			dev->features |= EMAC_FTR_NO_FLOW_CONTROL_40x;
 #else
 			printk(KERN_ERR "%s: Flow control not disabled!\n",
