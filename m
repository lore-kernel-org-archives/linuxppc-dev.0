Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vHJ0y6FJmzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 06:48:02 +1100 (AEDT)
Date: Mon, 6 Feb 2017 20:47:30 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: <mark.marshall@omicronenergy.com>
Cc: <computersforpeace@gmail.com>, <linux-mtd@lists.infradead.org>,
 markmarshall14@gmail.com, prabhakar.kushwaha@nxp.com,
 stable@vger.kernel.org, leoyang.li@nxp.com, oss@buserror.net,
 raghav.dogra@nxp.com, linuxppc-dev@lists.ozlabs.org, raghav@freescale.com,
 b44839@freescale.com
Subject: Re: [PATCH V2] mtd/ifc: Fix location of eccstat registers for IFC V1.0
Message-ID: <20170206204730.05882b11@bbrezillon>
In-Reply-To: <1485443907-11630-1-git-send-email-mark.marshall@omicronenergy.com>
References: <1485443907-11630-1-git-send-email-mark.marshall@omicronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Jan 2017 16:18:27 +0100
<mark.marshall@omicronenergy.com> wrote:

> From: Mark Marshall <mark.marshall@omicronenergy.com>
> 
> The commit 7a654172161c ("mtd/ifc: Add support for IFC controller
> version 2.0") added support for version 2.0 of the IFC controller.
> The version 2.0 controller has the ECC status registers at a different
> location to the previous versions.
> 
> Correct the fsl_ifc_nand structure so that the ECC status can be read
> from the correct location for both version 1.0 and 2.0 of the controller.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7a654172161c ("mtd/ifc: Add support for IFC controller version 2.0")
> Signed-off-by: Mark Marshall <mark.marshall@omicronenergy.com>

Applied after fixing the subject prefix: s/mtd\/ifc/mtd: nand: ifc:/.
Next time, please make sure to add 'nand' in the prefix, I don't care
if it's mtd/nand/xxxx or mtd: nand: xxx or mtd: nand/xxx, as long as
mtd and nand keywords are present ;-).

> ---
> 
> Changes since v1:
> 
> - simplified the reading of the registers.
> 
>  drivers/mtd/nand/fsl_ifc_nand.c | 8 +++++++-
>  include/linux/fsl_ifc.h         | 8 ++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
> index 0a177b1..d1570f5 100644
> --- a/drivers/mtd/nand/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/fsl_ifc_nand.c
> @@ -258,9 +258,15 @@ static void fsl_ifc_run_command(struct mtd_info *mtd)
>  		int bufnum = nctrl->page & priv->bufnum_mask;
>  		int sector = bufnum * chip->ecc.steps;
>  		int sector_end = sector + chip->ecc.steps - 1;
> +		__be32 *eccstat_regs;
> +
> +		if (ctrl->version >= FSL_IFC_VERSION_2_0_0)
> +			eccstat_regs = ifc->ifc_nand.v2_nand_eccstat;
> +		else
> +			eccstat_regs = ifc->ifc_nand.v1_nand_eccstat;
>  
>  		for (i = sector / 4; i <= sector_end / 4; i++)
> -			eccstat[i] = ifc_in32(&ifc->ifc_nand.nand_eccstat[i]);
> +			eccstat[i] = ifc_in32(&eccstat_regs[i]);
>  
>  		for (i = sector; i <= sector_end; i++) {
>  			errors = check_read_ecc(mtd, ctrl, eccstat, i);
> diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
> index 3f9778c..c332f0a 100644
> --- a/include/linux/fsl_ifc.h
> +++ b/include/linux/fsl_ifc.h
> @@ -733,8 +733,12 @@ struct fsl_ifc_nand {
>  	__be32 nand_erattr1;
>  	u32 res19[0x10];
>  	__be32 nand_fsr;
> -	u32 res20[0x3];
> -	__be32 nand_eccstat[6];
> +	u32 res20;
> +	/* The V1 nand_eccstat is actually 4 words that overlaps the
> +	 * V2 nand_eccstat.
> +	 */
> +	__be32 v1_nand_eccstat[2];
> +	__be32 v2_nand_eccstat[6];
>  	u32 res21[0x1c];
>  	__be32 nanndcr;
>  	u32 res22[0x2];
