Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD2E21A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:14:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>, amodra@gmail.com,
 ulrich.weigand@de.ibm.com, rostedt@goodmis.org
Subject: [PATCH 1/2] scripts/recordmcount.pl: support data in text section on
 powerpc
Date: Tue, 12 Jan 2016 23:14:22 +1100
Message-Id: <1452600863-6294-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ulrich Weigand <ulrich.weigand@de.ibm.com>

If a text section starts out with a data blob before the first
function start label, disassembly parsing doing in recordmcount.pl
gets confused on powerpc, leading to creation of corrupted module
objects.

This was not a problem so far since the compiler would never create
such text sections.  However, this has changed with a recent change
in GCC 6 to support distances of > 2GB between a function and its
assoicated TOC in the ELFv2 ABI, exposing this problem.

There is already code in recordmcount.pl to handle such data blobs
on the sparc64 platform.  This patch uses the same method to handle
those on powerpc as well.

Cc: stable@vger.kernel.org
Signed-off-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 scripts/recordmcount.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Steve can we get an ack for this one, to go via powerpc? cheers

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 826470d7f000..96e2486a6fc4 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -263,7 +263,8 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "powerpc") {
     $local_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\.?\\S+)";
-    $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?.*?)>:";
+    # See comment in the sparc64 section for why we use '\w'.
+    $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?\\w*?)>:";
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s\\.?_mcount\$";
 
     if ($bits == 64) {
-- 
2.5.0
