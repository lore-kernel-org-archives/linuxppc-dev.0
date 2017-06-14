Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wnWcY6jXJzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 13:01:33 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel] powerpc/debug: Add missing warn flag to WARN_ON's
 non-builtin path
Date: Wed, 14 Jun 2017 13:01:25 +1000
Message-Id: <20170614030125.45899-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When trapped on WARN_ON(), report_bug() is expected to return
BUG_TRAP_TYPE_WARN so the caller could increment NIP by 4 and continue.
The __builtin_constant_p() path of the PPC's WARN_ON() calls (indirectly)
__WARN_FLAGS() which has BUGFLAG_WARNING set, however the other branch
does not which makes report_bug() report a bug rather than a warning.

Fixes: 19d436268dde95389 ("debug: Add _ONCE() logic to report_bug()")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Actually 19d436268dde95389 replaced __WARN_TAINT() with __WARN_FLAGS()
and lost BUGFLAG_TAINT() and this is not in the commit log so it is
unclear:
1) why
2) whether this particular patch should be doing
   BUGFLAG_WARNING|BUGFLAG_TAINT(TAINT_WARN)
 or
   BUGFLAG_WARNING|(flags)

Any ideas? Thanks.


---
 arch/powerpc/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index f2c562a0a427..0151af6c2a50 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -104,7 +104,7 @@
 		"1:	"PPC_TLNEI"	%4,0\n"			\
 		_EMIT_BUG_ENTRY					\
 		: : "i" (__FILE__), "i" (__LINE__),		\
-		  "i" (BUGFLAG_TAINT(TAINT_WARN)),		\
+		  "i" (BUGFLAG_WARNING|BUGFLAG_TAINT(TAINT_WARN)),\
 		  "i" (sizeof(struct bug_entry)),		\
 		  "r" (__ret_warn_on));				\
 	}							\
-- 
2.11.0
