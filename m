Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17494.55672.893322.11125@cargo.ozlabs.ibm.com>
Date: Tue, 2 May 2006 14:00:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>,
    linuxppc-dev@ozlabs.org
Subject: Re: alignment exceptionhandler sleeps in invalid context
In-Reply-To: <17489.63055.968862.256370@cargo.ozlabs.ibm.com>
References: <20060424173246.GA22318@suse.de>
	<17489.63055.968862.256370@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> This patch should fix it, I hope.  If you can verify that it fixes it
> I'll send it to Linus.

but init barfs at startup with that patch, due to the double
evaluation of `ptr'.  This one runs a bit better...

Paul.

diff --git a/include/asm-powerpc/uaccess.h b/include/asm-powerpc/uaccess.h
index 3872e92..d83fc29 100644
--- a/include/asm-powerpc/uaccess.h
+++ b/include/asm-powerpc/uaccess.h
@@ -7,6 +7,7 @@ #ifndef __ASSEMBLY__
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <asm/processor.h>
+#include <asm/page.h>
 
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
@@ -179,9 +180,11 @@ do {								\
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	long __pu_err;						\
-	might_sleep();						\
-	__chk_user_ptr(ptr);					\
-	__put_user_size((x), (ptr), (size), __pu_err);		\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
+	if (!is_kernel_addr((unsigned long)__pu_addr))		\
+		might_sleep();					\
+	__chk_user_ptr(ptr);					\
+	__put_user_size((x), __pu_addr, (size), __pu_err);	\
 	__pu_err;						\
 })
 
@@ -258,9 +261,11 @@ #define __get_user_nocheck(x, ptr, size)
 ({								\
 	long __gu_err;						\
 	unsigned long __gu_val;					\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
-	might_sleep();						\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
+	if (!is_kernel_addr((unsigned long)__gu_addr))		\
+		might_sleep();					\
+	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
 })
@@ -270,9 +275,11 @@ #define __get_user64_nocheck(x, ptr, siz
 ({								\
 	long __gu_err;						\
 	long long __gu_val;					\
-	__chk_user_ptr(ptr);					\
-	might_sleep();						\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__chk_user_ptr(ptr);					\
+	if (!is_kernel_addr((unsigned long)__gu_addr))		\
+		might_sleep();					\
+	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
 })
