Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17489.63055.968862.256370@cargo.ozlabs.ibm.com>
Date: Fri, 28 Apr 2006 21:02:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: alignment exceptionhandler sleeps in invalid context
In-Reply-To: <20060424173246.GA22318@suse.de>
References: <20060424173246.GA22318@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> I'm not sure where the bug is. Does it mean the network stack does
> something nasty, or is the exception handler itself broken? (probably the latter)
> This is 2.6.16.9 on a p270.

This patch should fix it, I hope.  If you can verify that it fixes it
I'll send it to Linus.

Paul.

diff --git a/include/asm-powerpc/uaccess.h b/include/asm-powerpc/uaccess.h
index 3872e92..b02d858 100644
--- a/include/asm-powerpc/uaccess.h
+++ b/include/asm-powerpc/uaccess.h
@@ -179,7 +179,8 @@ do {								\
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	long __pu_err;						\
-	might_sleep();						\
+	if ((unsigned long)ptr < PAGE_OFFSET)			\
+		might_sleep();					\
 	__chk_user_ptr(ptr);					\
 	__put_user_size((x), (ptr), (size), __pu_err);		\
 	__pu_err;						\
@@ -259,7 +260,8 @@ ({								\
 	long __gu_err;						\
 	unsigned long __gu_val;					\
 	__chk_user_ptr(ptr);					\
-	might_sleep();						\
+	if ((unsigned long)ptr < PAGE_OFFSET)			\
+		might_sleep();					\
 	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -271,7 +273,8 @@ ({								\
 	long __gu_err;						\
 	long long __gu_val;					\
 	__chk_user_ptr(ptr);					\
-	might_sleep();						\
+	if ((unsigned long)ptr < PAGE_OFFSET)			\
+		might_sleep();					\
 	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
