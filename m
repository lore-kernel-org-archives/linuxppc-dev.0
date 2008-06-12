Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 86A30DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 17:05:16 +1000 (EST)
Date: Thu, 12 Jun 2008 17:05:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Modra <amodra@bigpond.net.au>
Subject: Re: linux-next: powerpc build failure
Message-Id: <20080612170505.6049fa75.sfr@canb.auug.org.au>
In-Reply-To: <20080612053335.GA22035@bubble.grove.modra.org>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
	<20080611095951.GB14033@elte.hu>
	<18512.32267.636550.47385@cargo.ozlabs.ibm.com>
	<20080612053335.GA22035@bubble.grove.modra.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__12_Jun_2008_17_05_05_+1000_vzfSIjzIrtG6spjm"
Cc: Thomas, linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__12_Jun_2008_17_05_05_+1000_vzfSIjzIrtG6spjm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jun 2008 15:03:35 +0930 Alan Modra <amodra@bigpond.net.au> wrote:
>
> On Thu, Jun 12, 2008 at 11:38:19AM +1000, Paul Mackerras wrote:
> > Direct unconditional branches, including procedure calls, can only
> > reach +/- 32MB from the address of the branch on powerpc.  So if the
> > image grows to more than 32MB of text there is a problem unless the
> > linker is smart enough to insert trampolines.  I don't know whether
> > GNU ld is that smart.
>=20
> It is, but you need to pass --relax to enable generation of the
> trampolines.

So I tried this (added --relax to LDFLAGS_vmlinux if CONFIG FTRACE was
set) and got this;

/usr/bin/ld: --relax and -r may not be used together

So, I will disable FTRACE on powerpc for now by removing HAVE_FTRACE from
being selected in arch/powerpc/Kconfig.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__12_Jun_2008_17_05_05_+1000_vzfSIjzIrtG6spjm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhQyqEACgkQTgG2atn1QN+8VgCeKNq4rWhMN7Uu5asxOt2++UZB
kzAAnAzNX0rPO27Bn4RbwoRBdyImeKdT
=QlV6
-----END PGP SIGNATURE-----

--Signature=_Thu__12_Jun_2008_17_05_05_+1000_vzfSIjzIrtG6spjm--
