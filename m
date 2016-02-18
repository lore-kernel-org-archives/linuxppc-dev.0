Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFFF81A05FE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:19:27 +1100 (AEDT)
Message-ID: <1455758364.2463.95.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Raghav Dogra <raghav.dogra@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Cc: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Date: Wed, 17 Feb 2016 19:19:24 -0600
In-Reply-To: <DB4PR04MB346600B0CB57C4F161C896589AE0@DB4PR04MB346.eurprd04.prod.outlook.com>
References: <1455516864-3594-1-git-send-email-raghav.dogra@nxp.com>
 <1455611695.2463.56.camel@buserror.net>
 <DB4PR04MB346600B0CB57C4F161C896589AE0@DB4PR04MB346.eurprd04.prod.outlook.com>
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

On Wed, 2016-02-17 at 14:40 +0000, Raghav Dogra wrote:
> 
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Tuesday, February 16, 2016 2:05 PM
> > To: Raghav Dogra <raghav.dogra@nxp.com>; linuxppc-dev@lists.ozlabs.org
> > Cc: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> > Subject: Re: [PATCH][v3] drivers/memory: Add deep sleep support for IFC
> > 
> > On Mon, 2016-02-15 at 11:44 +0530, Raghav Dogra wrote:
> > > 
> > > +
> > > +	ctrl->saved_regs = kzalloc(sizeof(struct fsl_ifc_regs),
> > > GFP_KERNEL);
> > > +	if (!ctrl->saved_regs)
> > > +		return -ENOMEM;
> > 
> > Allocate memory at probe time, not here.
> > 
> 
> But, why allocate memory at the probe when it is not known at that time
> whether
> deep sleep state would be required or not? Is that because we want to save
> time
> while going to deep sleep?

We also want to avoid potential failures here.  We can also keep the code
simpler by embedding this into the ctrl struct itself, and not dynamically
allocating it at all.

> > > 
> > > +	ifc_out32(0x0, &ifc->ifc_nand.nand_evter_intr_en);
> > > +	ifc_out32(0x0, &ifc->ifc_nor.nor_evter_intr_en);
> > > +	ifc_out32(0x0, &ifc->ifc_gpcm.gpcm_evter_intr_en);
> > > +
> > > +	memcpy_fromio(ctrl->saved_regs, ifc, sizeof(struct
> > > fsl_ifc_regs));
> > > +
> > > +/* save the interrupt values */
> > > +	ctrl->saved_regs->cm_evter_intr_en = cm_evter_intr_en;
> > > +	ctrl->saved_regs->ifc_nand.nand_evter_intr_en =
> > nand_evter_intr_en;
> > > +	ctrl->saved_regs->ifc_nor.nor_evter_intr_en =
> > > nor_evter_intr_en;
> > > +	ctrl->saved_regs->ifc_gpcm.gpcm_evter_intr_en =
> > gpcm_evter_intr_en;
> > 
> > Why didn't you use the memcpy_fromio() to save these, and clear intr_en
> > later?
> > 
> 
> I used it whenever I did a write/read on iomem. In this case, both memories 
> are non iomem.

Huh?  &ifc->ifc_nand.nand_evter_intr_en and such are iomem.

