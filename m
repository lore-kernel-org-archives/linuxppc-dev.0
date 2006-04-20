Return-Path: <robbat2@gentoo.org>
Received: from mail.net-conex.com (pops.net-conex.com [204.244.176.3])
	by ozlabs.org (Postfix) with ESMTP id 4B861679E6
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 10:16:12 +1000 (EST)
Received: from curie.orbis-terrarum.net (S01060050da688d47.vc.shawcable.net
	[24.80.100.253])
	by mail.net-conex.com (8.13.4/8.12.11) with ESMTP id k3K02FsD004515
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 17:02:15 -0700
Date: Wed, 19 Apr 2006 17:02:20 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: modules without a .toc section not loading
Message-ID: <20060420000220.GB22797@curie-int.vc.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I recently got myself a quad G5, and I'm working on a few things, and
I've run into what is either a ppc-specific GCC bug, or a module loader
bug. While the bug shows up in my custom module, it also shows up in two
other places in the current tree.

This was mentioned on the list in February, and Paulus asked for some
off-list input from the reporter, but I find nothing else.

Output in dmesg after insmod:
windfarm_pid: doesn't contain .toc or .stubs.

- My current tree is Paulus's powerpc.git tree.
- Tested with gcc 3.4.4 and 3.4.6 - both show the problem.
- in-tree modules that show it: windfarm_pid, ide-generic

Checking:
# objdump -h windfarm_pid.ko | grep toc
(not found)
# objdump -h windfarm_pid.o | grep toc
(not found)

Similarities in affected code:
All of the affected code seems to be very simple, and does not reference
very many external symbols, or any significant external symbols.

If I add some dud code with an external symbol (I added kalloc/kfree to
windfarm_pid), a .toc section does get generated correctly.

Hypothesis:
GCC isn't generating a .toc section because the source file doesn't
need one by it's consideration.=20

Ideas for Solutions:
1. Either the kernel needs to realize that it does not need a .toc
section (I'm uncertain about this, being new to PPC).
2. GCC is at fault, and it should be generating a .toc.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFERs+MPpIsIjIzwiwRAt2OAKCADghBHZUMOKovEhqT6ErLoSTMBQCg3BRH
07tgnH85A7yRoXkV0ZIr+2U=
=fjdZ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
