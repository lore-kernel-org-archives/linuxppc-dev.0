Return-Path: <linuxppcleo@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id B5C3B67BA0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 23:36:02 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so805114ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 06:36:00 -0700 (PDT)
Message-ID: <a0bc9bf80607200636q785180e0rca1f974c6fe6d127@mail.gmail.com>
Date: Thu, 20 Jul 2006 21:36:00 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
	hostdependency
In-Reply-To: <93F26879-ECEB-4513-AA77-EE7285DF7961@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4879B0C6C249214CBE7AB04453F84E4D07064D@zch01exm20.fsl.freescale.net>
	<93F26879-ECEB-4513-AA77-EE7285DF7961@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/20/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jul 20, 2006, at 6:42 AM, Li Yang-r58472 wrote:
>
> > Another one in header file.
> >
> > ---
> > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> > index 679c1cd..8da2774 100644
> > --- a/drivers/usb/host/ehci.h
> > +++ b/drivers/usb/host/ehci.h
> > @@ -642,7 +642,7 @@ #endif
> >
> >
> > /
> > *---------------------------------------------------------------------
> > -
> > ---*/
> >
> > -#ifdef CONFIG_PPC_83xx
> > +#ifdef CONFIG_MPC834x
> >  /* Some Freescale processors have an erratum in which the TT
> >   * port number in the queue head was 0..N-1 instead of 1..N.
> >   */
>
> Do we really want to make this change.  What harm is there in having
> the ehci support for MPC834x build on all 83xx processors?  I can't
> imagine we are going to config in support for ehci on anything that
> is MPC834x at this point and if you do, your device tree isn't going
> to have nodes in it so the drivers not going to bind against anything.
>

It's not very harmful.  But it will cause some misunderstanding.
There were already some guys trying to use the 834x USB driver on 836x
and 832x.  Anyway, it's a trivial patch.  Please apply if it doesn't
cause much trouble.
> Finally, I got to believe Freescale's going to build some MPC83xx in
> the future with the high speed USB IP.

I can't tell exactly.  But it's not likely to integrate this IP into a
chip with QE/CPM support.  As QE/CPM has already provided full speed
USB support, and the USB speed is not very important for Netcomm
processors.
>
> - kumar
>
> >
> >> -----Original Message-----
> >> From: linux-usb-devel-bounces@lists.sourceforge.net
> >> [mailto:linux-usb-devel-bounces@lists.sourceforge.net] On Behalf Of
> > Kumar Gala
> >> Sent: Friday, July 14, 2006 9:52 PM
> >> To: Li Yang-r58472
> >> Cc: linuxppc-dev@ozlabs.org; gregkh@suse.de;
> >> linux-usb-devel@lists.sourceforge.net
> >> Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
> > hostdependency
> >>
> >> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> >>
> >> On Jul 14, 2006, at 6:58 AM, Li Yang wrote:
> >>
> >>> The high-speed USB SOC only exists on MPC834x family not MPC83xx
> >>> family.
> >>>
> >>> Signed-off-by: Li Yang <leoli@freescale.com>
> >>>
> >>> ---
> >>>
> >>>  drivers/usb/host/ehci-hcd.c |    2 +-
> >>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-
> >>> hcd.c index 79f2d8b..3af1844 100644
> >>> --- a/drivers/usb/host/ehci-hcd.c
> >>> +++ b/drivers/usb/host/ehci-hcd.c
> >>> @@ -892,7 +892,7 @@ #include "ehci-pci.c"
> >>>  #define    EHCI_BUS_GLUED
> >>>  #endif
> >>>
> >>> -#ifdef CONFIG_PPC_83xx
> >>> +#ifdef CONFIG_MPC834x
> >>>  #include "ehci-fsl.c"
> >>>  #define    EHCI_BUS_GLUED
> >>>  #endif
> >
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
