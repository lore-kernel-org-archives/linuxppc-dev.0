Return-Path: <max@stro.at>
Received: from vostochny.stro.at (vostochny.stro.at [78.47.22.85])
	by ozlabs.org (Postfix) with ESMTP id D68D3B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 23:47:46 +1000 (EST)
From: maximilian attems <max@stro.at>
To: klibc@zytor.com
Subject: [PATCH] [klibc] ppc64: Fix build failure with stricter as
Date: Wed, 18 May 2011 15:41:20 +0200
Message-Id: <1305726080-27589-1-git-send-email-max@stro.at>
Cc: Matthias Klose <doko@ubuntu.com>, linuxppc-dev@lists.ozlabs.org,
	maximilian attems <max@stro.at>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Matthias Klose <doko@ubuntu.com>

Landed in Ubuntu klibc version 1.5.20-1ubuntu3.


Signed-off-by: maximilian attems <max@stro.at>
---
 usr/klibc/arch/ppc64/crt0.S |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/usr/klibc/arch/ppc64/crt0.S b/usr/klibc/arch/ppc64/crt0.S
index a7776a1..c976d5c 100644
--- a/usr/klibc/arch/ppc64/crt0.S
+++ b/usr/klibc/arch/ppc64/crt0.S
@@ -12,16 +12,17 @@
 	.section ".toc","aw"
 .LC0:	.tc	environ[TC],environ
 
+	.text
+	.align 4
+
 	.section ".opd","aw"
-	.align 3
-	.globl _start
 _start:
-	.quad	._start
-	.quad	.TOC.@tocbase, 0
-
-	.text
-	.globl	._start
+	.quad	._start, .TOC.@tocbase, 0
+	.previous
+	.size	_start, 24
 	.type	._start,@function
+	.globl	_start
+	.globl	._start
 ._start:
 	stdu    %r1,-32(%r1)
 	addi    %r3,%r1,32
@@ -29,4 +30,4 @@ _start:
 	b 	.__libc_init
 	nop
 
-	.size _start,.-_start
+	.size ._start,.-._start
-- 
1.7.4.4
