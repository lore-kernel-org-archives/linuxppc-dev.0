Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 175DB1A05FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 08:31:23 +1100 (AEDT)
Message-ID: <1446067854.701.365.camel@freescale.com>
Subject: Re: [V5, 2/6] fsl/fman: Add FMan support
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bucur
 Madalin-Cristian-B32716" <madalin.bucur@freescale.com>
Date: Wed, 28 Oct 2015 16:30:54 -0500
In-Reply-To: <BL2PR03MB5006080090B6783629A33A5E6220@BL2PR03MB500.namprd03.prod.outlook.com>
References: <1442836354-5445-1-git-send-email-igal.liberman@freescale.com>
 <20150925230153.GA4626@home.buserror.net>
 <BL2PR03MB5006080090B6783629A33A5E6220@BL2PR03MB500.namprd03.prod.outlook.com>
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

On Tue, 2015-10-27 at 11:32 -0500, Liberman Igal-B31950 wrote:

> > > +
> > > +struct device *fman_get_device(struct fman *fman) {
> > > + return fman->dev;
> > > +}
> > 
> > Is this really necessary?
> > 
> 
> Fman port needs fman->dev, fman structure is opaque, so yes, it's needed.

Why is opacity being maintained from one part of the fman driver to another?  
Isn't this the sort of excessive layering that was complained about?


> > > +         /* In B4 rev 2.0 (and above) the MURAM size is 512KB.
> > > +          * Check the SVR and update MURAM size if required.
> > > +          */
> > > +         u32 svr;
> > > +
> > > +         svr = mfspr(SPRN_SVR);
> > > +
> > > +         if ((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_MAJ(svr) >=
> > 2))
> > > +                 fman->dts_params.muram_size = 0x80000;
> > > + }
> > 
> > Why wasn't the MURAM size described in the device tree, as it was with
> > CPM/QE?
> > 
> 
> MURAM size described by the device-tree.
> In B4860 rev 2.0 (and above) MURAM size is bigger. 
> This is workaround, in order to have the same device tree for all B4860 
> revisions.

We don't support b4860 prior to rev 2.0 (due to e6500 core errata) so this is 
irrelevant.  Fix the device tree.

> > > +
> > > + of_node_put(muram_node);
> > > + of_node_put(fm_node);
> > > +
> > > + err = devm_request_irq(&of_dev->dev, irq, fman_irq,
> > > +                        IRQF_NO_SUSPEND, "fman", fman);
> > > + if (err < 0) {
> > > +         pr_err("Error: allocating irq %d (error = %d)\n", irq, err);
> > > +         goto fman_free;
> > > + }
> > 
> > Why IRQF_NO_SUSPEND?
> > 
> 
> It shouldn't be IRQF_NO_SUSPEND for now, removed. 

Why just "for now"?

-Scott
