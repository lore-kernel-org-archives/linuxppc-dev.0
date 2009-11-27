Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 006CA100979
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:43 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 3/8] stack-ppc: Adjust for ppc32
Message-ID: <20091127223342.GC21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Get rid of magic numbers, use appropriate defines from ptrace.h.

>From now on stack-ppc.c should be suitable for ppc32.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/stack-ppc.c |    4 ++--
 runtime/stack.c     |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/runtime/stack-ppc.c b/runtime/stack-ppc.c
index 3267194..df2db15 100644
--- a/runtime/stack-ppc.c
+++ b/runtime/stack-ppc.c
@@ -21,7 +21,7 @@ static void __stp_stack_print (struct pt_regs *regs, int verbose, int levels,
 			return;
 		_sp = (unsigned long *) sp;
 		newsp = _sp[0];
-		ip = _sp[2];
+		ip = _sp[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
 			if (verbose) {
 				_stp_printf("[0x%016lx] [0x%016lx] ", sp, ip);
@@ -38,7 +38,7 @@ static void __stp_stack_print (struct pt_regs *regs, int verbose, int levels,
 		 * See if this is an exception frame.
 		 * We look for the "regshere" marker in the current frame.
 		 */
-		if ( _sp[12] == 0x7265677368657265ul) {
+		if (_sp[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
 			if (verbose) {
diff --git a/runtime/stack.c b/runtime/stack.c
index ae89995..25dbdbb 100644
--- a/runtime/stack.c
+++ b/runtime/stack.c
@@ -40,7 +40,7 @@ static void _stp_stack_print_fallback(unsigned long, int, int);
 #include "stack-ia64.c"
 #elif  defined (__i386__)
 #include "stack-i386.c"
-#elif defined (__powerpc64__)
+#elif defined (__powerpc__)
 #include "stack-ppc.c"
 #elif defined (__arm__)
 #include "stack-arm.c"
-- 
1.6.3.3
