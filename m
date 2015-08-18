Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C9191A0153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 02:23:11 +1000 (AEST)
Message-ID: <1439914990.1628.6.camel@neuling.org>
Subject: Re: [PATCH] cxl: Allow release of contexts which have been OPENED
 but not STARTED
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@ozlabs.org,  dja@axtens.net, benh@kernel.crashing.org,
 imunsie@au1.ibm.com
Date: Tue, 18 Aug 2015 09:23:10 -0700
In-Reply-To: <1439889583.31374.1.camel@ellerman.id.au>
References: <1439879415-9925-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1439889583.31374.1.camel@ellerman.id.au>
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

On Tue, 2015-08-18 at 19:19 +1000, Michael Ellerman wrote:
> On Tue, 2015-08-18 at 16:30 +1000, Andrew Donnellan wrote:
> > If we open a context but do not start it (either because we do not atte=
mpt
> > to start it, or because it fails to start for some reason), we are left
> > with a context in state OPENED. Previously, cxl_release_context() only
> > allowed releasing contexts in state CLOSED, so attempting to release an
> > OPENED context would fail.
> >=20
> > In particular, this bug causes available contexts to run out after some=
 EEH
> > failures, where drivers attempt to release contexts that have failed to
> > start.
> >=20
> > Allow releasing contexts in any state other than STARTED, i.e. OPENED o=
r
> > CLOSED (we can't release a STARTED context as it's currently using the
> > hardware).
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> > Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > ---
> >  drivers/misc/cxl/api.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> > index 6a768a9..1c520b8 100644
> > --- a/drivers/misc/cxl/api.c
> > +++ b/drivers/misc/cxl/api.c
> > @@ -59,7 +59,7 @@ EXPORT_SYMBOL_GPL(cxl_get_phys_dev);
> > =20
> >  int cxl_release_context(struct cxl_context *ctx)
> >  {
> > -	if (ctx->status !=3D CLOSED)
> > +	if (ctx->status =3D=3D STARTED)
> >  		return -EBUSY;
>=20
> So this doesn't break when you add a new state, is it worth writing it as=
:
>=20
> 	if (ctx->status >=3D STARTED)
> 		return -EBUSY;
>=20
> ?

Yeah I think that would be more future proof, although it won't make a
difference with the current code.

FWIW, looks good to me.

Mikey
