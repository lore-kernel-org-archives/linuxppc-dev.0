Return-Path: <dgibson@ozlabs.org>
Date: Tue, 24 Jul 2007 15:14:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Improve the make install target
Message-ID: <20070724051452.GA28851@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes various improvements to dtc's make install target:
	- libfdt is also installed.  Specifically, libfdt.a and the
two export relevant header files, fdt.h and libfdt.h are installed.
	- ftdump is no longer installed.  It was only ever a
development debugging tool and may well go away at some point.
	- In keeping with normal conventions, there is now a PREFIX
variable, allowing control of where things are installed (in /usr,
/usr/local, /opt, etc.).
	- By default, installed into the user's home directory,
instead of /usr.  This is friendlier for self-installers, package
builders can easily override PREFIX to restore the old behaviour.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-07-23 16:21:46.000000000 +1000
+++ dtc/Makefile	2007-07-24 15:11:30.000000000 +1000
@@ -52,7 +52,10 @@ BISON = bison
 
 INSTALL = /usr/bin/install
 DESTDIR =
-BINDIR = /usr/bin
+PREFIX = $(HOME)
+BINDIR = $(PREFIX)/bin
+LIBDIR = $(PREFIX)/lib
+INCLUDEDIR = $(PREFIX)/include
 
 #
 # Overall rules
@@ -140,10 +143,14 @@ clean: libfdt_clean tests_clean
 	rm -f *.tab.[ch] lex.yy.c *.output vgcore.*
 	rm -f $(BIN)
 
-install: dtc ftdump
+install: all
+	@$(VECHO) INSTALL
 	$(INSTALL) -d $(DESTDIR)$(BINDIR)
 	$(INSTALL) -m 755 dtc $(DESTDIR)$(BINDIR)
-	$(INSTALL) -m 755 ftdump $(DESTDIR)$(BINDIR)
+	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
+	$(INSTALL) -m 644 $(LIBFDT_LIB) $(DESTDIR)$(LIBDIR)
+	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
+	$(INSTALL) -m 644 $(LIBFDT_INCLUDES) $(DESTDIR)$(INCLUDEDIR)
 
 define filechk
 	set -e;					\
Index: dtc/libfdt/Makefile.libfdt
===================================================================
--- dtc.orig/libfdt/Makefile.libfdt	2007-07-24 15:08:36.000000000 +1000
+++ dtc/libfdt/Makefile.libfdt	2007-07-24 15:10:20.000000000 +1000
@@ -3,13 +3,15 @@
 # This is not a complete Makefile of itself.  Instead, it is designed to
 # be easily embeddable into other systems of Makefiles.
 #
-
 LIBFDT_OBJS_L = fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o
 LIBFDT_OBJS = $(LIBFDT_OBJS_L:%=$(LIBFDT_PREFIX)%)
 
 LIBFDT_LIB_L = libfdt.a
 LIBFDT_LIB = $(LIBFDT_LIB_L:%=$(LIBFDT_PREFIX)%)
 
+LIBFDT_INCLUDES_L = fdt.h libfdt.h
+LIBFDT_INCLUDES = $(LIBFDT_INCLUDES_L:%=$(LIBFDT_PREFIX)%)
+
 LIBFDT_CLEANFILES_L = *~ *.o *.d *.a $(LIBFDT_LIB) \
 	*.i *.s a.out core
 LIBFDT_CLEANFILES = $(LIBFDT_CLEANFILES_L:%=$(LIBFDT_PREFIX)%)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
