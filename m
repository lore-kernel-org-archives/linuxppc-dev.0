Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrtw84pCbzDrcP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 07:42:16 +1100 (AEDT)
Message-ID: <1512504621.10062.10.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Leo Li <leoyang.li@nxp.com>, Joakim Tjernlund
 <Joakim.Tjernlund@infinera.com>, York Sun <york.sun@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 05 Dec 2017 14:10:21 -0600
In-Reply-To: <AM4PR0401MB1699F76EB10DD25705C4A8B98F3D0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <20170905115943.19919-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB20787FDC28E53BF15DF8E3949A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <AM4PR0401MB16991E3E16496C848E3AB9078F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1511284624.4775.138.camel@infinera.com>
 <AM4PR0401MB1699F76EB10DD25705C4A8B98F3D0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-05 at 15:16 +0000, Leo Li wrote:
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > Sent: Tuesday, November 21, 2017 11:17 AM
> > To: Leo Li <leoyang.li@nxp.com>; York Sun <york.sun@nxp.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
> > 
> > On Wed, 2017-09-06 at 19:19 +0000, Leo Li wrote:
> > > > -----Original Message-----
> > > > From: York Sun
> > > > Sent: Wednesday, September 06, 2017 10:34 AM
> > > > To: Leo Li <leoyang.li@nxp.com>
> > > > Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>; linuxppc-dev
> > > > linuxppc- dev <linuxppc-dev@lists.ozlabs.org>
> > > > Subject: Re: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
> > > > 
> > > > On 09/05/2017 04:59 AM, Joakim Tjernlund wrote:
> > > > > get_user() had it args reversed causing NIP to be NULL:ed instead
> > > > > of fixing up the PCI access.
> > > > > 
> > > > > Note: This still hangs my P1020 Freescale CPU hard, but at least I
> > > > > get a NIP now.
> > > > > 
> > > > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > > > > ---
> > > > >   arch/powerpc/sysdev/fsl_pci.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > > > > b/arch/powerpc/sysdev/fsl_pci.c index 7c8b779c329a..9e64c12dff6a
> > > > > 100644
> > > > > --- a/arch/powerpc/sysdev/fsl_pci.c
> > > > > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > > > > @@ -996,7 +996,7 @@ int fsl_pci_mcheck_exception(struct pt_regs
> > 
> > *regs)
> > > > >   	if (is_in_pci_mem_space(addr)) {
> > > > >   		if (user_mode(regs)) {
> > > > >   			pagefault_disable();
> > > > > -			ret = get_user(regs->nip, &inst);
> > > > > +			ret = get_user(inst, (__u32 __user *)regs-
> > > > > >nip);
> > > > >   			pagefault_enable();
> > > > >   		} else {
> > > > >   			ret = probe_kernel_address(regs->nip,
> > > > > inst);
> > > > > 
> > > > 
> > > > Leo,
> > > > 
> > > > Can you take a look, or assign it to someone who is familiar with this
> > 
> > code?
> > > 
> > > Acked-by: Li Yang <leoyang.li@nxp.com>
> > > 
> > > Regards,
> > > Leo
> > 
> > I think this is forgotten, cannot se it in Linus tree.
> 
> Hi Scott,
> 
> Could you help to review this patch and pick it up?  Thanks.

Sure... In the future please CC me on patches you want me to pick up.

-Scott
