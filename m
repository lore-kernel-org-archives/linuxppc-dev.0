Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 3DDFADDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 08:23:35 +1100 (EST)
Message-Id: <20081119212333.052756846@goodmis.org>
References: <20081119212204.318400312@goodmis.org>
Date: Wed, 19 Nov 2008 16:22:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] ftrace: align __mcount_loc sections
Cc: Andrew Morton <akpm@linux-foundation.org>, Milton Miller <miltonm@bga.com>,
	Matt Fleming <matthew.fleming@imgtec.com>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: add alignment option for recordmcount.pl script

Align the __mcount_loc sections so that architectures with strict
alignment requirements need not worry about performing unaligned
accesses.

This fixes an issue where I was seeing unaligned accesses, which are not
supported on our architecture (the results of an unaligned access are
undefined).

Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 scripts/recordmcount.pl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 6b9fe3e..eeac71c 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -134,6 +134,7 @@ my $section_regex;	# Find the start of a section
 my $function_regex;	# Find the name of a function
 			#    (return offset and func name)
 my $mcount_regex;	# Find the call site to mcount (return offset)
+my $alignment;         # The .align value to use for $mcount_section
 
 if ($arch eq "x86") {
     if ($bits == 64) {
@@ -148,6 +149,7 @@ if ($arch eq "x86_64") {
     $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount([+-]0x[0-9a-zA-Z]+)?\$";
     $type = ".quad";
+    $alignment = 8;
 
     # force flags for this arch
     $ld .= " -m elf_x86_64";
@@ -160,6 +162,7 @@ if ($arch eq "x86_64") {
     $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
     $type = ".long";
+    $alignment = 4;
 
     # force flags for this arch
     $ld .= " -m elf_i386";
@@ -288,6 +291,7 @@ sub update_funcs
 	    open(FILE, ">$mcount_s") || die "can't create $mcount_s\n";
 	    $opened = 1;
 	    print FILE "\t.section $mcount_section,\"a\",\@progbits\n";
+	    print FILE "\t.align $alignment\n";
 	}
 	printf FILE "\t%s %s + %d\n", $type, $ref_func, $offsets[$i] - $offset;
     }
-- 
1.5.6.5

-- 
