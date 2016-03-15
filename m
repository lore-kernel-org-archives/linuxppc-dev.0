Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPQBf6PDTzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 17:46:34 +1100 (AEDT)
Date: Tue, 15 Mar 2016 17:46:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: build failure after merge of the aio tree
Message-ID: <20160315174634.6766cd88@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Benjamin,

After merging the aio tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

fs/built-in.o: In function `aio_thread_op_foo_at':
aio.c:(.text+0x4dab4): undefined reference to `__get_user_bad'
aio.c:(.text+0x4daec): undefined reference to `__get_user_bad'

Caused by commit

  150a0b4905f1 ("aio: add support for async openat()")

despite commit

  d2f7a973e11e ("aio: don't use __get_user() for 64 bit values")

This is due to a bug in the powerpc __get_user_check() macro (the return
value is defined to be "unsigned long" which is only 32 bits on a 32
bit platform).

I applied the patch below which seems to help (Michael, what do you
think?), but given Al's and Christoph's reactions, I am inclined to
remove the aio tree from tomorrow and maybe it can be revisited after
the merge window.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Mar 2016 16:36:06 +1100
Subject: [PATCH] powerpc: fix get_user for 64 bit typs on 32 bit platforms

solution borrowed from the x86 uaccess.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/uaccess.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index b7c20f0b8fbe..52262b2f37fc 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -261,10 +261,13 @@ do {								\
 	}							\
 } while (0)
 
+#define __inttype(x) \
+	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
+
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
 	long __gu_err;						\
-	unsigned long __gu_val;					\
+	__inttype(*(ptr)) __gu_val;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
@@ -277,7 +280,7 @@ do {								\
 #define __get_user_check(x, ptr, size)					\
 ({									\
 	long __gu_err = -EFAULT;					\
-	unsigned long  __gu_val = 0;					\
+	__inttype(*(ptr)) __gu_val = 0;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
@@ -289,7 +292,7 @@ do {								\
 #define __get_user_nosleep(x, ptr, size)			\
 ({								\
 	long __gu_err;						\
-	unsigned long __gu_val;					\
+	__inttype(*(ptr)) __gu_val;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-- 
2.7.0

-- 
Cheers,
Stephen Rothwell
