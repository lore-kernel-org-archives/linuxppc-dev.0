Return-Path: <Varun.Sethi@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3035B1A013E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 20:58:05 +1000 (EST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 988651400AB
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 20:58:04 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH] iommu/fsl: Fix warning resulting from adding PCI device
 twice
Date: Thu, 4 Sep 2014 10:57:59 +0000
Message-ID: <332f3406b1974ff38aef45cc4f55373a@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1409810622-742-1-git-send-email-Varun.Sethi@freescale.com>
 <20140904101402.GM28786@8bytes.org>
In-Reply-To: <20140904101402.GM28786@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Emilian Medve <Emilian.Medve@freescale.com>,
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
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Thursday, September 04, 2014 3:44 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; alex.williamson@redhat.com; Medve
> Emilian-EMMEDVE1; linuxppc-dev@ozlabs.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] iommu/fsl: Fix warning resulting from adding PCI dev=
ice
> twice
>=20
> On Thu, Sep 04, 2014 at 11:33:42AM +0530, Varun Sethi wrote:
> > +	if (!iommu_group_get(dev))
> > +		ret =3D iommu_group_add_device(group, dev);
> >
> >  	iommu_group_put(group);
> >  	return ret;
>=20
> Doesn't this additional call to iommu_group_get take a reference to the
> iommu_group that needs to be released?
Yes, you are right this would take a reference to the group that should be =
released. I need to add iommu_group_put for decrementing the reference coun=
t. Will post a new patch.

Thanks,
Varun
