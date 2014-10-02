Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5537A1A0A44
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 12:01:53 +1000 (EST)
Message-ID: <1412215312.19209.96.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 04/17] powerpc/msi: Improve IRQ bitmap allocator
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Oct 2014 12:01:52 +1000
In-Reply-To: <20141001071331.CBE1B14017C@ozlabs.org>
References: <20141001071331.CBE1B14017C@ozlabs.org>
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

On Wed, 2014-10-01 at 17:13 +1000, Michael Ellerman wrote:
> On Tue, 2014-30-09 at 10:34:53 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > Currently msi_bitmap_alloc_hwirqs() will round up any IRQ allocation re=
quests
>                                                                        re=
quest
> > to the nearest power of 2.  eg. ask for 5 IRQs and you'll get 8.  This =
wastes a
>                              ^ one space after a period, or die!
>=20
> > lot of IRQs which can be a scarce resource.
> >=20
> > For cxl we can require multiple IRQs for every contexts that is attache=
d to the
>                                                  context
> > accelerator.  For AFU directed accelerators, there may be 1000s of cont=
exts
>=20
> What is an AFU directed accelerator?

=46rom the documentation in the last patch:

AFU Models
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    There are two programming models supported by the AFU.  Dedicated
    and AFU directed.  AFU may support one or both models.

    In dedicated model only one MMU context is supported.  In this
    model, only one userspace process can use the accelerator at time.

    In AFU directed model, up to 16K simultaneous contexts can be
    supported.  This means up to 16K simultaneous userspace
    applications may use the accelerator (although specific AFUs may
    support less).  In this mode, the AFU sends a 16 bit context ID
    with each of its requests.  This tells the PSL which context is
    associated with this operation.  If the PSL can't translate a
    request, the ID can also be accessed by the kernel so it can
    determine the associated userspace context to service this
    translation with.

>                   =20
> > attached, hence we can easily run out of IRQs, especially if we are nee=
dlessly
> > wasting them.
> >=20
> > This changes the msi_bitmap_alloc_hwirqs() to allocate only the require=
d number
>                 x
> > of IRQs, hence avoiding this wastage.
>=20
> The crucial detail you failed to mention is that you maintain the behavio=
ur that
> allocations are naturally aligned.

ok, I'll add that.

> Can you add a check in the test code at the bottom of the file to confirm=
 that
> please?

Yep
>=20
> > diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi=
_bitmap.c
> > index 2ff6302..961a358 100644
> > --- a/arch/powerpc/sysdev/msi_bitmap.c
> > +++ b/arch/powerpc/sysdev/msi_bitmap.c
> > @@ -20,32 +20,37 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp,=
 int num)
> >  	int offset, order =3D get_count_order(num);
> > =20
> >  	spin_lock_irqsave(&bmp->lock, flags);
> > -	/*
> > -	 * This is fast, but stricter than we need. We might want to add
> > -	 * a fallback routine which does a linear search with no alignment.
> > -	 */
> > -	offset =3D bitmap_find_free_region(bmp->bitmap, bmp->irq_count, order=
);
> > +
> > +	offset =3D bitmap_find_next_zero_area(bmp->bitmap, bmp->irq_count, 0,
> > +					    num, (1 << order) - 1);
> > +	if (offset > bmp->irq_count)
> > +		goto err;
>=20
> Can we get a newline here :)

Ok.

>=20
> > +	bitmap_set(bmp->bitmap, offset, num);
> >  	spin_unlock_irqrestore(&bmp->lock, flags);
> > =20
> >  	pr_debug("msi_bitmap: allocated 0x%x (2^%d) at offset 0x%x\n",
> >  		 num, order, offset);
>=20
> This print out is a bit confusing now, should probably just drop the orde=
r.

Arrh, yep.

Thanks,
Mikey
