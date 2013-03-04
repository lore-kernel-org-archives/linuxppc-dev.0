Return-Path: <B08248@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FE282C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 03:55:19 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: RE: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Mon, 4 Mar 2013 16:55:10 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035664E9@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
 <CALRxmdDEccTaS2Houuns44DoQ_8wUbXAMiXQ8w0Ks9R2F2u-Ag@mail.gmail.com>
 <C5ECD7A89D1DC44195F34B25E172658D3D12D9@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D3D12D9@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Monday, March 04, 2013 5:31 AM
> To: Stuart Yoder
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org; linu=
x-kernel@vger.kernel.org; Wood
> Scott-B07421; Joerg Roedel; Yoder Stuart-B08248
> Subject: RE: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU AP=
I implementation.
>=20
>=20
>=20
> > -----Original Message-----
> > From: Stuart Yoder [mailto:b08248@gmail.com]
> > Sent: Saturday, March 02, 2013 4:58 AM
> > To: Sethi Varun-B16395
> > Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> > linux-kernel@vger.kernel.org; Wood Scott-B07421; Joerg Roedel; Yoder
> > Stuart-B08248
> > Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU
> > API implementation.
> >
> > On Mon, Feb 18, 2013 at 6:52 AM, Varun Sethi <Varun.Sethi@freescale.com=
>
> > wrote:
> > [cut]
> > > +static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain,
> > > +unsigned long iova) {
> > > +       u32 win_cnt =3D dma_domain->win_cnt;
> > > +       struct dma_window *win_ptr =3D
> > > +                               &dma_domain->win_arr[0];
> > > +       struct iommu_domain_geometry *geom;
> > > +
> > > +       geom =3D &dma_domain->iommu_domain->geometry;
> > > +
> > > +       if (!win_cnt || !dma_domain->geom_size) {
> > > +               pr_err("Number of windows/geometry not configured for
> > the domain\n");
> > > +               return 0;
> > > +       }
> > > +
> > > +       if (win_cnt > 1) {
> > > +               u64 subwin_size;
> > > +               unsigned long subwin_iova;
> > > +               u32 wnd;
> > > +
> > > +               subwin_size =3D dma_domain->geom_size >> ilog2(win_cn=
t);
> >
> > Could it be just geom_size / win_cnt ??
> [Sethi Varun-B16395] You would run in to linking issues with respect to u=
64 division on 32 bit kernels.
>=20
> >
> > > +               subwin_iova =3D iova & ~(subwin_size - 1);
> > > +               wnd =3D (subwin_iova - geom->aperture_start) >>
> > ilog2(subwin_size);
> > > +               win_ptr =3D &dma_domain->win_arr[wnd];
> > > +       }
> > > +
> > > +       if (win_ptr->valid)
> > > +               return (win_ptr->paddr + (iova & (win_ptr->size -
> > > + 1)));
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int map_liodn_subwins(int liodn, struct fsl_dma_domain
> > > +*dma_domain)
> >
> > Just call it map_subwins().  They are just sub windows, not "liodn sub
> > windows".
> >
> [Sethi Varun-B16395] This would be called per liodn.
>
> > [cut]
> >
> > > +static int map_liodn_win(int liodn, struct fsl_dma_domain
> > > +*dma_domain)
> >
> > Call it map_win().
> [Sethi Varun-B16395] This would again be called per liodn.

On the function names-- function names are typically named
with a noun describing some object and a verb describing
the action...and sometimes a subsystem identifier:
    kmem_cache + zalloc
    spin + lock

I don't think inserting liodn in the function name to indicates that it=20
operates per liodn makes it more clear and reads a little awkward to me:

    map + liodn_win

...it's almost like there is a "liodn_win" object.

I think plain map_win() is more clear and the function prototype makes
it pretty clear that you are operating on an liodn.
=20
> > [cut]
> > > +static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl=
)
> > > +{
> > > +       u32 version;
> > > +
> > > +       /* Check the PCI controller version number by readding BRR1
> > register */
> > > +       version =3D in_be32(pci_ctl->cfg_addr + (PCI_FSL_BRR1 >> 2));
> > > +       version &=3D PCI_FSL_BRR1_VER;
> > > +       /* If PCI controller version is >=3D 0x204 we can partition
> > endpoints*/
> > > +       if (version >=3D 0x204)
> > > +               return 1;
> > > +
> > > +       return 0;
> > > +}
> >
> > Can we just use the compatible string here to identify the different
> > kinds of PCI
> > controllers?   Reading the actual device registers is ugly right now
> > because
> > you are #defining the BRR1 stuff in a generic powerpc header.
> >
> [Sethi Varun-B16395] hmmm......, I would have to check for various differ=
ent compatible strings in that
> case. May be I can move the defines to a different file. What if I move t=
hem to some other header?

Don't personally feel too strongly about version register or header...but i=
t should be some fsl
PCI header that you define those regs.

You'll either need to check for a hardware version number or a compatible,
so a compatible check may be just as easy...look for "fsl,qoriq-pcie-v2.4"?

Stuart
