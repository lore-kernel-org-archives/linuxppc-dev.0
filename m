Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 75112DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 12:03:01 +1100 (EST)
Message-ID: <49027044.90509@consentry.com>
Date: Fri, 24 Oct 2008 18:03:00 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: Add missing irq free in fs_enet error path.
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
I just noticed this file has already been touched in -rc1 so here is the
patch again, adjusted accordingly.

diff -r -upN 2.6.28-rc1/drivers/net/fs_enet/fs_enet-main.c NEW/drivers/net/fs_enet/fs_enet-main.c
--- 2.6.28-rc1/drivers/net/fs_enet/fs_enet-main.c       2008-10-24 17:54:31.000000000 -0700
+++ NEW/drivers/net/fs_enet/fs_enet-main.c      2008-10-24 17:57:03.000000000 -0700
@@ -795,6 +795,7 @@ static int fs_enet_open(struct net_devic

        err = fs_init_phy(dev);
        if (err) {
+               free_irq(fep->interrupt, dev);
                if (fep->fpi->use_napi)
                        napi_disable(&fep->napi);
                return err;
