Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22c.google.com (mail-io0-x22c.google.com
 [IPv6:2607:f8b0:4001:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458601A1DD7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 17:53:57 +1000 (AEST)
Received: by iod35 with SMTP id 35so19758824iod.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 00:53:54 -0700 (PDT)
Date: Mon, 31 Aug 2015 15:53:40 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Geoff Levand <geoff@infradead.org>,
 Anatolij Gustschin <agust@denx.de>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Question] Is little endian supported on all the platforms?
Message-ID: <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
 <1441003958.2720.5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
In-Reply-To: <1441003958.2720.5.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2015 at 04:52:38PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2015-08-31 at 14:44 +0800, Boqun Feng wrote:
> > Hi all,
> >=20
> > I hit a strange build error on v4.2, when I try to build a LE kernel
> > with a slightly modification of the ppc64_defconfig. What I did is just
> > make ppc64_defconfig and make menuconfig to set CPU_LITTLE_ENDIAN=3Dy, =
and
> > then build the kernel.
> >=20
> > I did a little research myself, and found out the error is because of
> > trying to build a LE kernel with CONFIG_PPC_PS3=3Dy. So a simple way to
> > reproduce is:
>=20
> First, LE isn't supported on PS/3 :-) It's only supported on POWER8
> machines (and *some* P7 machines and only when running as KVM guest).
>=20

Got it, thank you ;-)

So should we modify Kconfigs of all the platform to reflect this?

> But the specific problem you are having looks like a differnet issue
> with the PS3 boot wrapper.
>=20

But could the reason of this be that the building process of the PS3
boot wrapper assumes the kernel is BE?

Regards,
Boqun

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV5AgBAAoJEEl56MO1B/q4YE8H/isjkc9NeBxWOxr64i1mPg5J
zKXhDPXC7H4GHjEKmd/BgrH5WSJduCXyFF808B3YP+j5tFv49mCxZ6xwwDOXkPoY
OoLfbsy87/AcNCSOwiAsiQkv+dl+QgZlvXljStTS8L+BcZ/bheoyNgumKp0rHcoH
/rsfMd+j2cWNvK3eCausNX18miTTV2qHvEu3Q6QiiuG9/ZJ4RN6gX4pn1jSmUZav
Yln1sn2bFWrXszeRPV1s0d5G9ufukiyYMYALWUXpr2+HFZV+E4kn9CvQvF+oYTaj
INEz8q6qNFA2+HnT2p9LCuayrvzVciHQ9E8ep2ssQh1Ysu6hgMI6rGpqnyuVRGw=
=vQsn
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
