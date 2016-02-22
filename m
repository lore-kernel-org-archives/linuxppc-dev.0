Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E8331A06C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 16:14:10 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 22 Feb 2016 15:14:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A84402CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 16:14:06 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1M5DwTW000258
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 16:14:06 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1M5DXI9004211
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 16:13:34 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: michaele@au1.ibm.com
Subject: [PATCH 1/1] powerpc: Detect broken or mismatched toolchains
Date: Mon, 22 Feb 2016 16:13:08 +1100
Message-Id: <5c8ce41d4341aa5c0698abbc0284359a789d2334.1456117980.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It can currently be difficult to diagnose a build that fails due to
the compiler, linker or other parts of the toolchain being unable to
build binaries of the type required by the kernel config. For example
using a little endian toolchain to build a big endian kernel may
produce:

as: unrecognized option '-maltivec'

This patch adds a basic compile test and error message to
arch/powerpc/Makefile so that the above error becomes:

*** Sorry, your toolchain seems to be broken or incorrect. ***
Make sure it supports your kernel configuration (ppc64).

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

 arch/powerpc/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 96efd82..0041cd2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -355,6 +355,13 @@ TOUT	:= .tmp_gas_check
 # - Require gcc 4.0 or above on 64-bit
 # - gcc-4.2.0 has issues compiling modules on 64-bit
 checkbin:
+	@if test "$(call try-run,echo 'int _start(void) { return 0; }' > \"$$TMP\"; \
+	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -x c -nostdlib \"$$TMP\" \
+	-o /dev/null,ok,broken)" = "broken" ; then \
+		echo "*** Sorry, your toolchain seems to be broken or incorrect. ***" ; \
+		echo "Make sure it supports your kernel configuration ($(UTS_MACHINE))." ; \
+		false; \
+	fi
 	@if test "$(cc-name)" != "clang" \
 	    && test "$(cc-version)" = "0304" ; then \
 		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
-- 
2.1.0
