Return-Path: <yamada.masahiro@socionext.com>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zFxQ01pdzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 12:21:13 +1000 (AEST)
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove pre-build checks for old GCC versions
Date: Mon, 27 Aug 2018 11:20:02 +0900
Message-Id: <1535336402-10632-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

The GCC version checks in arch/powerpc/Makefile are obsolete now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/Makefile | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acb..57e7358 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -400,40 +400,8 @@ archclean:
 
 archprepare: checkbin
 
-# Use the file '.tmp_gas_check' for binutils tests, as gas won't output
-# to stdout and these checks are run even on install targets.
-TOUT	:= .tmp_gas_check
-
-# Check gcc and binutils versions:
-# - gcc-3.4 and binutils-2.14 are a fatal combination
-# - Require gcc 4.0 or above on 64-bit
-# - gcc-4.2.0 has issues compiling modules on 64-bit
+# Check binutils versions:
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
@@ -441,7 +409,3 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
-
-
-CLEAN_FILES += $(TOUT)
-
-- 
2.7.4
