Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 74C6ADDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 11:00:42 +1100 (EST)
Date: Mon, 29 Dec 2008 11:00:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>, Neil Horman
	<nhorman@tuxdriver.com>
Subject: linux-next: origin tree build failure
Message-Id: <20081229110041.0eca977a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linux-next@vger.kernel.org,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dave, Neil,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

drivers/net/ibmveth.c: In function 'ibmveth_poll':
drivers/net/ibmveth.c:1034: warning: passing argument 1 of 'netif_rx_reschedule' from incompatible pointer type
drivers/net/ibmveth.c:1034: error: too many arguments to function 'netif_rx_reschedule'

Another miss in commit 908a7a16b852ffd618a9127be8d62432182d81b4 ("net: Remove
unused netdev arg from some NAPI interfaces").

I have added the following patch for today.

(I wonder how many more there will be? :-()

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 29 Dec 2008 10:56:00 +1100
Subject: [PATCH] net: ibmveth NAPI interface cleanup fix

Commit 908a7a16b852ffd618a9127be8d62432182d81b4 ("net: Remove unused
netdev arg from some NAPI interfaces") missed one spot.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ibmveth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
index 1f055a9..9bc0f17 100644
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -1031,7 +1031,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		netif_rx_complete(napi);
 
 		if (ibmveth_rxq_pending_buffer(adapter) &&
-		    netif_rx_reschedule(netdev, napi)) {
+		    netif_rx_reschedule(napi)) {
 			lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 					       VIO_IRQ_DISABLE);
 			goto restart_poll;
-- 
1.6.0.5
