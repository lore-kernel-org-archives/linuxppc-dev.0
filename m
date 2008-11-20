Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id C9AB7DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 07:35:54 +1100 (EST)
Message-Id: <20081120203552.112676000@goodmis.org>
References: <20081120203415.251344054@goodmis.org>
Date: Thu, 20 Nov 2008 15:34:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ftrace: create default variables for archs in
	recordmcount.pl
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

Impact: cleanup of recordmcount.pl

Now that more architectures are being ported to the MCOUNT_RECORD
method, there is no reason to have each declare their own arch
specific variable if most of them share the same value. This patch
creates a set of default values for the arch specific variables
based off of i386.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 scripts/recordmcount.pl |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 7ec032e..c5c58ac 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -145,10 +145,17 @@ if ($arch eq "x86") {
     }
 }
 
+#
+# We base the defaults off of i386, the other archs may
+# feel free to change them in the below if statements.
+#
+$nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
+$section_regex = "Disassembly of section\\s+(\\S+):";
+$function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
+$mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
+$type = ".long";
+
 if ($arch eq "x86_64") {
-    $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
-    $section_regex = "Disassembly of section\\s+(\\S+):";
-    $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount([+-]0x[0-9a-zA-Z]+)?\$";
     $type = ".quad";
     $alignment = 8;
@@ -160,11 +167,6 @@ if ($arch eq "x86_64") {
     $cc .= " -m64";
 
 } elsif ($arch eq "i386") {
-    $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
-    $section_regex = "Disassembly of section\\s+(\\S+):";
-    $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
-    $type = ".long";
     $alignment = 4;
 
     # force flags for this arch
@@ -174,11 +176,6 @@ if ($arch eq "x86_64") {
     $cc .= " -m32";
 
 } elsif ($arch eq "sh") {
-    $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
-    $section_regex = "Disassembly of section\\s+(\\S+):";
-    $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
-    $type = ".long";
 
     # force flags for this arch
     $ld .= " -m shlelf_linux";
@@ -187,13 +184,11 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "powerpc") {
     $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\.?\\S+)";
-    $section_regex = "Disassembly of section\\s+(\\S+):";
     $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s\\.?_mcount\$";
+
     if ($bits == 64) {
 	$type = ".quad";
-    } else {
-	$type = ".long";
     }
 
 } else {
-- 
1.5.6.5

-- 
