Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6C64A679F9
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 10:05:42 +1000 (EST)
Date: Mon, 1 May 2006 10:05:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: sign extension for 32bit syscalls on ppc64
Message-Id: <20060501100518.22aedb20.sfr@canb.auug.org.au>
In-Reply-To: <jezmi4xzoc.fsf@sykes.suse.de>
References: <20060428131254.GA507@lst.de>
	<17490.42497.351114.712494@cargo.ozlabs.ibm.com>
	<20060429113059.150cadd6.sfr@canb.auug.org.au>
	<17490.53377.898206.21369@cargo.ozlabs.ibm.com>
	<20060429131640.6f79e0d3.sfr@canb.auug.org.au>
	<jezmi4xzoc.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__1_May_2006_10_05_18_+1000_ykn=XvkAUjFUJ_HB"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__1_May_2006_10_05_18_+1000_ykn=XvkAUjFUJ_HB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Sat, 29 Apr 2006 15:46:11 +0200 Andreas Schwab <schwab@suse.de> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
> > Has any testing been done on these interfaces that involves 32 bit
> > processes passing AT_FDCWD on 64 bit kernels (I realise that it will wo=
rk
> > for some architectures but I suspect not ppc64).
>=20
> Appears to work fine for me (tested with openat).

Try mkdirat. openat has a compat wrapper that has the dfd paramater
declared as a unsigned int and passes it to sys_openat, whose first
paramter is decalred to be int, so the sign extension gets done.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__1_May_2006_10_05_18_+1000_ykn=XvkAUjFUJ_HB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEVVDDFdBgD/zoJvwRAu8dAJ9HHGsqjQa18ELTHvVb4KlfVy4M5ACfbcII
znPgdi5JU/TkXjruaVsDqZw=
=hrcM
-----END PGP SIGNATURE-----

--Signature=_Mon__1_May_2006_10_05_18_+1000_ykn=XvkAUjFUJ_HB--
