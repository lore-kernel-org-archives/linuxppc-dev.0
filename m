Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6504A1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 07:51:21 +1000 (EST)
Date: Thu, 14 Jul 2011 14:50:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH] Correct offset_in_page mask bits in function
	edac_mc_handle_ce.
Message-Id: <20110714145042.9d2e88de.akpm@linux-foundation.org>
In-Reply-To: <1310608902-14221-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1310608902-14221-1-git-send-email-Shaohui.Xie@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kumar.gala@freescale.com, "Kai.Jiang" <Kai.Jiang@freescale.com>,
	djiang@mvista.com, ptyser@xes-inc.com, dougthompson@xmission.com,
	scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Jul 2011 10:01:42 +0800
Shaohui Xie <Shaohui.Xie@freescale.com> wrote:

> From: Kai.Jiang <Kai.Jiang@freescale.com>
> 
> Parameter offset_in_page in function edac_mc_handle_ce should be masked
> the higher bits above the page size, not the lower bits. The original input
> sometimes causes crash.
> 
> Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
> ---
>  drivers/edac/mpc85xx_edac.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 38ab8e2..b048a5f 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -854,11 +854,11 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
>  		mpc85xx_mc_printk(mci, KERN_ERR, "PFN out of range!\n");
>  
>  	if (err_detect & DDR_EDE_SBE)
> -		edac_mc_handle_ce(mci, pfn, err_addr & PAGE_MASK,
> +		edac_mc_handle_ce(mci, pfn, err_addr & ~PAGE_MASK,
>  				  syndrome, row_index, 0, mci->ctl_name);
>  
>  	if (err_detect & DDR_EDE_MBE)
> -		edac_mc_handle_ue(mci, pfn, err_addr & PAGE_MASK,
> +		edac_mc_handle_ue(mci, pfn, err_addr & ~PAGE_MASK,
>  				  row_index, mci->ctl_name);
>  
>  	out_be32(pdata->mc_vbase + MPC85XX_MC_ERR_DETECT, err_detect);

The patch should have had your Signed-off-by:, as described in
Documentation/SubmittingPatches.  I added your s-o-b to my copy -
please ack this.

>From the description it appears to me that this fix should be
backported into 2.6.39.x and earlier.  Do you agree?

The way to indicate this intention is to add "Cc: <stable@kernel.org>"
to the changelog.  I added that tag to my copy of this patch.
