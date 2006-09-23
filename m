Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0538D67BBB
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:37:46 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1GQvWX-0002e8-Pj
	for linuxppc-dev@ozlabs.org; Sat, 23 Sep 2006 01:37:41 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc oprofile __user annotations
Message-Id: <E1GQvWX-0002e8-Pj@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2006 01:37:41 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/oprofile/backtrace.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index 75f57bc..b4278cf 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -11,6 +11,7 @@ #include <linux/oprofile.h>
 #include <linux/sched.h>
 #include <asm/processor.h>
 #include <asm/uaccess.h>
+#include <asm/compat.h>
 
 #define STACK_SP(STACK)		*(STACK)
 
@@ -26,8 +27,9 @@ #endif
 static unsigned int user_getsp32(unsigned int sp, int is_first)
 {
 	unsigned int stack_frame[2];
+	void __user *p = compat_ptr(sp);
 
-	if (!access_ok(VERIFY_READ, sp, sizeof(stack_frame)))
+	if (!access_ok(VERIFY_READ, p, sizeof(stack_frame)))
 		return 0;
 
 	/*
@@ -35,8 +37,7 @@ static unsigned int user_getsp32(unsigne
 	 * which means that we've done all that we can do from
 	 * interrupt context.
 	 */
-	if (__copy_from_user_inatomic(stack_frame, (void *)(long)sp,
-					sizeof(stack_frame)))
+	if (__copy_from_user_inatomic(stack_frame, p, sizeof(stack_frame)))
 		return 0;
 
 	if (!is_first)
@@ -54,10 +55,10 @@ static unsigned long user_getsp64(unsign
 {
 	unsigned long stack_frame[3];
 
-	if (!access_ok(VERIFY_READ, sp, sizeof(stack_frame)))
+	if (!access_ok(VERIFY_READ, (void __user *)sp, sizeof(stack_frame)))
 		return 0;
 
-	if (__copy_from_user_inatomic(stack_frame, (void *)sp,
+	if (__copy_from_user_inatomic(stack_frame, (void __user *)sp,
 					sizeof(stack_frame)))
 		return 0;
 
-- 
1.4.2.GIT
