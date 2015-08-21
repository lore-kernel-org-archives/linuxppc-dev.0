Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 705531A0258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 16:35:12 +1000 (AEST)
Received: by pacdd16 with SMTP id dd16so37370262pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 23:35:10 -0700 (PDT)
Date: Fri, 21 Aug 2015 14:34:58 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/8] jump_label: introduce
 DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
Message-ID: <20150821063458.GC12451@pek-khao-d1.corp.ad.wrs.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
 <1440072876-8321-4-git-send-email-haokexin@gmail.com>
 <20150821062826.GA566@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
In-Reply-To: <20150821062826.GA566@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2015 at 08:28:26AM +0200, Ingo Molnar wrote:
>=20
> * Kevin Hao <haokexin@gmail.com> wrote:
>=20
> > These are used to define a static_key_{true,false} array.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  include/linux/jump_label.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> > index 7f653e8f6690..5c1d6a49dd6b 100644
> > --- a/include/linux/jump_label.h
> > +++ b/include/linux/jump_label.h
> > @@ -267,6 +267,12 @@ struct static_key_false {
> >  #define DEFINE_STATIC_KEY_FALSE(name)	\
> >  	struct static_key_false name =3D STATIC_KEY_FALSE_INIT
> > =20
> > +#define DEFINE_STATIC_KEY_TRUE_ARRAY(name, n)	\
> > +	struct static_key_true name[n] =3D { [0 ... n - 1] =3D STATIC_KEY_TRU=
E_INIT }
> > +
> > +#define DEFINE_STATIC_KEY_FALSE_ARRAY(name, n)	\
> > +	struct static_key_false name[n] =3D { [0 ... n - 1] =3D STATIC_KEY_FA=
LSE_INIT }
>=20
> I think the define makes the code more obfuscated and less clear, the ope=
n-coded=20
> initialization is pretty dense and easy to read to begin with.

OK, I will drop this patch and move the initialization of the array to the
corresponding patch.

Thanks,
Kevin

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1saSAAoJEJNY7TDerrFxWMAIAMl2ek57AbbSaUciuND2R8zY
Lcfmws7UgcAIoSTGPe3NuyOASAIon26FYe9H6CA+kaL9tIxmUtuE5Ewe39ZPZU2C
nJWdR+kLd2sTXZSTljFtrn0I0FiTTd0CitHC4+YztNcDfr6L77mTQntS6x+J1CB3
RYb4PjYX/u0H6CcvHczirvasWRU8sq8NJikyYsTois7UwKtsb4jFGKHAySi9y7FU
hUMINbTEi9pnRaGL0tz0vidYNxgMMqodwhrZyH8fgHVZHPlUfizMMecpXAVRLYK9
uJNbAgOB45DF+o2oYLDHATayrc7vWyHM3sPIjzWh+iTNa+G73oBLIfn16CkNQ1s=
=571b
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