> > > +
> > > +/*
> > > + * IFC interrupts disabled
> > > + */
> > > +	ifc_out32(0x0, &ifc->cm_evter_intr_en);
> > > +	ifc_out32(0x0, &ifc->ifc_nand.nand_evter_intr_en);
> > > +	ifc_out32(0x0, &ifc->ifc_nor.nor_evter_intr_en);
> > > +	ifc_out32(0x0, &ifc->ifc_gpcm.gpcm_evter_intr_en);
> > > +
> > > +
> > > +	if (ctrl->saved_regs) {
> > > +		for (ifc_bank = 0; ifc_bank < FSL_IFC_BANK_COUNT;
> > > ifc_bank++) {
> > > +			ifc_out32(savd_regs
> > > ->cspr_cs[ifc_bank].cspr_ext,
> > > +					&ifc
> > > ->cspr_cs[ifc_bank].cspr_ext);
> > > +			ifc_out32(savd_regs->cspr_cs[ifc_bank].cspr,
> > > +					&ifc->cspr_cs[ifc_bank].cspr);
> > > +			ifc_out32(savd_regs->amask_cs[ifc_bank].amask,
> > > +					&ifc
> > > ->amask_cs[ifc_bank].amask);
> > > +			ifc_out32(savd_regs
> > > ->csor_cs[ifc_bank].csor_ext,
> > > +					&ifc
> > > ->csor_cs[ifc_bank].csor_ext);
> > > +			ifc_out32(savd_regs->csor_cs[ifc_bank].csor,
> > > +					&ifc->csor_cs[ifc_bank].csor);
> > 
> > Align continuation lines the way patchwork suggests ("&ifc" aligned with
> > "savd").
> 
> Okay, I will take care of this in the next patch.
> 
> > 
> > Does resume from deep sleep go via U-Boot (which would initialize these
> > registers) on these chips?
> 
> Yes, deep sleep resume goes via u-boot and these registers should be
> initialized 
> By u-boot.

So then we don't need to save/restore them.

> 

> > > +
> > > +/*
> > > +* IFC controller NOR machine registers */
> > > +		ifc_out32(savd_regs->ifc_nor.nor_evter_en,
> > > +					&ifc->ifc_nor.nor_evter_en);
> > > +		ifc_out32(savd_regs->ifc_nor.norcr, &ifc
> > > ->ifc_nor.norcr);
> > 
> > What uses these?
> > 
> 
> These registers are not used as such, but we would like to retain their
> value as they
> can be of help in case of error conditions.

I don't follow.  Neither of those registers reports errors, and the registers
that *do* report errors are generally w1c and thus you can't save/restore
them.

> > > 
> > > +
> > > +	ver = ifc_in32(&ctrl->regs->ifc_rev);
> > > +	ncfgr = ifc_in32(&ifc->ifc_nand.ncfgr);
> > > +	if (ver >= FSL_IFC_V1_3_0) {
> > > +
> > > +		ifc_out32(ncfgr | IFC_NAND_SRAM_INIT_EN,
> > > +					&ifc->ifc_nand.ncfgr);
> > > +		/* wait for  SRAM_INIT bit to be clear or timeout */
> > > +		timeout = IFC_TIMEOUT_MSECS;
> > > +		while ((ifc_in32(&ifc->ifc_nand.ncfgr) &
> > > +					IFC_NAND_SRAM_INIT_EN) &&
> > timeout)
> > > {
> > > +			cpu_relax();
> > > +			timeout--;
> > > +		}
> > 
> > How can this timeout be in milliseconds or any other real unit of time, if
> > it's
> > actually measuring loop iterations with no udelay() or similar?
> > 
> 
> Yes, it's not in millisecond any longer. Will change the name to
> IFC_WAIT_ITR

What does ITR mean?  And my complaint was not just about naming -- this type
of delay loop is inherently unpredictable.  Future chips might go through
100,000 loops a lot faster than current chips.  Use a timeout that reflects
actual time.


> > > +
> > > +		if (!timeout)
> > > +			dev_err(ctrl->dev, "Timeout waiting for IFC
> > > SRAM
> > > INIT");
> > > +	}
> > 
> > U-boot does this when the version is > 1.1.0 -- why >= 1.3.0 here?  Are
> > there
> > any versions in between 1.1.0 and 1.3.0?
> 
> Because only B4 and T4 are based on 1.1.0 which do not support deep sleep.
> The first board which supports deep sleep is T1040 which has version 1.3.0.

That's a lousy excuse for making the code look like only >= 1.3.0 needs SRAM
init.  BTW, we should be doing this SRAM init on regular boot as well, since
we shouldn't rely on it having happened in the bootloader.

> > Also, how did Linux and U-Boot end up having opposite argument ordering
> > for ifc_out32()? :-(
> > 
> > -Scott
> 
> I guess it happened in the patch:
> https://patchwork.ozlabs.org/patch/474719/
> Let's keep it that way now? Changing it would require significant work.

I'm not suggesting that it be changed now -- just grumbling, and hoping that
we're more careful next time.

-Scott
