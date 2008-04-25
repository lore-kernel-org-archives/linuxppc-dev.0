Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDAADDDECF
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 16:01:44 +1000 (EST)
Message-ID: <481173C1.8060300@pobox.com>
Date: Fri, 25 Apr 2008 02:01:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] ibm_newemac: Fix problem with jumbo frame support
	and EMAC V4.patch
References: <20080422004758.1A823DE19B@ozlabs.org>
In-Reply-To: <20080422004758.1A823DE19B@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> From: Stefan Roese <sr@denx.de>
> 
> This fixes the jumbo frame support on EMAC V4 systems. Now the correct
> bit is set depending on the EMAC version configured.
> 
> Tested on Kilauea (405EX) and Canyonlands (460EX).
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
>  drivers/net/ibm_newemac/core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index 0789802..486901f 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -524,7 +524,10 @@ static int emac_configure(struct emac_instance *dev)
>  		rx_size = dev->rx_fifo_size_gige;
>  
>  		if (dev->ndev->mtu > ETH_DATA_LEN) {
> -			mr1 |= EMAC_MR1_JPSM;
> +			if (emac_has_feature(dev, EMAC_FTR_EMAC4))
> +				mr1 |= EMAC4_MR1_JPSM;
> +			else
> +				mr1 |= EMAC_MR1_JPSM;
>  			dev->stop_timeout = STOP_TIMEOUT_1000_JUMBO;
>  		} else
>  			dev->stop_timeout = STOP_TIMEOUT_1000;

applied 1-6
