Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id 4C7DA4F45F
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 08:53:47 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so1259631rvb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 15:53:46 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 13/13] net: fix fsl_pq_mdio driver to use module_init()
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Andy Fleming <afleming@freescale.com>, David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 25 Apr 2009 16:53:44 -0600
Message-ID: <20090425225344.32392.18956.stgit@localhost.localdomain>
In-Reply-To: <20090425224458.32392.31296.stgit@localhost.localdomain>
References: <20090425224458.32392.31296.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Modules are not supposed to use any of the *_initcall*() hooks as
the entry point.  fsl_pq_mdio.c was using subsys_initcall_sync()
instead of module_init() to guarantee that the MDIO bus was initialized
before the Ethernet driver goes looking for the phy.  However, the recent
OF helpers rework happens to also make sure PHY connection is deferred to
.open time, so using an initcall is no longer necessary.

This patch replaces the initcall with a more traditional an accepted
module_init() call.

Tested on Freescale MPC8349emitxgp eval board.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/net/fsl_pq_mdio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
index b01daa1..d12e0e0 100644
--- a/drivers/net/fsl_pq_mdio.c
+++ b/drivers/net/fsl_pq_mdio.c
@@ -415,10 +415,10 @@ int __init fsl_pq_mdio_init(void)
 {
 	return of_register_platform_driver(&fsl_pq_mdio_driver);
 }
+module_init(fsl_pq_mdio_init);
 
 void fsl_pq_mdio_exit(void)
 {
 	of_unregister_platform_driver(&fsl_pq_mdio_driver);
 }
-subsys_initcall_sync(fsl_pq_mdio_init);
 module_exit(fsl_pq_mdio_exit);
