Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 6C6B1B713A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Nov 2010 01:09:54 +1100 (EST)
Received: by ewy26 with SMTP id 26so1749464ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 06:09:52 -0800 (PST)
Date: Fri, 12 Nov 2010 17:09:47 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 2/2] ucc_geth: Fix deadlock
Message-ID: <20101112140947.GB28223@oksana.dev.rtsoft.ru>
References: <1289570109-8160-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1289570109-8160-2-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1289570109-8160-2-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 12, 2010 at 02:55:09PM +0100, Joakim Tjernlund wrote:
> This script:
>  while [ 1==1 ] ; do ifconfig eth0 up; usleep 1950000 ;ifconfig eth0 down; dmesg -c ;done
> causes in just a second or two:
> INFO: task ifconfig:572 blocked for more than 120 seconds.
[...]
> The reason appears to be ucc_geth_stop meets adjust_link as the
> PHY reports PHY changes. I belive adjust_link hangs somewhere,
> holding the PHY lock, because ucc_geth_stop disabled the
> controller HW.
> Fix is to stop the PHY before disabling the controller.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

It's unclear where exactly adjust_link() hangs, but the patch
looks as the right thing overall.

Thanks!

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

> ---
>  drivers/net/ucc_geth.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 6c254ed..06a5db3 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -2050,12 +2050,16 @@ static void ucc_geth_stop(struct ucc_geth_private *ugeth)
>  
>  	ugeth_vdbg("%s: IN", __func__);
>  
> +	/*
> +	 * Tell the kernel the link is down.
> +	 * Must be done before disabling the controller
> +	 * or deadlock may happen.
> +	 */
> +	phy_stop(phydev);
> +
>  	/* Disable the controller */
>  	ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);
>  
> -	/* Tell the kernel the link is down */
> -	phy_stop(phydev);
> -
>  	/* Mask all interrupts */
>  	out_be32(ugeth->uccf->p_uccm, 0x00000000);
