Return-Path: <leoyang.li@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40066.outbound.protection.outlook.com [40.107.4.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnYLf65NjzDrT1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 05:19:52 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: York Sun <york.sun@nxp.com>
CC: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>, "linuxppc-dev
 linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
Date: Wed, 6 Sep 2017 19:19:43 +0000
Message-ID: <AM4PR0401MB16991E3E16496C848E3AB9078F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <20170905115943.19919-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB20787FDC28E53BF15DF8E3949A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB20787FDC28E53BF15DF8E3949A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
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
> From: York Sun
> Sent: Wednesday, September 06, 2017 10:34 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>; linuxppc-dev linuxp=
pc-
> dev <linuxppc-dev@lists.ozlabs.org>
> Subject: Re: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
>=20
> On 09/05/2017 04:59 AM, Joakim Tjernlund wrote:
> > get_user() had it args reversed causing NIP to be NULL:ed instead of
> > fixing up the PCI access.
> >
> > Note: This still hangs my P1020 Freescale CPU hard, but at least I get
> > a NIP now.
> >
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > ---
> >   arch/powerpc/sysdev/fsl_pci.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > b/arch/powerpc/sysdev/fsl_pci.c index 7c8b779c329a..9e64c12dff6a
> > 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -996,7 +996,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
> >   	if (is_in_pci_mem_space(addr)) {
> >   		if (user_mode(regs)) {
> >   			pagefault_disable();
> > -			ret =3D get_user(regs->nip, &inst);
> > +			ret =3D get_user(inst, (__u32 __user *)regs->nip);
> >   			pagefault_enable();
> >   		} else {
> >   			ret =3D probe_kernel_address(regs->nip, inst);
> >
>=20
> Leo,
>=20
> Can you take a look, or assign it to someone who is familiar with this co=
de?

Acked-by: Li Yang <leoyang.li@nxp.com>

Regards,
Leo
