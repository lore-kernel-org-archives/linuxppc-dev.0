Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6D251007F7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:27:01 +1000 (EST)
Received: from mail128-co1 (localhost [127.0.0.1])	by
 mail128-co1-R.bigfish.com (Postfix) with ESMTP id 2668F202D5	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:19 +0000 (UTC)
Received: from CO1EHSMHS028.bigfish.com (unknown [10.243.78.241])	by
 mail128-co1.bigfish.com (Postfix) with ESMTP id 92A14A80044	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:05 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQeLJ019320	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:41 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 11/17] PowerPC: booke64: Fix machine check handler to use
 the right prolog
Date: Mon, 25 Jun 2012 15:26:29 +0300
Message-ID: <1340627195-11544-12-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Machine check exception handler was using a wrong prolog. Hypervisors, like
KVM, which are called early from the exception handler rely on the interrupt
source.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 52aa96b..06f7aec 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -290,7 +290,7 @@ interrupt_end_book3e:
 
 /* Machine Check Interrupt */
 	START_EXCEPTION(machine_check);
-	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
+	MC_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
-- 
1.7.4.1
