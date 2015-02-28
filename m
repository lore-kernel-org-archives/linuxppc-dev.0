Return-Path: <jiri@resnulli.us>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E2F81A00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 19:59:39 +1100 (AEDT)
Received: by wghk14 with SMTP id k14so24571981wgh.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 00:59:34 -0800 (PST)
Date: Sat, 28 Feb 2015 09:59:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: Re: [PATCHi v2] ibmveth: Add function to enable live MAC address
 changes
Message-ID: <20150228085932.GA2012@nanopsycho.orion>
References: <1425102964-3131-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425102964-3131-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: brking@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sat, Feb 28, 2015 at 06:56:04AM CET, tlfalcon@linux.vnet.ibm.com wrote:
>Add a function that will enable changing the MAC address
>of an ibmveth interface while it is still running.
>
>Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>---
>v2:
>   If h_change_logical_lan_mac fails, dev->dev_addr will not be changed.
>
> drivers/net/ethernet/ibm/ibmveth.c | 25 ++++++++++++++++++++++++-
> 1 file changed, 24 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>index 21978cc..b6ac676 100644
>--- a/drivers/net/ethernet/ibm/ibmveth.c
>+++ b/drivers/net/ethernet/ibm/ibmveth.c
>@@ -1327,6 +1327,29 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
> 	return ret;
> }
> 
>+static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
>+{
>+	struct ibmveth_adapter *adapter = netdev_priv(dev);
>+	struct sockaddr *addr = p;
>+	u64 mac_address;
>+	int rc;
>+
>+	if (!is_valid_ether_addr(addr->sa_data))
>+		return -EADDRNOTAVAIL;
>+
>+	mac_address = ibmveth_encode_mac_addr(addr->sa_data);
>+	rc = h_change_logical_lan_mac(adapter->vdev->unit_address, mac_address);
>+	if (rc) {
>+		netdev_err(adapter->netdev, "h_change_logical_lan_mac failed "
>+			   "with rc=%d\n", rc);

Please do not wrap text in message. For that, 80-char limit does not apply.


>+		return rc;
>+	}
>+
>+	ether_addr_copy(dev->dev_addr, addr->sa_data);
>+
>+	return 0;
>+}
>+
> static const struct net_device_ops ibmveth_netdev_ops = {
> 	.ndo_open		= ibmveth_open,
> 	.ndo_stop		= ibmveth_close,
>@@ -1337,7 +1360,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
> 	.ndo_fix_features	= ibmveth_fix_features,
> 	.ndo_set_features	= ibmveth_set_features,
> 	.ndo_validate_addr	= eth_validate_addr,
>-	.ndo_set_mac_address	= eth_mac_addr,
>+	.ndo_set_mac_address    = ibmveth_set_mac_addr,
> #ifdef CONFIG_NET_POLL_CONTROLLER
> 	.ndo_poll_controller	= ibmveth_poll_controller,
> #endif
>-- 
>1.8.3.1
>
