Return-Path: <prabhakar@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 907FA1A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 16:11:56 +1100 (AEDT)
From: Kushwaha Prabhakar <prabhakar@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Dogra Raghav <raghav@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [1/2] mpc85xx/lbc: modify suspend/resume entry sequence
Date: Thu, 24 Dec 2015 04:38:11 +0000
Message-ID: <DM2PR0301MB06702E55727D2B36887B6E2DA9E70@DM2PR0301MB0670.namprd03.prod.outlook.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
 <20151224041924.GA18543@home.buserror.net>
In-Reply-To: <20151224041924.GA18543@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, December 24, 2015 9:49 AM
> To: Dogra Raghav-B46184 <raghav@freescale.com>
> Cc: linuxppc-dev@lists.ozlabs.org; Kushwaha Prabhakar-B32579
> <prabhakar@freescale.com>
> Subject: Re: [1/2] mpc85xx/lbc: modify suspend/resume entry sequence
>=20
> On Fri, Oct 30, 2015 at 11:54:59AM +0530, Raghav Dogra wrote:
> >  /* restore lbc registers */
> > -static int fsl_lbc_resume(struct platform_device *pdev)
> > +static int fsl_lbc_syscore_resume(void)
> >  {
> > -	struct fsl_lbc_ctrl *ctrl =3D dev_get_drvdata(&pdev->dev);
> > -	struct fsl_lbc_regs __iomem *lbc =3D ctrl->regs;
> > +	struct fsl_lbc_ctrl *ctrl;
> > +	struct fsl_lbc_regs __iomem *lbc;
> > +
> > +	ctrl =3D fsl_lbc_ctrl_dev;
> > +	if (!ctrl)
> > +		goto out;
> > +
> > +	lbc =3D ctrl->regs;
> > +	if (!lbc)
> > +		goto out;
> >
> >  	if (ctrl->saved_regs) {
> >  		_memcpy_toio(lbc, ctrl->saved_regs, @@ -379,7 +398,9 @@
> static int
> > fsl_lbc_resume(struct platform_device *pdev)
> >  		kfree(ctrl->saved_regs);
> >  		ctrl->saved_regs =3D NULL;
> >  	}
> > -	return 0;
> > +
> > +out:
> > +	return;
> >  }
>=20
> arch/powerpc/sysdev/fsl_lbc.c:401:2: error:
> 'return' with no value, in function returning non-void [-Werror=3Dreturn-=
type]
>=20
>=20
> >  #endif /* CONFIG_SUSPEND */
> >
> > @@ -391,20 +412,26 @@ static const struct of_device_id fsl_lbc_match[] =
=3D
> {
> >  	{},
> >  };
> >
> > +#ifdef CONFIG_SUSPEND
> > +static struct syscore_ops lbc_syscore_pm_ops =3D {
> > +	.suspend =3D fsl_lbc_syscore_suspend,
> > +	.resume =3D fsl_lbc_syscore_resume,
> > +};
> > +#endif
>=20
> arch/powerpc/sysdev/fsl_lbc.c:416:2: error:
> initialization from incompatible pointer type [-Werror]
> arch/powerpc/sysdev/fsl_lbc.c:416:2: error:
> (near initialization for 'lbc_syscore_pm_ops.resume') [-Werror]
>=20

Can you please help us with the tool-chain used for compiling.

--prabhakar
