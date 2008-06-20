Return-Path: <billfink@mindspring.com>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id C4E23DDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 13:01:35 +1000 (EST)
Date: Thu, 19 Jun 2008 23:01:28 -0400
From: Bill Fink <billfink@mindspring.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
Message-Id: <20080619230128.def96ee0.billfink@mindspring.com>
In-Reply-To: <200806181707.17739.laurentp@cse-semaphore.com>
References: <200806181707.17739.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Jun 2008, Laurent Pinchart wrote:

> The restart() function is called when the link state changes and resets
> multicast and promiscous settings. This patch restores those settings at the
> end of restart().
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
>  drivers/net/fs_enet/mac-fcc.c     |    3 +++
>  2 files changed, 4 insertions(+), 1 deletions(-)

Is the whole patch here?  The above says 2 files changed and 5 lines
changed, but what's included here is only 1 file and 3 line changes.

> diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
> index ce40cf9..1a95cf1 100644
> --- a/drivers/net/fs_enet/mac-fcc.c
> +++ b/drivers/net/fs_enet/mac-fcc.c
> @@ -464,6 +464,9 @@ static void restart(struct net_device *dev)
>  		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
>  
>  	S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
> +
> +	/* Restore multicast and promiscous settings */
> +	set_multicast_list(dev);
>  }
>  
>  static void stop(struct net_device *dev)

						-Bill
