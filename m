Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DD591A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 01:28:47 +1100 (AEDT)
Date: Mon, 11 Jan 2016 14:00:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20160111140038.GC6588@sirena.org.uk>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hI0LKvM4dmXJ5Wy2"
In-Reply-To: <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--hI0LKvM4dmXJ5Wy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2016 at 10:10:56AM -0200, Fabio Estevam wrote:
> On Mon, Jan 11, 2016 at 10:04 AM, Fabio Estevam <festevam@gmail.com> wrote:

> > [    2.526984] ------------[ cut here ]------------
> > [    2.531632] WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:2755
> > lockdep_trace_alloc+0xf4/0x124()

> This fixes the warning:

> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -180,7 +180,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
>         .volatile_reg = fsl_ssi_volatile_reg,
>         .precious_reg = fsl_ssi_precious_reg,
>         .writeable_reg = fsl_ssi_writeable_reg,
> -       .cache_type = REGCACHE_RBTREE,
>  };

> Is this the correct fix?

I suspect not, it looks like the driver is using the cache for
suspend/resume handling.  I've dropped the patch for now.  Either the
driver should explicitly write to the relevant registers outside of
interrupt context to ensure the cache entry exists or it should keep the
defaults and explicitly write them to hardware at startup to ensure
sync (the former is more likely to be safe).

--hI0LKvM4dmXJ5Wy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWk7WFAAoJECTWi3JdVIfQqwMH/igsSpD64+/Csx8zYZBUH/pX
CmUjBDptMDMUTqpKcUd/eo7wCnAuFClaMjI50f06Gr12FMvCjfqmxAbCR+dvUBfk
MfLE7ofTq8cgzkmXYpMFaIxvkkeIxwF5PBlhIfPGTNuZ86V4MRtf4P8uOKLNW7EF
5HB3tzw+ehuQt+aolGy3rx6Db9JiCX5ad6oT5ZfJC4tVAcQFiW5Bo+YnK67ON1m9
fp7wyoDW8n+zkbJsgonDHNIvtTtPvfwmkqU6HKy9suhaIycMHCUI8nprHbUwNC6C
mxe2so2kRfNrwk9UCeQWsKcXlYGHcCd4Pe3pT3WCeHFQj1k+m04TjyeCce2dtYo=
=h59D
-----END PGP SIGNATURE-----

--hI0LKvM4dmXJ5Wy2--
