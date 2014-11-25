Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 529FF1A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 05:12:23 +1100 (AEDT)
Date: Tue, 25 Nov 2014 19:13:47 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Message-ID: <20141125181347.GC9716@katana>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
 <1416274083.15957.96.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
In-Reply-To: <1416274083.15957.96.camel@freescale.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 Linux device trees <devicetree@vger.kernel.org>, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 07:28:03PM -0600, Scott Wood wrote:
> On Fri, 2014-11-14 at 09:28 +0100, Wolfram Sang wrote:
> > > >=20
> > > > If we're going to change the device tree I'd rather just add a prop=
erty
> > > > to say what the prescaler is.
> > >=20
> > >  We would however, leave the boards' device trees that use things like
> > > "fsl,mpc8543-i2c" as is and introduce the prescaler for the others re=
quiring it.
> > >=20
> > >=20
> > > Now the drawback is that the driver would require a change, to parse =
this
> > > prescaler new prescaler property. Would this be OK from your point of=
 view
> > > Wolfram ? If yes, I will send the patches for it.
> >=20
> > I don't think it is OK.
>=20
> Why?

Because I thought it could be deduced. Then, a seperate property would
not be OK.

> >  I'd think it can be deduced from the compatible property.
>=20
> For almost all existing device trees it cannot be.

Pity :( If we do introduce a new property, it should probably be
"clock-div". Grepping through binding documentation, that seems
accepted. We should ask DT maintainers, too, to be safe.

> If you want something that will work without changing device trees,
> you'll need to use SVR to identify the SoC.

The driver is doing that already, see mpc_i2c_get_sec_cfg_8xxx(). Dunno
if it makes sense to add to it for consistency reasons?


--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdMbbAAoJEBQN5MwUoCm2BIsQAJ+N/XUWx2AclSWuY0H6ZtQD
i5oOPHCbuu3GNjIqJlWjRRHYpMQb0wkl+u9Xbo8yzKULEeQ8cxb4FLOv70ylem/E
kFkyecWGFdkRnLwTSk8FvywYayTmlb0ktNBeg83XJcx58ibN+Otwc0WzWNM0cLFX
kKWhlNpKrz2LyNCJP4oFB7vhu5TClAo6VTdYBrN5bGY0BlEuhuRB7vx2RKTWvAWf
VTIoMIBDVJAHbIYfMo1mFUgu0yK1j69/IAT8N1UZXttKlG0ZCbpeTXYrLds+n7ss
DRChWvK9FH46gzzLmPbIAA/oUDAuetIcgyBwlwCt6xrW2MdncEML8YymhUjCF18p
g739ZFA7Ukvn9J5NK/3+JfCy4Z5/aY1yiCHazwHVFK8wv7Asr994fl27HenDGjSq
vupdCCv7cswoauVV4mydc0eZVovjFOijaVEwsFZLX6aXDLkw5OzEpA4xvh4lc9cm
B/vr3iDYHn0+EuVpYUovh3Ob3vW+TGOObY2QV+Wh2R4jvBqZQ9sVNBomg4r0W/Nc
61CQzvM5TpmwOVXnI6cXz++P079js300Qy4oAG/q6luchyPWBUk1vujCnXP3iRh4
PvkUjdU0H7SbYYAd/LEFpwqv29go9dz6BLEoAB1P33XdOfAdXPGmtqQv3oFzXs91
5vfrkJBSvxVChwOphWJf
=A8Vc
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
