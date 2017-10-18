Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0086.hostedemail.com
 [216.40.44.86])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH7ZH2G9YzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 21:28:38 +1100 (AEDT)
Message-ID: <1508322510.6806.3.camel@perches.com>
Subject: Re: char-TPM: Adjustments for ten function implementations
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@lip6.fr>, Alexander.Steffen@infineon.com
Cc: elfring@users.sourceforge.net, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, James.Bottomley@HansenPartnership.comg,
 dan.carpenter@oracle.com, jarkko.sakkinen@linux.intel.com,
 andriy.shevchenko@linux.intel.com, benh@kernel.crashing.org,
 clabbe.montjoie@gmail.com, jgunthorpe@obsidianresearch.com,
 jsnitsel@redhat.com,  kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
 nayna@linux.vnet.ibm.com,  paulus@samba.org, PeterHuewe@gmx.de,
 stefanb@linux.vnet.ibm.com,  linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Date: Wed, 18 Oct 2017 03:28:30 -0700
In-Reply-To: <alpine.DEB.2.20.1710181154390.3524@hadrien>
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
 <alpine.DEB.2.20.1710181154390.3524@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-18 at 12:00 +0200, Julia Lawall wrote:
> 
> On Wed, 18 Oct 2017, Alexander.Steffen@infineon.com wrote:
> 
> > > On Wed, 2017-10-18 at 11:00 +0200, SF Markus Elfring wrote:
> > > > > The printk removals do change the objects.
> > > > > 
> > > > > The value of that type of change is only for resource limited systems.
> > > > 
> > > > I imagine that such small code adjustments are also useful for other
> > > 
> > > systems.
> > > 
> > > Your imagination and mine differ.
> > > Where do you _think_ it matters?
> > > 
> > > For instance, nothing about
> > > 
> > > 	sizeof(type)
> > > vs
> > > 	sizeof(*ptr)
> > > 
> > > makes it easier for a human to read the code.
> > 
> > If it does not make it easier to read the code for you, then maybe you
> > should consider that this might not be true for all humans. For me, it
> > makes it much easier to see at a glance, that code like
> > ptr=malloc(sizeof(*ptr)) is correct.
> 
> I don't think there is a perfect solution.  The type argument to sizeof
> could have the wrong type.  The expression argument to sizeof could be
> missing the *.

Yup.

Today, even after all of Markus' patches for this style
conversion, there is still only ~2:1 preference for
	ptr = k.alloc(sizeof(*ptr))
over
	ptr = k.alloc(sizeof(struct foo))
in the kernel tree

Ugly grep follows:

$ grep -rohP --include=*.[ch] "\w+\s*=\s*[kv].alloc\s*\(\s*sizeof.*," * | \
  sed -r -e 's/(\w+)\s*=\s*[kv].alloc\s*\(\s*sizeof\s*\(\s*\*\s*\1\s*\)/foo = k.alloc(sizeof(*foo))/' \
         -e 's/(\w+)\s*=\s*[kv].alloc\s*\(\s*sizeof\s*\(\s*struct\s+\w+\s*\)/foo = k.alloc(sizeof(struct foo))/' | \
  sort | uniq -c | sort -rn | head -2
   6123 foo = k.alloc(sizeof(*foo)),
   3060 foo = k.alloc(sizeof(struct foo)),

> Unpleasant consequences are possible in both cases.

Yup.

> Probably each maintainer has a style they prefer.  Perhaps it could be
> useful to adjust the code to follow the dominant strategy, in cases where
> there are a inconsistencies.  For example
> 
> if (...)
>   x = foo1(sizeof(struct xtype));
> else
>   x = foo2(sizeof(*x));
> 
> might at least cause some unnecessary mental effort to process.

Sure, but perhaps _only_ when there are inconsistencies
in the same compilation unit.'
