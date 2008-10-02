Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep23-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 3D5F1DE38C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 06:06:43 +1000 (EST)
Received: from ng.localnet ([77.56.223.114]) by viefep23-int.chello.at
	(InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
	id <20081002200641.ZBDZ29348.viefep23-int.chello.at@ng.localnet>
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Oct 2008 22:06:41 +0200
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Install & document convert-dtsv0
Date: Thu, 2 Oct 2008 22:06:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810022206.36010.niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Patch against http://www.jdl.com/software/dtc.git
Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
---
 Documentation/manual.txt |   20 ++++++++++++++++++++
 Makefile                 |    1 +
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/manual.txt b/Documentation/manual.txt
index b957662..0674384 100644
--- a/Documentation/manual.txt
+++ b/Documentation/manual.txt
@@ -19,6 +19,8 @@ II - The DT block format
 
 III - libfdt
 
+IV - Conversion to Version 1
+
 
 I - "dtc", the device tree compiler
 ===================================
@@ -613,6 +615,24 @@ strings block.
 
 
 III - libfdt
+============
 
 This library should be merged into dtc proper.
 This library should likely be worked into U-Boot and the kernel.
+
+IV - Conversion to Version 1
+============================
+
+convert-dtsv0 is a small utility program which converts (DTS)
+Device Tree Source from the obsolete version 0 to version 1.
+
+Version 1 DTS files are marked by line "/dts-v1/;" at the top of the file.
+
+The syntax of the convert-dtsv0 command line is:
+
+convert-dtsv0 [<input_filename ... >]
+
+Each file passed will be converted to the new /dts-v1/ version by creating
+a new file with a "v1" appended the filename.
+
+Comments, empty lines, etc. are preserved.
diff --git a/Makefile b/Makefile
index 5ad0189..558e10c 100644
--- a/Makefile
+++ b/Makefile
@@ -52,6 +52,7 @@ install: all
 	@$(VECHO) INSTALL
 	$(INSTALL) -d $(DESTDIR)$(BINDIR)
 	$(INSTALL) -m 755 dtc $(DESTDIR)$(BINDIR)
+	$(INSTALL) -m 755 convert-dtsv0 $(DESTDIR)$(BINDIR)
 	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -m 644 $(LIBFDT_lib) $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
-- 
1.6.0.1
