Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C50B22C0340
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 04:10:02 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "joro@8bytes.org" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 1/7] powerpc: Add interface to get msi region information
Date: Tue, 8 Oct 2013 17:09:50 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07196054@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
 <20130924235812.GD9302@google.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
 <20131008170228.GD17455@8bytes.org>
In-Reply-To: <20131008170228.GD17455@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: joro@8bytes.org [mailto:joro@8bytes.org]
> Sent: Tuesday, October 08, 2013 10:32 PM
> To: Bjorn Helgaas
> Cc: Bhushan Bharat-R65777; alex.williamson@redhat.com; benh@kernel.crashi=
ng.org;
> galak@kernel.crashing.org; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-pci@vger.kernel.org; agraf@suse.de; Wood Scot=
t-
> B07421; iommu@lists.linux-foundation.org
> Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region informa=
tion
>=20
> On Tue, Oct 08, 2013 at 10:47:49AM -0600, Bjorn Helgaas wrote:
> > I still have no idea what an "aperture type IOMMU" is, other than that
> > it is "different."
>=20
> An aperture based IOMMU is basically any GART-like IOMMU which can only r=
emap a
> small window (the aperture) of the DMA address space. DMA outside of that=
 window
> is either blocked completly or passed through untranslated.

It is completely blocked for Freescale PAMU.=20
So for this type of iommu what we have to do is to create a MSI mapping jus=
t after guest physical address, Example: guest have a 512M of memory then w=
e create window of 1G (because of power of 2 requirement), then we have to =
FIT MSI just after 512M of guest.
And for that we need
	1) to know the physical address of MSI's in interrupt controller (for that=
 this patch was all about of).

	2) When guest enable MSI interrupt then we write MSI-address and MSI-DATA =
in device. The discussion with Alex Williamson is about that interface.

Thanks
-Bharat

>=20
>=20
> 	Joerg
>=20
>=20
