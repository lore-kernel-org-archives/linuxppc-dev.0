Return-Path: <paulus@ozlabs.org>
Date: Wed, 26 Feb 2014 17:07:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Increase stack redzone for 64-bit userspace to 512
 bytes
Message-ID: <20140226060738.GF28143@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new ELFv2 little-endian ABI increases the stack redzone -- the
area below the stack pointer that can be used for storing data --
from 288 bytes to 512 bytes.  This means that we need to allow more
space on the user stack when delivering a signal to a 64-bit process.

To make the code a bit clearer, we define new USER_REDZONE_SIZE and
KERNEL_REDZONE_SIZE symbols in ptrace.h.  For now, we leave the
kernel redzone size at 288 bytes, since increasing it to 512 bytes
would increase the size of interrupt stack frames correspondingly.
Gcc currently only makes use of 288 bytes of redzone, even when
compiling for little-endian.  In future, hopefully gcc will provide
an option to control the amount of redzone used, and then we could
reduce it even more.

This also changes the code in arch_compat_alloc_user_space() to
preserve the expanded redzone.  It is not clear why this function would
ever be used on a 64-bit process, though.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/compat.h |  5 +++--
 arch/powerpc/include/asm/ptrace.h | 16 +++++++++++++++-
 arch/powerpc/kernel/signal_64.c   |  4 ++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 84fdf68..a613d2c 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -200,10 +200,11 @@ static inline void __user *arch_compat_alloc_user_space(long len)
 
 	/*
 	 * We can't access below the stack pointer in the 32bit ABI and
-	 * can access 288 bytes in the 64bit ABI
+	 * can access 288 bytes in the 64bit big-endian ABI,
+	 * or 512 bytes with the new ELFv2 little-endian ABI.
 	 */
 	if (!is_32bit_task())
-		usp -= 288;
+		usp -= USER_REDZONE_SIZE;
 
 	return (void __user *) (usp - len);
 }
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index becc08e..279b80f 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -28,11 +28,23 @@
 
 #ifdef __powerpc64__
 
+/*
+ * Size of redzone that userspace is allowed to use below the stack
+ * pointer.  This is 288 in the 64-bit big-endian ELF ABI, and 512 in
+ * the new ELFv2 little-endian ABI, so we allow the larger amount.
+ *
+ * For kernel code we allow a 288-byte redzone, in order to conserve
+ * kernel stack space; gcc currently only uses 288 bytes, and will
+ * hopefully allow explicit control of the redzone size in future.
+ */
+#define USER_REDZONE_SIZE	512
+#define KERNEL_REDZONE_SIZE	288
+
 #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
 #define STACK_FRAME_LR_SAVE	2	/* Location of LR in stack frame */
 #define STACK_FRAME_REGS_MARKER	ASM_CONST(0x7265677368657265)
 #define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + \
-					STACK_FRAME_OVERHEAD + 288)
+				 STACK_FRAME_OVERHEAD + KERNEL_REDZONE_SIZE)
 #define STACK_FRAME_MARKER	12
 
 /* Size of dummy stack frame allocated when calling signal handler. */
@@ -41,6 +53,8 @@
 
 #else /* __powerpc64__ */
 
+#define USER_REDZONE_SIZE	0
+#define KERNEL_REDZONE_SIZE	0
 #define STACK_FRAME_OVERHEAD	16	/* size of minimum stack frame */
 #define STACK_FRAME_LR_SAVE	1	/* Location of LR in stack frame */
 #define STACK_FRAME_REGS_MARKER	ASM_CONST(0x72656773)
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index e35bf77..8d253c2 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -65,8 +65,8 @@ struct rt_sigframe {
 	struct siginfo __user *pinfo;
 	void __user *puc;
 	struct siginfo info;
-	/* 64 bit ABI allows for 288 bytes below sp before decrementing it. */
-	char abigap[288];
+	/* New 64 bit little-endian ABI allows redzone of 512 bytes below sp */
+	char abigap[USER_REDZONE_SIZE];
 } __attribute__ ((aligned (16)));
 
 static const char fmt32[] = KERN_INFO \
-- 
1.9.rc1
