Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAD311A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 21:33:29 +1000 (EST)
Message-ID: <1411731209.1733.51.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 10/15] powerpc/mm: Add hooks for cxl
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Date: Fri, 26 Sep 2014 21:33:29 +1000
In-Reply-To: <20140926143309.33c0eeac@kryten>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-11-git-send-email-mikey@neuling.org>
 <20140926143309.33c0eeac@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-09-26 at 14:33 +1000, Anton Blanchard wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > This add a hook into tlbie() so that we use global invalidations when
> > there are cxl contexts active.
> >=20
> > Normally cxl snoops broadcast tlbie.  cxl can have TLB entries
> > invalidated via MMIO, but we aren't doing that yet.  So for now we
> > are just disabling local tlbies when cxl contexts are active.  In
> > future we can make tlbie() local mode smarter so that it invalidates
> > cxl contexts explicitly when it needs to.
> >=20
> > This also adds a hooks for when SLBs are invalidated to ensure any
> > corresponding SLBs in cxl are also invalidated at the same time.
> >=20
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>=20
> > +	use_local =3D local && mmu_has_feature(MMU_FTR_TLBIEL) && !cxl_ctx_in=
_use();
>=20
> Seems reasonable until we can get the MMIO based optimisation in.
>=20
> Will all CAPI cached translations be invalidated before we finish using
> a CAPI context?=20

I'm not sure I understand. Can you elaborate?

> And conversely, could CAPI cache any translations when a
> context isn't active?=20

The kernel invalidates all translations when the file descriptor is
closed.  So no, unless the PSL was badly behaving and ignoring the
invalidations.... but if we can't trust the PSL we're screwed.

> I'm mostly concerned that we can't have a
> situation where badly behaving userspace could result in a stale
> translation.

We only map what a user processes maps and we tear it down when the
process is teared down (on the file descriptor release).  So I think we
are ok. =20

Unless there's some lazy teardown you're alluding to that I'm missing?

>=20
> >  	spu_flush_all_slbs(mm);
> >  #endif
> > +	cxl_slbia(mm);
>=20
> >  			spu_flush_all_slbs(mm);
> >  #endif
> > +			cxl_slbia(mm);
>=20
> >  	spu_flush_all_slbs(mm);
> >  #endif
> > +	cxl_slbia(mm);
>=20
> >  	spu_flush_all_slbs(mm);
> >  #endif
> > +	cxl_slbia(mm);
>=20
> Should we combine the SPU vs CXL callouts into something common -
> perhaps copro_flush_all_slbs()?

Sounds good.  I'll update.

Mikey
