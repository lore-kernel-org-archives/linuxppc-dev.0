Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xhgMX66jvzDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 06:33:44 +1000 (AEST)
Date: Tue, 29 Aug 2017 22:33:40 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, ludovic.desroches@microchip.com, jochen@scram.de,
 vadimp@mellanox.com, michaelsh@mellanox.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 andy.gross@linaro.org, david.brown@linaro.org, ldewangan@nvidia.com,
 thierry.reding@gmail.com, jonathanh@nvidia.com,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] i2c: busses: make i2c_adapter_quirks const
Message-ID: <20170829203340.cl2uiuqoaikwsvmv@ninjato>
References: <1503317524-21276-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6re5ubh3nkbyixxu"
In-Reply-To: <1503317524-21276-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6re5ubh3nkbyixxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 05:42:04PM +0530, Bhumika Goyal wrote:
> Make these const as they are only stored as a reference in the quirks
> field of an i2c_adapter structure, which is const.
>=20
> Done using Coccinelle:
> @match disable optional_qualifier@
> identifier s;
> @@
> static struct i2c_adapter_quirks s =3D {...};
>=20
> @ref@
> position p;
> identifier match.s;
> @@
> s@p
>=20
> @good1@
> identifier y;
> position ref.p;
> identifier match.s;
> @@
> struct i2c_adapter y =3D {...,.quirks=3D&s@p,...};
>=20
> @good2@
> struct i2c_adapter y;
> identifier match.s;
> position ref.p;
> @@
> y.quirks =3D &s@p
>=20
> @bad depends on  !good1 && !good2@
> position ref.p;
> identifier match.s;
> @@
> s@p
>=20
> @depends on forall !bad disable optional_qualifier@
> identifier match.s;
> @@
> static
> + const
> struct i2c_adapter_quirks s;
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Removed the cocci script from the commit message and applied to
for-next, thanks!


--6re5ubh3nkbyixxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlz6QACgkQFA3kzBSg
KbahRhAAq5+Jb7JhVOWnWvrQZNJRrT/XvVWTrPEjmqWleZqOWYwlf+xVMwHhPruF
VOoJfL3nSNtkW5KwE0tv06SGlaztPvrLGA+lNO+AFcn9XsPes6nVuYC9G0uPw70L
tULYk2zkFsyAqfSAMOq9YL7HcxjLVo7awd/uJ+G7FI+nxKEmzCP1kjYUsnh+8ITa
BS7haPyonxgM5dCgJJc5MqKyGuKqPcgoYGrJ1ExPMKq3OGIkz684hQdpXMCpg8yd
cMylVExAco61ZZYKmWGFA1l+4PSVXowqifyemZgkUOfjfsqQvB6A9QrojJhjdnXW
LPpiNv4YsaCDV0tGJ27CUG9+PBDq464EuGKqQR5UeAqGtnkVUFOnJk96IoSrBqaE
ksAtJSFmSVJ41kWyuq1nHxw8AIeyOBP46huD8zy59fi4wzv9RRJkazZvMQCswl/P
dn/Sk4/WlgACE5veaGz8WfJQzq9/vNpmIG4Hyy5UyMhYPBMBot8teJxpVdxb3G9A
yis7y82MYnjTwR5smULX3NHtkZSlojIe3M/ry4gaZt0YXDmk3TwFhb3UoZDkg4mM
6qFPJBDPMzMOnhaDSedgDi8/m2DUa5Yaa3r+pSHu6mDXRzX2pQMKFHMW3nhN6HG0
G9NXPY4RVmNrbszG4aNi4cVYld9PUWyq8yxy0lXOAZyk/KUrvFI=
=E5i7
-----END PGP SIGNATURE-----

--6re5ubh3nkbyixxu--
