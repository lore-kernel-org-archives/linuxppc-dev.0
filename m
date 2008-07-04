Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09E8FDDECA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 22:25:14 +1000 (EST)
Message-ID: <486E16A3.6020403@garzik.org>
Date: Fri, 04 Jul 2008 08:25:07 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2] fs_enet: restore promiscuous and multicast settings
	in restart()
References: <200806261148.26569.laurentp@cse-semaphore.com>
In-Reply-To: <200806261148.26569.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Matvejchikov Ilya <matvejchikov@gmail.com>,
	vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> The restart() function is called when the link state changes and resets
> multicast and promiscuous settings. This patch restores those settings at the
> end of restart().
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
>  drivers/net/fs_enet/mac-fcc.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
> index e363211..849afbe 100644
> --- a/drivers/net/fs_enet/mac-fcc.c
> +++ b/drivers/net/fs_enet/mac-fcc.c
> @@ -463,6 +463,9 @@ static void restart(struct net_device *dev)
>  	else
>  		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
>  
> +	/* Restore multicast and promiscuous settings */
> +	set_multicast_list(dev);
> +
>  	S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);

applied 2.6.26
