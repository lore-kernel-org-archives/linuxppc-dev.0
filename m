Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4185548NzDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 14:59:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: <linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
 kernel-hardening@lists.openwall.com, Anton Blanchard <anton@samba.org>,
 <amodra@gmail.com>, Nick Piggin <npiggin@gmail.com>
Subject: [PATCH] lkdtm: Mark lkdtm_rodata_do_nothing() notrace
Date: Wed,  3 Aug 2016 14:59:31 +1000
Message-Id: <1470200371-31565-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lkdtm_rodata_do_nothing() is an empty function which is generated in
order to test the non-executability of rodata.

Currently if function tracing is enabled then an mcount callsite will be
generated for lkdtm_rodata_do_nothing(), and it will appear in the list
of available functions for function tracing (available_filter_functions).

Given it's purpose purely as a test function, it seems preferable for
lkdtm_rodata_do_nothing() to be marked notrace, so it doesn't appear as
traceable.

This also avoids triggering a linker bug on powerpc:

  https://sourceware.org/bugzilla/show_bug.cgi?id=20428

When the linker sees code that needs to generate a call stub, eg. a
branch to mcount(), it assumes the section is executable and
dereferences a NULL pointer leading to a linker segfault. Marking
lkdtm_rodata_do_nothing() notrace avoids triggering the bug because the
function contains no other function calls.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/misc/lkdtm_rodata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm_rodata.c b/drivers/misc/lkdtm_rodata.c
index 166b1db3969f..3564477b8c2d 100644
--- a/drivers/misc/lkdtm_rodata.c
+++ b/drivers/misc/lkdtm_rodata.c
@@ -4,7 +4,7 @@
  */
 #include "lkdtm.h"
 
-void lkdtm_rodata_do_nothing(void)
+void notrace lkdtm_rodata_do_nothing(void)
 {
 	/* Does nothing. We just want an architecture agnostic "return". */
 }
-- 
2.7.4
