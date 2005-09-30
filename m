Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 30 Sep 2005 23:36:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__30_Sep_2005_23_36_02_+1000_fjKdipMiF9MEyg6g"
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/9] more merge changes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__30_Sep_2005_23_36_02_+1000_fjKdipMiF9MEyg6g
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Another series of patches to continue the merge.  These are some tidyups
and moving of more code and lead to enough merged for ppc64 legacy iSeries
to build and boot with ARCH=3Dpowerpc.  There is still a lot left to merge,
though.

As an aside, this leads to a machine that says this:

igosouth:~# uname -a
Linux igosouth 2.6.14-rc2sfr #1 SMP Fri Sep 30 17:16:03 EST 2005 powerpc GN=
U/Linux

i.e. it identifies itself as powerpc not ppc64. Which benh points out will
probably break all sorts of things :-)

I have built this for (my configs) pSeries, iSeries, g5, ARCH=3Dppc,
ARCH=3Dpowerpc ppc32 pmac, ARCH=3Dpowerpc iSeries and booted the ARCH=3Dpow=
erpc
iSeries kernel.  So hopefully I haven't broken too much.

Paulus, I will let you know where you can find my git tree in a separate em=
ail.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

 arch/powerpc/Kconfig                           |   12 +
 arch/powerpc/Kconfig.debug                     |    2=20
 arch/powerpc/Makefile                          |   28 +--
 arch/powerpc/kernel/Makefile                   |   20 +-
 arch/powerpc/kernel/asm-offsets.c              |  220 +++++++++++++-------=
-----
 arch/powerpc/kernel/head_64.S                  |    9 -
 arch/powerpc/kernel/idle_power4.S              |    5=20
 arch/powerpc/kernel/vmlinux.lds                |  174 -------------------
 arch/powerpc/kernel/vmlinux.lds.S              |  190 ++++++++++++++++++++-
 arch/powerpc/platforms/iseries/call_sm.h       |    7=20
 arch/powerpc/platforms/iseries/ipl_parms.h     |    7=20
 arch/powerpc/platforms/iseries/irq.c           |    3=20
 arch/powerpc/platforms/iseries/irq.h           |    8=20
 arch/powerpc/platforms/iseries/lpardata.c      |   10 -
 arch/powerpc/platforms/iseries/lpevents.c      |    2=20
 arch/powerpc/platforms/iseries/main_store.h    |    7=20
 arch/powerpc/platforms/iseries/pci.c           |    3=20
 arch/powerpc/platforms/iseries/proc.c          |    5=20
 arch/powerpc/platforms/iseries/processor_vpd.h |    7=20
 arch/powerpc/platforms/iseries/release_data.h  |    7=20
 arch/powerpc/platforms/iseries/setup.c         |   10 -
 arch/powerpc/platforms/iseries/spcomm_area.h   |    7=20
 arch/powerpc/platforms/iseries/vpd_areas.h     |    7=20
 arch/ppc/kernel/Makefile                       |    2=20
 arch/ppc/kernel/fpu.S                          |  133 ---------------
 arch/ppc/kernel/vector.S                       |  217 --------------------=
----
 arch/ppc64/Makefile                            |    2=20
 arch/ppc64/kernel/Makefile                     |   16 -
 arch/ppc64/kernel/vector.S                     |  172 -------------------
 include/asm-powerpc/system.h                   |    4=20
 include/asm-ppc64/iSeries/iSeries_irq.h        |    8=20
 31 files changed, 406 insertions(+), 898 deletions(-)

--Signature=_Fri__30_Sep_2005_23_36_02_+1000_fjKdipMiF9MEyg6g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPT9IFdBgD/zoJvwRAmU5AJwK0ct8tSm/hyd2u3S8iCASFJi/7gCeOG5A
b2yFuCRhDiy9sWVCIbJta04=
=xIBh
-----END PGP SIGNATURE-----

--Signature=_Fri__30_Sep_2005_23_36_02_+1000_fjKdipMiF9MEyg6g--
