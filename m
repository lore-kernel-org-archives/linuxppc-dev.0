Return-Path: <radford@galvanix.net>
Received: from mail.blackbean.org (cpe-67-49-92-118.socal.res.rr.com
	[67.49.92.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1A1FDDDE3
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 09:13:23 +1100 (EST)
Date: Thu, 20 Nov 2008 14:04:06 -0800
From: Jim Radford <radford@galvanix.net>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] ftrace: mcountrecord.pl for arm
Message-ID: <20081120220406.GA2159@blackbean.org>
References: <20081120203415.251344054@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081120203415.251344054@goodmis.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Matt Fleming <mjf@gentoo.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo and Steven,

Here is a patch on top of Steven's for recordmcount.pl on arm.

-Jim

---
From: Jim Radford <radford@galvanix.com>
Subject: ftrace: mcountrecord.pl for arm

Signed-Off-By: Jim Radford <radford@galvanix.com>

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index c5c58ac..3d16795 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -135,6 +135,7 @@ my $section_regex;	# Find the start of a section
 my $function_regex;	# Find the name of a function
 			#    (return offset and func name)
 my $mcount_regex;	# Find the call site to mcount (return offset)
+my $section_type;	# Section header plus possible alignment command
 my $alignment;         # The .align value to use for $mcount_section
 
 if ($arch eq "x86") {
@@ -153,6 +154,7 @@ $nm_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
 $section_regex = "Disassembly of section\\s+(\\S+):";
 $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
 $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
+$section_type = '@progbits';
 $type = ".long";
 
 if ($arch eq "x86_64") {
@@ -191,6 +193,10 @@ if ($arch eq "x86_64") {
 	$type = ".quad";
     }
 
+} elsif ($arch eq "arm") {
+    $alignment = 2;
+    $section_type = '%progbits';
+
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
@@ -311,7 +317,7 @@ sub update_funcs
 	if (!$opened) {
 	    open(FILE, ">$mcount_s") || die "can't create $mcount_s\n";
 	    $opened = 1;
-	    print FILE "\t.section $mcount_section,\"a\",\@progbits\n";
+	    print FILE "\t.section $mcount_section,\"a\",$section_type\n";
 	    print FILE "\t.align $alignment\n" if (defined($alignment));
 	}
 	printf FILE "\t%s %s + %d\n", $type, $ref_func, $offsets[$i] - $offset;
