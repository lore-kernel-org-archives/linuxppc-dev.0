Return-Path: <rmcguire@videopresence.com>
Received: from smtpout09.prod.mesa1.secureserver.net
	(smtpout09-04.prod.mesa1.secureserver.net [64.202.165.17])
	by ozlabs.org (Postfix) with SMTP id C75B1DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 10:05:30 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Andy Fleming'" <afleming@freescale.com>
References: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>
	<000601c85fc5$41e48330$6405a8c0@absolut>
	<D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
Subject: RE: SET_NETDEV_DEV -> 83xx HDLC Driver??
Date: Tue, 29 Jan 2008 15:04:41 -0800
Message-ID: <002301c862cb$54f73770$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy,

/drivers/net/fec_8xx

Doesn't use the call, though I imagine it is legacy or only for older
boards.

Thanks for pointing me at the newer stuff, guess I had a brain cramp and
didn't think to look there. Also makes much more sense now that the 
pdev->dev is not a PCI device but a Platform device.

One question, since you've probably got more experience with this than I do.

The gianfar, and ucc_geth drivers are not modules. Is there a problem with
using these driver _probe_ functions in a module style driver? OR should I
just change my driver over to be a platform style?

As far as I can tell the HDLC driver I am trying to create for the 83xx is
going to be somewhat similar to the Ethernet driver. Only I don't want it
loaded as part of the kernel.

-Russ

> -----Original Message-----
> From: Andy Fleming [mailto:afleming@freescale.com]
> Sent: Tuesday, January 29, 2008 2:33 PM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: SET_NETDEV_DEV -> 83xx HDLC Driver??
> 
> 
> On Jan 25, 2008, at 20:43, Russell McGuire wrote:
> 
> > All,
> >
> > I am partly done porting a combination of the 83xx ATM driver and
> > dscc4 HDLC
> > driver into a 83xx HDLC driver.
> >
> > However, encounter a call I don't truly understand.
> >
> > SET_NETDEV_DEV(dev, pointer_to_some_handle);
> >
> > I can see plenty of examples of this registering some kind of PCI
> > device
> > handle, however in this case I am not using a PCI device. So what
> > should the
> > pointer be? Or can this call be ignored, and if so what are the
> > consequences?
> >
> > I see the some of the Freescale Ethernet devices don't use this call.
> >
> > Anyway, can somebody shed some light on if I am going to need this,
> > or a way
> > to get it to work, without creating a PCI device?
> 
> 
> Look at gianfar.c (which uses a platform_device) or ucc_geth (which
> uses an of_device).  Which freescale devices don't use that call?
> We'll fix them.
> 
> Andy
