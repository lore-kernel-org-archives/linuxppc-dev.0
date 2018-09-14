Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BNpp6sCgzF3VD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 15:09:06 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id s13-v6so3714592pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:09:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: remove old GCC version checks
Date: Fri, 14 Sep 2018 15:08:52 +1000
Message-Id: <20180914050854.6214-2-npiggin@gmail.com>
In-Reply-To: <20180914050854.6214-1-npiggin@gmail.com>
References: <20180914050854.6214-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GCC 4.6 is the minimum supported now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acba164a..2ecd0976914a 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -404,36 +404,9 @@ archprepare: checkbin
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check
 
-# Check gcc and binutils versions:
-# - gcc-3.4 and binutils-2.14 are a fatal combination
-# - Require gcc 4.0 or above on 64-bit
-# - gcc-4.2.0 has issues compiling modules on 64-bit
+# Check toolchain versions:
+# - gcc-4.6 is the minimum kernel-wide version so nothing required.
 checkbin:
-	@if test "$(cc-name)" != "clang" \
-	    && test "$(cc-version)" = "0304" ; then \
-		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
-			echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '; \
-			echo 'correctly with gcc-3.4 and your version of binutils.'; \
-			echo '*** Please upgrade your binutils or downgrade your gcc'; \
-			false; \
-		fi ; \
-	fi
-	@if test "$(cc-name)" != "clang" \
-	    && test "$(cc-version)" -lt "0400" \
-	    && test "x${CONFIG_PPC64}" = "xy" ; then \
-                echo -n "Sorry, GCC v4.0 or above is required to build " ; \
-                echo "the 64-bit powerpc kernel." ; \
-                false ; \
-        fi
-	@if test "$(cc-name)" != "clang" \
-	    && test "$(cc-fullversion)" = "040200" \
-	    && test "x${CONFIG_MODULES}${CONFIG_PPC64}" = "xyy" ; then \
-		echo -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \
-		echo 'kernel with modules enabled.' ; \
-		echo -n '*** Please use a different GCC version or ' ; \
-		echo 'disable kernel modules' ; \
-		false ; \
-	fi
 	@if test "x${CONFIG_CPU_LITTLE_ENDIAN}" = "xy" \
 	    && $(LD) --version | head -1 | grep ' 2\.24$$' >/dev/null ; then \
 		echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
-- 
2.18.0
