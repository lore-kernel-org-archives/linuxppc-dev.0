Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 14:42:54 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/4] powerpc: Require gcc 4.0 on 64-bit
Message-ID: <20120418144254.3286ce94@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Older versions of gcc had issues with using -maltivec together with
-mcpu of a non altivec capable CPU. We work around it by specifying
-mcpu=970, but the logic is complicated.

In preparation for adding more -mcpu targets, remove the workaround
and just require gcc 4.0 for 64-bit builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

4.0 came out in 2005 and the gcc on RHEL5 and SLES10 looks to be 4.1.
I highly doubt a ppc64 kernel will build these days on either RHEL4 or
SLES9.

Anything else we have to worry about?

Index: linux-build/arch/powerpc/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/Makefile	2012-04-18 11:59:31.444220933 +1000
+++ linux-build/arch/powerpc/Makefile	2012-04-18 11:59:58.860721391 +1000
@@ -234,10 +234,11 @@ archprepare: checkbin
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check
-# Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
-# instructions.
-# gcc-3.4 and binutils-2.14 are a fatal combination.
 
+# Check gcc and binutils versions:
+# - gcc-3.4 and binutils-2.14 are a fatal combination
+# - Require gcc 4.0 or above on 64-bit
+# - gcc-4.2.0 has issues compiling modules on 64-bit
 checkbin:
 	@if test "$(call cc-version)" = "0304" ; then \
 		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
@@ -247,6 +248,12 @@ checkbin:
 			false; \
 		fi ; \
 	fi
+	@if test "$(call cc-version)" -lt "0400" \
+	    && test "x${CONFIG_PPC64}" = "xy" ; then \
+                echo -n "Sorry, GCC v4.0 or above is required to build " ; \
+                echo "the 64-bit powerpc kernel." ; \
+                false ; \
+        fi
 	@if test "$(call cc-fullversion)" = "040200" \
 	    && test "x${CONFIG_MODULES}${CONFIG_PPC64}" = "xyy" ; then \
 		echo -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \
