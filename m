Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD03A1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 22:47:52 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
Date: Fri, 4 Jul 2014 12:47:44 +0000
Message-ID: <6425d2420c6f4f03b15f2d7ce5be3215@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <1403618237-26248-2-git-send-email-Varun.Sethi@freescale.com>
 <20140704104430.GD13434@8bytes.org>
In-Reply-To: <20140704104430.GD13434@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Friday, July 04, 2014 4:15 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; alex.williamson@redhat.com
> Subject: Re: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
>=20
> On Tue, Jun 24, 2014 at 07:27:15PM +0530, Varun Sethi wrote:
> >  	/* window size is 2^(WSE+1) bytes */
> > -	return __ffs(addrspace_size) - 1;
> > +	return fls64(addrspace_size) - 2;
>=20
> This looks bogus, why do you replace ffs (find-first-bit) by fls (find-
> last-bit)?
>=20
Address space size is always a power of 2. This change was required to hand=
le address sizes > 32bit width on 32 bit architectures.

-Varun
