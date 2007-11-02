Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4785EDDEEF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 02:36:49 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lA2FadHA011607
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 08:36:45 -0700 (MST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: jdl@Freescale.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] dtc: Fix the install target
Date: Fri,  2 Nov 2007 10:26:15 -0500
Message-Id: <1194017175-25610-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

/usr/bin/install: cannot stat `fdt.h': No such file or directory
/usr/bin/install: cannot stat `libfdt.h': No such file or directory

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 Makefile |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 84f0efe..d59554a 100644
--- a/Makefile
+++ b/Makefile
@@ -56,7 +56,7 @@ install: all
 	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -m 644 $(LIBFDT_LIB) $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
-	$(INSTALL) -m 644 $(LIBFDT_INCLUDES) $(DESTDIR)$(INCLUDEDIR)
+	$(INSTALL) -m 644 $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_INCLUDES)) $(DESTDIR)$(INCLUDEDIR)
 
 #
 # Rules for versioning
@@ -136,17 +136,17 @@ endif
 #
 LIBFDT_objdir = libfdt
 LIBFDT_srcdir = libfdt
-include libfdt/Makefile.libfdt
+include $(LIBFDT_srcdir)/Makefile.libfdt
 
 .PHONY: libfdt
 libfdt: $(LIBFDT_LIB)
 
-$(LIBFDT_LIB): $(addprefix libfdt/,$(LIBFDT_OBJS))
+$(LIBFDT_LIB): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
 
 libfdt_clean:
 	@$(VECHO) CLEAN "(libfdt)"
-	rm -f $(addprefix libfdt/,$(STD_CLEANFILES))
-	rm -f $(addprefix libfdt/,$(LIBFDT_CLEANFILES))
+	rm -f $(addprefix $(LIBFDT_objdir)/,$(STD_CLEANFILES))
+	rm -f $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_CLEANFILES))
 
 ifneq ($(DEPTARGETS),)
 -include $(LIBFDT_OBJS:%.o=$(LIBFDT_objdir)/%.d)
-- 
1.5.3.GIT
