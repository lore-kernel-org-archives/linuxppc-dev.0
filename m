Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39F2C100876
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  9 Jan 2011 11:42:09 +1100 (EST)
From: Ben Hutchings <ben@decadent.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Jan 2011 00:24:01 +0000
Message-ID: <1294532641.3283.70.camel@localhost>
Mime-Version: 1.0
Subject: [PATCH 1/2] powerpc/boot/dts: Install dts from the right directory
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dts-installed variable is initialised using a wildcard path that
will be expanded relative to the build directory.  Use the existing
variable dtstree to generate an absolute wildcard path that will work
when building in a separate directory.

Reported-by: Gerhard Pircher <gerhard_pircher@gmx.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Tested-by: Gerhard Pircher <gerhard_pircher@gmx.net> [against 2.6.32]
---
 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 96deec6..8917816 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -368,7 +368,7 @@ INSTALL :=3D install
 extra-installed		:=3D $(patsubst $(obj)/%, $(DESTDIR)$(WRAPPER_OBJDIR)/%, =
$(extra-y))
 hostprogs-installed	:=3D $(patsubst %, $(DESTDIR)$(WRAPPER_BINDIR)/%, $(ho=
stprogs-y))
 wrapper-installed	:=3D $(DESTDIR)$(WRAPPER_BINDIR)/wrapper
-dts-installed		:=3D $(patsubst $(obj)/dts/%, $(DESTDIR)$(WRAPPER_DTSDIR)/%=
, $(wildcard $(obj)/dts/*.dts))
+dts-installed		:=3D $(patsubst $(dtstree)/%, $(DESTDIR)$(WRAPPER_DTSDIR)/%=
, $(wildcard $(dtstree)/*.dts))
=20
 all-installed		:=3D $(extra-installed) $(hostprogs-installed) $(wrapper-in=
stalled) $(dts-installed)
=20
--=20
1.7.2.3
