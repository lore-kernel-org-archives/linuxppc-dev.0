Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C70132C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 23:11:14 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Tue, 4 Dec 2012 12:11:06 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2B715D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
 <50BD056F.7070701@freescale.com>
In-Reply-To: <50BD056F.7070701@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Tuesday, December 04, 2012 1:33 AM
> To: Sethi Varun-B16395
> Cc: joerg.roedel@amd.com; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Wood Scott-B07421
> Subject: Re: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
>=20
> Varun Sethi wrote:
>=20
> > +	out_be32(&pamu_regs->ppbah, ((u64)ppaact_phys) >> 32);
> > +	out_be32(&pamu_regs->ppbal, ppaact_phys);
> > +	ppaact_phys =3D ppaact_phys + PAACT_SIZE;
> > +	out_be32(&pamu_regs->pplah, ((u64)ppaact_phys) >> 32);
> > +	out_be32(&pamu_regs->pplal, ppaact_phys);
>=20
> Instead of  ((u64)ppaact_phys) >> 32, use upper_32_bits() and
> lower_32_bits().
>=20
> > +#define PAACE_NUMBER_ENTRIES    0xFF
>=20
> This is going to break with large LIODNs.  Instead of hard-coding the
> size of the PPAACT, you need to scan the device tree for the largest
> LIODN, and make the array dynamically sized.
This would in any case change with the new LIODN allocation scheme. I inten=
d on introducing the new scheme as a separate patch.

-Varun
