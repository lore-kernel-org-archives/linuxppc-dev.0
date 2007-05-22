Return-Path: <linas@austin.ibm.com>
Date: Tue, 22 May 2007 18:52:37 -0500
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 10/10] spidernet: increase the NAPI weight
Message-ID: <20070522235237.GI2147@austin.ibm.com>
References: <20070522230942.GT5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070522230942.GT5921@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, Florin Malita <fmalita@gmail.com>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Another way of minimizing the likelyhood of RX ram from overflowing
is to empty out the entire rx ring every chance we get. Change
the crazy watchdog timeout from 50 seconds to 3 seconds, while
we're here.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: netdev-2.6/drivers/net/spider_net.h
===================================================================
--- netdev-2.6.orig/drivers/net/spider_net.h	2007-05-22 18:03:24.000000000 -0500
+++ netdev-2.6/drivers/net/spider_net.h	2007-05-22 18:03:43.000000000 -0500
@@ -56,8 +56,13 @@ extern char spider_net_driver_name[];
 
 #define SPIDER_NET_RX_CSUM_DEFAULT		1
 
-#define SPIDER_NET_WATCHDOG_TIMEOUT		50*HZ
-#define SPIDER_NET_NAPI_WEIGHT			64
+#define SPIDER_NET_WATCHDOG_TIMEOUT		3*HZ
+
+/* We really really want to empty the ring buffer every time,
+ * so as to avoid the RX ram full bug. So set the napi weight
+ * to the ring size.
+ */
+#define SPIDER_NET_NAPI_WEIGHT			SPIDER_NET_RX_DESCRIPTORS_DEFAULT
 
 #define SPIDER_NET_FIRMWARE_SEQS	6
 #define SPIDER_NET_FIRMWARE_SEQWORDS	1024
