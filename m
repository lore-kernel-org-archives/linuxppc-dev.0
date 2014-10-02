Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66E521A0A44
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 13:43:55 +1000 (EST)
Message-ID: <1412221434.19209.106.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 13/17] cxl: Add base builtin support
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Oct 2014 13:43:54 +1000
In-Reply-To: <20141001120010.A834E140170@ozlabs.org>
References: <20141001120010.A834E140170@ozlabs.org>
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
> On Tue, 2014-30-09 at 10:35:02 UTC, Michael Neuling wrote:
> > This also adds the cxl_ctx_in_use() function for use in the mm code to =
see if
> > any cxl contexts are currently in use.  This is used by the tlbie() to
> > determine if it can do local TLB invalidations or not.  This also adds =
get/put
> > calls for the cxl driver module to refcount the active cxl contexts.
>=20
> > diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
> > new file mode 100644
> > index 0000000..f4cbcfb
> > --- /dev/null
> > +++ b/drivers/misc/cxl/base.c
> > @@ -0,0 +1,102 @@
> > +/*
> > + * Copyright 2014 IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/rcupdate.h>
> > +#include <asm/errno.h>
> > +#include <misc/cxl.h>
> > +#include "cxl.h"
> > +
> > +/* protected by rcu */
> > +static struct cxl_calls *cxl_calls;
> > +
> > +static atomic_t use_count =3D ATOMIC_INIT(0);
> ...
>=20
> > +void cxl_ctx_get(void)
> > +{
> > +	atomic_inc(&use_count);
> > +}
> > +EXPORT_SYMBOL(cxl_ctx_get);
> > +
> > +void cxl_ctx_put(void)
> > +{
> > +	atomic_dec(&use_count);
> > +}
> > +EXPORT_SYMBOL(cxl_ctx_put);
> > +
> > +bool cxl_ctx_in_use(void)
> > +{
> > +	return (atomic_read(&use_count) !=3D 0);
> > +}
> > +EXPORT_SYMBOL(cxl_ctx_in_use);
>=20
> So as written this results in a function call for every tlbie(), even whe=
n no
> one has ever used a CAPI adapter, or when none are even in the machine.

Yep.

> I think the patch below is a better trade off. It makes the use_count glo=
bal,
> but that's not a biggy. The benefit is that the additional code in tlbie(=
)
> becomes:
>=20
> 	ld      r10,-29112(r2)
> 	lwz     r10,0(r10)
> 	cmpwi   cr7,r10,0
>=20
> Which is about as good as it can get.

Nice.. I'll add.  Thanks.

Mikey

>=20
> cheers
>=20
>=20
> diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
> index f4cbcfbd8dbc..4401d1c2dd33 100644
> --- a/drivers/misc/cxl/base.c
> +++ b/drivers/misc/cxl/base.c
> @@ -16,7 +16,7 @@
>  /* protected by rcu */
>  static struct cxl_calls *cxl_calls;
> =20
> -static atomic_t use_count =3D ATOMIC_INIT(0);
> +atomic_t cxl_use_count =3D ATOMIC_INIT(0);
> =20
>  #ifdef CONFIG_CXL_MODULE
> =20
> @@ -65,24 +65,6 @@ void cxl_slbia(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL(cxl_slbia);
> =20
> -void cxl_ctx_get(void)
> -{
> -	atomic_inc(&use_count);
> -}
> -EXPORT_SYMBOL(cxl_ctx_get);
> -
> -void cxl_ctx_put(void)
> -{
> -	atomic_dec(&use_count);
> -}
> -EXPORT_SYMBOL(cxl_ctx_put);
> -
> -bool cxl_ctx_in_use(void)
> -{
> -	return (atomic_read(&use_count) !=3D 0);
> -}
> -EXPORT_SYMBOL(cxl_ctx_in_use);
> -
>  int register_cxl_calls(struct cxl_calls *calls)
>  {
>  	if (cxl_calls)
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index bde46a330881..6e43dca6a792 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -18,12 +18,24 @@ struct cxl_irq_ranges {
>  };
> =20
>  #ifdef CONFIG_CXL_BASE
> +extern atomic_t cxl_use_count;
> =20
>  void cxl_slbia(struct mm_struct *mm);
> -void cxl_ctx_get(void);
> -void cxl_ctx_put(void);
> -bool cxl_ctx_in_use(void);
> =20
> +static inline bool cxl_ctx_in_use(void)
> +{
> +	return (atomic_read(&cxl_use_count) !=3D 0);
> +}
> +
> +static inline void cxl_ctx_get(void)
> +{
> +	atomic_inc(&cxl_use_count);
> +}
> +
> +static inline void cxl_ctx_put(void)
> +{
> +	atomic_dec(&cxl_use_count);
> +}
>  #else /* CONFIG_CXL_BASE */
> =20
>  #define cxl_slbia(...) do { } while (0)
>=20
