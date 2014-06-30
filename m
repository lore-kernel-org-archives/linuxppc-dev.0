Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D59381A001A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 06:59:58 +1000 (EST)
Message-ID: <1404161983.2435.182.camel@snotra.buserror.net>
Subject: Re: [RESEND PATCH] memory: Freescale CoreNet Coherency Fabric error
 reporting driver
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <Bharat.Bhushan@freescale.com>
Date: Mon, 30 Jun 2014 15:59:43 -0500
In-Reply-To: <806516468c994e638fc9214b0e5a7b9f@DM2PR03MB574.namprd03.prod.outlook.com>
References: <20140530222743.GA6918@home.buserror.net>
 <967d9a5e0f7e4d0a8f5e7ec6b8e88ff2@BLUPR03MB566.namprd03.prod.outlook.com>
 <1401900111.6603.325.camel@snotra.buserror.net>
 <35f1762b80694ba4835cd7902a2faa0a@BLUPR03MB566.namprd03.prod.outlook.com>
 <1401901656.6603.327.camel@snotra.buserror.net>
 <806516468c994e638fc9214b0e5a7b9f@DM2PR03MB574.namprd03.prod.outlook.com>
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

On Sun, 2014-06-29 at 23:58 -0500, Bhushan Bharat-R65777 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, June 04, 2014 10:38 PM
> > To: Bhushan Bharat-R65777
> > Cc: Greg Kroah-Hartman; linuxppc-dev@lists.ozlabs.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [RESEND PATCH] memory: Freescale CoreNet Coherency Fabric error
> > reporting driver
> > 
> > On Wed, 2014-06-04 at 12:04 -0500, Bhushan Bharat-R65777 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, June 04, 2014 10:12 PM
> > > > To: Bhushan Bharat-R65777
> > > > Cc: Greg Kroah-Hartman; linuxppc-dev@lists.ozlabs.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [RESEND PATCH] memory: Freescale CoreNet Coherency
> > > > Fabric error reporting driver
> > > >
> > > > On Wed, 2014-06-04 at 03:17 -0500, Bhushan Bharat-R65777 wrote:
> > > > > > +static int ccf_remove(struct platform_device *pdev) {
> > > > > > +	struct ccf_private *ccf = dev_get_drvdata(&pdev->dev);
> > > > > > +
> > > > > > +	switch (ccf->info->version) {
> > > > > > +	case CCF1:
> > > > > > +		iowrite32be(0, &ccf->err_regs->errdis);
> > > > > > +		break;
> > > > > > +
> > > > > > +	case CCF2:
> > > > > > +		iowrite32be(0, &ccf->err_regs->errinten);
> > > > >
> > > > > Do you think it is same to disable detection bits in ccf->err_regs-
> > >errdis?
> > > >
> > > > Disabling the interrupt is what we're aiming for here, but ccf1
> > > > doesn't provide a way to do that separate from disabling detection.
> > >
> > > What I wanted to say that do we also need to disable detection (set
> > > ERRDET_LAE | ERRDET_CV bits in errdis) apart from clearing errinten on
> > > ccf2 ?
> > 
> > I don't think we "need" to.  You could argue that we should for consistency,
> > though I think there's value in errors continuing to be detected even without
> > the driver (e.g. can dump the registers in a debugger).
> 
> Yes this comment was for consistency. Also IIUC, the state which is left when the driver is removed is not default reset behavior.

How many drivers leave the hardware in pristine reset state when
exiting?  And you could argue that having detection off by default is
poor hardware design (enabling interrupts is another matter of course).

> If we want errors to be detected then should not we have a sysfs interface?

That may be useful but it's beyond the scope of what I'm doing with this
patch.  We currently don't log machine checks anywhere but via printk
either.

BTW, I thought I had sent v2 of this, but I don't see it anywhere...
I'll respin soon.

-Scott
