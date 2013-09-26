Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AA0E2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 18:24:31 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id lf10so985838pab.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 01:24:20 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/booke64: check napping in performance monitor
 interrupt
Date: Thu, 26 Sep 2013 16:23:56 +0800
Message-Id: <1380183836-17039-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The performance monitor interrupt is asynchronous, so we should check
if the current processor is in napping status in the handler of this
interrupt.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 2d06704..68d74b4 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -607,6 +607,7 @@ kernel_dbg_exc:
 	NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_MONITOR,
 				PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
+	CHECK_NAPPING()
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.performance_monitor_exception
 	b	.ret_from_except_lite
-- 
1.8.3.1
