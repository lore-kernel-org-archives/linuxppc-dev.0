Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3B2DCDDF44
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 04:07:56 +1100 (EST)
Message-ID: <4745B41B.3040904@scram.de>
Date: Thu, 22 Nov 2007 17:53:47 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH resend 1/4] powerpc: fix typo #ifdef -> #ifndef
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fpi->cp_command should be overwritten only if CONFIG_PPC_CPM_NEW_BINDING
is NOT set. Otherwise it is already set from the device tree.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/net/fs_enet/mac-scc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 03134f4..48f2f30 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -158,7 +158,7 @@ static int setup_data(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);

-#ifdef CONFIG_PPC_CPM_NEW_BINDING
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 	struct fs_platform_info *fpi = fep->fpi;

 	fep->scc.idx = fs_get_scc_index(fpi->fs_no);
-- 
1.5.3.4
