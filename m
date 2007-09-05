Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 76271DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:35:39 +1000 (EST)
Date: Tue, 4 Sep 2007 21:42:30 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Move lowlevel runlatch calls under cpu feature
	control
Message-ID: <20070905024230.GC27139@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no need to call the runlatch on functions on processors that
don't implement them (CPU_FTR_CTRL).
    
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 33c4e8c..cec5908 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -656,7 +656,9 @@ hardware_interrupt_common:
 	FINISH_NAP
 hardware_interrupt_entry:
 	DISABLE_INTS
+BEGIN_FTR_SECTION
 	bl	.ppc64_runlatch_on
+END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
 	b	.ret_from_except_lite
diff --git a/include/asm-powerpc/exception.h b/include/asm-powerpc/exception.h
index d850c8e..39abdb0 100644
--- a/include/asm-powerpc/exception.h
+++ b/include/asm-powerpc/exception.h
@@ -282,7 +282,9 @@ label##_common:						\
 	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
 	FINISH_NAP;					\
 	DISABLE_INTS;					\
+BEGIN_FTR_SECTION					\
 	bl	.ppc64_runlatch_on;			\
+END_FTR_SECTION_IFSET(CPU_FTR_CTRL)			\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
 	bl	hdlr;					\
 	b	.ret_from_except_lite
