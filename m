Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A57B1A0879
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 10:20:58 +1000 (EST)
Date: Mon, 11 Aug 2014 10:20:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
Message-ID: <20140811102052.6d9c28cb@canb.auug.org.au>
In-Reply-To: <1407561732-817-1-git-send-email-linux@roeck-us.net>
References: <1407561732-817-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Je.kQBUMvSEkChVVghKMWnP"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/Je.kQBUMvSEkChVVghKMWnP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Fri,  8 Aug 2014 22:22:12 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> Once again, we see
>=20
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:865: Error: attempt to move .org bac=
kwards
> arch/powerpc/kernel/exceptions-64s.S:866: Error: attempt to move .org bac=
kwards
> arch/powerpc/kernel/exceptions-64s.S:890: Error: attempt to move .org bac=
kwards
>=20
> when compiling ppc:allmodconfig.
>=20
> This time the problem has been caused by to commit 0869b6fd209bda
> ("powerpc/book3s: Add basic infrastructure to handle HMI in Linux"),
> which adds functions hmi_exception_early and hmi_exception_after_realmode
> into a critical (size-limited) code area, even though that does not appear
> to be necessary.
>=20
> Move those functions to a non-critical area of the file.
>=20
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Compile tested with all ppc configurations.
> The reported checkpatch error appears to be a false positive.

Thanks.

I have added that to my fixes tree for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/Je.kQBUMvSEkChVVghKMWnP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJT6AxpAAoJEMDTa8Ir7ZwVQBgP/3Ie7o02bek22/BasSgXzUqh
OpdoVzL3FGZFfUTPA83IiMt6r+qJGwHybnDOFBdp3vDV6FVncFbPfhaGnKfVPDwa
LBcj0vfNU9yksVoETtZZ0nyJ4V2X5YM+ziZMspNQeSfpzmK4k22ydaXBdPEM+9S1
xzq79p+SqmbwnbK+9S0pn+6hpZw8Cgr0buH35Bg0NPwdRxwvMflrIaCyMJ6WvCe2
XlCRAdkJ4O/W04o3+d/vSqi6fKsDjsX8P81O40w3h+S0zZTt56qXT8TnptmpglrY
IRi1ohMfY/3c0lXsCxawO5quwavDnBdv1mPsavgkCD7TV8eBPHy0rLz6/YPdpth9
Rc6IGnifLKbDouGInJToev7QmTKwewdmHMdDdcqeoWm0e/lha+iN3iDNz+EcGSPV
r5u8VxTuK7SpNE9zEOSO8QYi0G+RJvmZOACIUE5tJLzDlZ0+RgjqXf/g+Hhyk+BP
g3AF2IGXY5yulmM6XQEsJZ5hP9NHcp++b9+ELEYOgDRlzKXCpbljsFjfeLTfXSrr
C6S2+4xENS2PBjQZCl3ecLG2vhlzwE76UVzLBeiv1JDP89/wwDol6zb9pYbruJKr
jPE/YD7xDmkW4qDq+90mBLpPwkU7ugb1o35tugclG8C9WDDBt/NoZ8lvKBZCBZVt
JESCTLfRd4296OCgdR/q
=7aEu
-----END PGP SIGNATURE-----

--Sig_/Je.kQBUMvSEkChVVghKMWnP--
