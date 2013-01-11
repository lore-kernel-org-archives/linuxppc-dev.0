Return-Path: <B31383@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74FBF2C0233
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 21:47:28 +1100 (EST)
From: Mehresh Ramneek-B31383 <B31383@freescale.com>
To: "balbi@ti.com" <balbi@ti.com>, Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Date: Fri, 11 Jan 2013 10:47:20 +0000
Message-ID: <75A6930FC6B2FE479E2BC468C9240CE0C0096E@039-SN1MPN1-005.039d.mgd.msft.net>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
 <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
 <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111082731.GA11085@arwen.pp.htv.fi>
 <F281D0F91ED19E4D8E63A7504E8A649803D63DA7@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111084129.GB11085@arwen.pp.htv.fi>
 <94F013E7935FF44C83EBE7784D62AD3F09526C23@039-SN2MPN1-023.039d.mgd.msft.net>
 <20130111094618.GD11085@arwen.pp.htv.fi>
In-Reply-To: <20130111094618.GD11085@arwen.pp.htv.fi>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Chen Peter-B29397 <B29397@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Greg KH <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Friday, January 11, 2013 3:18 PM
> To: Li Yang-R58472
> Cc: balbi@ti.com; Chen Peter-B29397; Mehresh Ramneek-B31383;
> kernel@pengutronix.de; Greg KH; linux-usb@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on
> current v3.8-rc3
>=20
> Hi,
>=20
> On Fri, Jan 11, 2013 at 09:24:16AM +0000, Li Yang-R58472 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Felipe Balbi [mailto:balbi@ti.com]
> > > Sent: Friday, January 11, 2013 4:41 PM
> > > To: Chen Peter-B29397
> > > Cc: balbi@ti.com; kernel@pengutronix.de; Li Yang-R58472; Greg KH;
> > > linux- usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > > Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on
> > > current v3.8-rc3
> > >
> > > Hi,
> > >
> > > On Fri, Jan 11, 2013 at 08:35:29AM +0000, Chen Peter-B29397 wrote:
> > > > > > I am working on it, but there are two versions, this one and
> > > chipidea's.
> > > > > >
> > > > > > Anyway, I will send a patch to fix this problem.
> > > > >
> > > > > if you're already using chipidea, then send me a patch removing
> > > > > this driver and focus your effort on chipidea.
> > > > >
> > > > Added Sascha
> > > >
> > > > Now, not all of FSL i.mx USB can move to use chipidea due to some
> > > > platform and USB PHY problem.
> > >
> > > then we need to target fixing those problems and moving to chipidea
> > > completely at some point. There's no reason to duplicate efforts if
> > > we already have a re-usable driver in tree, right ?
> > >
> > > Let's fix this build break and focus on making sure all i.MX
> > > platforms can use chipidea so we can drop fsl udc on next merge
> > > window. That would be a great patchset to see.
> >
> > I do agree that we need move to use the chipidea driver and eventually
> > remove the fsl udc driver, but there were many users of the current
> > driver such as PowerPC and Coldfire platforms besides the i.MX
> > platforms.  The support for them with chipidea driver could also be
> > broken for now.  I would suggest to have a transitional period that
> > both drivers are kept while new development be based on the new
> > driver.
>=20
> right, right. That can be done as long as 'transitional period' isn't 20
> years. At least make a plan to remove fsl udc, if it doesn't happen in
> the next 4 merge windows, I will remove it myself to force people to
> reuse other drivers. There is no reason to keep both drivers around.
>=20
> > Added Ramneek.  What do you think of the current status for chipidea
> > driver on PowerPC platforms?
>=20
> that would be great to know, indeed.
>=20
> --
> balbi

As per my info, chipidea drv has never been tested for any ppc platforms we=
 have...
Also not sure how long chipidea will be used for ppc platforms...
Let me get back to you on this

-Ramneek=20
