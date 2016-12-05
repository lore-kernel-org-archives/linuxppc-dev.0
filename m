Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXKfh60f0zDvtD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 20:47:08 +1100 (AEDT)
Date: Mon, 5 Dec 2016 20:47:04 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC 3/3] powerpc/64: Enable use of radix MMU under
 hypervisor on POWER9
Message-ID: <20161205094704.GD13528@fergus.ozlabs.ibm.com>
References: <20161205080219.GA13528@fergus.ozlabs.ibm.com>
 <20161205080435.GC13528@fergus.ozlabs.ibm.com>
 <1480928132.5297.0.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1480928132.5297.0.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 05, 2016 at 07:55:32PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2016-12-05 at 19:04 +1100, Paul Mackerras wrote:
> > +       vec5 = of_get_flat_dt_prop(chosen, "ibm,architecture-vec-5", &size);
> > +       if (!vec5 || size <= OV5_INDX(OV5_MMU_RADIX_300))
> > +               return;
> 
> Could be bike shedding but shouldn't we first check if
> we are in an LPAR and bail out of we are not, then
> if we *are* and the above size is too small to contain
> the ARCH 3.00 options, also disable radix as obviously
> the hypervisor doesn't know about it ?

This is *very* early on, so early that we haven't yet decided what
platform we're on.  If we're not in an LPAR then we won't have a
/chosen/ibm-architecture-vec-5 property.  Any hypervisor that is too
old to have that property will also be too old to set the radix
bit in the ibm,pa-features property, so we won't use radix.

If we do have the property but it's short then yes that's a good
indication that the hypervisor can't do radix, though in that case
it's strange that it set the radix bit in the ibm,pa-features property
(which must have been set otherwise we wouldn't have got here).

I'll do a new patch.

> > +       if (!(vec5[OV5_INDX(OV5_MMU_RADIX_300)] & OV5_FEAT(OV5_MMU_RADIX_300)))
> > +               /* Hypervisor doesn't support radix */
> > +               cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
> > +}
> > +

Paul.
