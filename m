Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE6B91A002C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 06:49:06 +1000 (EST)
Message-ID: <1409086131.6510.80.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] fsl_ifc: Support all 8 IFC chip selects
From: Scott Wood <scottwood@freescale.com>
To: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 26 Aug 2014 15:48:51 -0500
In-Reply-To: <1720585700.271372.1409074298919.JavaMail.zimbra@xes-inc.com>
References: <1720585700.271372.1409074298919.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-26 at 12:31 -0500, Aaron Sierra wrote:
> Freescale's QorIQ T Series processors support 8 IFC chip selects
> within a memory map backward compatible with previous P Series
> processors which supported only 4 chip selects.
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/memory/fsl_ifc.c        |  2 +-
>  drivers/mtd/nand/fsl_ifc_nand.c | 17 ++++++++++-------
>  include/linux/fsl_ifc.h         | 34 +++++++++++++++++++++++++---------
>  3 files changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> index 3d5d792..a539dc2 100644
> --- a/drivers/memory/fsl_ifc.c
> +++ b/drivers/memory/fsl_ifc.c
> @@ -61,7 +61,7 @@ int fsl_ifc_find(phys_addr_t addr_base)
>  	if (!fsl_ifc_ctrl_dev || !fsl_ifc_ctrl_dev->regs)
>  		return -ENODEV;
>  
> -	for (i = 0; i < ARRAY_SIZE(fsl_ifc_ctrl_dev->regs->cspr_cs); i++) {
> +	for (i = 0; i < fsl_ifc_bank_count(fsl_ifc_ctrl_dev->regs); i++) {
>  		u32 cspr = in_be32(&fsl_ifc_ctrl_dev->regs->cspr_cs[i].cspr);
>  		if (cspr & CSPR_V && (cspr & CSPR_BA) ==
>  				convert_ifc_address(addr_base))
> diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
> index 2338124..f7b7077 100644
> --- a/drivers/mtd/nand/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/fsl_ifc_nand.c
> @@ -31,7 +31,6 @@
>  #include <linux/mtd/nand_ecc.h>
>  #include <linux/fsl_ifc.h>
>  
> -#define FSL_IFC_V1_1_0	0x01010000
>  #define ERR_BYTE		0xFF /* Value returned for read
>  					bytes when read failed	*/
>  #define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
> @@ -54,7 +53,7 @@ struct fsl_ifc_mtd {
>  /* overview of the fsl ifc controller */
>  struct fsl_ifc_nand_ctrl {
>  	struct nand_hw_control controller;
> -	struct fsl_ifc_mtd *chips[FSL_IFC_BANK_COUNT];
> +	struct fsl_ifc_mtd *chips[FSL_IFC_BANK_COUNT_MAX];

FSL_IFC_MAX_BANKS would be more concise.  I'm not sure we really need to
rename this, though.

> @@ -834,5 +843,12 @@ struct fsl_ifc_ctrl {
>  
>  extern struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
>  
> +static inline u32 fsl_ifc_version(struct fsl_ifc_regs *regs) {
> +	return ioread32be(&regs->ifc_rev) & FSL_IFC_VERSION_MASK;
> +}
> +
> +static inline int fsl_ifc_bank_count(struct fsl_ifc_regs *regs) {
> +	return (fsl_ifc_version(regs) == FSL_IFC_VERSION_1_0_0) ? 4 : 8;
> +}

Whitespace

Do we really need the bank count here, as opposed to just checking it in
probe()?  I also don't really care for reading the registers over and
over, even though it's not performance critical.

The reserved bits of the version register are defined as zero for
current versions -- I think just comparing ifc_rev to the version
constant, as is currently done, is fine.

Also, please send the patch to the mtd list and maintainer.

-Scott
