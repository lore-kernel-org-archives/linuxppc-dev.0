Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C8F5C67B35
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 13:44:56 +1000 (EST)
Date: Mon, 1 May 2006 13:44:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: schwab@suse.de
Subject: Re: sign extension for 32bit syscalls on ppc64
Message-Id: <20060501134440.2166d820.sfr@canb.auug.org.au>
In-Reply-To: <20060501100518.22aedb20.sfr@canb.auug.org.au>
References: <20060428131254.GA507@lst.de>
	<17490.42497.351114.712494@cargo.ozlabs.ibm.com>
	<20060429113059.150cadd6.sfr@canb.auug.org.au>
	<17490.53377.898206.21369@cargo.ozlabs.ibm.com>
	<20060429131640.6f79e0d3.sfr@canb.auug.org.au>
	<jezmi4xzoc.fsf@sykes.suse.de>
	<20060501100518.22aedb20.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__1_May_2006_13_44_40_+1000_qYf5Dc.dHA=B0T9M"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__1_May_2006_13_44_40_+1000_qYf5Dc.dHA=B0T9M
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 1 May 2006 10:05:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Try mkdirat. openat has a compat wrapper that has the dfd paramater
> declared as a unsigned int and passes it to sys_openat, whose first
> paramter is decalred to be int, so the sign extension gets done.

OK, I actually tried this and it works! :-(

I traced the code path and it turns out that the place we check for the
-100 (in do_path_lookup), the compiler has used a cmpwi instruction and so
ignores the top 32 bits.  Thus we get away with the ABI abuse!

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__1_May_2006_13_44_40_+1000_qYf5Dc.dHA=B0T9M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEVYQoFdBgD/zoJvwRAjBXAJ9dvz7uzIR5SHo60aHe+SmolNC1qACgoCGz
npoULxLXyF3Tn5YYikAiNPM=
=Q6p4
-----END PGP SIGNATURE-----

--Signature=_Mon__1_May_2006_13_44_40_+1000_qYf5Dc.dHA=B0T9M--
