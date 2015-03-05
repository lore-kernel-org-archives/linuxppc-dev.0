Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BC921A0330
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 12:28:53 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH v3 7/8] sparc: switch to using asm-generic for seccomp.h
Date: Wed,  4 Mar 2015 17:27:07 -0800
Message-Id: <1425518828-16017-8-git-send-email-keescook@chromium.org>
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>,
 James Hogan <james.hogan@imgtec.com>, Laura Abbott <lauraa@codeaurora.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Daniel Borkmann <dborkman@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. The obsolete sigreturn in COMPAT mode
is retained as an override. Remaining definitions are identical. Also
corrected missing #define for header reinclusion protection.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/include/asm/seccomp.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/seccomp.h b/arch/sparc/include/asm/seccomp.h
index adca1bce41d4..5ef8826d44f8 100644
--- a/arch/sparc/include/asm/seccomp.h
+++ b/arch/sparc/include/asm/seccomp.h
@@ -1,15 +1,10 @@
 #ifndef _ASM_SECCOMP_H
+#define _ASM_SECCOMP_H
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
 #define __NR_seccomp_sigreturn_32 __NR_sigreturn
 
+#include <asm-generic/seccomp.h>
+
 #endif /* _ASM_SECCOMP_H */
-- 
1.9.1
