Return-Path: <B08248@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A46652C02F8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 03:22:08 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Sethi Varun-B16395
 <B16395@freescale.com>
Subject: RE: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
 pointer in archdata.
Date: Fri, 1 Mar 2013 16:21:57 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503565876@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
 <20130227113045.GH26252@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
 <BAB98EA5-5324-4FB2-97C2-A28A96C569DC@kernel.crashing.org>
 <51300367.6080300@ozlabs.ru>
 <C5ECD7A89D1DC44195F34B25E172658D3C802F@039-SN2MPN1-013.039d.mgd.msft.net>
 <51307DCE.1050506@ozlabs.ru>
In-Reply-To: <51307DCE.1050506@ozlabs.ru>
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
> From: Alexey Kardashevskiy [mailto:aik@ozlabs.ru]
> Sent: Friday, March 01, 2013 4:07 AM
> To: Sethi Varun-B16395
> Cc: Kumar Gala; Benjamin Herrenschmidt; iommu@lists.linux-foundation.org;=
 linuxppc-dev@lists.ozlabs.org
> list; linux-kernel@vger.kernel.org list; Wood Scott-B07421; Yoder Stuart-=
B08248; Joerg Roedel; Paul
> Mackerras; David Gibson; Alex Williamson
> Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information poi=
nter in archdata.
>=20
> btw the device struct already has a pointer to its iommu_group, and the
> iommu_group struct itself has a pointer void *iommu_data which you could
> use for anything you want (iommu_group_get_iommudata(),
> iommu_group_set_iommudata()).
>
> By design you are expected to add iommu groups to a domain but not device=
s
> so I am not so sure that you really need a pointer to domain in the devic=
e
> struct.

Well, at the lowest level the IOMMU API does attach devices to domains-- i.=
e.
API attach_dev().  So, it seems to conceptually make sense to have a ptr
from the device to the associated domain.  When you implement attach_dev()
you need to be able to see whether the device is already attached to
a domain.   Adding a couple of levels of indirection...from device to
group to domain...doesn't seems to make things simpler or better IMHO.

x86 keeps a pointer to the domain in device archdata and since there is
a direct correlation between a device and domain I'd rather see it
where this patch has it.

Stuart
