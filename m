Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymYhc5jmzzDrVZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 06:32:16 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASJUU44144413
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 14:32:14 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ehcpy3fr5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 14:32:13 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 28 Nov 2017 14:32:12 -0500
From: Breno Leitao <leitao@debian.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH] scripts: Add ppc64le support for checkstack.pl
Date: Tue, 28 Nov 2017 17:29:34 -0200
Message-Id: <1511897374-27408-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

64-bit ELF v2 ABI specification for POWER describes, on section "General
Stack Frame Requirements", that the stack should use the following
instructions when compiled with backchain:

  mflr r0
  std  r0, 16(r1)
  stdu r1, -XX(r1)

Where XX is the frame size for that function, and this is the value
checkstack.pl will find the stack size for each function.

This patch also simplifies the entire Powerpc section, since just two
type of instructions are used, 'stdu' for 64 bits and 'stwu' for 32 bits
platform.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 scripts/checkstack.pl | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 7f4c41717e26..8ed217ddf2c9 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -14,6 +14,7 @@
 #	M68k port by Geert Uytterhoeven and Andreas Schwab
 #	AArch64, PARISC ports by Kyle McMartin
 #	sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
+#	ppc64le port by Breno Leitao <leitao@debian.org>
 #
 #	Usage:
 #	objdump -d vmlinux | scripts/checkstack.pl [arch]
@@ -81,13 +82,9 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 		$re = qr/.*l\.addi.*r1,r1,-(([0-9]{2}|[3-9])[0-9]{2})/o;
 	} elsif ($arch eq 'parisc' || $arch eq 'parisc64') {
 		$re = qr/.*ldo ($x{1,8})\(sp\),sp/o;
-	} elsif ($arch eq 'ppc') {
-		#c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
-		$re = qr/.*stwu.*r1,-($x{1,8})\(r1\)/o;
-	} elsif ($arch eq 'ppc64') {
-		#XXX
-		$re = qr/.*stdu.*r1,-($x{1,8})\(r1\)/o;
-	} elsif ($arch eq 'powerpc') {
+	} elsif ($arch eq 'powerpc' || $arch =~ /^ppc(64)?(le)?$/ ) {
+		# powerpc    : 94 21 ff 30     stwu    r1,-208(r1)
+		# ppc64(le)  : 81 ff 21 f8     stdu    r1,-128(r1)
 		$re = qr/.*st[dw]u.*r1,-($x{1,8})\(r1\)/o;
 	} elsif ($arch =~ /^s390x?$/) {
 		#   11160:       a7 fb ff 60             aghi   %r15,-160
-- 
2.15.0
