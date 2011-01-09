Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1637DB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  9 Jan 2011 11:41:57 +1100 (EST)
From: Ben Hutchings <ben@decadent.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
In-Reply-To: <1294532641.3283.70.camel@localhost>
References: <1294532641.3283.70.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Jan 2011 00:25:36 +0000
Message-ID: <1294532736.3283.73.camel@localhost>
Mime-Version: 1.0
Subject: [PATCH 2/2] powerpc/boot/Makefile: Use $(src) and $(obj) as per
	makefiles.txt
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

$(src) and $(obj) are normally the same, but are supposed to be used
for paths under $(srctree) and $(objtree) respectively.

Also use $(dtstree) and $(wrapper) as appropriate.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is totally untested, so please review carefully!

Ben.

 arch/powerpc/boot/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8917816..bd7abba 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -33,7 +33,7 @@ ifeq ($(call cc-option-yn, -fstack-protector),y)
 BOOTCFLAGS	+=3D -fno-stack-protector
 endif
=20
-BOOTCFLAGS	+=3D -I$(obj) -I$(srctree)/$(obj)
+BOOTCFLAGS	+=3D -I$(obj) -I$(srctree)/$(src)
=20
 DTC_FLAGS	?=3D -p 1024
=20
@@ -399,10 +399,10 @@ $(extra-installed)	: $(DESTDIR)$(WRAPPER_OBJDIR)/% : =
$(obj)/% | $(DESTDIR)$(WRAP
 $(hostprogs-installed)  : $(DESTDIR)$(WRAPPER_BINDIR)/% : $(obj)/% | $(DES=
TDIR)$(WRAPPER_BINDIR)
 	$(call cmd,install_exe)
=20
-$(dts-installed)	: $(DESTDIR)$(WRAPPER_DTSDIR)/% : $(srctree)/$(obj)/dts/%=
 | $(DESTDIR)$(WRAPPER_DTSDIR)
+$(dts-installed)	: $(DESTDIR)$(WRAPPER_DTSDIR)/% : $(dtstree)/% | $(DESTDI=
R)$(WRAPPER_DTSDIR)
 	$(call cmd,install_dts)
=20
-$(wrapper-installed): $(DESTDIR)$(WRAPPER_BINDIR) $(srctree)/$(obj)/wrappe=
r | $(DESTDIR)$(WRAPPER_BINDIR)
+$(wrapper-installed): $(DESTDIR)$(WRAPPER_BINDIR) $(wrapper) | $(DESTDIR)$=
(WRAPPER_BINDIR)
 	$(call cmd,install_wrapper)
=20
 $(obj)/bootwrapper_install: $(all-installed)
--=20
1.7.2.3
