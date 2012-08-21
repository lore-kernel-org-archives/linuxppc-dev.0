Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 756F32C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 00:24:59 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio: apply RX/TX enable to active switch ports only
Date: Tue, 21 Aug 2012 10:23:55 -0400
Message-Id: <1345559035-25879-2-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
References: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify RIO enumeration to apply RX/TX enable operations only to active
switch ports. This will leave inactive ports in condition consistent with
their state.

This patch is applicable to kernel versions starting from v2.6.35.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
---
 drivers/rapidio/rio-scan.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 2bebd79..02e686b 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -839,12 +839,10 @@ static int __devinit rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 		for (port_num = 0;
 		     port_num < RIO_GET_TOTAL_PORTS(rdev->swpinfo);
 		     port_num++) {
-			/*Enable Input Output Port (transmitter reviever)*/
-			rio_enable_rx_tx_port(port, 0,
+			if (sw_inport == port_num) {
+				rio_enable_rx_tx_port(port, 0,
 					      RIO_ANY_DESTID(port->sys_size),
 					      hopcount, port_num);
-
-			if (sw_inport == port_num) {
 				rdev->rswitch->port_ok |= (1 << port_num);
 				continue;
 			}
@@ -857,6 +855,9 @@ static int __devinit rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 				pr_debug(
 				    "RIO: scanning device on port %d\n",
 				    port_num);
+				rio_enable_rx_tx_port(port, 0,
+					      RIO_ANY_DESTID(port->sys_size),
+					      hopcount, port_num);
 				rdev->rswitch->port_ok |= (1 << port_num);
 				rio_route_add_entry(rdev, RIO_GLOBAL_TABLE,
 						RIO_ANY_DESTID(port->sys_size),
-- 
1.7.8.4
