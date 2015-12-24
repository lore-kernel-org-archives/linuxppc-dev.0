Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2269A1A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 15:49:27 +1100 (AEDT)
Message-ID: <1450932555.18314.121.camel@freescale.com>
Subject: Re: [1/2] mpc85xx/lbc: modify suspend/resume entry sequence
From: Scott Wood <scottwood@freescale.com>
To: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>, Dogra Raghav-B46184
 <raghav@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 23 Dec 2015 22:49:15 -0600
In-Reply-To: <DM2PR0301MB06702E55727D2B36887B6E2DA9E70@DM2PR0301MB0670.namprd03.prod.outlook.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
 <20151224041924.GA18543@home.buserror.net>
 <DM2PR0301MB06702E55727D2B36887B6E2DA9E70@DM2PR0301MB0670.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-12-23 at 22:38 -0600, Kushwaha Prabhakar-B32579 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, December 24, 2015 9:49 AM
> > To: Dogra Raghav-B46184 <raghav@freescale.com>
> > Cc: linuxppc-dev@lists.ozlabs.org; Kushwaha Prabhakar-B32579
> > <prabhakar@freescale.com>
> > Subject: Re: [1/2] mpc85xx/lbc: modify suspend/resume entry sequence
> > 
> > On Fri, Oct 30, 2015 at 11:54:59AM +0530, Raghav Dogra wrote:
> > >  /* restore lbc registers */
> > > -static int fsl_lbc_resume(struct platform_device *pdev)
> > > +static int fsl_lbc_syscore_resume(void)
> > >  {
> > > -	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
> > > -	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> > > +	struct fsl_lbc_ctrl *ctrl;
> > > +	struct fsl_lbc_regs __iomem *lbc;
> > > +
> > > +	ctrl = fsl_lbc_ctrl_dev;
> > > +	if (!ctrl)
> > > +		goto out;
> > > +
> > > +	lbc = ctrl->regs;
> > > +	if (!lbc)
> > > +		goto out;
> > > 
> > >  	if (ctrl->saved_regs) {
> > >  		_memcpy_toio(lbc, ctrl->saved_regs, @@ -379,7 +398,9 @@
> > static int
> > > fsl_lbc_resume(struct platform_device *pdev)
> > >  		kfree(ctrl->saved_regs);
> > >  		ctrl->saved_regs = NULL;
> > >  	}
> > > -	return 0;
> > > +
> > > +out:
> > > +	return;
> > >  }
> > 
> > arch/powerpc/sysdev/fsl_lbc.c:401:2: error:
> > 'return' with no value, in function returning non-void [-Werror=return
> > -type]
> > 
> > 
> > >  #endif /* CONFIG_SUSPEND */
> > > 
> > > @@ -391,20 +412,26 @@ static const struct of_device_id fsl_lbc_match[] =
> > {
> > >  	{},
> > >  };
> > > 
> > > +#ifdef CONFIG_SUSPEND
> > > +static struct syscore_ops lbc_syscore_pm_ops = {
> > > +	.suspend = fsl_lbc_syscore_suspend,
> > > +	.resume = fsl_lbc_syscore_resume,
> > > +};
> > > +#endif
> > 
> > arch/powerpc/sysdev/fsl_lbc.c:416:2: error:
> > initialization from incompatible pointer type [-Werror]
> > arch/powerpc/sysdev/fsl_lbc.c:416:2: error:
> > (near initialization for 'lbc_syscore_pm_ops.resume') [-Werror]
> > 
> 
> Can you please help us with the tool-chain used for compiling.

It doesn't matter.  The patch is clearly wrong based on inspection.

-Scott
