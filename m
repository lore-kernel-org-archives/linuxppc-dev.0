Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 478D0DE2B3
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 01:56:52 +1000 (EST)
Date: Mon, 30 Jun 2008 10:56:42 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] update crypto node definition and device tree instances
Message-Id: <20080630105642.78df36f9.kim.phillips@freescale.com>
In-Reply-To: <fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
References: <20080627115243.d76e0814.kim.phillips@freescale.com>
	<fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 27 Jun 2008 22:29:59 -0700
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Fri, Jun 27, 2008 at 9:52 AM, Kim Phillips
> <kim.phillips@freescale.com> wrote:
> > delete obsolete device-type property, delete model property
> > (use compatible property instead), prepend "fsl," to Freescale
> > specific properties. Add nodes to device trees that are missing them,
> > and fix broken property values in other trees.
> >
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> 
> Are there any drivers in mainline which use this node?  Do these

there's one sitting on kernel.org's cryptodev-2.6 tree.

> changes break backwards compatibility with already deployed boards?
> (I know; this patch doesn't change any code; but I'm asking whether
> the driver will need to support both old and new bindings).

Since the driver won't go in until 2.6.27 (and hopefully this patch),
I'm guessing no.  There are out-of-tree drivers that will need to be
updated to handle the new bindings, however.

> > ---
> > diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> > index 46e2da3..9a3881d 100644
> > --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> > +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> > @@ -226,22 +226,15 @@
> >                        compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
> >                };
> >
> > -/* May need to remove if on a part without crypto engine */
> >                crypto@30000 {
> > -                       device_type = "crypto";
> > -                       model = "SEC2";
> > -                       compatible = "fsl,mpc8272-talitos-sec2",
> > -                                    "fsl,talitos-sec2",
> > -                                    "fsl,talitos",
> > -                                    "talitos";
> > +                       compatible = "fsl,sec1.0";
> 
> Should really be encoding the SoC model in the compatible property.
> At the very least, compatible should be:
> compatible = "fsl,mpc8272-sec", "fsl,sec1.0";
> 
> I'm really don't like "fsl,sec1.0" or any of the variants as a
> compatible property either because it can easily be abused (it's not
> anchored to a specific physical part so the meaning can shift over
> time); but that is another argument and it is well documented in other
> email threads (http://thread.gmane.org/gmane.linux.ports.ppc64.devel/38977/focus=39147)

I don't follow - afaict, the thread you are referring to had a
more generic name (no version number for the device).  Meanwhile, the
"fsl,secX.Y" designation /is/ anchored to one or more specific parts
and thus its meaning will not shift over time.  In fact, different
revisions of the mpc834x have different revisions of the SEC device
(the node gets up-revved in u-boot), so compatible = "fsl,mpc8349-sec"
is, in fact, ambiguous.

Kim
