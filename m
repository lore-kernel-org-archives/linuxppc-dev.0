Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D641DDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 23:14:42 +1000 (EST)
Message-ID: <46D8143C.9030603@garzik.org>
Date: Fri, 31 Aug 2007 09:14:36 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/6] ibmveth: Add ethtool TSO handlers
References: <11873601831813-patch-mail.ibm.com>
	<200708171416.l7HEGbwx003958@d01av02.pok.ibm.com>
In-Reply-To: <200708171416.l7HEGbwx003958@d01av02.pok.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	santil@linux.vnet.ibm.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King wrote:
> Add handlers for get_tso and get_ufo to prevent errors being printed
> by ethtool.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  linux-2.6-bjking1/drivers/net/ibmveth.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -puN drivers/net/ibmveth.c~ibmveth_ethtool_get_tso drivers/net/ibmveth.c
> --- linux-2.6/drivers/net/ibmveth.c~ibmveth_ethtool_get_tso	2007-08-08 10:46:28.000000000 -0500
> +++ linux-2.6-bjking1/drivers/net/ibmveth.c	2007-08-08 10:46:28.000000000 -0500
> @@ -767,6 +767,8 @@ static const struct ethtool_ops netdev_e
>  	.set_tx_csum		= ibmveth_set_tx_csum,
>  	.get_rx_csum		= ibmveth_get_rx_csum,
>  	.set_rx_csum		= ibmveth_set_rx_csum,
> +	.get_tso			= ethtool_op_get_tso,
> +	.get_ufo			= ethtool_op_get_ufo,

This patch is fine, but I wonder if we shouldn't add some code to 
net/core/ethtool.c along the lines of...

	if (!netdev->ethtool_ops->get_tso)
		ethtool_op_get_tso(args);
	else
		netdev->ethtool_ops->get_tso(args);

Because this certainly seems like desirable behavior across all devices.
