Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A4898679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 21:41:56 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k6KBfp69015140
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 04:41:51 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6KBfmRa027966
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 06:41:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
	hostdependency
Date: Thu, 20 Jul 2006 19:42:10 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D07064D@zch01exm20.fsl.freescale.net>
In-Reply-To: <6DFEB2BB-05AB-441E-854E-297987B97A0E@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <gregkh@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Another one in header file.

---
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 679c1cd..8da2774 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -642,7 +642,7 @@ #endif

=20
/*----------------------------------------------------------------------
---*/

-#ifdef CONFIG_PPC_83xx
+#ifdef CONFIG_MPC834x
 /* Some Freescale processors have an erratum in which the TT
  * port number in the queue head was 0..N-1 instead of 1..N.
  */

> -----Original Message-----
> From: linux-usb-devel-bounces@lists.sourceforge.net
> [mailto:linux-usb-devel-bounces@lists.sourceforge.net] On Behalf Of
Kumar Gala
> Sent: Friday, July 14, 2006 9:52 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org; gregkh@suse.de;
> linux-usb-devel@lists.sourceforge.net
> Subject: Re: [linux-usb-devel] [PATCH] Fix Freescale high-speed USB
hostdependency
>=20
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> On Jul 14, 2006, at 6:58 AM, Li Yang wrote:
>=20
> > The high-speed USB SOC only exists on MPC834x family not MPC83xx
> > family.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> >
> > ---
> >
> >  drivers/usb/host/ehci-hcd.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-
> > hcd.c index 79f2d8b..3af1844 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -892,7 +892,7 @@ #include "ehci-pci.c"
> >  #define	EHCI_BUS_GLUED
> >  #endif
> >
> > -#ifdef CONFIG_PPC_83xx
> > +#ifdef CONFIG_MPC834x
> >  #include "ehci-fsl.c"
> >  #define	EHCI_BUS_GLUED
> >  #endif
