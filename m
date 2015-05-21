Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8954A1A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 13:48:29 +1000 (AEST)
Message-ID: <1432180109.27130.16.camel@neuling.org>
Subject: Re: [PATCH v3] cxl: Export AFU error buffer via sysfs
From: Michael Neuling <mikey@neuling.org>
To: trigg <mr.triggtrigg@gmail.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, Michael Ellerman
 <michael@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
Date: Thu, 21 May 2015 13:48:29 +1000
In-Reply-To: <DFEFF502-9818-4AC2-ADDC-B5A16A047D71@gmail.com>
References: <1432142313-7741-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <1432165570.27130.5.camel@neuling.org>
 <DFEFF502-9818-4AC2-ADDC-B5A16A047D71@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-21 at 09:06 +0530, trigg wrote:
>=20
>=20
> > On 21-May-2015, at 05:16, Michael Neuling <mikey@neuling.org> wrote:
> >=20
> > + */
> > > +ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
> > > +                loff_t off, size_t count)
> > > +{
> > > +    loff_t aligned_off;
> > > +    size_t aligned_count;
> > > +    const void __iomem *ebuf =3D afu->afu_desc_mmio +
> > > afu->eb_offset;
> > > +
> > > +    if (!afu->eb_len || count =3D=3D 0 || off < 0)
> >=20
> > if eb_len =3D=3D 0 we don't even create the sysfs file.  So is this
> > check
> > needed?
> This function is non static so it can be potentially called from
> kernel.

What?  You mean outside this file?

> Condition check of "if (count =3D=3D 0 || off < 0 || (size_t)off
> >=3D afu->eb_len) "
> should work solving the problem below too.

It makes no sense to call this outside of sysfs reading the error
buffer.

> > > +    aligned_off =3D round_down(off, 8);
> > > +    aligned_count =3D round_up(off + count, 8) - aligned_off;
> >=20
> > I kinda preferred the start end variables, and length was just end -
> > start.
> >=20
> > I though it was more readable. IMHO
> >=20
> > How about:
> >=20
> >   aligned_start =3D round_down(off, 8);
> >   aligned_end =3D round_up(off + count, 8);
> >   aligned_length =3D aligned_end - aligned_start;
> Agreed on aligned_start and aligned_end but would not
> need aligned_end in rest of the code.

Aligned_end makes it more readable.

> >=20
> > > +
> > > +    /* fast path */
> > > +    if ((aligned_off =3D=3D off) && (aligned_count =3D=3D count)) {
> > > +        /* no need to use the bounce buffer */
> > > +        _memcpy_fromio(buf, ebuf + off, count);
> >=20
> > I would drop this, as the other code path should work fine.
> > Premature optimisation.....
> I am inclined to differ on this. Code below uses a bounce buffer
> which needs more than double the amount of loads and stores.

Cacheable vs non-cacheable is important here though.

> If the caller wants to speed up things it can simply ask for aligned
> read that won't have this overhead. This will be especially useful=20
> In large reads.

The overhead will mostly be in the non-cachable/MMIO load/stores rather
than the cacheable load/stores, so there may be little performance
difference  anyway.

The only reason this could be useful is if you have a really really
large error buffer.  Even then, why do you need to read it that quickly?

Mikey
