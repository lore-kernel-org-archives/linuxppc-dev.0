Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE7FC2C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 18:42:29 +1000 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rr4so833135pbb.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 01:42:27 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/ppc64: remove the unneeded load of ti_flags in
 resume_kernel
Date: Thu, 26 Sep 2013 16:41:34 +0800
Message-Id: <1380184894-19862-1-git-send-email-haokexin@gmail.com>
Cc: Tiejun Chen <tiejun.chen@windriver.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already got the value of current_thread_info and ti_flags and store
them into r9 and r4 respectively before jumping to resume_kernel. So
there is no reason to reload them again.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index c04cdf7..2fe620f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -673,9 +673,7 @@ _GLOBAL(ret_from_except_lite)
 
 resume_kernel:
 	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
-	CURRENT_THREAD_INFO(r9, r1)
-	ld	r8,TI_FLAGS(r9)
-	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
+	andis.	r8,r4,_TIF_EMULATE_STACK_STORE@h
 	beq+	1f
 
 	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
-- 
1.8.3.1
