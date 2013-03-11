Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4EB12C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 13:37:00 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/85xx: Add platform_device declaration to fsl_pci.h
Date: Mon, 11 Mar 2013 02:36:43 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C11ED4@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1362386409-15907-1-git-send-email-B38951@freescale.com>
 <CC45B9DD-7BB6-4E88-B5A0-F3E7A30608A7@kernel.crashing.org>
In-Reply-To: <CC45B9DD-7BB6-4E88-B5A0-F3E7A30608A7@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Saturday, March 09, 2013 4:38 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH] powerpc/85xx: Add platform_device declaration to
> fsl_pci.h
>=20
>=20
> On Mar 4, 2013, at 2:40 AM, Jia Hongtao wrote:
>=20
> > mpc85xx_pci_err_probe(struct platform_device *op) need platform_device
> > declaration for definition. Otherwise, it will cause compile error if
> > any files including fsl_pci.h without declaration of platform_device.
> >
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > ---
> > arch/powerpc/sysdev/fsl_pci.h |    2 ++
> > 1 files changed, 2 insertions(+), 0 deletions(-)
> >
>=20
> Where does the compile error show up?
>=20
> - k

The function mpc85xx_pci_err_probe(struct platform_device *op) need
*platform_device* declaration so <linux/platform_device.h> must be
included.=20

For now there is no compile error occurred just because the file that
need fsl_pci.h happened to include <linux/platform_device.h> already.

If not the compile error log will be like this:
"
In file included from arch/powerpc/kernel/traps.c:62:0:
arch/powerpc/sysdev/fsl_pci.h:108:34: error: 'struct platform_device' decla=
red inside parameter list
arch/powerpc/sysdev/fsl_pci.h:108:34: error: its scope is only this definit=
ion or declaration, which is probably not what you want
"

You mean I have to show the compile error log in patch description?

Thanks.
-Hongtao.

>=20
> > diff --git a/arch/powerpc/sysdev/fsl_pci.h
> > b/arch/powerpc/sysdev/fsl_pci.h index c495c00..df66721 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.h
> > +++ b/arch/powerpc/sysdev/fsl_pci.h
> > @@ -14,6 +14,8 @@
> > #ifndef __POWERPC_FSL_PCI_H
> > #define __POWERPC_FSL_PCI_H
> >
> > +#include <linux/platform_device.h>
> > +
> > #define PCIE_LTSSM	0x0404		/* PCIE Link Training and
> Status */
> > #define PCIE_LTSSM_L0	0x16		/* L0 state */
> > #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version
> Rev2.2 */
> > --
> > 1.7.5.1
> >
>=20
