Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 8D4CF474DA
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:10:27 +1100 (EST)
Message-ID: <490255DA.40104@consentry.com>
Date: Fri, 24 Oct 2008 16:10:18 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add missing irq free in fs_enet error path.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If something goes wrong attaching to phy driver, we weren't freeing the IRQ.

Signed-off-by: Mike Ditto <mditto@consentry.com>
---

cvs diff -r linux-2_6_27 -upN linux/drivers/net/fs_enet/fs_enet-main.c
Index: linux/drivers/net/fs_enet/fs_enet-main.c
===================================================================
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 fs_enet-main.c
--- linux/drivers/net/fs_enet/fs_enet-main.c    11 Oct 2008 02:53:59 -0000     1.1.1.1
+++ linux/drivers/net/fs_enet/fs_enet-main.c    24 Oct 2008 22:19:47 -0000
@@ -811,6 +811,7 @@ static int fs_enet_open(struct net_devic

        err = fs_init_phy(dev);
        if (err) {
+               fs_free_irq(dev, fep->interrupt);
                if (fep->fpi->use_napi)
                        napi_disable(&fep->napi);
                return err;
