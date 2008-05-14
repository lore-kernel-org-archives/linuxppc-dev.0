Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2A00DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 09:13:00 +1000 (EST)
Message-Id: <200805142312.m4ENCqLg026256@imap1.linux-foundation.org>
Subject: [patch 1/4] powerpc: fix for OProfile callgraph for Power 64 bit user
	apps
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Wed, 14 May 2008 16:12:52 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, carll@us.ibm.com,
	cel@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Carl Love <cel@us.ibm.com>

Fix the 64 bit user code backtrace which currently may hang the system.

Signed-off-by: Carl Love <carll@us.ibm.com>
Cc: Maynard Johnson <maynardj@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/oprofile/backtrace.c |   33 ++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff -puN arch/powerpc/oprofile/backtrace.c~powerpc-fix-for-oprofile-callgraph-for-power-64-bit-user-apps arch/powerpc/oprofile/backtrace.c
--- a/arch/powerpc/oprofile/backtrace.c~powerpc-fix-for-oprofile-callgraph-for-power-64-bit-user-apps
+++ a/arch/powerpc/oprofile/backtrace.c
@@ -53,19 +53,40 @@ static unsigned int user_getsp32(unsigne
 #ifdef CONFIG_PPC64
 static unsigned long user_getsp64(unsigned long sp, int is_first)
 {
-	unsigned long stack_frame[3];
+	unsigned long stk_frm_lr;
+	unsigned long stk_frm_sp;
+	unsigned long size;
+
+	/* Issue the __copy_from_user_inatomic() third argument currently
+	 * only takes sizes 1, 2, 4 or 8 bytes.  Don't read more then the
+	 * first 48 bytes of the stack frame.  That is all that is
+	 * guaranteed to exist.  Reading more may cause the system to hang.
+	 *
+	 * 64 bit stack frame layout:
+	 * 0-7   bytes is the pointer to previous stack
+	 * 8-15  bytes condition register save area
+	 * 16-23 bytes link register save area
+	 */
+	size = sizeof(unsigned long);
+	if (!access_ok(VERIFY_READ, (void __user *)sp, size))
+		return 0;
 
-	if (!access_ok(VERIFY_READ, (void __user *)sp, sizeof(stack_frame)))
+	if (__copy_from_user_inatomic(&stk_frm_sp, (void __user *)sp,
+					size))
 		return 0;
 
-	if (__copy_from_user_inatomic(stack_frame, (void __user *)sp,
-					sizeof(stack_frame)))
+	/* get the LR from the user stack */
+	if (!access_ok(VERIFY_READ, (void __user *)(sp+16), size))
+		return 0;
+
+	if (__copy_from_user_inatomic(&stk_frm_lr, (void __user *)(sp+16),
+					size))
 		return 0;
 
 	if (!is_first)
-		oprofile_add_trace(STACK_LR64(stack_frame));
+		oprofile_add_trace(stk_frm_lr);
 
-	return STACK_SP(stack_frame);
+	return stk_frm_sp;
 }
 #endif
 
_
