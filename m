Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFA0BDDF6B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 22:17:44 +1000 (EST)
Message-ID: <486E14E3.6080402@garzik.org>
Date: Fri, 04 Jul 2008 08:17:39 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2] ibm_newemac: Fixes entry of short packets
References: <1214902699-10534-1-git-send-email-sr@denx.de>
In-Reply-To: <1214902699-10534-1-git-send-email-sr@denx.de>
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
> Short packets has to be discarded by the driver. So this patch addresses the
> issue of discarding the short packets of size lesser then ethernet header
> size.
> 
> Signed-off-by: Sathya Narayanan <sathyan@teamf1.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/net/ibm_newemac/core.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index ca63fa0..babc79a 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -1636,6 +1636,12 @@ static int emac_poll_rx(void *param, int budget)
>  			goto next;
>  		}
>  
> +		if (len < ETH_HLEN) {
> +			++dev->estats.rx_dropped_stack;
> +			emac_recycle_rx_skb(dev, slot, len);
> +			goto next;
> +		}
> +
>  		if (len && len < EMAC_RX_COPY_THRESH) {

applied 2.6.26
