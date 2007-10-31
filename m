Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id C536ADE0DB
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 17:29:34 +1100 (EST)
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQR000LWJBV13D0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 31 Oct 2007 00:28:43 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQR00CRTJBUZT70@pd3mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 31 Oct 2007 00:28:43 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQR00EFIJBU6730@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 31 Oct 2007 00:28:42 -0600 (MDT)
Date: Wed, 31 Oct 2007 00:28:42 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] [POWERPC] mpc5200: Fix Kconfig dependancies on MPC5200	FEC
	device driver
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-id: <20071031062842.7966.99739.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

When not building an arch/powerpc kernel, the mpc5200 FEC driver depends
on some symbols which are not defined (BESTCOMM & BESTCOMM_FEC).

This patch flips around the dependancy logic so that it cannot be
selected unless BESTCOMM_FEC is selected first.  Kconfig stops
complaining this way.

Also, the driver only works for arch/powerpc (not arch/ppc) anyway so
it should depend on PPC_MERGE also.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/net/Kconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 867cb73..5f800a6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1883,9 +1883,7 @@ config FEC2
 
 config FEC_MPC52xx
 	tristate "MPC52xx FEC driver"
-	depends on PPC_MPC52xx
-	select PPC_BESTCOMM
-	select PPC_BESTCOMM_FEC
+	depends on PPC_MERGE && PPC_MPC52xx && PPC_BESTCOMM_FEC
 	select CRC32
 	select PHYLIB
 	---help---
