Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7C5FB7084
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 17:43:51 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8DD0DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 17:43:51 +1000 (EST)
Subject: Re: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: catalin.marinas@arm.com
In-Reply-To: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
References: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-okPXwpUUnxj6/rc68Hil"
Date: Thu, 16 Jul 2009 17:43:50 +1000
Message-Id: <1247730230.18228.5.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-okPXwpUUnxj6/rc68Hil
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-16 at 11:25 +1000, Michael Ellerman wrote:
> Very lightly tested, doesn't crash the kernel.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>=20
> It doesn't look like we actually need to add any support in the
> arch code - or is there something I'm missing?

Hmm, I think we want to add annotations in lib/lmb.c don't we? That's
our low-level pre-bootmem allocator.

And we have the same problem with _edata as x86.

And I'm seeing lots (~250) of these:

unreferenced object 0xc0000000fcd2e2f0 (size 16):
  comm "swapper", pid 1, jiffies 4294892393
  backtrace:
    [<c00000000014d9c0>] .create_object+0x164/0x2a8
    [<c00000000014dc94>] .kmemleak_alloc+0x74/0x120
    [<c0000000001474d0>] .__kmalloc+0x20c/0x2ac
    [<c00000000036998c>] .kvasprintf+0x64/0xb0
    [<c000000000360558>] .kobject_set_name_vargs+0x44/0xb4
    [<c0000000003f06d0>] .dev_set_name+0x50/0x6c
    [<c00000000042a794>] .scsi_sysfs_device_initialize+0xd0/0x16c
    [<c000000000426600>] .scsi_alloc_sdev+0x1c4/0x284
    [<c000000000426b50>] .scsi_probe_and_add_lun+0x144/0xbd4
    [<c0000000004279bc>] .__scsi_scan_target+0xfc/0x658
    [<c000000000427f90>] .scsi_scan_channel+0x78/0xe8
    [<c0000000004280cc>] .scsi_scan_host_selected+0xcc/0x154
    [<c00000000042823c>] .do_scsi_scan_host+0xe8/0x10c
    [<c0000000004286ec>] .scsi_scan_host+0x250/0x294
    [<c000000000456ef8>] .ibmvscsi_probe+0x4f8/0x630
    [<c000000000027418>] .vio_bus_probe+0x360/0x3cc


cheers

--=-okPXwpUUnxj6/rc68Hil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpe2jAACgkQdSjSd0sB4dJPnwCgo8e6jk+jiZyDP2sw6ZpM+Yxy
uU0AoKQzES5kG297PhCZ4FCpv6H7lnKR
=4Vxm
-----END PGP SIGNATURE-----

--=-okPXwpUUnxj6/rc68Hil--
