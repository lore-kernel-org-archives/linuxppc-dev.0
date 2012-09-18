Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11CFB2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 04:29:02 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND] rapidio: apply RX/TX enable to active switch ports only
Date: Tue, 18 Sep 2012 14:27:13 -0400
Message-Id: <1347992833-13744-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Apply port RX/TX enable operations only to active switch ports.

RapidIO specification (Part 6: LP-Serial Physical Layer)
recommends to keep Output Port Enable (TX) and Input Port Enable (RX)
control bits in disabled state (0b0) after device reset. It also allows
to have implementation specific reset state for these bits.

This patch ensures that TX/RX enable action is applied only to active
switch's ports while preserving an initial state of inactive ones.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
---

RESEND: Initial submission of this patch was dropped due to feedback
comment which raised concern about some RapidIO switch implementations
that may be affected by the change. After specification and device details
review this patch declared to be safe because it preserves any combination
of initial states of RX/TX enable for inactive port. 

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
