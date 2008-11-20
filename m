Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 2CF78DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 07:35:53 +1100 (EST)
Message-Id: <20081120203551.633484431@goodmis.org>
References: <20081120203415.251344054@goodmis.org>
Date: Thu, 20 Nov 2008 15:34:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sh: dynamic ftrace support.
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

From: Matt Fleming <mjf@gentoo.org>

First cut at dynamic ftrace support.

[
  Steven Rostedt - only updated the recordmcount.pl file.
    There are updates for PowerPC that will conflict with this,
    and we need to base off of these changes.
]

Signed-off-by: Matt Fleming <mjf@gentoo.org>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 scripts/recordmcount.pl |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index eeac71c..9f75438 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -170,6 +170,17 @@ if ($arch eq "x86_64") {
     $objcopy .= " -O elf32-i386";
     $cc .= " -m32";
 
+} elsif ($arch eq "sh") {
+    $section_regex = "Disassembly of section\\s+(\\S+):";
+    $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
+    $type = ".long";
+
+    # force flags for this arch
+    $ld .= " -m shlelf_linux";
+    $objcopy .= " -O elf32-sh-linux";
+    $cc .= " -m32";
+
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
1.5.6.5

-- 
