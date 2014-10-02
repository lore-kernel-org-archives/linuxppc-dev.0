Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 013F01A18E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 13:37:52 +1000 (EST)
Message-ID: <1412221071.19209.103.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 07/17] cxl: Add new header for call backs and structs
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Oct 2014 13:37:51 +1000
In-Reply-To: <20141001120010.4813614016A@ozlabs.org>
References: <20141001120010.4813614016A@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 22:00 +1000, Michael Ellerman wrote:
> On Tue, 2014-30-09 at 10:34:56 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > This new header add defines for callbacks and structs needed by the res=
t of the
>                   adds
> > kernel to hook into the cxl infrastructure.
> >=20
> > Empty functions are provided when CONFIG CXL_BASE is not enabled.
> >=20
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  include/misc/cxl.h | 34 ++++++++++++++++++++++++++++++++++
>=20
> include/misc is kind of weird. I guess it's a misc device.
>=20
> Any reason not to have it in arch/powerpc/include ?

We can do either way.  We did consider it a driver so putting it in
arch/powerpc didn't seem quite right.

I might leave it here unless you really object.

>=20
> > diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> > new file mode 100644
> > index 0000000..bde46a3
> > --- /dev/null
> > +++ b/include/misc/cxl.h
> > @@ -0,0 +1,34 @@
> > +/*
> > + * Copyright 2014 IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#ifndef _MISC_ASM_CXL_H
>=20
> No ASM.

Oops, yes.

>=20
> > +#define _MISC_ASM_CXL_H
> > +
> > +#define CXL_IRQ_RANGES 4
> > +
> > +struct cxl_irq_ranges {
> > +	irq_hw_number_t offset[CXL_IRQ_RANGES];
> > +	irq_hw_number_t range[CXL_IRQ_RANGES];
> > +};
> > +
> > +#ifdef CONFIG_CXL_BASE
> > +
> > +void cxl_slbia(struct mm_struct *mm);
> > +void cxl_ctx_get(void);
> > +void cxl_ctx_put(void);
> > +bool cxl_ctx_in_use(void);
> > +
> > +#else /* CONFIG_CXL_BASE */
> > +
> > +#define cxl_slbia(...) do { } while (0)
> > +#define cxl_ctx_in_use(...) false
>=20
> Any reason these shouldn't be static inlines?

No, I'll change.

Mikey
