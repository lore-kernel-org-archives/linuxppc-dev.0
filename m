Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 70EA4B7D30
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Mar 2010 11:10:31 +1100 (EST)
Date: Wed, 3 Mar 2010 11:10:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: linux-next: possible recursive locking detected
Message-Id: <20100303111027.03ab3c15.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__3_Mar_2010_11_10_27_+1100_uFNhYnIKVqvGjR/j"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__3_Mar_2010_11_10_27_+1100_uFNhYnIKVqvGjR/j
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

next-20100302 (and next-20100301) produce this log during boot on a
Power5 lpar.

calling  .hvc_vio_init+0x0/0x34 @ 1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: possible recursive locking detected ]
2.6.33-autokern1 #1
---------------------------------------------
swapper/1 is trying to acquire lock:
 (&dev->mutex){+.+...}, at: [<c000000000345490>] .__driver_attach+0x80/0xe0

but task is already holding lock:
 (&dev->mutex){+.+...}, at: [<c000000000345480>] .__driver_attach+0x70/0xe0

other info that might help us debug this:
1 lock held by swapper/1:
 #0:  (&dev->mutex){+.+...}, at: [<c000000000345480>] .__driver_attach+0x70=
/0xe0

stack backtrace:
Call Trace:
[c0000000400cf590] [c000000000010780] .show_stack+0x70/0x184 (unreliable)
[c0000000400cf640] [c000000000096c24] .validate_chain+0x6e4/0xf2c
[c0000000400cf750] [c000000000097d8c] .__lock_acquire+0x920/0x9e4
[c0000000400cf850] [c000000000097ef8] .lock_acquire+0xa8/0xec
[c0000000400cf920] [c000000000567fc4] .mutex_lock_nested+0x5c/0x468
[c0000000400cfa00] [c000000000345490] .__driver_attach+0x80/0xe0
[c0000000400cfa90] [c000000000343f0c] .bus_for_each_dev+0x84/0xdc
[c0000000400cfb40] [c000000000344e6c] .driver_attach+0x28/0x40
[c0000000400cfbc0] [c0000000003448ec] .bus_add_driver+0xd8/0x2b0
[c0000000400cfc70] [c000000000345830] .driver_register+0xd4/0x1a8
[c0000000400cfd20] [c00000000002225c] .vio_register_driver+0x40/0x5c
[c0000000400cfdb0] [c0000000007ff4d4] .hvc_vio_init+0x1c/0x34
[c0000000400cfe30] [c0000000000094c0] .do_one_initcall+0x9c/0x1cc
[c0000000400cfee0] [c0000000007d6d2c] .kernel_init+0x218/0x294
[c0000000400cff90] [c000000000026c00] .kernel_thread+0x54/0x70
initcall .hvc_vio_init+0x0/0x34 returned 0 after 1904 usecs

Any ideas?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__3_Mar_2010_11_10_27_+1100_uFNhYnIKVqvGjR/j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuNqPMACgkQjjKRsyhoI8z5PQCfbWDaxg00Xlql6CuzXX7rk2kE
PbIAnjwEwX6CVCX0KBNb6T6IJwrJZgOg
=aDoc
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Mar_2010_11_10_27_+1100_uFNhYnIKVqvGjR/j--
