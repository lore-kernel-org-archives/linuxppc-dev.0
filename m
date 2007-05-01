Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 826BADDE9F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 17:35:44 +1000 (EST)
Date: Tue, 1 May 2007 17:22:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Subject: [PATCH 0/11] Consolidation of Open Firmware routines
Message-Id: <20070501172250.80707fb8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_May_2007_17_22_50_+1000_2FNZMhIkHjgaNk_P"
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__1_May_2007_17_22_50_+1000_2FNZMhIkHjgaNk_P
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi all,

Just thought I would show you all where I am up to.  I have moved from
openfw.h, drivers/openf and CONFIG_OPENFW to of.h, drivers/of and
CONFIG_OF - if this offends anyone please scream soon so I can change
that back.

The current diffstat looks like below, so some progress has been made:

 arch/powerpc/Kconfig              |    3 +
 arch/powerpc/kernel/of_device.c   |  122 +----------------
 arch/powerpc/kernel/prom.c        |  249 +---------------------------------
 arch/sparc/Kconfig                |    3 +
 arch/sparc/kernel/of_device.c     |  151 +++-----------------
 arch/sparc/kernel/prom.c          |  173 +-----------------------
 arch/sparc/kernel/time.c          |    2 +-
 arch/sparc64/Kconfig              |    3 +
 arch/sparc64/kernel/auxio.c       |    2 +-
 arch/sparc64/kernel/of_device.c   |  164 ++++------------------
 arch/sparc64/kernel/power.c       |    2 +-
 arch/sparc64/kernel/prom.c        |  173 +-----------------------
 arch/sparc64/kernel/time.c        |    2 +-
 drivers/Kconfig                   |    2 +
 drivers/Makefile                  |    1 +
 drivers/of/Kconfig                |    3 +
 drivers/of/Makefile               |    2 +
 drivers/of/base.c                 |  274 +++++++++++++++++++++++++++++++++++++
 drivers/of/device.c               |  131 ++++++++++++++++++
 include/asm-powerpc/of_device.h   |   22 +---
 include/asm-powerpc/of_platform.h |   38 +-----
 include/asm-powerpc/prom.h        |   47 ++-----
 include/asm-sparc/of_device.h     |   49 +------
 include/asm-sparc/of_platform.h   |   32 +++++
 include/asm-sparc/prom.h          |   65 +++------
 include/asm-sparc64/of_device.h   |   50 +------
 include/asm-sparc64/of_platform.h |   33 +++++
 include/asm-sparc64/prom.h        |   65 +++------
 include/linux/of.h                |   60 ++++++++
 include/linux/of_device.h         |   26 ++++
 include/linux/of_platform.h       |   55 ++++++++

The battle continues :-)
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_May_2007_17_22_50_+1000_2FNZMhIkHjgaNk_P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGNurPFdBgD/zoJvwRAlQHAJ4gsKsKO1dh+bmQt/9v6k5FKCk7pACgkuGw
aL8CeDRcy04KoaP566XMMhE=
=kdf/
-----END PGP SIGNATURE-----

--Signature=_Tue__1_May_2007_17_22_50_+1000_2FNZMhIkHjgaNk_P--
