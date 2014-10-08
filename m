Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E3541A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 11:46:04 +1100 (EST)
Message-ID: <1412729164.4133.3.camel@ale.ozlabs.ibm.com>
Subject: Re: [v3, 08/16] powerpc/powerpc: Add new PCIe functions for
 allocating cxl interrupts
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 08 Oct 2014 11:46:04 +1100
In-Reply-To: <20141007225905.0F85514011E@ozlabs.org>
References: <20141007225905.0F85514011E@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 imunsie@au.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anton@samba.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-08 at 09:59 +1100, Michael Ellerman wrote:
> On Tue, 2014-07-10 at 10:48:14 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > This adds a number of functions for allocating IRQs under powernv PCIe =
for cxl.
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> > index baf3de6..3b67010b 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -38,6 +38,8 @@
> >  #include <asm/debug.h>
> >  #include <asm/firmware.h>
> > =20
> > +#include <misc/cxl.h>
>=20
> You should be including pnv-pci.h here.
>=20
> Otherwise the header and the implementation could get out of sync, it wil=
l also
> fix these:
>=20
>   arch/powerpc/platforms/powernv/pci-ioda.c:1365:5: warning: symbol 'pnv_=
phb_to_cxl' was not declared. Should it be static?
>   arch/powerpc/platforms/powernv/pci-ioda.c:1389:5: warning: symbol 'pnv_=
cxl_alloc_hwirqs' was not declared. Should it be static?
>   arch/powerpc/platforms/powernv/pci-ioda.c:1404:6: warning: symbol 'pnv_=
cxl_release_hwirqs' was not declared. Should it be static?
>   arch/powerpc/platforms/powernv/pci-ioda.c:1413:6: warning: symbol 'pnv_=
cxl_release_hwirq_ranges' was not declared. Should it be static?
>   arch/powerpc/platforms/powernv/pci-ioda.c:1433:5: warning: symbol 'pnv_=
cxl_alloc_hwirq_ranges' was not declared. Should it be static?
>   arch/powerpc/platforms/powernv/pci-ioda.c:1470:5: warning: symbol 'pnv_=
cxl_get_irq_count' was not declared. Should it be static?
>   arch/powerpc/platforms/powernv/pci-ioda.c:1479:5: warning: symbol 'pnv_=
cxl_ioda_msi_setup' was not declared. Should it be static?

Ok... will fix.

Mikey
