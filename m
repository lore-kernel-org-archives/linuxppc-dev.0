Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 680F3DDF1B
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 00:29:35 +1000 (EST)
Received: from [84.135.193.106] (helo=[10.0.0.4])
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.66) (envelope-from <johannes@sipsolutions.net>)
	id 1HhRRy-0001py-8S
	for linuxppc-dev@ozlabs.org; Fri, 27 Apr 2007 15:29:30 +0100
Subject: kref badness with snd-aoa, powerpc.git
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nAo1IUkc6noyO9RkgoSo"
Date: Fri, 27 Apr 2007 16:29:32 +0200
Message-Id: <1177684172.3565.11.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nAo1IUkc6noyO9RkgoSo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm not exactly sure what is causing this for aoa:
[  149.604347] ------------[ cut here ]------------
[  149.604363] Badness at lib/kref.c:32
[  149.604368] Call Trace:
[  149.604373] [e9211bc0] [c0008e24] show_stack+0x3c/0x194 (unreliable)
[  149.604394] [e9211bf0] [c018afc4] report_bug+0x84/0xf4
[  149.604412] [e9211c00] [c02f8674] __kprobes_text_start+0xd4/0x53c
[  149.604431] [e9211c50] [c0011b10] ret_from_except_full+0x0/0x4c
[  149.604445] --- Exception: 700 at kref_get+0xc/0x24
[  149.604456]     LR =3D of_node_get+0x20/0x38
[  149.604462] [e9211d10] [c008c10c] kmem_cache_zalloc+0xac/0x114 (unreliab=
le)
[  149.604475] [e9211d20] [c000f764] of_get_next_child+0x3c/0x98
[  149.604485] [e9211d40] [f265d20c] i2sbus_probe+0x54/0x664 [snd_aoa_i2sbu=
s]
[  149.604504] [e9211da0] [c01fe664] macio_device_probe+0x5c/0x84
[  149.604518] [e9211dc0] [c01eed4c] really_probe+0x80/0x17c
[  149.604530] [e9211de0] [c01ef124] __driver_attach+0xe8/0x118
[  149.604541] [e9211e00] [c01ee000] bus_for_each_dev+0x58/0x94
[  149.604551] [e9211e30] [c01eeb94] driver_attach+0x24/0x34
[  149.604561] [e9211e40] [c01ee40c] bus_add_driver+0x88/0x1b4
[  149.604571] [e9211e60] [c01ef464] driver_register+0x68/0xb0
[  149.604581] [e9211e70] [c01fe528] macio_register_driver+0x28/0x38
[  149.604592] [e9211e80] [f25e0018] soundbus_i2sbus_init+0x18/0x48 [snd_ao=
a_i2sbus]
[  149.604604] [e9211e90] [c0051da0] sys_init_module+0x170/0x1578
[  149.604615] [e9211f40] [c00114b4] ret_from_syscall+0x0/0x38
[  149.604625] --- Exception: c01 at 0xff6e284
[  149.604648]     LR =3D 0x10003c50

It prints a few more of these coming from __pmf_find_function. May well
be a refcounting bug in aoa itself, but I can't seem to make out what it
would be. Does anybody have any ideas?

johannes

--=-nAo1IUkc6noyO9RkgoSo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMgjM/ETPhpq3jKURAqbfAKCttzh/rHQ4tPPmOn4O5WdVCXucAwCgtY2v
9R+lBxBObkgCPczdsUpxMlc=
=mpFc
-----END PGP SIGNATURE-----

--=-nAo1IUkc6noyO9RkgoSo--
