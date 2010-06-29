Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 56544B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 17:08:29 +1000 (EST)
Date: Tue, 29 Jun 2010 17:08:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix feature-fixup tests for gcc 4.5
Message-Id: <20100629170829.8ff9a7a1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The feature-fixup test declare some extern void variables and then take
their addresses.  Fix this by declaring them as extern u8 instead.

Fixes these warnings (treated as errors):

  CC      arch/powerpc/lib/feature-fixups.o
cc1: warnings being treated as errors
arch/powerpc/lib/feature-fixups.c: In function 'test_cpu_macros':
arch/powerpc/lib/feature-fixups.c:293:23: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:294:9: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:297:2: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:297:2: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c: In function 'test_fw_macros':
arch/powerpc/lib/feature-fixups.c:306:23: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:307:9: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:310:2: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:310:2: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c: In function 'test_lwsync_macros':
arch/powerpc/lib/feature-fixups.c:321:23: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:322:9: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:326:3: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:326:3: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:329:3: error: taking address of expression of type 'void'
arch/powerpc/lib/feature-fixups.c:329:3: error: taking address of expression of type 'void'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/lib/feature-fixups.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

I haven't actually booted this, just built it.

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index e640175..0d08d01 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -12,6 +12,7 @@
  *  2 of the License, or (at your option) any later version.
  */
 
+#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
@@ -288,8 +289,8 @@ static void test_alternative_case_with_external_branch(void)
 
 static void test_cpu_macros(void)
 {
-	extern void ftr_fixup_test_FTR_macros;
-	extern void ftr_fixup_test_FTR_macros_expected;
+	extern u8 ftr_fixup_test_FTR_macros;
+	extern u8 ftr_fixup_test_FTR_macros_expected;
 	unsigned long size = &ftr_fixup_test_FTR_macros_expected -
 			     &ftr_fixup_test_FTR_macros;
 
@@ -301,8 +302,8 @@ static void test_cpu_macros(void)
 static void test_fw_macros(void)
 {
 #ifdef CONFIG_PPC64
-	extern void ftr_fixup_test_FW_FTR_macros;
-	extern void ftr_fixup_test_FW_FTR_macros_expected;
+	extern u8 ftr_fixup_test_FW_FTR_macros;
+	extern u8 ftr_fixup_test_FW_FTR_macros_expected;
 	unsigned long size = &ftr_fixup_test_FW_FTR_macros_expected -
 			     &ftr_fixup_test_FW_FTR_macros;
 
@@ -314,10 +315,10 @@ static void test_fw_macros(void)
 
 static void test_lwsync_macros(void)
 {
-	extern void lwsync_fixup_test;
-	extern void end_lwsync_fixup_test;
-	extern void lwsync_fixup_test_expected_LWSYNC;
-	extern void lwsync_fixup_test_expected_SYNC;
+	extern u8 lwsync_fixup_test;
+	extern u8 end_lwsync_fixup_test;
+	extern u8 lwsync_fixup_test_expected_LWSYNC;
+	extern u8 lwsync_fixup_test_expected_SYNC;
 	unsigned long size = &end_lwsync_fixup_test -
 			     &lwsync_fixup_test;
 
-- 
1.7.1



-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
