Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76C0DB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Mar 2011 14:26:03 +1100 (EST)
Subject: Re: [PATCH][v2] driver/FSL SATA:Fix wrong Device Error Register usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
In-Reply-To: <1298282264-1222-1-git-send-email-prabhakar@freescale.com>
References: <1298282264-1222-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 14:25:47 +1100
Message-ID: <1299036347.8833.819.camel@pasglop>
Mime-Version: 1.0
Cc: meet2prabhu@gmail.com, B00888@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-21 at 15:27 +0530, Prabhakar Kushwaha wrote:
> When a single device error is detected, the device under the error is indicated
> by the error bit set in the DER. There is a one to one mapping between register
> bit and devices on Port multiplier(PMP) i.e. bit 0 represents PMP device 0 and
> bit 1 represents PMP device 1 etc.

It might help to send those patches to the linux-ide mailing list and
appropriate libata maintainers in addition to CC'ing linuxppc-dev.

Cheers,
Ben.

> Current implementation treats Device error register value as device number not
> set of bits representing multiple device on PMP. It is changed to consider bit
> level.
> No need to check for each set bit as all command is going to be aborted.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Signed-off-by: Ashish Kalra <B00888@freescale.com>
> ---
>  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)
> 
>  Changes for v1: Incorporated David Laight's comment
>  	- Single usage of ffs()
> 
>  Changes for v2: Incorporated David Laight's comment
>  	- Changed type of dev_num to unsigned
> 
>  drivers/ata/sata_fsl.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index b0214d0..895771c 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1040,12 +1040,14 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  
>  		/* find out the offending link and qc */
>  		if (ap->nr_pmp_links) {
> +			unsigned int dev_num;
>  			dereg = ioread32(hcr_base + DE);
>  			iowrite32(dereg, hcr_base + DE);
>  			iowrite32(cereg, hcr_base + CE);
>  
> -			if (dereg < ap->nr_pmp_links) {
> -				link = &ap->pmp_link[dereg];
> +			dev_num = ffs(dereg)-1;
> +			if (dev_num < ap->nr_pmp_links) {
> +				link = &ap->pmp_link[dev_num];
>  				ehi = &link->eh_info;
>  				qc = ata_qc_from_tag(ap, link->active_tag);
>  				/*
