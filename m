Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 47F45B7266
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 08:20:55 +1100 (EST)
Date: Fri, 18 Nov 2011 08:20:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 3/6] powerpc/85xx: separate MPIC handling code
Message-Id: <20111118082048.a92d484642d973332a47e7a8@canb.auug.org.au>
In-Reply-To: <4EC555D7.1080808@gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-3-git-send-email-dbaryshkov@gmail.com>
 <CALg11mj7DG2KE=pODJ526zQdQZSc4vFuDCtEGGYXNiwxpGAcyA@mail.gmail.com>
 <4EC555D7.1080808@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__18_Nov_2011_08_20_48_+1100_3xk3aWzu/BYsNPdW"
Cc: linuxppc-dev@lists.ozlabs.org, lee.nipper@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__18_Nov_2011_08_20_48_+1100_3xk3aWzu/BYsNPdW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Thu, 17 Nov 2011 22:43:35 +0400 Dmitry Eremin-Solenikov <dbaryshkov@gmai=
l.com> wrote:
>
> On 11/17/2011 10:30 PM, Lee Nipper wrote:
> > On Thu, Nov 17, 2011 at 11:56 AM, Dmitry Eremin-Solenikov
> > <dbaryshkov@gmail.com>  wrote:
> >> All mpc85xx boards deal with MPIC initialization in more or less the
> >> same way. The only difrerences are some flags (WANTS_RESET,
> >> BROKEN_FRR_NIRQS, SINGLE_DEST_CPU), and some bugs like leaking device
> >> node counter, etc. To minimize problems, switch all boards to use one
> >> single instance of code.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov<dbaryshkov@gmail.com>
> >
> > <snip>
> >
> > since parameters broken_frr and singledest are used later,
> > flags should probably be just:
> >
> >              unsigned int flags =3D MPIC_PRIMARY | MPIC_BIG_ENDIAN;
>=20
> Yes, forgot about this when cleaning up. Sorry.

Since the three arguments to this function are just used to set flags,
maybe it would be better to just pass in the extra flags required in each
case as a single argument.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_Nov_2011_08_20_48_+1100_3xk3aWzu/BYsNPdW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOxXqwAAoJEECxmPOUX5FE9NQP/1dLBEDUCrMT1mxi/9BA4Twd
VxcZY6JfqjRQ6B8PZK4vbHnP3ftipz/r5NFFFjPEVgZv0lNCis8PT+TFDYu656ap
87QG2ZTouIaipd81z3aanqQb4UEz5hxTZUbHRGcIWMiQ8dhNm28RvmWjZzSrTMl3
e9eM/LUNYdontkcUenF7eyUqWdgBcOzZ719RopMTTSlpFzfQaQOIIveYsH4W4O6Y
Ucp6kXEDDJhJ+YXBx17/jBYRZ0ZJT2ZUr9f0i2C/BxekXd+RFA+oUPjleu7gyU2o
pEUGE+Ik9iHdIInzWvwxLaNjLkmNNBCDL1bGXluA6FafWoiteo/KgWzQSaitLTKb
oFHRcksdkYyciab05pv+vsjS5KXwIS4iFd/Ch96KsHsqdB1Tb9SDeS2obbPylf/I
OOVHX8Sk/9+qKEku/x4IEf2jWJPcWsoYEdcnnirHdsukhF1Dbm7P3bjpbpgVxIQ3
M5rnV4IvqBXCPhRbqkI4L6oxO6JP+8KHoojL3Eke8OcXQa1y8/XRAUBJczHD0CHY
91kz0szZd6hQd/uWfqSlBAtGOVPx3ywGWmP+EqcvF2ROVFf/SAjoanHi+TFmp6MH
zFP+AX9sUI0QbxvuPOEHJkrousltwSzJ2bGSlLb1FiF9k6ZcVwsIoRsSfe9MYp7R
B5gcXceTdomBb8mypYSV
=NewE
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Nov_2011_08_20_48_+1100_3xk3aWzu/BYsNPdW--
