Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2CE1EB7CF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Feb 2010 10:07:08 +1100 (EST)
Date: Tue, 9 Feb 2010 10:07:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Subject: tip build problem on powerpc
Message-Id: <20100209100700.81685ffe.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__9_Feb_2010_10_07_00_+1100_dGQNYtNRg+qaRNfd"
Cc: Don Zickus <dzickus@redhat.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__9_Feb_2010_10_07_00_+1100_dGQNYtNRg+qaRNfd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Last night's build of tip/master on powerpc produced these errors:

kernel/nmi_watchdog.c:33: error: redefinition of 'touch_nmi_watchdog'
kernel/nmi_watchdog.c:59: error: 'nmi_watchdog_enabled' undeclared (first u=
se in this function)
kernel/nmi_watchdog.c:59: error: (Each undeclared identifier is reported on=
ly once
kernel/nmi_watchdog.c:59: error: for each function it appears in.)
kernel/nmi_watchdog.c:109: error: implicit declaration of function 'die_nmi'
kernel/nmi_watchdog.c:136: error: 'cpu_khz' undeclared (first use in this f=
unction)

This was from the powerpc pseries_defconfig build (as well as the
pamc32_defconfig, ppc6xx_defconfig and ppc64_defconfig builds).  Caused
by commit 1fb9d6ad2766a1dd70d167552988375049a97f21 ("nmi_watchdog: Add
new, generic implementation, using perf events") but exposed by commit
84e478c6f1eb9c4bfa1fff2f8108e9a061b46428 ("nmi_watchdog: Config option to
enable new nmi_watchdog").

Full logs, configs: http://kisskb.ellerman.id.au/kisskb/branch/12/
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__9_Feb_2010_10_07_00_+1100_dGQNYtNRg+qaRNfd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktwmRQACgkQjjKRsyhoI8zNbQCeMJzSrhHOO5x6ESgjQKBhCydi
Mv0AmgJ7giKuY3VHDLzA6Ts9gr09w/jN
=ukqN
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Feb_2010_10_07_00_+1100_dGQNYtNRg+qaRNfd--
