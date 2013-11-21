Return-Path: <Varun.Sethi@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 514512C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 22:20:16 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Alex Williamson <alex.williamson@redhat.com>, Bharat Bhushan
 <Bharat.Bhushan@freescale.com>
Subject: RE: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Thu, 21 Nov 2013 11:20:01 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5C38AC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1384973243.2879.361.camel@ul30vt.home>
In-Reply-To: <1384973243.2879.361.camel@ul30vt.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "agraf@suse.de" <agraf@suse.de>, Stuart Yoder <stuart.yoder@freescale.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Alex Williamson
> Sent: Thursday, November 21, 2013 12:17 AM
> To: Bhushan Bharat-R65777
> Cc: linux-pci@vger.kernel.org; agraf@suse.de; Yoder Stuart-B08248; Wood
> Scott-B07421; iommu@lists.linux-foundation.org; bhelgaas@google.com;
> linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU
> (PAMU)
>=20
> On Tue, 2013-11-19 at 10:47 +0530, Bharat Bhushan wrote:
> > From: Bharat Bhushan <bharat.bhushan@freescale.com>
> >
> > PAMU (FSL IOMMU) has a concept of primary window and subwindows.
> > Primary window corresponds to the complete guest iova address space
> > (including MSI space), with respect to IOMMU_API this is termed as
> > geometry. IOVA Base of subwindow is determined from the number of
> > subwindows (configurable using iommu API).
> > MSI I/O page must be within the geometry and maximum supported
> > subwindows, so MSI IO-page is setup just after guest memory iova space.
> >
> > So patch 1/9-4/9(inclusive) are for defining the interface to get:
> >   - Number of MSI regions (which is number of MSI banks for powerpc)
> >   - MSI-region address range: Physical page which have the
> >     address/addresses used for generating MSI interrupt
> >     and size of the page.
> >
> > Patch 5/9-7/9(inclusive) is defining the interface of setting up MSI
> > iova-base for a msi region(bank) for a device. so that when
> > msi-message will be composed then this configured iova will be used.
> > Earlier we were using iommu interface for getting the configured iova
> > which was not currect and Alex Williamson suggeested this type of
> interface.
> >
> > patch 8/9 moves some common functions in a separate file so that these
> > can be used by FSL_PAMU implementation (next patch uses this).
> > These will be used later for iommu-none implementation. I believe we
> > can do more of this but will take step by step.
> >
> > Finally last patch actually adds the support for FSL-PAMU :)
>=20
> Patches 1-3: msi_get_region needs to return an error an error (probably
> -EINVAL) if called on a path where there's no backend implementation.
> Otherwise the caller doesn't know that the data in the region pointer
> isn't valid.
>=20
> Patches 5&6: same as above for msi_set_iova, return an error if no
> backend implementation.
>=20
> Patch 7: Why does fsl_msi_del_iova_device bother to return anything if
> it's always zero?  Return -ENODEV when not found?
>=20
> Patch 9:
>=20
> vfio_handle_get_attr() passes random kernel data back to userspace in the
> event of iommu_domain_get_attr() error.
>=20
> vfio_handle_set_attr(): I don't see any data validation happening, is
> iommu_domain_set_attr() really that safe?
[Sethi Varun-B16395] The parameter validation can be left to the lower leve=
l iommu driver. The attribute could be specific to a given hardware.

-Varun
