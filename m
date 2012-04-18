Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 57F29B6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 23:28:21 +1000 (EST)
Message-ID: <1334755678.5989.320.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 18 Apr 2012 15:27:58 +0200
In-Reply-To: <1334747877.3143.12.camel@pasglop>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <1334744414.3143.2.camel@pasglop> <1334745292.5989.291.camel@thor.local>
 <1334747877.3143.12.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, o jordan <ojordan12345@hotmail.co.uk>,
 Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2012-04-18 at 21:17 +1000, Benjamin Herrenschmidt wrote:=20
> On Wed, 2012-04-18 at 12:34 +0200, Michel D=C3=A4nzer wrote:
> > On Mit, 2012-04-18 at 20:20 +1000, Benjamin Herrenschmidt wrote:=20
> > > On Wed, 2012-04-18 at 10:02 +0200, Michel D=C3=A4nzer wrote:
> > > >=20
> > > > > GPU lockup appears to be a common problem with the radeon driver.
> > > >=20
> > > > It's what happens when anything goes wrong with the GPU. If it does=
n't
> > > > happen with agpmode=3D-1, it's probably an AGP related coherency is=
sue.=20
> > >=20
> > > I had some success hacking the DRM to do an in_le32 from the ring hea=
d
> > > after writing it. Just a gross hack but it seemed to help on a G5.
> >=20
> > AFAICT radeon_ring_commit() does that already:
> >=20
> >         DRM_MEMORYBARRIER();
> >         WREG32(ring->wptr_reg, (ring->wptr << ring->ptr_reg_shift) & ri=
ng->ptr_reg_mask);
> >         (void)RREG32(ring->wptr_reg);
> >=20
> > We added the readback about a decade ago. :)
>=20
> Hrm, I have a different hack in that old tree I was playing with a while
> back, let me see...
>=20
> --- a/drivers/gpu/drm/radeon/radeon_cp.c
> +++ b/drivers/gpu/drm/radeon/radeon_cp.c

Note that radeon_cp.c is UMS code, for KMS you need to look at
radeon_ring.c.

> @@ -2245,6 +2245,9 @@ void radeon_commit_ring(drm_radeon_private_t
> *dev_priv)
>         DRM_MEMORYBARRIER();
>         GET_RING_HEAD( dev_priv );
> =20
> +#ifdef CONFIG_PPC
> +       in_be32(dev_priv->ring.start);
> +#endif
>         if ((dev_priv->flags & RADEON_FAMILY_MASK) >=3D CHIP_R600) {
>=20
>=20
> I think that my rational was to ensure that all previous stores to
> AGP (indirect buffers etc...) were pushed out & ordered vs the ring
> wptr update or something like that, bcs I think those path aren't well
> ordered in HW. In fact I suspect we might even need a bigger hammer than
> that in_be32().

Probably wouldn't hurt trying something like that in the KMS code as
well.


> Another hack I had around was removing the SBA reset from agp-uninorth
> completely on binding new pages, it seemed to cause hangs.

You mean like commit 5613beb46d54da6ef7f1c4589e9f2e60eeb10721? :)


> > > I suspect there's a fundamental design issue with apple bridge in tha=
t
> > > the CPU to memory path isn't coherent at all with the GPU to memory p=
ath
> > > ie. even vs. cache flush instructions (ie buffers in the memory
> > > controllers can still be out of sync).
> > >=20
> > > Darwin does some gross hacks to work around that, some of them visibl=
e
> > > in the AGP drivers, some burried in the Apple driver, I don't know fo=
r
> > > sure. It's possible that they end up mapping all AGP memory as cache
> > > inhibited, but we can't do that because of our linear mapping.
> >=20
> > We are doing that though...
>=20
> Are we really ? I thought we were taking existing cachable RAM objects
> and mapping them into the AGP gart.

No, the radeon driver has always mapped memory uncacheable to the CPU
while it's bound into the AGP GART.

> Are we replacing both kernel & user mappings for those objects with an
> equivalent cache inhibited mapping ?=20
>=20
> I'm not -that- familiar with how ttm works here.

I'm hardly more familiar with how it all works than you. :)

> In any case it can cause bus checkstops because the same pages can be
> prefetched into the cache via the linear mapping which is covered by
> BATs

So you've been saying for about a decade. :) But I've never seen any
problems tracked down to that.

> (unless you make your graphic objects HIGHMEM only but good luck with
> that :-)

FWIW I think TTM indeed prefers highmem pages for GPU access. The radeon
driver normally doesn't need kernel mappings for them.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
