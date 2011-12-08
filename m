Return-Path: <matt@ozlabs.org>
Message-ID: <4EE05FC5.9000701@ozlabs.org>
Date: Thu, 08 Dec 2011 17:57:09 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PPC: Add __SANE_USERSPACE_TYPES__ to asm/types.h for LL64
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC64 uses long long for u64 in the kernel, but powerpc's asm/types.h
prevents 64-bit userland from seeing this definition, instead defaulting
to u64 == long in userspace.  Some user programs (e.g. kvmtool) may actually
want LL64, so this patch adds a check for __SANE_USERSPACE_TYPES__ so that,
if defined, int-ll64.h is included instead.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/include/asm/types.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index 8947b98..d82e94e 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -5,8 +5,11 @@
  * This is here because we used to use l64 for 64bit powerpc
  * and we don't want to impact user mode with our change to ll64
  * in the kernel.
+ *
+ * However, some user programs are fine with this.  They can
+ * flag __SANE_USERSPACE_TYPES__ to get int-ll64.h here.
  */
-#if defined(__powerpc64__) && !defined(__KERNEL__)
+#if !defined(__SANE_USERSPACE_TYPES__) && defined(__powerpc64__) && !defined(__KERNEL__)
 # include <asm-generic/int-l64.h>
 #else
 # include <asm-generic/int-ll64.h>
-- 
1.7.0.4
