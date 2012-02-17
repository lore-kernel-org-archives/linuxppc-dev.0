Return-Path: <B37022@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C77411007DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 14:20:34 +1100 (EST)
From: Pan Jiafei-B37022 <B37022@freescale.com>
To: Liu Shengzhou-B36685 <B36685@freescale.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/usb: fix bug of kernel hang when initializing usb
Date: Fri, 17 Feb 2012 03:20:18 +0000
Message-ID: <4F9F958A64F25C4DA463F3D6931E533140828E@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1329433132.2892.30.camel@pasglop> <1329436955.2892.32.camel@pasglop>
 <3F453DDFF675A64A89321A1F3528102170A6FF@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <3F453DDFF675A64A89321A1F3528102170A6FF@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FYI, I once fixed this issue when backport P5020 BSP for WR Linux, The foll=
owing is the patch which I have submitted to linuxbj-internal.


From: linuxbj-internal-bounces@linux.freescale.net [mailto:linuxbj-internal=
-bounces@linux.freescale.net] On Behalf Of Pan Jiafei-B37022
Sent: Friday, December 16, 2011 12:49 PM
To: linuxbj-internal@linux.freescale.net
Cc: Pan Jiafei-B37022
Subject: [Linuxbj-internal] [PATCH] USB: ehci-fsl: Turn on cache snooping o=
n MPC8xxx

If a MPC8xxx was being used, 'have_sysif_regs' should be set and
it should setup cache snooping for all the 4GB space on both PPC32
and PPC64.

Signed-off-by: Pan Jiafei <Jiafei.Pan@freescale.com>
---
drivers/usb/host/ehci-fsl.c |   23 ++++++++++-------------
1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 90534cc..ee14fa7 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -260,21 +260,18 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
    if (pdata->have_sysif_regs) {
          temp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL);
          out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
-          out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
-    }

-#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
-    /*
-    * Turn on cache snooping hardware, since some PowerPC platforms
-    * wholly rely on hardware to deal with cache coherent
-    */
+          /*
+          * Turn on cache snooping hardware, since some PowerPC platforms
+          * wholly rely on hardware to deal with cache coherent
+          */

-    /* Setup Snooping for all the 4GB space */
-    /* SNOOP1 starts from 0x0, size 2G */
-    out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
-    /* SNOOP2 starts from 0x80000000, size 2G */
-    out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
-#endif
+          /* Setup Snooping for all the 4GB space */
+          /* SNOOP1 starts from 0x0, size 2G */
+          out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
+          /* SNOOP2 starts from 0x80000000, size 2G */
+          out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_=
2GB);
+    }

     if ((pdata->operating_mode =3D=3D FSL_USB2_DR_HOST) ||
               (pdata->operating_mode =3D=3D FSL_USB2_DR_OTG))
--=20
1.7.5.1

> -----Original Message-----
> From: linuxppc-dev-bounces+jiafei.pan=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+jiafei.pan=3Dfreescale.com@lists.ozlabs.org]
> On Behalf Of Liu Shengzhou-B36685
> Sent: Friday, February 17, 2012 10:33 AM
> To: Benjamin Herrenschmidt
> Cc: linux-usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: RE: [PATCH] powerpc/usb: fix bug of kernel hang when
> initializing usb
>=20
>=20
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Sent: Friday, February 17, 2012 8:03 AM
> > To: Liu Shengzhou-B36685
> > Cc: linux-usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc/usb: fix bug of kernel hang when
> > initializing usb
> >
> > On Fri, 2012-02-17 at 09:58 +1100, Benjamin Herrenschmidt wrote:
> > > On Thu, 2012-02-16 at 18:02 +0800, Shengzhou Liu wrote:
> > > > If USB UTMI PHY is not enable, writing to portsc register will
> > > > lead to kernel hang during boot up.
> > > >
> > > > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > > > ---
> > > > Apply for master branch of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-
> > 2.6.git
> > > > Tested on P5020DS, the issue was reported by Benjamin Herrenschmidt=
.
> > >
> > > This fixes the hang, but sadly doesn't make USB work. I now get:
> >
> >  .../...
> >
> > Ok, found the problem.
> >
> > First, the SDK kernel had a delay after setting that bit, I added that
> > back in. This is not what fixed it but it looks like the right thing
> > to do, though please, use msleep rather than udelay here if possible
> > (not in atomic context).
> >
> > Then, the real culprit is (CC'ing Kumar and Scott to figure out why)
> > this statement:
> >
> > #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
> > 	/*
> > 	 * Turn on cache snooping hardware, since some PowerPC platforms
> > 	 * wholly rely on hardware to deal with cache coherent
> > 	 */
> >
> > 	/* Setup Snooping for all the 4GB space */
> > 	/* SNOOP1 starts from 0x0, size 2G */
> > 	out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
> > 	/* SNOOP2 starts from 0x80000000, size 2G */
> > 	out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 |
> SNOOP_SIZE_2GB);
> > #endif
> >
> > I'm building a 64-bit kernel so this isn't compiled and it looks like
> > the EHCI is thus not snooping.
> >
> > By removing the defined(CONFIG_PPC32) part of the statement, my
> > problem goes away.
> >
> > Cheers,
> > Ben.
> >
> >
>=20
> [Shengzhou] I tested the patch with 32bit P5020DS, USB worked well. Not
> tested with 64-bit kernel.
> Glad to you had found the problem in case of 64-bit, thanks!
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
