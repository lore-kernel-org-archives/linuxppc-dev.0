Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA2401A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 02:42:03 +1000 (EST)
Message-ID: <1401900111.6603.325.camel@snotra.buserror.net>
Subject: Re: [RESEND PATCH] memory: Freescale CoreNet Coherency Fabric error
 reporting driver
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <Bharat.Bhushan@freescale.com>
Date: Wed, 4 Jun 2014 11:41:51 -0500
In-Reply-To: <967d9a5e0f7e4d0a8f5e7ec6b8e88ff2@BLUPR03MB566.namprd03.prod.outlook.com>
References: <20140530222743.GA6918@home.buserror.net>
 <967d9a5e0f7e4d0a8f5e7ec6b8e88ff2@BLUPR03MB566.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-04 at 03:17 -0500, Bhushan Bharat-R65777 wrote:
> > +struct ccf_err_regs {
> > +	u32 errdet;		/* 0x00 Error Detect Register */
> > +	/* 0x04 Error Enable (ccf1)/Disable (ccf2) Register */
> > +	u32 errdis;
> > +	/* 0x08 Error Interrupt Enable Register (ccf2 only) */
> > +	u32 errinten;
> > +	u32 cecar;		/* 0x0c Error Capture Attribute Register */
> > +	u32 cecadrh;		/* 0x10 Error Capture Address High */
> 
> s/cecadrh/cecaddrh/g
> This way we will be consistent with Reference manual.

It's "cecadrh" in ccf1 and "cecaddrh" in ccf2.  I suppose I should use
the latter since "errdet/errdis/errinten" are the ccf2 names.

> > +	u32 cecadrl;		/* 0x14 Error Capture Address Low */
> 
> s/cecadrl/cecaddrl/g
> 
> > +	u32 cecar2;		/* 0x18 Error Capture Attribute Register 2 */
> > +};
> > +
> > +/* LAE/CV also valid for errdis and errinten */
> > +#define ERRDET_LAE		(1 << 0)  /* Local Access Error */
> > +#define ERRDET_CV		(1 << 1)  /* Coherency Violation */
> > +#define ERRDET_CTYPE_SHIFT	26	  /* Capture Type (ccf2 only) */
> > +#define ERRDET_CTYPE_MASK	(0x3f << ERRDET_CTYPE_SHIFT)
> 
> Should not this be (0x1f << ERRDET_CTYPE_SHIFT)

Yes, thanks for catching that.

> > +#define ERRDET_CAP		(1 << 31) /* Capture Valid (ccf2 only) */
> > +
> > +#define CECAR_VAL		(1 << 0)  /* Valid (ccf1 only) */
> > +#define CECAR_UVT		(1 << 15) /* Unavailable target ID (ccf1) */
> > +#define CECAR_SRCID_SHIFT_CCF1	24
> > +#define CECAR_SRCID_MASK_CCF1	(0xff << CECAR_SRCID_SHIFT_CCF1)
> > +#define CECAR_SRCID_SHIFT_CCF2	18
> > +#define CECAR_SRCID_MASK_CCF2	(0xff << CECAR_SRCID_SHIFT_CCF2)
> > +
> > +#define CECADRH_ADDRH		0xf
> 
> On ccf2 this id 0xff.

OK.  I think we can get away with using 0xff on both.

> > +static int ccf_remove(struct platform_device *pdev) {
> > +	struct ccf_private *ccf = dev_get_drvdata(&pdev->dev);
> > +
> > +	switch (ccf->info->version) {
> > +	case CCF1:
> > +		iowrite32be(0, &ccf->err_regs->errdis);
> > +		break;
> > +
> > +	case CCF2:
> > +		iowrite32be(0, &ccf->err_regs->errinten);
> 
> Do you think it is same to disable detection bits in ccf->err_regs->errdis?

Disabling the interrupt is what we're aiming for here, but ccf1 doesn't
provide a way to do that separate from disabling detection.

-Scott
