Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH6yp0PHzzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 21:01:19 +1100 (AEDT)
Date: Wed, 18 Oct 2017 12:00:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Alexander.Steffen@infineon.com
cc: joe@perches.com, elfring@users.sourceforge.net,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 James.Bottomley@HansenPartnership.comg, dan.carpenter@oracle.com,
 jarkko.sakkinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
 benh@kernel.crashing.org, clabbe.montjoie@gmail.com,
 jgunthorpe@obsidianresearch.com, jsnitsel@redhat.com,
 kgold@linux.vnet.ibm.com, mpe@ellerman.id.au, nayna@linux.vnet.ibm.com,
 paulus@samba.org, PeterHuewe@gmx.de, stefanb@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: RE: char-TPM: Adjustments for ten function implementations
In-Reply-To: <026d582729b849b780fbaa06fb8bc79e@infineon.com>
Message-ID: <alpine.DEB.2.20.1710181154390.3524@hadrien>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
 <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
 <1508318326.6806.1.camel@perches.com>
 <026d582729b849b780fbaa06fb8bc79e@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wed, 18 Oct 2017, Alexander.Steffen@infineon.com wrote:

> > On Wed, 2017-10-18 at 11:00 +0200, SF Markus Elfring wrote:
> > > > The printk removals do change the objects.
> > > >
> > > > The value of that type of change is only for resource limited systems.
> > >
> > > I imagine that such small code adjustments are also useful for other
> > systems.
> >
> > Your imagination and mine differ.
> > Where do you _think_ it matters?
> >
> > For instance, nothing about
> >
> > 	sizeof(type)
> > vs
> > 	sizeof(*ptr)
> >
> > makes it easier for a human to read the code.
>
> If it does not make it easier to read the code for you, then maybe you
> should consider that this might not be true for all humans. For me, it
> makes it much easier to see at a glance, that code like
> ptr=malloc(sizeof(*ptr)) is correct.

I don't think there is a perfect solution.  The type argument to sizeof
could have the wrong type.  The expression argument to sizeof could be
missing the *.  Unpleasant consequences are possible in both cases.
Probably each maintainer has a style they prefer.  Perhaps it could be
useful to adjust the code to follow the dominant strategy, in cases where
there are a inconsistencies.  For example

if (...)
  x = foo1(sizeof(struct xtype));
else
  x = foo2(sizeof(*x));

might at least cause some unnecessary mental effort to process.

julia
