Return-Path: <cel@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C640DDDE08
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:14:33 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m47IERPv029462
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 14:14:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m47IERUA253096
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 14:14:27 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m47IEQiw022136
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 14:14:26 -0400
Subject: [PATCH] Fix for OProfile callgraph for Power 64 bit user apps
From: Carl Love <cel@us.ibm.com>
To: inuxppc-dev <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Maynard Johnson <maynardj@us.ibm.com>, cel@us.ibm.com
Content-Type: text/plain
Date: Wed, 07 May 2008 11:12:04 -0700
Message-Id: <1210183924.7726.28.camel@carll-linux-desktop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following patch fixes the 64 bit user code backtrace 
which currently may hang the system.  

Signed-off-by: Carl Love <carll@us.ibm.com>

Index: linux-2.6.25.1/arch/powerpc/oprofile/backtrace.c
===================================================================
--- linux-2.6.25.1.orig/arch/powerpc/oprofile/backtrace.c	2008-05-01 16:45:25.000000000 -0500
+++ linux-2.6.25.1/arch/powerpc/oprofile/backtrace.c	2008-05-07 11:29:02.000000000 -0500
@@ -53,19 +53,40 @@
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
 
