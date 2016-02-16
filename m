Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59F7D1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 19:35:00 +1100 (AEDT)
Message-ID: <1455611695.2463.56.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Raghav Dogra <raghav.dogra@nxp.com>, linuxppc-dev@lists.ozlabs.org
Cc: prabhakar.kushwaha@nxp.com
Date: Tue, 16 Feb 2016 02:34:55 -0600
In-Reply-To: <1455516864-3594-1-git-send-email-raghav.dogra@nxp.com>
References: <1455516864-3594-1-git-send-email-raghav.dogra@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH][v3] drivers/memory: Add deep sleep support for IFC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-15 at 11:44 +0530, Raghav Dogra wrote:
> Add support of suspend, resume function to support deep sleep.
> Also make sure of SRAM initialization  during resume.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Signed-off-by: Raghav Dogra <raghav.dogra@nxp.com>
> ---
> Changes for v3: Replace spin_event_timeout() with arch independent macro
> 
> Based on git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> branch "master"
> 
>  drivers/memory/fsl_ifc.c | 165
> +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsl_ifc.h  |   6 ++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> index acd1460..fa028bd 100644
> --- a/drivers/memory/fsl_ifc.c
> +++ b/drivers/memory/fsl_ifc.c
> @@ -24,6 +24,7 @@
>  #include <linux/compiler.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
> +#include <linux/delay.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> @@ -35,6 +36,8 @@
>  
>  struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
>  EXPORT_SYMBOL(fsl_ifc_ctrl_dev);
> +#define FSL_IFC_V1_3_0	0x01030000
> +#define IFC_TIMEOUT_MSECS	100000 /* 100ms */

What does the "MSECS" mean in IFC_TIMEOUT_MSECS?  It's a unit without a
quantity.

