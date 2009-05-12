Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9519DDFC0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 18:41:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4C8fUKi017513
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 01:41:41 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4C8fMVD006912
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:41:30 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: akpm@linux-foundation.org, galak@kernel.crashing.org, davem@davemloft.net,
	mporter@kernel.crashing.org
Subject: [PATCH 6/6] rio: fix section mismatch
Date: Tue, 12 May 2009 16:36:03 +0800
Message-Id: <1242117363-14949-6-git-send-email-leoli@freescale.com>
In-Reply-To: <1242117363-14949-5-git-send-email-leoli@freescale.com>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<1242117363-14949-2-git-send-email-leoli@freescale.com>
	<1242117363-14949-3-git-send-email-leoli@freescale.com>
	<1242117363-14949-4-git-send-email-leoli@freescale.com>
	<1242117363-14949-5-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/rapidio/rio-scan.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 0838fb2..e29be3c 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -296,7 +296,7 @@ static int __devinit rio_add_device(struct rio_dev *rdev)
  * to a RIO device on success or NULL on failure.
  *
  */
-static struct rio_dev *rio_setup_device(struct rio_net *net,
+static struct rio_dev __devinit *rio_setup_device(struct rio_net *net,
 					struct rio_mport *port, u16 destid,
 					u8 hopcount, int do_enum)
 {
@@ -569,7 +569,7 @@ static void rio_net_add_mport(struct rio_net *net, struct rio_mport *port)
  * Recursively enumerates a RIO network.  Transactions are sent via the
  * master port passed in @port.
  */
-static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
+static int __devinit rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 			 u8 hopcount)
 {
 	int port_num;
@@ -728,7 +728,7 @@ static int rio_enum_complete(struct rio_mport *port)
  * Recursively discovers a RIO network.  Transactions are sent via the
  * master port passed in @port.
  */
-static int
+static int __devinit
 rio_disc_peer(struct rio_net *net, struct rio_mport *port, u16 destid,
 	      u8 hopcount)
 {
-- 
1.5.4
