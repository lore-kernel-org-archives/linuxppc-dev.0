From: Allen Curtis <acurtis@onz.com>
Reply-To: acurtis@onz.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Cross compile helper patch
Date: Tue, 27 Aug 2002 17:02:54 -0700
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_UG1JFDQF6PH6UU7MA6SG"
Message-Id: <200208271702.54458.acurtis@onz.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_UG1JFDQF6PH6UU7MA6SG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I am not sure where to send these so here it goes.

--
All things come to those who wait. Some of us just have to wait a little
longer...
--------------Boundary-00=_UG1JFDQF6PH6UU7MA6SG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cross.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cross.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1114  -> 1.1115
#	            Makefile	1.164   -> 1.165
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/26	acurtis@ws01.onz.com	1.1115
# Make update for cross development.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Aug 27 16:21:45 2002
+++ b/Makefile	Tue Aug 27 16:21:45 2002
@@ -5,7 +5,12 @@

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

-ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+ARCH := $(shell if [ -f Make.arch ]; then \
+			cat Make.arch; \
+		else \
+			uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/; \
+		fi)
+
 KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")

 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
@@ -19,7 +24,9 @@
 HOSTCC  	= gcc
 HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer

-CROSS_COMPILE 	=
+CROSS_COMPILE 	= $(shell if [ -f Make.crosscompiler ]; then \
+			          cat Make.crosscompiler; \
+			  fi)

 #
 # Include the make variables (CC, etc...)

--------------Boundary-00=_UG1JFDQF6PH6UU7MA6SG--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
