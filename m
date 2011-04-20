Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 545C4B6FEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Apr 2011 02:23:53 +1000 (EST)
Date: Wed, 20 Apr 2011 11:23:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andrea Galbusera <gizero@gmail.com>
Subject: Re: [PATCH 1/1] powerpc: Fix multicast problem in fs_enet driver
Message-ID: <20110420112341.41d57444@schlenkerla.am.freescale.net>
In-Reply-To: <1303289719-16913-1-git-send-email-gizero@gmail.com>
References: <1303289719-16913-1-git-send-email-gizero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Apr 2011 10:55:19 +0200
Andrea Galbusera <gizero@gmail.com> wrote:

> mac-fec.c was setting individual UDP address registers instead of multicast
> group address registers when joining a multicast group.
> This prevented from correctly receiving UDP multicast packets.
> According to datasheet, replaced hash_table_high and hash_table_low
> with grp_hash_table_high and grp_hash_table_low respectively.
> 
> Tested on a MPC5121 based board.
> 
> Signed-off-by: Andrea Galbusera <gizero@gmail.com>
> ---
>  drivers/net/fs_enet/mac-fec.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
> index 61035fc..b9fbc83 100644
> --- a/drivers/net/fs_enet/mac-fec.c
> +++ b/drivers/net/fs_enet/mac-fec.c
> @@ -226,8 +226,8 @@ static void set_multicast_finish(struct net_device *dev)
>  	}
>  
>  	FC(fecp, r_cntrl, FEC_RCNTRL_PROM);
> -	FW(fecp, hash_table_high, fep->fec.hthi);
> -	FW(fecp, hash_table_low, fep->fec.htlo);
> +	FW(fecp, grp_hash_table_high, fep->fec.hthi);
> +	FW(fecp, grp_hash_table_low, fep->fec.htlo);
>  }
>  
>  static void set_multicast_list(struct net_device *dev)
> @@ -273,8 +273,8 @@ static void restart(struct net_device *dev)
>  	/*
>  	 * Reset all multicast.
>  	 */
> -	FW(fecp, hash_table_high, fep->fec.hthi);
> -	FW(fecp, hash_table_low, fep->fec.htlo);
> +	FW(fecp, grp_hash_table_high, fep->fec.hthi);
> +	FW(fecp, grp_hash_table_low, fep->fec.htlo);
>  
>  	/*
>  	 * Set maximum receive buffer size.

This will break on 8xx which does not have grp_hash_table_*.  It has only
one set of hash table registers which are used only for multicast -- so
8xx should have fec_hash_table_* renamed to fec_grp_hash_table_* in struct
fec.

-Scott
