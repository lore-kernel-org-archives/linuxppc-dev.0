Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 77971B6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 15:57:09 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6FA8DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 15:57:08 +1000 (EST)
Subject: [PATCH] powerpc: Check for unsupported relocs when using
	CONFIG_RELOCATABLE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Sep 2009 15:57:02 +1000
Message-Id: <1252994222.8375.201.camel@pasglop>
Mime-Version: 1.0
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tony Breeds <tony@bakeyournoodle.com>

When using CONFIG_RELOCATABLE, we build the kernel as a position
independent executable. The kernel then uses a little bit of relocation
code to relocate itself. That code only deals with R_PPC64_RELATIVE
relocations though. If for some reason you use assembly constructs
such as LOAD_REG_IMMEDIATE() to load the address of a symbol, you'll
generate different kinds of relocations that won't be processed properly
and bad things will happen. (We have 2 such bugs today).

The perl script tries to filter out "known" bad ones. It's possible
that we are missing some in the case of a weak function that nobody
implements, we'll see if we get false positive and fix it.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 952a396..0101e0c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -166,6 +166,17 @@ PHONY += $(BOOT_TARGETS)
 
 boot := arch/$(ARCH)/boot
 
+ifeq ($(CONFIG_RELOCATABLE),y)
+quiet_cmd_relocs_check = CALL    $<
+      cmd_relocs_check = perl $< "$(OBJDUMP)" "$(obj)/vmlinux"
+
+PHONY += relocs_check
+relocs_check: arch/powerpc/relocs_check.pl vmlinux
+	$(call cmd,relocs_check)
+
+zImage: relocs_check
+endif
+
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
diff --git a/arch/powerpc/relocs_check.pl b/arch/powerpc/relocs_check.pl
new file mode 100755
index 0000000..215e966
--- /dev/null
+++ b/arch/powerpc/relocs_check.pl
@@ -0,0 +1,57 @@
+#!/usr/bin/perl
+
+# Copyright © 2009 IBM Corporation
+
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+
+# This script checks the relcoations of a vmlinux for "suspicious"
+# relocations.
+
+use strict;
+use warnings;
+
+if ($#ARGV != 1) {
+	print "$#ARGV\n";
+	die "$0 [path to objdump] [path to vmlinux]\n";
+}
+
+# Have Kbuild supply the path to objdump so we handle cross compilation.
+my $objdump = shift;
+my $vmlinux = shift;
+my $bad_relocs_count = 0;
+my $bad_relocs = "";
+my $old_binutils = 0;
+
+open(FD, "$objdump -R $vmlinux|") or die;
+while (<FD>) {
+	study $_;
+
+	# Only look at relcoation lines.
+	next if (!/\s+R_/);
+
+	# These relocations are okay
+	next if (/R_PPC64_RELATIVE/ or /R_PPC64_NONE/ or
+	         /R_PPC64_ADDR64\s+mach_/);
+
+	# If we see this type of relcoation it's an idication that
+	# we /may/ be using an old version of binutils.
+	if (/R_PPC64_UADDR64/) {
+		$old_binutils++;
+	}
+
+	$bad_relocs_count++;
+	$bad_relocs .= $_;
+}
+
+if ($bad_relocs_count) {
+	print "WARNING: $bad_relocs_count bad relocations\n";
+	print $bad_relocs;
+}
+
+if ($old_binutils) {
+	print "WARNING: You need at binutils >= 2.19 to build a ".
+	      "CONFIG_RELCOATABLE kernel\n";
+}
