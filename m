Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id DA682DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 08:23:36 +1100 (EST)
Message-Id: <20081119212334.535779903@goodmis.org>
References: <20081119212204.318400312@goodmis.org>
Date: Wed, 19 Nov 2008 16:22:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] powerpc/ppc32: ftrace, enabled dynamic ftrace
Cc: Andrew Morton <akpm@linux-foundation.org>, Milton Miller <miltonm@bga.com>,
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

Impact: Port 32 bit PowerPC dynamic ftrace

This patch adds the necessary hooks to get PPC32 dynamic ftrace working.
It does not handle modules. They are ignored by this patch.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/Kconfig    |    2 +-
 scripts/recordmcount.pl |    7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9675e95..d64b629 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -108,7 +108,7 @@ config ARCH_NO_VIRT_TO_BUS
 config PPC
 	bool
 	default y
-	select HAVE_FTRACE_MCOUNT_RECORD if PPC64
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 7acbe17..48609e9 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -178,7 +178,12 @@ if ($arch eq "x86_64") {
     $section_regex = "Disassembly of section\\s+(\\S+):";
     $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?.*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s\\.?_mcount\$";
-    $type = ".quad";
+    if ($bits == 64) {
+	$type = ".quad";
+    } else {
+	$type = ".long";
+    }
+
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
1.5.6.5

-- 
