Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CEE71A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 22:27:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Don't do gcc version checks if we're building with
 clang
Date: Tue, 21 Apr 2015 22:26:57 +1000
Message-Id: <1429619217-15870-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.mj@au1.ibm.com, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have several checks for bad gcc versions in our Makefile. These don't
apply if we're building with clang, so skip them in that case.

The obvious check would be for ${COMPILER} = "gcc", but because of the
way the logic in the top level Makefile conditionally sets COMPILER,
it's possible that we're building with gcc but COMPILER was not set.

So instead check for ${COMPILER} != "clang", which we know is currently
the only other possibility.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 07a480861f78..3609504b0ad2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -314,7 +314,8 @@ TOUT	:= .tmp_gas_check
 # - Require gcc 4.0 or above on 64-bit
 # - gcc-4.2.0 has issues compiling modules on 64-bit
 checkbin:
-	@if test "$(cc-version)" = "0304" ; then \
+	@if test "${COMPILER}" != "clang" \
+	    && test "$(cc-version)" = "0304" ; then \
 		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
 			echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '; \
 			echo 'correctly with gcc-3.4 and your version of binutils.'; \
@@ -322,13 +323,15 @@ checkbin:
 			false; \
 		fi ; \
 	fi
-	@if test "$(cc-version)" -lt "0400" \
+	@if test "${COMPILER}" != "clang" \
+	    && test "$(cc-version)" -lt "0400" \
 	    && test "x${CONFIG_PPC64}" = "xy" ; then \
                 echo -n "Sorry, GCC v4.0 or above is required to build " ; \
                 echo "the 64-bit powerpc kernel." ; \
                 false ; \
         fi
-	@if test "$(cc-fullversion)" = "040200" \
+	@if test "${COMPILER}" != "clang" \
+	    && test "$(cc-fullversion)" = "040200" \
 	    && test "x${CONFIG_MODULES}${CONFIG_PPC64}" = "xyy" ; then \
 		echo -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \
 		echo 'kernel with modules enabled.' ; \
-- 
2.1.0
