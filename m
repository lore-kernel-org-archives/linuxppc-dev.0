Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 198B3B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 16:31:38 +1000 (EST)
Subject: Re: [PATCH 23/33] net/ps3: gelic - Add missing annotations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 16:31:24 +1000
Message-Id: <1245047484.19217.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 16:38 +0200, Geert Uytterhoeven wrote:
> probe functions should be __devinit
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Cc: Geoff Levand <geoffrey.levand@am.sony.com>

Please send to netdev or get an ack from davem.

Cheers,
Ben.

> ---
>  drivers/net/ps3_gelic_net.c      |   22 ++++++++++++----------
>  drivers/net/ps3_gelic_wireless.c |    6 +++---
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ps3_gelic_net.c b/drivers/net/ps3_gelic_net.c
> index 2b38f39..d1a5fb4 100644
> --- a/drivers/net/ps3_gelic_net.c
> +++ b/drivers/net/ps3_gelic_net.c
> @@ -214,9 +214,10 @@ static void gelic_card_free_chain(struct gelic_card *card,
>   *
>   * returns 0 on success, <0 on failure
>   */
> -static int gelic_card_init_chain(struct gelic_card *card,
> -				 struct gelic_descr_chain *chain,
> -				 struct gelic_descr *start_descr, int no)
> +static int __devinit gelic_card_init_chain(struct gelic_card *card,
> +					   struct gelic_descr_chain *chain,
> +					   struct gelic_descr *start_descr,
> +					   int no)
>  {
>  	int i;
>  	struct gelic_descr *descr;
> @@ -407,7 +408,7 @@ rewind:
>   *
>   * returns 0 on success, < 0 on failure
>   */
> -static int gelic_card_alloc_rx_skbs(struct gelic_card *card)
> +static int __devinit gelic_card_alloc_rx_skbs(struct gelic_card *card)
>  {
>  	struct gelic_descr_chain *chain;
>  	int ret;
> @@ -1422,8 +1423,8 @@ static const struct net_device_ops gelic_netdevice_ops = {
>   *
>   * fills out function pointers in the net_device structure
>   */
> -static void gelic_ether_setup_netdev_ops(struct net_device *netdev,
> -					 struct napi_struct *napi)
> +static void __devinit gelic_ether_setup_netdev_ops(struct net_device *netdev,
> +						   struct napi_struct *napi)
>  {
>  	netdev->watchdog_timeo = GELIC_NET_WATCHDOG_TIMEOUT;
>  	/* NAPI */
> @@ -1443,7 +1444,8 @@ static void gelic_ether_setup_netdev_ops(struct net_device *netdev,
>   * gelic_ether_setup_netdev initializes the net_device structure
>   * and register it.
>   **/
> -int gelic_net_setup_netdev(struct net_device *netdev, struct gelic_card *card)
> +int __devinit gelic_net_setup_netdev(struct net_device *netdev,
> +				     struct gelic_card *card)
>  {
>  	int status;
>  	u64 v1, v2;
> @@ -1491,7 +1493,7 @@ int gelic_net_setup_netdev(struct net_device *netdev, struct gelic_card *card)
>   * the card and net_device structures are linked to each other
>   */
>  #define GELIC_ALIGN (32)
> -static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
> +static struct gelic_card * __devinit gelic_alloc_card_net(struct net_device **netdev)
>  {
>  	struct gelic_card *card;
>  	struct gelic_port *port;
> @@ -1542,7 +1544,7 @@ static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
>  	return card;
>  }
>  
> -static void gelic_card_get_vlan_info(struct gelic_card *card)
> +static void __devinit gelic_card_get_vlan_info(struct gelic_card *card)
>  {
>  	u64 v1, v2;
>  	int status;
> @@ -1616,7 +1618,7 @@ static void gelic_card_get_vlan_info(struct gelic_card *card)
>  /**
>   * ps3_gelic_driver_probe - add a device to the control of this driver
>   */
> -static int ps3_gelic_driver_probe(struct ps3_system_bus_device *dev)
> +static int __devinit ps3_gelic_driver_probe(struct ps3_system_bus_device *dev)
>  {
>  	struct gelic_card *card;
>  	struct net_device *netdev;
> diff --git a/drivers/net/ps3_gelic_wireless.c b/drivers/net/ps3_gelic_wireless.c
> index 4f3ada6..b6b3ca9 100644
> --- a/drivers/net/ps3_gelic_wireless.c
> +++ b/drivers/net/ps3_gelic_wireless.c
> @@ -2442,7 +2442,7 @@ static const struct iw_handler_def gelic_wl_wext_handler_def = {
>  #endif
>  };
>  
> -static struct net_device *gelic_wl_alloc(struct gelic_card *card)
> +static struct net_device * __devinit gelic_wl_alloc(struct gelic_card *card)
>  {
>  	struct net_device *netdev;
>  	struct gelic_port *port;
> @@ -2722,7 +2722,7 @@ static struct ethtool_ops gelic_wl_ethtool_ops = {
>  	.set_rx_csum	= gelic_net_set_rx_csum,
>  };
>  
> -static void gelic_wl_setup_netdev_ops(struct net_device *netdev)
> +static void __devinit gelic_wl_setup_netdev_ops(struct net_device *netdev)
>  {
>  	struct gelic_wl_info *wl;
>  	wl = port_wl(netdev_priv(netdev));
> @@ -2738,7 +2738,7 @@ static void gelic_wl_setup_netdev_ops(struct net_device *netdev)
>  /*
>   * driver probe/remove
>   */
> -int gelic_wl_driver_probe(struct gelic_card *card)
> +int __devinit gelic_wl_driver_probe(struct gelic_card *card)
>  {
>  	int ret;
>  	struct net_device *netdev;
