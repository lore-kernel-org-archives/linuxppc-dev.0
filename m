Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 87F58B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 20:35:12 +1000 (EST)
Message-ID: <1334745292.5989.291.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 18 Apr 2012 12:34:52 +0200
In-Reply-To: <1334744414.3143.2.camel@pasglop>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <1334744414.3143.2.camel@pasglop>
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

On Mit, 2012-04-18 at 20:20 +1000, Benjamin Herrenschmidt wrote:=20
> On Wed, 2012-04-18 at 10:02 +0200, Michel D=C3=A4nzer wrote:
> >=20
> > > GPU lockup appears to be a common problem with the radeon driver.
> >=20
> > It's what happens when anything goes wrong with the GPU. If it doesn't
> > happen with agpmode=3D-1, it's probably an AGP related coherency issue.=
=20
>=20
> I had some success hacking the DRM to do an in_le32 from the ring head
> after writing it. Just a gross hack but it seemed to help on a G5.

AFAICT radeon_ring_commit() does that already:

        DRM_MEMORYBARRIER();
        WREG32(ring->wptr_reg, (ring->wptr << ring->ptr_reg_shift) & ring->=
ptr_reg_mask);
        (void)RREG32(ring->wptr_reg);

We added the readback about a decade ago. :)


> I suspect there's a fundamental design issue with apple bridge in that
> the CPU to memory path isn't coherent at all with the GPU to memory path
> ie. even vs. cache flush instructions (ie buffers in the memory
> controllers can still be out of sync).
>=20
> Darwin does some gross hacks to work around that, some of them visible
> in the AGP drivers, some burried in the Apple driver, I don't know for
> sure. It's possible that they end up mapping all AGP memory as cache
> inhibited, but we can't do that because of our linear mapping.

We are doing that though...


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
