Return-Path: <loeliger@ld0161-tx32.am.freescale.net>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8781DDEF4
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 01:20:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6NFKrJY004754
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:20:54 -0700 (MST)
Received: from ld0161-tx32.am.freescale.net (ld0161-tx32.am.freescale.net
	[10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6NFKr3W005840
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:20:53 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] libfdt: Fix 'make install' target handling of .h files.
Date: Wed, 23 Jul 2008 10:20:53 -0500
Message-Id: <1216826453-18515-1-git-send-email-jdl@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The definition of LIBFDT_INCLUDES was accidentally dropped.
Put it back and add srcdir prefix handling for it.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 Makefile               |    4 +++-
 libfdt/Makefile.libfdt |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e871855..0222dc0 100644
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,7 @@ install: all
 	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -m 644 $(LIBFDT_lib) $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
-	$(INSTALL) -m 644 $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_INCLUDES)) $(DESTDIR)$(INCLUDEDIR)
+	$(INSTALL) -m 644 $(LIBFDT_include) $(DESTDIR)$(INCLUDEDIR)
 
 #
 # Rules for versioning
@@ -140,6 +140,8 @@ endif
 LIBFDT_objdir = libfdt
 LIBFDT_srcdir = libfdt
 LIBFDT_lib = $(LIBFDT_objdir)/libfdt.a
+LIBFDT_include = $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_INCLUDES))
+
 include $(LIBFDT_srcdir)/Makefile.libfdt
 
 .PHONY: libfdt
diff --git a/libfdt/Makefile.libfdt b/libfdt/Makefile.libfdt
index f4f495b..6c42acf 100644
--- a/libfdt/Makefile.libfdt
+++ b/libfdt/Makefile.libfdt
@@ -3,5 +3,6 @@
 # This is not a complete Makefile of itself.  Instead, it is designed to
 # be easily embeddable into other systems of Makefiles.
 #
+LIBFDT_INCLUDES = fdt.h libfdt.h
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
-- 
1.5.6.3.439.g1e10
