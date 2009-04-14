Return-Path: <a.beregalov@gmail.com>
Date: Tue, 14 Apr 2009 22:39:38 +0400
From: Alexander Beregalov <a.beregalov@gmail.com>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [BUILD FAILURE 06/12] Next April 14 : PPC64 randconfig
	[drivers/net/ehea/ehea_main.c]
Message-ID: <20090414183938.GA17134@orion>
References: <1239733747.5344.78.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239733747.5344.78.camel@subratamodak.linux.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jan-Bernd Themann <themann@de.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	sachinp <sachinp@linux.vnet.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Julia Lawall <julia@diku.dk>, linux-next <linux-next@vger.kernel.org>,
	linux-net <linux-net@vger.kernel.org>,
	Mel Gorman <mel@skynet.ie>, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 14, 2009 at 11:59:07PM +0530, Subrata Modak wrote:
> Observed the following build error:
> CC      drivers/net/ehea/ehea_main.o
> drivers/net/ehea/ehea_main.c: In function ???ehea_setup_single_port???:
> drivers/net/ehea/ehea_main.c:3145: error: ???struct net_device??? has no
> member named ???tx_timeout???

>From 56142fa2ed992aeee3f2635990ac37807379a310 Mon Sep 17 00:00:00 2001
From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 14 Apr 2009 22:35:32 +0400
Subject: [PATCH] ehea: Fix incomplete conversion to net_device_ops


Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 drivers/net/ehea/ehea_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index ac0c5b4..604c844 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -3080,7 +3080,8 @@ static const struct net_device_ops ehea_netdev_ops = {
 	.ndo_change_mtu		= ehea_change_mtu,
 	.ndo_vlan_rx_register	= ehea_vlan_rx_register,
 	.ndo_vlan_rx_add_vid	= ehea_vlan_rx_add_vid,
-	.ndo_vlan_rx_kill_vid	= ehea_vlan_rx_kill_vid
+	.ndo_vlan_rx_kill_vid	= ehea_vlan_rx_kill_vid,
+	.ndo_tx_timeout		= ehea_tx_watchdog,
 };
 
 struct ehea_port *ehea_setup_single_port(struct ehea_adapter *adapter,
@@ -3142,7 +3143,6 @@ struct ehea_port *ehea_setup_single_port(struct ehea_adapter *adapter,
 		      | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM | NETIF_F_HW_VLAN_TX
 		      | NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER
 		      | NETIF_F_LLTX;
-	dev->tx_timeout = &ehea_tx_watchdog;
 	dev->watchdog_timeo = EHEA_WATCH_DOG_TIMEOUT;
 
 	INIT_WORK(&port->reset_task, ehea_reset_port);
-- 
1.6.2.3
