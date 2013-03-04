Return-Path: <B16395@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 835842C02FF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 17:36:17 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Yoder Stuart-B08248 <B08248@freescale.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Subject: RE: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
 pointer in archdata.
Date: Mon, 4 Mar 2013 06:35:55 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3D06A1@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
 <20130227113045.GH26252@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
 <BAB98EA5-5324-4FB2-97C2-A28A96C569DC@kernel.crashing.org>
 <51300367.6080300@ozlabs.ru>
 <C5ECD7A89D1DC44195F34B25E172658D3C802F@039-SN2MPN1-013.039d.mgd.msft.net>
 <51307DCE.1050506@ozlabs.ru>
 <9F6FE96B71CF29479FF1CDC8046E1503565876@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E1503565876@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Friday, March 01, 2013 9:52 PM
> To: Alexey Kardashevskiy; Sethi Varun-B16395
> Cc: Kumar Gala; Benjamin Herrenschmidt; iommu@lists.linux-foundation.org;
> linuxppc-dev@lists.ozlabs.org list; linux-kernel@vger.kernel.org list;
> Wood Scott-B07421; Joerg Roedel; Paul Mackerras; David Gibson; Alex
> Williamson
> Subject: RE: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
> pointer in archdata.
>=20
>=20
>=20
> > -----Original Message-----
> > From: Alexey Kardashevskiy [mailto:aik@ozlabs.ru]
> > Sent: Friday, March 01, 2013 4:07 AM
> > To: Sethi Varun-B16395
> > Cc: Kumar Gala; Benjamin Herrenschmidt;
> > iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org list;
> > linux-kernel@vger.kernel.org list; Wood Scott-B07421; Yoder
> > Stuart-B08248; Joerg Roedel; Paul Mackerras; David Gibson; Alex
> > Williamson
> > Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
> pointer in archdata.
> >
> > btw the device struct already has a pointer to its iommu_group, and
> > the iommu_group struct itself has a pointer void *iommu_data which you
> > could use for anything you want (iommu_group_get_iommudata(),
> > iommu_group_set_iommudata()).
> >
> > By design you are expected to add iommu groups to a domain but not
> > devices so I am not so sure that you really need a pointer to domain
> > in the device struct.
>=20
> Well, at the lowest level the IOMMU API does attach devices to domains--
> i.e.
> API attach_dev().  So, it seems to conceptually make sense to have a ptr
> from the device to the associated domain.  When you implement
> attach_dev() you need to be able to see whether the device is already
> attached to
> a domain.   Adding a couple of levels of indirection...from device to
> group to domain...doesn't seems to make things simpler or better IMHO.
>=20
> x86 keeps a pointer to the domain in device archdata and since there is a
> direct correlation between a device and domain I'd rather see it where
> this patch has it.
>=20

As Stuart stated this allows us to maintain the device <-> domain relations=
hip at the lowest level.

-Varun