>  
>  /*
>   * convert_ifc_address - convert the base address
> @@ -309,6 +312,163 @@ err:
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +/* save ifc registers */
> +static int fsl_ifc_suspend(struct device *dev)
> +{
> +	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
> +	__be32 nand_evter_intr_en, cm_evter_intr_en, nor_evter_intr_en,
> +							 gpcm_evter_intr_en
> ;

s/__be32/u32/ as they've already been converted to host endianness.

Also please repeat the type on a new line rather than use continuation lines
to declare more variables (and don't indent continuation lines so far).

> +
> +	ctrl->saved_regs = kzalloc(sizeof(struct fsl_ifc_regs),
> GFP_KERNEL);
> +	if (!ctrl->saved_regs)
> +		return -ENOMEM;

Allocate memory at probe time, not here.

> +	cm_evter_intr_en = ifc_in32(&ifc->cm_evter_intr_en);
> +	nand_evter_intr_en = ifc_in32(&ifc->ifc_nand.nand_evter_intr_en);
> +	nor_evter_intr_en = ifc_in32(&ifc->ifc_nor.nor_evter_intr_en);
> +	gpcm_evter_intr_en = ifc_in32(&ifc->ifc_gpcm.gpcm_evter_intr_en);
> +
> +/* IFC interrupts disabled */
> +
> +	ifc_out32(0x0, &ifc->cm_evter_intr_en);

Indent the comments the same as the code.

> +	ifc_out32(0x0, &ifc->ifc_nand.nand_evter_intr_en);
> +	ifc_out32(0x0, &ifc->ifc_nor.nor_evter_intr_en);
> +	ifc_out32(0x0, &ifc->ifc_gpcm.gpcm_evter_intr_en);
> +
> +	memcpy_fromio(ctrl->saved_regs, ifc, sizeof(struct fsl_ifc_regs));
> +
> +/* save the interrupt values */
> +	ctrl->saved_regs->cm_evter_intr_en = cm_evter_intr_en;
> +	ctrl->saved_regs->ifc_nand.nand_evter_intr_en = nand_evter_intr_en;
> +	ctrl->saved_regs->ifc_nor.nor_evter_intr_en = nor_evter_intr_en;
> +	ctrl->saved_regs->ifc_gpcm.gpcm_evter_intr_en = gpcm_evter_intr_en;

Why didn't you use the memcpy_fromio() to save these, and clear intr_en later?

That said, I still don't like this approach.  I'd rather see the nand driver
save the registers it cares about, and this driver wouldn't have to do much
other than quiesce the rest of the interrupts.

> +
> +	return 0;
> +}
> +
> +/* restore ifc registers */
> +static int fsl_ifc_resume(struct device *dev)
> +{
> +	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
> +	struct fsl_ifc_regs *savd_regs = ctrl->saved_regs;
> +	uint32_t ver = 0, ncfgr, timeout, ifc_bank, i;

s/savd/saved/

> +
> +/*
> + * IFC interrupts disabled
> + */
> +	ifc_out32(0x0, &ifc->cm_evter_intr_en);
> +	ifc_out32(0x0, &ifc->ifc_nand.nand_evter_intr_en);
> +	ifc_out32(0x0, &ifc->ifc_nor.nor_evter_intr_en);
> +	ifc_out32(0x0, &ifc->ifc_gpcm.gpcm_evter_intr_en);
> +
> +
> +	if (ctrl->saved_regs) {
> +		for (ifc_bank = 0; ifc_bank < FSL_IFC_BANK_COUNT;
> ifc_bank++) {
> +			ifc_out32(savd_regs->cspr_cs[ifc_bank].cspr_ext,
> +					&ifc->cspr_cs[ifc_bank].cspr_ext);
> +			ifc_out32(savd_regs->cspr_cs[ifc_bank].cspr,
> +					&ifc->cspr_cs[ifc_bank].cspr);
> +			ifc_out32(savd_regs->amask_cs[ifc_bank].amask,
> +					&ifc->amask_cs[ifc_bank].amask);
> +			ifc_out32(savd_regs->csor_cs[ifc_bank].csor_ext,
> +					&ifc->csor_cs[ifc_bank].csor_ext);
> +			ifc_out32(savd_regs->csor_cs[ifc_bank].csor,
> +					&ifc->csor_cs[ifc_bank].csor);

Align continuation lines the way patchwork suggests ("&ifc" aligned with
"savd").

Does resume from deep sleep go via U-Boot (which would initialize these
registers) on these chips?

> +			for (i = 0; i < 4; i++) {
> +				ifc_out32(savd_regs
> ->ftim_cs[ifc_bank].ftim[i],
> +					&ifc->ftim_cs[ifc_bank].ftim[i]);
> +			}
> +		}
> +		ifc_out32(savd_regs->ifc_gcr, &ifc->ifc_gcr);
> +		ifc_out32(savd_regs->cm_evter_en, &ifc->cm_evter_en);
> +
> +/*
> +* IFC controller NAND machine registers
> +*/
> +		ifc_out32(savd_regs->ifc_nand.ncfgr, &ifc->ifc_nand.ncfgr);
> +		ifc_out32(savd_regs->ifc_nand.nand_fcr0,
> +						&ifc->ifc_nand.nand_fcr0);
> +		ifc_out32(savd_regs->ifc_nand.nand_fcr1,
> +						&ifc->ifc_nand.nand_fcr1);
> +		ifc_out32(savd_regs->ifc_nand.row0, &ifc->ifc_nand.row0);
> +		ifc_out32(savd_regs->ifc_nand.row1, &ifc->ifc_nand.row1);
> +		ifc_out32(savd_regs->ifc_nand.col0, &ifc->ifc_nand.col0);
> +		ifc_out32(savd_regs->ifc_nand.col1, &ifc->ifc_nand.col1);
> +		ifc_out32(savd_regs->ifc_nand.row2, &ifc->ifc_nand.row2);
> +		ifc_out32(savd_regs->ifc_nand.col2, &ifc->ifc_nand.col2);
> +		ifc_out32(savd_regs->ifc_nand.row3, &ifc->ifc_nand.row3);
> +		ifc_out32(savd_regs->ifc_nand.col3, &ifc->ifc_nand.col3);
> +		ifc_out32(savd_regs->ifc_nand.nand_fbcr,
> +						&ifc->ifc_nand.nand_fbcr);
> +		ifc_out32(savd_regs->ifc_nand.nand_fir0,
> +						&ifc->ifc_nand.nand_fir0);
> +		ifc_out32(savd_regs->ifc_nand.nand_fir1,
> +						&ifc->ifc_nand.nand_fir1);
> +		ifc_out32(savd_regs->ifc_nand.nand_fir2,
> +						&ifc->ifc_nand.nand_fir2);
> +		ifc_out32(savd_regs->ifc_nand.nand_csel,
> +						&ifc->ifc_nand.nand_csel);
> +		ifc_out32(savd_regs->ifc_nand.nandseq_strt,
> +						&ifc
> ->ifc_nand.nandseq_strt);
> +		ifc_out32(savd_regs->ifc_nand.nand_evter_en,
> +						&ifc
> ->ifc_nand.nand_evter_en);
> +		ifc_out32(savd_regs->ifc_nand.nanndcr, &ifc
> ->ifc_nand.nanndcr);

Many of these are either initialized by the NAND driver for each transaction,
or are not used at all.

> +
> +/*
> +* IFC controller NOR machine registers
> +*/
> +		ifc_out32(savd_regs->ifc_nor.nor_evter_en,
> +					&ifc->ifc_nor.nor_evter_en);
> +		ifc_out32(savd_regs->ifc_nor.norcr, &ifc->ifc_nor.norcr);

What uses these?

> +
> +/*
> + * IFC controller GPCM Machine registers
> + */
> +		ifc_out32(savd_regs->ifc_gpcm.gpcm_evter_en,
> +					&ifc->ifc_gpcm.gpcm_evter_en);
> +
> +
> +
> +/*
> + * IFC interrupts enabled
> + */
> +	ifc_out32(ctrl->saved_regs->cm_evter_intr_en, &ifc
> ->cm_evter_intr_en);
> +	ifc_out32(ctrl->saved_regs->ifc_nand.nand_evter_intr_en,
> +					&ifc->ifc_nand.nand_evter_intr_en);
> +	ifc_out32(ctrl->saved_regs->ifc_nor.nor_evter_intr_en,
> +					&ifc->ifc_nor.nor_evter_intr_en);
> +	ifc_out32(ctrl->saved_regs->ifc_gpcm.gpcm_evter_intr_en,
> +					&ifc->ifc_gpcm.gpcm_evter_intr_en);
> +
> +		kfree(ctrl->saved_regs);
> +		ctrl->saved_regs = NULL;
> +	}

Bad indentation

> +
> +	ver = ifc_in32(&ctrl->regs->ifc_rev);
> +	ncfgr = ifc_in32(&ifc->ifc_nand.ncfgr);
> +	if (ver >= FSL_IFC_V1_3_0) {
> +
> +		ifc_out32(ncfgr | IFC_NAND_SRAM_INIT_EN,
> +					&ifc->ifc_nand.ncfgr);
> +		/* wait for  SRAM_INIT bit to be clear or timeout */
> +		timeout = IFC_TIMEOUT_MSECS;
> +		while ((ifc_in32(&ifc->ifc_nand.ncfgr) &
> +					IFC_NAND_SRAM_INIT_EN) && timeout)
> {
> +			cpu_relax();
> +			timeout--;
> +		}

How can this timeout be in milliseconds or any other real unit of time, if
it's actually measuring loop iterations with no udelay() or similar?

Is it really necessary to spin here rather than waiting for an interrupt like
normal?

> +
> +		if (!timeout)
> +			dev_err(ctrl->dev, "Timeout waiting for IFC SRAM
> INIT");
> +	}

U-boot does this when the version is > 1.1.0 -- why >= 1.3.0 here?  Are there
any versions in between 1.1.0 and 1.3.0?

Also, how did Linux and U-Boot end up having opposite argument ordering for
ifc_out32()? :-(

-Scott
