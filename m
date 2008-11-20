Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 23AE0DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 07:35:53 +1100 (EST)
Message-Id: <20081120203551.873831232@goodmis.org>
References: <20081120203415.251344054@goodmis.org>
Date: Thu, 20 Nov 2008 15:34:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ftrace: add support for powerpc to recordmcount.pl script
Cc: Matt Fleming <mjf@gentoo.org>, Jim Radford <radford@galvanix.net>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

Impact: Add PowerPC port to recordmcount.pl script

This patch updates the recordmcount.pl script to process
PowerPC.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 scripts/recordmcount.pl |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 9f75438..7ec032e 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -130,6 +130,7 @@ my %weak;		# List of weak functions
 my %convert;		# List of local functions used that needs conversion
 
 my $type;
+my $nm_regex;		# Find the local functions (return function)
 my $section_regex;	# Find the start of a section
 my $function_regex;	# Find the name of a function
 			#    (return offset and func name)
@@ -145,6 +146,7 @@ if ($arch eq "x86") {
 }
 
 if ($arch eq "x86_64") {
+    $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
     $section_regex = "Disassembly of section\\s+(\\S+):";
     $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount([+-]0x[0-9a-zA-Z]+)?\$";
@@ -158,6 +160,7 @@ if ($arch eq "x86_64") {
     $cc .= " -m64";
 
 } elsif ($arch eq "i386") {
+    $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
     $section_regex = "Disassembly of section\\s+(\\S+):";
     $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
@@ -171,6 +174,7 @@ if ($arch eq "x86_64") {
     $cc .= " -m32";
 
 } elsif ($arch eq "sh") {
+    $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
     $section_regex = "Disassembly of section\\s+(\\S+):";
     $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
@@ -181,6 +185,17 @@ if ($arch eq "x86_64") {
     $objcopy .= " -O elf32-sh-linux";
     $cc .= " -m32";
 
+} elsif ($arch eq "powerpc") {
+    $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\.?\\S+)";
+    $section_regex = "Disassembly of section\\s+(\\S+):";
+    $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?.*?)>:";
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s\\.?_mcount\$";
+    if ($bits == 64) {
+	$type = ".quad";
+    } else {
+	$type = ".long";
+    }
+
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
@@ -250,7 +265,7 @@ if (!$found_version) {
 #
 open (IN, "$nm $inputfile|") || die "error running $nm";
 while (<IN>) {
-    if (/^[0-9a-fA-F]+\s+t\s+(\S+)/) {
+    if (/$nm_regex/) {
 	$locals{$1} = 1;
     } elsif (/^[0-9a-fA-F]+\s+([wW])\s+(\S+)/) {
 	$weak{$2} = $1;
@@ -302,7 +317,7 @@ sub update_funcs
 	    open(FILE, ">$mcount_s") || die "can't create $mcount_s\n";
 	    $opened = 1;
 	    print FILE "\t.section $mcount_section,\"a\",\@progbits\n";
-	    print FILE "\t.align $alignment\n";
+	    print FILE "\t.align $alignment\n" if (defined($alignment));
 	}
 	printf FILE "\t%s %s + %d\n", $type, $ref_func, $offsets[$i] - $offset;
     }
-- 
1.5.6.5

-- 
