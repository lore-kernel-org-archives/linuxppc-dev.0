Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB791DDDCA
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 21:25:42 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp04.in.ibm.com (8.13.1/8.13.1) with ESMTP id mBTAPXff001075
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 15:55:33 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBTAPZc03731536
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 15:55:35 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id mBTAPWtT016746
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 21:25:32 +1100
Date: Mon, 29 Dec 2008 15:55:29 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] clean up of netif_rx_reschedule() changes in drivers
Message-ID: <20081229102509.GA11111@linux.vnet.ibm.com>
References: <20081229110041.0eca977a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20081229110041.0eca977a.sfr@canb.auug.org.au>
Cc: Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Linus <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Stephen Rothwell <sfr@canb.auug.org.au> [2008-12-29 11:00:41]:

> Hi Dave, Neil,
> 
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> 
> drivers/net/ibmveth.c: In function 'ibmveth_poll':
> drivers/net/ibmveth.c:1034: warning: passing argument 1 of 'netif_rx_reschedule' from incompatible pointer type
> drivers/net/ibmveth.c:1034: error: too many arguments to function 'netif_rx_reschedule'
> 
> Another miss in commit 908a7a16b852ffd618a9127be8d62432182d81b4 ("net: Remove
> unused netdev arg from some NAPI interfaces").
> 
> I have added the following patch for today.
> 
> (I wonder how many more there will be? :-()
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 29 Dec 2008 10:56:00 +1100
> Subject: [PATCH] net: ibmveth NAPI interface cleanup fix
> 
> Commit 908a7a16b852ffd618a9127be8d62432182d81b4 ("net: Remove unused
> netdev arg from some NAPI interfaces") missed one spot.

Hi Stephen,

	Thanks, the patch fixes the build failure for me.

  Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ibmveth.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
> index 1f055a9..9bc0f17 100644
> --- a/drivers/net/ibmveth.c
> +++ b/drivers/net/ibmveth.c
> @@ -1031,7 +1031,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  		netif_rx_complete(napi);
> 
>  		if (ibmveth_rxq_pending_buffer(adapter) &&
> -		    netif_rx_reschedule(netdev, napi)) {
> +		    netif_rx_reschedule(napi)) {
>  			lpar_rc = h_vio_signal(adapter->vdev->unit_address,
>  					       VIO_IRQ_DISABLE);
>  			goto restart_poll;
> -- 
> 1.6.0.5

I hit similar build failure due to the change in the netif_rx_reschedule()

drivers/net/ehea/ehea_main.c: In function 'ehea_poll':
drivers/net/ehea/ehea_main.c:844: warning: passing argument 1 of 'netif_rx_reschedule' from incompatible pointer type
drivers/net/ehea/ehea_main.c:844: error: too many arguments to function 'netif_rx_reschedule'
make[3]: *** [drivers/net/ehea/ehea_main.o] Error 1

greping through the sources for the changes missed out, we have

./drivers/net/arm/ixp4xx_eth.c:507:							netif_rx_reschedule(dev, napi)) {
./drivers/net/arm/ep93xx_eth.c:310:             if (more && netif_rx_reschedule(dev, napi))
./drivers/net/wan/ixp4xx_hss.c:657:							netif_rx_reschedule(dev, napi)) {

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
 drivers/net/arm/ep93xx_eth.c |    2 +-
 drivers/net/arm/ixp4xx_eth.c |    2 +-
 drivers/net/wan/ixp4xx_hss.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/arm/ep93xx_eth.c b/drivers/net/arm/ep93xx_eth.c
index 6ecc600..3ec20cc 100644
--- a/drivers/net/arm/ep93xx_eth.c
+++ b/drivers/net/arm/ep93xx_eth.c
@@ -307,7 +307,7 @@ poll_some_more:
 		}
 		spin_unlock_irq(&ep->rx_lock);
 
-		if (more && netif_rx_reschedule(dev, napi))
+		if (more && netif_rx_reschedule(napi))
 			goto poll_some_more;
 	}
 
diff --git a/drivers/net/arm/ixp4xx_eth.c b/drivers/net/arm/ixp4xx_eth.c
index 26af411..5fce1d5 100644
--- a/drivers/net/arm/ixp4xx_eth.c
+++ b/drivers/net/arm/ixp4xx_eth.c
@@ -504,7 +504,7 @@ static int eth_poll(struct napi_struct *napi, int budget)
 			netif_rx_complete(napi);
 			qmgr_enable_irq(rxq);
 			if (!qmgr_stat_empty(rxq) &&
-			    netif_rx_reschedule(dev, napi)) {
+			    netif_rx_reschedule(napi)) {
 #if DEBUG_RX
 				printk(KERN_DEBUG "%s: eth_poll"
 				       " netif_rx_reschedule successed\n",
diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 0c68025..2dc2416 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -654,7 +654,7 @@ static int hss_hdlc_poll(struct napi_struct *napi, int budget)
 			netif_rx_complete(dev, napi);
 			qmgr_enable_irq(rxq);
 			if (!qmgr_stat_empty(rxq) &&
-			    netif_rx_reschedule(dev, napi)) {
+			    netif_rx_reschedule(napi)) {
 #if DEBUG_RX
 				printk(KERN_DEBUG "%s: hss_hdlc_poll"
 				       " netif_rx_reschedule succeeded\n",
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
