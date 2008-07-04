Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D08BDDED1
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 22:17:37 +1000 (EST)
Message-ID: <486E14DA.6070104@garzik.org>
Date: Fri, 04 Jul 2008 08:17:30 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3] ibm_newemac: Fixes kernel crashes when speed of cable
	connected changes
References: <1214902685-10489-1-git-send-email-sr@denx.de>
In-Reply-To: <1214902685-10489-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sathya Narayanan <sathyan@teamf1.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> From: Sathya Narayanan <sathyan@teamf1.com>
> 
> The descriptor pointers were not initialized to NIL values, so it was
> poiniting to some random addresses which was completely invalid. This
> fix takes care of initializing the descriptor to NIL values and clearing
> the valid descriptors on clean ring operation.
> 
> Signed-off-by: Sathya Narayanan <sathyan@teamf1.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/net/ibm_newemac/core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index 5d2108c..ca63fa0 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -2719,6 +2719,8 @@ static int __devinit emac_probe(struct of_device *ofdev,
>  	/* Clean rings */
>  	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
>  	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
> +	memset(dev->tx_skb, 0, NUM_TX_BUFF * sizeof(struct sk_buff *));
> +	memset(dev->rx_skb, 0, NUM_RX_BUFF * sizeof(struct sk_buff *));
>  

applied to 2.6.26
