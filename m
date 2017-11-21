Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0070.outbound.protection.outlook.com [104.47.41.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhC240R8XzDrZ4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 04:17:14 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
Date: Tue, 21 Nov 2017 17:17:06 +0000
Message-ID: <1511284624.4775.138.camel@infinera.com>
References: <20170905115943.19919-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB20787FDC28E53BF15DF8E3949A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <AM4PR0401MB16991E3E16496C848E3AB9078F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
In-Reply-To: <AM4PR0401MB16991E3E16496C848E3AB9078F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-06 at 19:19 +0000, Leo Li wrote:
> > -----Original Message-----
> > From: York Sun
> > Sent: Wednesday, September 06, 2017 10:34 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>; linuxppc-dev linu=
xppc-
> > dev <linuxppc-dev@lists.ozlabs.org>
> > Subject: Re: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
> >=20
> > On 09/05/2017 04:59 AM, Joakim Tjernlund wrote:
> > > get_user() had it args reversed causing NIP to be NULL:ed instead of
> > > fixing up the PCI access.
> > >=20
> > > Note: This still hangs my P1020 Freescale CPU hard, but at least I ge=
t
> > > a NIP now.
> > >=20
> > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > > ---
> > >   arch/powerpc/sysdev/fsl_pci.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > > b/arch/powerpc/sysdev/fsl_pci.c index 7c8b779c329a..9e64c12dff6a
> > > 100644
> > > --- a/arch/powerpc/sysdev/fsl_pci.c
> > > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > > @@ -996,7 +996,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs=
)
> > >   	if (is_in_pci_mem_space(addr)) {
> > >   		if (user_mode(regs)) {
> > >   			pagefault_disable();
> > > -			ret =3D get_user(regs->nip, &inst);
> > > +			ret =3D get_user(inst, (__u32 __user *)regs->nip);
> > >   			pagefault_enable();
> > >   		} else {
> > >   			ret =3D probe_kernel_address(regs->nip, inst);
> > >=20
> >=20
> > Leo,
> >=20
> > Can you take a look, or assign it to someone who is familiar with this =
code?
>=20
> Acked-by: Li Yang <leoyang.li@nxp.com>
>=20
> Regards,
> Leo

I think this is forgotten, cannot se it in Linus tree.=
